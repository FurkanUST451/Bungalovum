-- =============================================================================
-- Bungalovum · 15 · Yönetici: ilanın tam konumunu yönetici girer
--
-- Ev sahibi uygulamada yalnızca il, ilçe ve açık adres yazıyor (harita / pin
-- yok, adresten konum bulma kapalı). Tam koordinatı yönetici ilan onayında
-- elle girer:
--
-- - admin_set_listing_location: listing_private.latitude/longitude yazar,
--   işlem kaydına düşer. Misafire gösterilen ~500 m yuvarlanmış yaklaşık konum
--   (listings.latitude/longitude) mevcut private.sync_approx_location
--   trigger'ı ile kendiliğinden güncellenir; burada yeniden yazılmaz.
-- - admin_review_listing: onayda tam konum yoksa 'location_required'.
-- - admin_list_listings: "konumu eksik" filtresi (p_missing_location) ve
--   satırda has_location.
-- - admin_badge_counts: listings_missing_location (menü rozeti).
--
-- Not: otomatik onay (private.auto_approve_reviews, yalnızca geliştirme) bu
-- kuralı aramaz; açıkken ilan konumsuz yayına girebilir ve "konumu eksik"
-- listesinde görünür.
-- =============================================================================

-- Türkiye sınırları (listing_private / listings check kısıtlarıyla aynı).
create or replace function private.is_valid_tr_location(p_lat double precision, p_lng double precision)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select p_lat is not null and p_lng is not null
     and p_lat between 35 and 43 and p_lng between 25 and 45;
$$;

-- -----------------------------------------------------------------------------
-- Tam konumu yaz
-- -----------------------------------------------------------------------------

create or replace function public.admin_set_listing_location(
  p_listing uuid,
  p_lat double precision,
  p_lng double precision
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_old_lat double precision;
  v_old_lng double precision;
begin
  perform private.require_admin();
  if not private.is_valid_tr_location(p_lat, p_lng) then
    perform private.fail('invalid_location');
  end if;

  select latitude, longitude into v_old_lat, v_old_lng
  from public.listing_private where listing_id = p_listing for update;
  if not found then
    perform private.fail('not_found');
  end if;

  -- private.sync_approx_location (after update) listings'teki yaklaşık
  -- konumu ~500 m ızgaraya yuvarlayarak günceller.
  update public.listing_private
  set latitude = p_lat, longitude = p_lng
  where listing_id = p_listing;

  perform private.log_admin_action(
    'listing_location_set', 'listing', p_listing,
    case when v_old_lat is null then null
         else jsonb_build_object('latitude', v_old_lat, 'longitude', v_old_lng) end,
    jsonb_build_object('latitude', p_lat, 'longitude', p_lng),
    null
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- İlan onayı: tam konum zorunlu (gövde 20261009090000_admin.sql ile aynı,
-- yalnızca konum denetimi eklendi)
-- -----------------------------------------------------------------------------

create or replace function public.admin_review_listing(p_listing uuid, p_approve boolean, p_note text default null)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  if not p_approve then
    perform private.require_note(v_note);
  end if;

  if p_approve and not exists (
    select 1 from public.listing_private
    where listing_id = p_listing and private.is_valid_tr_location(latitude, longitude)
  ) then
    perform private.fail('location_required');
  end if;

  update public.listings
  set status = case when p_approve then 'published'::public.listing_status else 'rejected'::public.listing_status end,
      published_at = case when p_approve then coalesce(published_at, now()) else published_at end,
      review_note = v_note,
      sections_in_review = '{}'
  where id = p_listing and status = 'in_review'
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;

  if p_approve then
    update public.listing_documents set status = 'approved', reviewed_at = now()
    where listing_id = p_listing and status = 'uploaded';
    update public.profiles set is_host = true, hosting_since = coalesce(hosting_since, private.today())
    where id = l.host_id;
  end if;

  perform private.log_admin_action(
    case when p_approve then 'listing_approved'::public.admin_action_kind else 'listing_rejected'::public.admin_action_kind end,
    'listing', p_listing,
    jsonb_build_object('status', 'in_review'),
    jsonb_build_object('status', l.status),
    v_note
  );
  return l;
end;
$$;

-- -----------------------------------------------------------------------------
-- İlan listesi: "konumu eksik" filtresi (yeni parametre → eski imza silinir)
-- -----------------------------------------------------------------------------

drop function public.admin_list_listings(text, public.listing_status, int, int);

-- p_missing_location: incelemede / yayında / rezervasyona kapalı olup tam
-- konumu girilmemiş ilanlar.
create or replace function public.admin_list_listings(
  p_search text default null,
  p_status public.listing_status default null,
  p_limit int default 50,
  p_offset int default 0,
  p_missing_location boolean default false
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_q text := nullif(btrim(coalesce(p_search, '')), '');
  v_like text := private.like_pattern(btrim(coalesce(p_search, '')));
  v_result jsonb;
begin
  perform private.require_admin();

  with base as (
    select
      l.id, l.listing_no, l.title, l.status, l.sections_in_review, l.property_type,
      l.region, l.city, l.district, l.nightly_price, l.max_guests,
      l.created_at, l.updated_at, l.submitted_at, l.published_at,
      l.rating_avg, l.review_count, l.host_id,
      ph.url as cover_url,
      private.join_name(p.first_name, a.last_name) as host_name,
      u.email::text as host_email,
      private.is_valid_tr_location(lp.latitude, lp.longitude) as has_location
    from public.listings l
    left join public.listing_private lp on lp.listing_id = l.id
    left join public.listing_photos ph on ph.id = l.cover_photo_id
    left join public.profiles p on p.id = l.host_id
    left join public.account_details a on a.user_id = l.host_id
    left join auth.users u on u.id = l.host_id
    where (p_status is null or l.status = p_status)
      and (
        not coalesce(p_missing_location, false)
        or (
          l.status in ('in_review', 'published', 'paused')
          and not private.is_valid_tr_location(lp.latitude, lp.longitude)
        )
      )
      and (
        v_q is null
        or l.listing_no ilike v_like
        or l.title ilike v_like
        or l.region ilike v_like
        or l.city ilike v_like
        or l.district ilike v_like
        or private.join_name(p.first_name, a.last_name) ilike v_like
        or u.email ilike v_like
        or l.id::text = lower(v_q)
      )
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(
        to_jsonb(r) || jsonb_build_object(
          'photo_count', (select count(*) from public.listing_photos ph where ph.listing_id = r.id),
          'booking_count', (
            select count(*) from public.bookings b
            where b.listing_id = r.id and b.status in ('confirmed', 'completed')
          )
        )
        order by r.created_at desc
      )
      from (
        select * from base
        order by created_at desc
        limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
      ) r
    ), '[]'::jsonb)
  )
  into v_result;
  return v_result;
end;
$$;

-- -----------------------------------------------------------------------------
-- Menü rozetleri: konumu eksik ilanlar eklendi (diğer anahtarlar
-- 20261009120000_admin_round2.sql ile aynı)
-- -----------------------------------------------------------------------------

create or replace function public.admin_badge_counts()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return jsonb_build_object(
    'listings_in_review', (select count(*) from public.listings where status = 'in_review'),
    'sections_in_review', (
      select count(*) from public.listings
      where status in ('published', 'paused') and cardinality(sections_in_review) > 0
    ),
    'identities_pending', (select count(*) from private.host_accounts where identity_status = 'pending'),
    'payouts_pending', (select count(*) from private.host_accounts where payout_status = 'pending'),
    'issue_reports_open', (select count(*) from public.issue_reports where status <> 'resolved'),
    'listing_reports_open', (select count(*) from public.listing_reports where status <> 'resolved'),
    'deletion_requests_open', (select count(*) from private.account_deletion_requests where processed_at is null),
    'support_waiting', (
      select count(*) from public.conversations
      where kind = 'support' and last_sender_id = guest_id
    ),
    -- Yayında / rezervasyona kapalı olup tam konumu girilmemiş ilanlar.
    'listings_missing_location', (
      select count(*) from public.listings l
      left join public.listing_private lp on lp.listing_id = l.id
      where l.status in ('published', 'paused')
        and not private.is_valid_tr_location(lp.latitude, lp.longitude)
    )
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Yetki: yeni / yeniden oluşturulan yönetici fonksiyonları anonime kapalı.
-- -----------------------------------------------------------------------------

do $$
declare
  f record;
begin
  for f in
    select p.proname, pg_get_function_identity_arguments(p.oid) as args
    from pg_proc p
    join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname like 'admin\_%'
  loop
    execute format('revoke execute on function public.%I(%s) from public, anon', f.proname, f.args);
    execute format('grant execute on function public.%I(%s) to authenticated', f.proname, f.args);
  end loop;
end;
$$;
