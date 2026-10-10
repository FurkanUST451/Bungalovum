-- =============================================================================
-- Bungalovum · Geliştirmede yasal ve kimlik adımlarının ayrı ayarı
--
-- 20261008120000'de 9. adım (yasal) ve 10. adım (kimlik ve ödeme) şartı
-- otomatik onaya bağlanmıştı. Yönetici panelinden elle inceleme için
-- otomatik onay kapatılınca bu şartlar da geri geldi ve uygulama
-- (DraftValidator.requireLegal / requireIdentityPayout = false) ile backend
-- ayrıştı. Artık ayrı bir ayar:
--
--   require_legal_identity = false → bu iki adım incelemeye göndermede aranmaz
--   (otomatik onay açık ya da kapalı olsun).
--
-- Canlıya çıkmadan önce true yapılmalı (CLAUDE.md §10: izin belge numarası
-- olmayan ilan yayına alınmaz) ve uygulamadaki iki bayrak geri açılmalı:
--   update public.platform_settings set require_legal_identity = true where id;
-- =============================================================================

alter table public.platform_settings
  add column require_legal_identity boolean not null default true;

-- DEV: telefon uygulamasındaki geçici bayraklarla aynı.
update public.platform_settings set require_legal_identity = false where id;

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
  -- DEV: require_legal_identity kapalıyken yasal adım aranmaz.
  if s.require_legal_identity and (
       l.permit_type is null or btrim(l.permit_no) = ''
       or not l.kbs_declaration or not l.permit_holder_declaration or not l.update_declaration
       or not coalesce(v_tax_ok, false) or btrim(coalesce(h.tax_office, '')) = ''
     ) then
    v_missing := v_missing || 'legal'::public.wizard_step;
  end if;

  -- DEV: require_legal_identity kapalıyken kimlik ve ödeme adımı aranmaz.
  if s.require_legal_identity and (
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
