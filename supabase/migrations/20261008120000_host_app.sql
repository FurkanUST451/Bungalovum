-- =============================================================================
-- Bungalovum · 10 · Ev sahibi akışının uygulamaya bağlanması
--
-- - Geliştirmede otomatik inceleme (platform_settings.auto_approve_reviews)
-- - Vergi (adım 9) ve iletişim (adım 10) bilgisi ayrı kaydedilir
-- - Kimlik yüklenince otomatik inceleme
-- - İlanı yayından kaldırma
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Otomatik inceleme (yalnızca geliştirme)
-- -----------------------------------------------------------------------------

alter table public.platform_settings
  add column auto_approve_reviews boolean not null default false;

-- DEV: yönetici paneli yokken ilan ve kimlik kendiliğinden onaylanır.
-- Canlıya çıkmadan önce false yapılmalı:
--   update public.platform_settings set auto_approve_reviews = false where id;
update public.platform_settings set auto_approve_reviews = true where id;

-- Kimliği otomatik onaylar. Doğrulanmış ad: profildeki ad soyad, yoksa IBAN
-- sahibi. Ad IBAN sahibiyle eşleşmezse ödeme hesabı reddedilir
-- (admin_review_identity ile aynı kural).
create or replace function private.auto_review_identity(p_user uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_name text;
begin
  if not (private.settings()).auto_approve_reviews then
    return;
  end if;

  select nullif(btrim(regexp_replace(p.first_name || ' ' || coalesce(a.last_name, ''), '\s+', ' ', 'g')), '')
  into v_name
  from public.profiles p
  left join public.account_details a on a.user_id = p.id
  where p.id = p_user;

  update private.host_accounts h
  set identity_status = 'approved',
      verified_name = coalesce(v_name, nullif(btrim(h.account_holder), '')),
      identity_reviewed_at = now(),
      identity_review_note = null,
      payout_status = case
        when h.iban is not null
             and coalesce(v_name, h.account_holder) is not null
             and not private.same_name(h.account_holder, coalesce(v_name, h.account_holder))
          then 'rejected'::public.verification_status
        else h.payout_status
      end
  where h.user_id = p_user and h.identity_status = 'pending';

  if found then
    update public.profiles set identity_verified = true where id = p_user;
  end if;
end;
$$;

-- Her dakika: 1 dakikadır incelemede bekleyen ilanlar, yayındaki ilanlarda
-- yeniden incelemeye giren bölümler ve bekleyen ödeme hesapları onaylanır.
create or replace function private.auto_approve_reviews()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  r record;
begin
  if not (private.settings()).auto_approve_reviews then
    return;
  end if;

  for r in
    select id, host_id from public.listings
    where status = 'in_review' and submitted_at < now() - interval '1 minute'
    for update skip locked
  loop
    update public.listings
    set status = 'published',
        published_at = coalesce(published_at, now()),
        review_note = null,
        sections_in_review = '{}'
    where id = r.id;
    update public.listing_documents set status = 'approved', reviewed_at = now()
    where listing_id = r.id and status = 'uploaded';
    update public.profiles set is_host = true, hosting_since = coalesce(hosting_since, private.today())
    where id = r.host_id;
  end loop;

  update public.listing_documents d
  set status = 'approved', reviewed_at = now()
  from public.listings l
  where d.listing_id = l.id
    and d.status = 'uploaded'
    and l.status in ('published', 'paused')
    and 'legal' = any (l.sections_in_review)
    and l.updated_at < now() - interval '1 minute';

  update public.listings
  set sections_in_review = '{}'
  where status in ('published', 'paused')
    and cardinality(sections_in_review) > 0
    and updated_at < now() - interval '1 minute';

  for r in select user_id from private.host_accounts where identity_status = 'pending' loop
    perform private.auto_review_identity(r.user_id);
  end loop;

  update private.host_accounts
  set payout_status = 'approved', payout_reviewed_at = now()
  where payout_status = 'pending'
    and identity_status = 'approved'
    and (verified_name is null or private.same_name(account_holder, verified_name));
end;
$$;

select cron.schedule('auto-approve-reviews', '* * * * *', $$select private.auto_approve_reviews()$$);

-- -----------------------------------------------------------------------------
-- Vergi ve iletişim bilgisi ayrı kaydedilir (adım 9 ve 10)
-- -----------------------------------------------------------------------------

-- Yayındaki ilanlarda "legal" bölümünü incelemeye alır.
create or replace function private.mark_host_listings_legal_review(p_host uuid)
returns void
language sql
set search_path = ''
as $$
  update public.listings
  set sections_in_review = sections_in_review || 'legal'::public.wizard_step
  where host_id = p_host
    and status in ('published', 'paused')
    and not ('legal' = any (sections_in_review));
$$;

-- 91 · Vergi bilgisi. TCKN/VKN yalnızca burada yazılır; maskeli döner.
create or replace function public.save_host_tax_id(
  p_tax_type public.tax_type,
  p_tax_id text,
  p_tax_office text
)
returns text
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_tax_id text := regexp_replace(coalesce(p_tax_id, ''), '\D', '', 'g');
  v_old private.host_accounts;
begin
  if (p_tax_type = 'individual' and not private.is_valid_tckn(v_tax_id))
     or (p_tax_type = 'company' and not private.is_valid_vkn(v_tax_id)) then
    perform private.fail('invalid_tax_id');
  end if;

  select * into v_old from private.host_accounts where user_id = v_uid;

  insert into private.host_accounts as h (user_id, tax_type, tax_id, tax_office)
  values (v_uid, p_tax_type, v_tax_id, btrim(coalesce(p_tax_office, '')))
  on conflict (user_id) do update
  set tax_type = excluded.tax_type,
      tax_id = excluded.tax_id,
      tax_office = excluded.tax_office;

  if v_old.tax_id is distinct from v_tax_id or v_old.tax_type is distinct from p_tax_type then
    perform private.mark_host_listings_legal_review(v_uid);
  end if;
  return private.mask_tail(v_tax_id);
end;
$$;

-- Vergi dairesi tek başına değişebilir (TCKN yeniden istenmez).
create or replace function public.save_host_tax_office(p_tax_office text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
begin
  insert into private.host_accounts as h (user_id, tax_office)
  values (v_uid, btrim(coalesce(p_tax_office, '')))
  on conflict (user_id) do update set tax_office = excluded.tax_office;
end;
$$;

-- 92 · Fatura adresi ve acil durum telefonu.
create or replace function public.save_host_contact(
  p_billing_address text,
  p_emergency_phone text,
  p_reachable_during_stay boolean default true
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_phone text := right(regexp_replace(coalesce(p_emergency_phone, ''), '\D', '', 'g'), 10);
begin
  if v_phone <> '' and v_phone !~ '^5[0-9]{9}$' then
    perform private.fail('invalid_phone');
  end if;

  insert into private.host_accounts as h (user_id, billing_address, emergency_phone, reachable_during_stay)
  values (v_uid, btrim(coalesce(p_billing_address, '')), nullif(v_phone, ''), coalesce(p_reachable_during_stay, true))
  on conflict (user_id) do update
  set billing_address = excluded.billing_address,
      emergency_phone = excluded.emergency_phone,
      reachable_during_stay = excluded.reachable_during_stay;
end;
$$;

-- -----------------------------------------------------------------------------
-- Kimlik: yüklenince (geliştirmede) otomatik incelenir
-- -----------------------------------------------------------------------------

create or replace function public.submit_identity_documents(p_front_path text, p_back_path text, p_selfie_path text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_prefix text := v_uid::text || '/';
begin
  if not (starts_with(p_front_path, v_prefix) and starts_with(p_back_path, v_prefix) and starts_with(p_selfie_path, v_prefix)) then
    perform private.fail('invalid_path');
  end if;

  insert into private.host_accounts as h (user_id, identity_status, identity_front_path, identity_back_path, selfie_path)
  values (v_uid, 'pending', p_front_path, p_back_path, p_selfie_path)
  on conflict (user_id) do update
  set identity_status = 'pending',
      identity_front_path = excluded.identity_front_path,
      identity_back_path = excluded.identity_back_path,
      selfie_path = excluded.selfie_path,
      identity_reviewed_at = null,
      identity_review_note = null;

  perform private.mark_host_listings_for_review(v_uid);
  perform private.auto_review_identity(v_uid);
end;
$$;

-- -----------------------------------------------------------------------------
-- 95 · İlanı yayından kaldır (taslağa döner)
-- -----------------------------------------------------------------------------

create or replace function public.unpublish_listing(p_listing uuid)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
begin
  if exists (
    select 1 from public.bookings
    where listing_id = p_listing
      and status in ('awaiting_payment', 'pending', 'confirmed')
      and check_out >= private.today()
  ) then
    perform private.fail('has_upcoming_bookings');
  end if;

  update public.listings
  set status = 'draft', sections_in_review = '{}'
  where id = p_listing
    and host_id = private.require_user()
    and status in ('published', 'paused')
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;
  return l;
end;
$$;

-- -----------------------------------------------------------------------------
-- Adresten konum şimdilik kapalı: incelemeye göndermede konum şartı yok.
-- Konum bulma geri açılınca "or p.latitude is null" şartı yeni bir
-- migration ile geri eklenmeli.
--
-- Belge dosyaları da şimdilik zorunlu değil (izin belge NUMARASI zorunlu
-- kalır). Geri açınca permit/deed/entrance_plate ve koşullu belge şartları
-- yeni bir migration ile eklenmeli.
-- -----------------------------------------------------------------------------

create or replace function private.listing_missing_steps(p_listing uuid)
returns public.wizard_step[]
language plpgsql
stable
set search_path = ''
as $$
declare
  l public.listings;
  p public.listing_private;
  h private.host_accounts;
  s public.platform_settings := private.settings();
  v_missing public.wizard_step[] := '{}';
  v_photos int;
  v_has_cover boolean;
  v_tax_ok boolean;
begin
  select * into l from public.listings where id = p_listing;
  select * into p from public.listing_private where listing_id = p_listing;
  select * into h from private.host_accounts where user_id = l.host_id;

  if l.property_type is null or cardinality(l.settings) = 0 or btrim(p.address) = ''
     or btrim(l.city) = '' or btrim(l.district) = '' then
    v_missing := v_missing || 'type_and_location'::public.wizard_step;
  end if;

  if l.max_guests < 1 or l.beds < 1 or l.bathrooms < 1
     or jsonb_array_length(l.bed_types) = 0 or coalesce(l.indoor_m2, 0) <= 0 then
    v_missing := v_missing || 'basics'::public.wizard_step;
  end if;

  if l.has_pool and (
    (l.pool_heated and l.pool_temp_c is null)
    or l.pool_width_m is null or l.pool_length_m is null
    or l.pool_depth_min_m is null or l.pool_depth_max_m is null
    or l.pool_season_start is null or l.pool_season_end is null
  ) then
    v_missing := v_missing || 'pool_and_amenities'::public.wizard_step;
  end if;

  select count(*), bool_or(id = l.cover_photo_id)
  into v_photos, v_has_cover
  from public.listing_photos where listing_id = p_listing;
  if v_photos < s.min_listing_photos or not coalesce(v_has_cover, false) then
    v_missing := v_missing || 'photos'::public.wizard_step;
  end if;

  if char_length(btrim(l.title)) < 10 or cardinality(l.highlights) = 0
     or char_length(btrim(l.space)) < 50 then
    v_missing := v_missing || 'title_and_description'::public.wizard_step;
  end if;

  if ('outdoor_camera' = any (l.safety) and btrim(l.outdoor_camera_note) = '')
     or (l.has_pool and not l.pool_no_lifeguard_ack) then
    v_missing := v_missing || 'safety_and_rules'::public.wizard_step;
  end if;

  if coalesce(l.nightly_price, 0) <= 0 or l.min_nights < 1 then
    v_missing := v_missing || 'pricing'::public.wizard_step;
  end if;

  if l.self_check_in = 'keybox' and (btrim(p.lockbox_code) = '' or btrim(p.lockbox_hint) = '') then
    v_missing := v_missing || 'check_in'::public.wizard_step;
  end if;

  -- İzin belge numarası olmayan ilan yayına alınmaz. Belge dosyaları
  -- şimdilik zorunlu değil.
  v_tax_ok := case h.tax_type
    when 'individual' then private.is_valid_tckn(h.tax_id)
    when 'company' then private.is_valid_vkn(h.tax_id)
    else false
  end;
  -- DEV: otomatik onay açıkken (geliştirme) yasal adım şimdilik aranmaz;
  -- otomatik onay kapatılınca kural kendiliğinden geri gelir.
  if not s.auto_approve_reviews and (
       l.permit_type is null or btrim(l.permit_no) = ''
       or not l.kbs_declaration or not l.permit_holder_declaration or not l.update_declaration
       or not coalesce(v_tax_ok, false) or btrim(coalesce(h.tax_office, '')) = ''
     ) then
    v_missing := v_missing || 'legal'::public.wizard_step;
  end if;

  -- DEV: otomatik onay açıkken kimlik ve ödeme adımı şimdilik aranmaz.
  if not s.auto_approve_reviews and (
       h.user_id is null
       or h.identity_status not in ('pending', 'approved')
       or not private.is_valid_tr_iban(h.iban)
       or (h.verified_name is not null and not private.same_name(h.account_holder, h.verified_name))
       or btrim(coalesce(h.billing_address, '')) = ''
       or length(regexp_replace(coalesce(h.emergency_phone, ''), '\D', '', 'g')) < 10
     ) then
    v_missing := v_missing || 'identity_and_payout'::public.wizard_step;
  end if;

  return v_missing;
end;
$$;
