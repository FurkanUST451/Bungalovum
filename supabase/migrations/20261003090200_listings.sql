-- =============================================================================
-- Bungalovum · 02 · İlanlar ve ev sahibi hesabı
--
-- listings           → ilan modeli (tek kaynak, §10). Yayındakini herkes görür.
-- listing_photos     → fotoğraflar (dosyalar Cloudflare R2'de, burada adres)
-- listing_private    → tam adres, tam konum, anahtar kutusu, Wi-Fi, ev kılavuzu.
--                      Yalnızca ev sahibi; misafire get_trip_access() ile açılır.
-- listing_documents  → yasal belgeler (dosyalar private Storage bucket'ında)
-- private.host_accounts → vergi bilgisi, kimlik doğrulaması, IBAN (API'ye kapalı)
-- =============================================================================

create type public.listing_status as enum ('draft', 'in_review', 'published', 'rejected', 'paused');
create type public.wizard_step as enum (
  'type_and_location', 'basics', 'pool_and_amenities', 'photos', 'title_and_description',
  'safety_and_rules', 'pricing', 'check_in', 'legal', 'identity_and_payout'
);
create type public.property_type as enum (
  'bungalow', 'a_frame', 'tree_house', 'stone_house', 'glamping_tent', 'tiny_house', 'cabin'
);
create type public.listing_setting as enum ('lakeside', 'lake_view', 'forest', 'mountain_view', 'near_sea');
create type public.amenity_kind as enum (
  'private_pool', 'jacuzzi', 'barbecue', 'parking', 'kitchen', 'wifi', 'air_conditioning',
  'orthopedic_bed', 'fireplace', 'pets', 'step_free_entry'
);
create type public.highlight_tag as enum (
  'lake_view', 'heated_pool', 'self_check_in', 'in_forest', 'sunset_terrace', 'quiet_area'
);
create type public.safety_kind as enum (
  'co_alarm', 'smoke_detector', 'first_aid_kit', 'fire_extinguisher', 'pool_fence', 'outdoor_camera'
);
create type public.self_check_in as enum ('none', 'keybox', 'smart_lock');
create type public.cancellation_policy as enum ('flexible', 'moderate', 'strict');
create type public.listing_badge as enum ('guest_favorite', 'rare_find');
create type public.room_kind as enum ('living', 'bedroom', 'bathroom', 'outdoor', 'pool');
create type public.permit_type as enum ('tourism_rental', 'tourism_operation', 'municipal_license');
create type public.host_doc_kind as enum ('permit', 'deed', 'condo_decision', 'power_of_attorney', 'entrance_plate');
create type public.doc_status as enum ('uploaded', 'approved', 'rejected');
create type public.verification_status as enum ('not_started', 'pending', 'approved', 'rejected');
create type public.tax_type as enum ('individual', 'company');

create sequence public.listing_no_seq start 1001;

-- -----------------------------------------------------------------------------
-- listings
-- -----------------------------------------------------------------------------

create table public.listings (
  id uuid primary key default gen_random_uuid(),
  -- Misafire gösterilen ilan numarası: "BV-1001"
  listing_no text not null unique default ('BV-' || nextval('public.listing_no_seq')),
  host_id uuid not null default auth.uid() references public.profiles (id) on delete restrict,

  -- Yaşam döngüsü (yalnızca RPC değiştirir)
  status public.listing_status not null default 'draft',
  resume_step public.wizard_step not null default 'type_and_location',
  sections_in_review public.wizard_step[] not null default '{}',
  submitted_at timestamptz,
  published_at timestamptz,
  review_note text,

  -- 1 · Tür ve konum. Tam adres ve konum listing_private'ta; buradaki
  -- latitude/longitude yaklaşıktır (~500 m) ve oradan otomatik üretilir.
  property_type public.property_type,
  settings public.listing_setting[] not null default '{}',
  -- Arama bölgesi ("Sapanca"), il ("Sakarya"), semt ("Kırkpınar")
  region text not null default '' check (char_length(region) <= 60),
  city text not null default '' check (char_length(city) <= 60),
  district text not null default '' check (char_length(district) <= 60),
  latitude double precision check (latitude between 35 and 43),
  longitude double precision check (longitude between 25 and 45),

  -- 2 · Temel bilgiler
  max_guests smallint not null default 2 check (max_guests between 1 and 16),
  bedrooms smallint not null default 1 check (bedrooms between 0 and 10),
  beds smallint not null default 1 check (beds between 0 and 30),
  bathrooms smallint not null default 1 check (bathrooms between 0 and 10),
  -- [{"type": "double", "count": 1}]  type: double | single | sofa_bed | bunk
  bed_types jsonb not null default '[]' check (jsonb_typeof(bed_types) = 'array'),
  indoor_m2 int check (indoor_m2 > 0),
  garden_m2 int check (garden_m2 >= 0),
  whole_place boolean not null default true,
  accessible boolean not null default false,

  -- 3 · Havuz ve olanaklar
  has_pool boolean not null default false,
  pool_private boolean not null default true,
  pool_heated boolean not null default false,
  pool_temp_c smallint check (pool_temp_c between 10 and 40),
  pool_width_m numeric(4, 1) check (pool_width_m > 0),
  pool_length_m numeric(4, 1) check (pool_length_m > 0),
  pool_depth_min_m numeric(3, 1) check (pool_depth_min_m > 0),
  pool_depth_max_m numeric(3, 1) check (pool_depth_max_m > 0),
  pool_season_start smallint check (pool_season_start between 1 and 12),
  pool_season_end smallint check (pool_season_end between 1 and 12),
  pool_note text not null default '' check (char_length(pool_note) <= 300),
  amenities public.amenity_kind[] not null default '{}',

  -- 4 · Fotoğraflar (listing_photos); kapak
  cover_photo_id uuid,

  -- 5 · Başlık ve açıklama
  title text not null default '' check (char_length(title) <= 50),
  -- Kartta görünen kısa bilgi: "10 dk göle yürüme"
  tagline text check (char_length(tagline) <= 60),
  highlights public.highlight_tag[] not null default '{}' check (cardinality(highlights) <= 3),
  summary text not null default '' check (char_length(summary) <= 1000),
  space text not null default '' check (char_length(space) <= 1000),
  guest_access text not null default '' check (char_length(guest_access) <= 1000),
  other_notes text not null default '' check (char_length(other_notes) <= 1000),

  -- 6 · Güvenlik ve kurallar
  safety public.safety_kind[] not null default '{}',
  outdoor_camera_note text not null default '' check (char_length(outdoor_camera_note) <= 300),
  pool_no_lifeguard_ack boolean not null default false,
  pool_depth_marked boolean not null default false,
  check_in_from time not null default '14:00',
  check_in_to time not null default '22:00',
  check_out_by time not null default '11:00',
  self_check_in public.self_check_in not null default 'none',
  pets_allowed boolean not null default false,
  smoking_allowed boolean not null default false,
  events_allowed boolean not null default false,
  quiet_hours boolean not null default true,
  quiet_from time not null default '23:00',
  quiet_to time not null default '08:00',

  -- 7 · Fiyat ve rezervasyon (TRY)
  nightly_price int check (nightly_price > 0),
  -- Cuma ve cumartesi geceleri
  weekend_price int check (weekend_price > 0),
  cleaning_fee int not null default 0 check (cleaning_fee >= 0),
  weekly_discount_percent smallint not null default 0 check (weekly_discount_percent between 0 and 50),
  min_nights smallint not null default 1 check (min_nights between 1 and 30),
  instant_book boolean not null default true,
  cancellation_policy public.cancellation_policy not null default 'flexible',

  -- 9 · Yasal (belge no misafire de gösterilir; dosyalar listing_documents'ta)
  permit_type public.permit_type,
  permit_no text not null default '' check (char_length(permit_no) <= 50),
  multi_unit_parcel boolean not null default false,
  on_behalf_of_owner boolean not null default false,
  kbs_declaration boolean not null default false,
  permit_holder_declaration boolean not null default false,
  update_declaration boolean not null default false,

  -- 93 · Onaylar
  accuracy_consent boolean not null default false,
  agreement_consent boolean not null default false,
  ministry_consent boolean not null default false,

  -- İstatistikler (değerlendirmelerden hesaplanır)
  rating_avg numeric(3, 2),
  review_count int not null default 0,
  rating_cleanliness numeric(3, 2),
  rating_accuracy numeric(3, 2),
  rating_communication numeric(3, 2),
  rating_location numeric(3, 2),
  rating_value numeric(3, 2),
  badge public.listing_badge,

  -- Konum araması için birleşik metin
  search_text text generated always as (lower(region || ' ' || city || ' ' || district || ' ' || title)) stored,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index listings_host_idx on public.listings (host_id);
create index listings_published_idx on public.listings (status, region) where status = 'published';
create index listings_geo_idx on public.listings (latitude, longitude) where status = 'published';
create index listings_search_trgm_idx on public.listings using gin (search_text extensions.gin_trgm_ops);
create index listings_amenities_idx on public.listings using gin (amenities);
create index listings_settings_idx on public.listings using gin (settings);

create trigger listings_updated_at before update on public.listings
for each row execute function private.set_updated_at();

-- -----------------------------------------------------------------------------
-- listing_photos (dosya Cloudflare R2'de)
-- -----------------------------------------------------------------------------

create table public.listing_photos (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings (id) on delete cascade,
  room public.room_kind not null,
  -- R2 nesne anahtarı: listings/{listing_id}/{photo_id}.jpg
  storage_key text not null unique,
  -- Herkese açık adres (CDN / r2.dev)
  url text not null,
  width int check (width > 0),
  height int check (height > 0),
  blurhash text check (char_length(blurhash) <= 100),
  caption text not null default '' check (char_length(caption) <= 120),
  position smallint not null default 0,
  created_at timestamptz not null default now(),
  -- Fotoğraf yalnızca kendi ilanının klasöründe olabilir (r2-upload-url üretir).
  check (storage_key like 'listings/' || listing_id::text || '/%')
);

create index listing_photos_listing_idx on public.listing_photos (listing_id, position);

alter table public.listings
  add constraint listings_cover_photo_fk
  foreign key (cover_photo_id) references public.listing_photos (id) on delete set null;

-- -----------------------------------------------------------------------------
-- listing_private (yalnızca ev sahibi)
-- -----------------------------------------------------------------------------

create table public.listing_private (
  listing_id uuid primary key references public.listings (id) on delete cascade,
  address text not null default '' check (char_length(address) <= 300),
  latitude double precision check (latitude between 35 and 43),
  longitude double precision check (longitude between 25 and 45),
  lockbox_code text not null default '' check (char_length(lockbox_code) <= 30),
  lockbox_hint text not null default '' check (char_length(lockbox_hint) <= 200),
  wifi_name text not null default '' check (char_length(wifi_name) <= 64),
  wifi_password text not null default '' check (char_length(wifi_password) <= 64),
  pool_instructions text not null default '' check (char_length(pool_instructions) <= 1000),
  house_instructions text not null default '' check (char_length(house_instructions) <= 1000),
  -- [{"kind": "pool", "title": "...", "items": ["..."]}]
  -- kind: pool | house | kitchen | outdoor | other
  guide_sections jsonb not null default '[]' check (jsonb_typeof(guide_sections) = 'array'),
  checkout_tasks text[] not null default '{}',
  updated_at timestamptz not null default now()
);

create trigger listing_private_updated_at before update on public.listing_private
for each row execute function private.set_updated_at();

-- İlan oluşunca boş özel kayıt da oluşur.
create or replace function private.create_listing_private()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.listing_private (listing_id) values (new.id);
  return new;
end;
$$;

create trigger listings_create_private after insert on public.listings
for each row execute function private.create_listing_private();

-- Tam konumdan yaklaşık konum: ~500 m'lik ızgaraya yuvarlanır.
create or replace function private.sync_approx_location()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.latitude is distinct from old.latitude or new.longitude is distinct from old.longitude then
    update public.listings
    set latitude = round((new.latitude / 0.005)::numeric) * 0.005,
        longitude = round((new.longitude / 0.005)::numeric) * 0.005
    where id = new.listing_id;
  end if;
  return new;
end;
$$;

create trigger listing_private_sync_location after update on public.listing_private
for each row execute function private.sync_approx_location();

-- -----------------------------------------------------------------------------
-- listing_documents (dosya: Storage › host-documents, private)
-- -----------------------------------------------------------------------------

create table public.listing_documents (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings (id) on delete cascade,
  kind public.host_doc_kind not null,
  -- host-documents bucket'ında: {host_id}/{listing_id}/{kind}-{uuid}.pdf
  storage_path text not null,
  status public.doc_status not null default 'uploaded',
  review_note text,
  uploaded_at timestamptz not null default now(),
  reviewed_at timestamptz,
  unique (listing_id, kind)
);

-- -----------------------------------------------------------------------------
-- private.host_accounts — vergi, kimlik doğrulaması, IBAN (API'ye kapalı)
-- -----------------------------------------------------------------------------

create table private.host_accounts (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  tax_type public.tax_type not null default 'individual',
  -- Şahıs: TCKN, şirket: VKN
  tax_id text,
  tax_office text,
  billing_address text,
  emergency_phone text,
  reachable_during_stay boolean not null default true,
  -- Kimlik doğrulama (Storage › identity-documents)
  identity_status public.verification_status not null default 'not_started',
  identity_front_path text,
  identity_back_path text,
  selfie_path text,
  verified_name text,
  identity_reviewed_at timestamptz,
  identity_review_note text,
  -- Ödeme hesabı
  iban text,
  account_holder text,
  payout_status public.verification_status not null default 'not_started',
  payout_reviewed_at timestamptz,
  updated_at timestamptz not null default now()
);

create trigger host_accounts_updated_at before update on private.host_accounts
for each row execute function private.set_updated_at();

-- -----------------------------------------------------------------------------
-- Korunan kolonlar ve yayındaki ilanda yeniden inceleme (§10)
-- -----------------------------------------------------------------------------

create or replace function private.guard_listing_update()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  if current_user in ('anon', 'authenticated') and (
    new.id is distinct from old.id
    or new.listing_no is distinct from old.listing_no
    or new.host_id is distinct from old.host_id
    or new.status is distinct from old.status
    or new.sections_in_review is distinct from old.sections_in_review
    or new.submitted_at is distinct from old.submitted_at
    or new.published_at is distinct from old.published_at
    or new.review_note is distinct from old.review_note
    or new.latitude is distinct from old.latitude
    or new.longitude is distinct from old.longitude
    or new.rating_avg is distinct from old.rating_avg
    or new.review_count is distinct from old.review_count
    or new.rating_cleanliness is distinct from old.rating_cleanliness
    or new.rating_accuracy is distinct from old.rating_accuracy
    or new.rating_communication is distinct from old.rating_communication
    or new.rating_location is distinct from old.rating_location
    or new.rating_value is distinct from old.rating_value
    or new.badge is distinct from old.badge
    or new.created_at is distinct from old.created_at
  ) then
    raise exception using errcode = '42501', message = 'protected_column';
  end if;

  -- İncelemedeki ilan düzenlenemez.
  if current_user in ('anon', 'authenticated') and old.status = 'in_review' then
    raise exception using errcode = 'P0001', message = 'listing_in_review';
  end if;

  -- Yayındaki ilanda yasal bilgiler değişirse yalnızca o bölüm incelemeye girer.
  if old.status in ('published', 'paused') and (
    new.permit_type is distinct from old.permit_type
    or new.permit_no is distinct from old.permit_no
    or new.multi_unit_parcel is distinct from old.multi_unit_parcel
    or new.on_behalf_of_owner is distinct from old.on_behalf_of_owner
  ) and not ('legal' = any (new.sections_in_review)) then
    new.sections_in_review := new.sections_in_review || 'legal'::public.wizard_step;
  end if;

  return new;
end;
$$;

create trigger listings_guard before update on public.listings
for each row execute function private.guard_listing_update();

-- Yayındaki ilanda belge değişirse 'legal' bölümü incelemeye girer.
create or replace function private.on_listing_document_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_listing uuid;
begin
  if tg_op = 'DELETE' then
    v_listing := old.listing_id;
  else
    v_listing := new.listing_id;
    -- Yalnızca inceleme sonucu güncellendiyse yeniden incelemeye gerek yok.
    if tg_op = 'UPDATE' and new.storage_path = old.storage_path then
      return new;
    end if;
  end if;

  update public.listings
  set sections_in_review = sections_in_review || 'legal'::public.wizard_step
  where id = v_listing
    and status in ('published', 'paused')
    and not ('legal' = any (sections_in_review));
  return null;
end;
$$;

create trigger listing_documents_review after insert or update or delete on public.listing_documents
for each row execute function private.on_listing_document_change();

-- Belgeyi yeniden yükleyen ev sahibi inceleme sonucunu kendisi belirleyemez.
create or replace function private.guard_listing_document()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  if current_user in ('anon', 'authenticated') then
    if tg_op = 'UPDATE' and (new.listing_id is distinct from old.listing_id or new.kind is distinct from old.kind) then
      raise exception using errcode = '42501', message = 'protected_column';
    end if;
    new.status := 'uploaded';
    new.review_note := null;
    new.reviewed_at := null;
    new.uploaded_at := now();
  end if;
  return new;
end;
$$;

create trigger listing_documents_guard before insert or update on public.listing_documents
for each row execute function private.guard_listing_document();

-- -----------------------------------------------------------------------------
-- RLS yardımcıları (politikalarda kullanılır, public şemada olmak zorunda)
-- -----------------------------------------------------------------------------

create or replace function public.is_listing_host(p_listing uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.listings where id = p_listing and host_id = auth.uid());
$$;

create or replace function public.is_listing_visible(p_listing uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.listings
    where id = p_listing
      and (status = 'published' or host_id = auth.uid()
           or exists (select 1 from private.admins where user_id = auth.uid()))
  );
$$;

-- -----------------------------------------------------------------------------
-- RLS
-- -----------------------------------------------------------------------------

alter table public.listings enable row level security;
alter table public.listing_photos enable row level security;
alter table public.listing_private enable row level security;
alter table public.listing_documents enable row level security;

-- listings
create policy "Yayındaki ilanları herkes, kendi ilanını sahibi görür"
on public.listings for select
to anon, authenticated
using (status = 'published' or host_id = (select auth.uid()) or (select public.is_admin()));

create policy "Ev sahibi taslak oluşturur"
on public.listings for insert
to authenticated
with check (host_id = (select auth.uid()) and status = 'draft');

create policy "Ev sahibi kendi ilanını düzenler"
on public.listings for update
to authenticated
using (host_id = (select auth.uid()))
with check (host_id = (select auth.uid()));

create policy "Ev sahibi yalnızca taslağını siler"
on public.listings for delete
to authenticated
using (host_id = (select auth.uid()) and status = 'draft');

-- listing_photos
create policy "Görünen ilanın fotoğraflarını herkes görür"
on public.listing_photos for select
to anon, authenticated
using ((select public.is_listing_visible(listing_id)));

create policy "Ev sahibi fotoğraf ekler"
on public.listing_photos for insert
to authenticated
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi fotoğraf düzenler"
on public.listing_photos for update
to authenticated
using ((select public.is_listing_host(listing_id)))
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi fotoğraf siler"
on public.listing_photos for delete
to authenticated
using ((select public.is_listing_host(listing_id)));

-- listing_private
create policy "Ev sahibi özel bilgileri görür"
on public.listing_private for select
to authenticated
using ((select public.is_listing_host(listing_id)) or (select public.is_admin()));

create policy "Ev sahibi özel bilgileri düzenler"
on public.listing_private for update
to authenticated
using ((select public.is_listing_host(listing_id)))
with check ((select public.is_listing_host(listing_id)));

-- listing_documents
create policy "Ev sahibi ve yönetici belgeleri görür"
on public.listing_documents for select
to authenticated
using ((select public.is_listing_host(listing_id)) or (select public.is_admin()));

create policy "Ev sahibi belge ekler"
on public.listing_documents for insert
to authenticated
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi belge değiştirir"
on public.listing_documents for update
to authenticated
using ((select public.is_listing_host(listing_id)))
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi belge siler"
on public.listing_documents for delete
to authenticated
using ((select public.is_listing_host(listing_id)));

-- -----------------------------------------------------------------------------
-- İncelemeye gönderme kuralları (uygulamadaki DraftValidator ile aynı).
-- Eksik adımları döner; boşsa ilan gönderilebilir.
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
  v_docs public.host_doc_kind[];
  v_tax_ok boolean;
begin
  select * into l from public.listings where id = p_listing;
  select * into p from public.listing_private where listing_id = p_listing;
  select * into h from private.host_accounts where user_id = l.host_id;

  if l.property_type is null or cardinality(l.settings) = 0 or btrim(p.address) = ''
     or btrim(l.city) = '' or btrim(l.district) = '' or p.latitude is null then
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

  -- İzin belge numarası olmayan ilan yayına alınmaz.
  select array_agg(kind) into v_docs
  from public.listing_documents where listing_id = p_listing and status <> 'rejected';
  v_docs := coalesce(v_docs, '{}');
  v_tax_ok := case h.tax_type
    when 'individual' then private.is_valid_tckn(h.tax_id)
    when 'company' then private.is_valid_vkn(h.tax_id)
    else false
  end;
  if l.permit_type is null or btrim(l.permit_no) = ''
     or not ('permit' = any (v_docs)) or not ('deed' = any (v_docs)) or not ('entrance_plate' = any (v_docs))
     or (l.multi_unit_parcel and not ('condo_decision' = any (v_docs)))
     or (l.on_behalf_of_owner and not ('power_of_attorney' = any (v_docs)))
     or not l.kbs_declaration or not l.permit_holder_declaration or not l.update_declaration
     or not coalesce(v_tax_ok, false) or btrim(coalesce(h.tax_office, '')) = '' then
    v_missing := v_missing || 'legal'::public.wizard_step;
  end if;

  if h.user_id is null
     or h.identity_status not in ('pending', 'approved')
     or not private.is_valid_tr_iban(h.iban)
     or (h.verified_name is not null and not private.same_name(h.account_holder, h.verified_name))
     or btrim(coalesce(h.billing_address, '')) = ''
     or length(regexp_replace(coalesce(h.emergency_phone, ''), '\D', '', 'g')) < 10 then
    v_missing := v_missing || 'identity_and_payout'::public.wizard_step;
  end if;

  return v_missing;
end;
$$;

-- -----------------------------------------------------------------------------
-- RPC: ev sahibi
-- -----------------------------------------------------------------------------

-- Taslağın eksik adımları ("Devam" / "İncelemeye gönder" butonları için).
create or replace function public.listing_missing_steps(p_listing uuid)
returns public.wizard_step[]
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if not public.is_listing_host(p_listing) and not public.is_admin() then
    perform private.fail('not_found');
  end if;
  return private.listing_missing_steps(p_listing);
end;
$$;

-- 93 · İncelemeye gönder.
create or replace function public.submit_listing_for_review(p_listing uuid)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
  v_missing public.wizard_step[];
begin
  select * into l from public.listings where id = p_listing and host_id = private.require_user() for update;
  if l.id is null then
    perform private.fail('not_found');
  end if;
  if l.status not in ('draft', 'rejected') then
    perform private.fail('invalid_status');
  end if;

  v_missing := private.listing_missing_steps(p_listing);
  if cardinality(v_missing) > 0 then
    perform private.fail('listing_incomplete', array_to_string(v_missing, ','));
  end if;
  if not (l.accuracy_consent and l.agreement_consent and l.ministry_consent) then
    perform private.fail('consents_required');
  end if;

  update public.listings
  set status = 'in_review', submitted_at = now(), review_note = null
  where id = p_listing
  returning * into l;
  return l;
end;
$$;

-- 95 · İlanı rezervasyona kapat / aç.
create or replace function public.set_listing_paused(p_listing uuid, p_paused boolean)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
begin
  update public.listings
  set status = case when p_paused then 'paused'::public.listing_status else 'published'::public.listing_status end
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

-- 92 · Vergi ve iletişim bilgileri. TCKN/VKN yalnızca burada yazılır.
create or replace function public.save_host_tax_info(
  p_tax_type public.tax_type,
  p_tax_id text,
  p_tax_office text,
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
  v_tax_id text := regexp_replace(coalesce(p_tax_id, ''), '\D', '', 'g');
  v_phone text := right(regexp_replace(coalesce(p_emergency_phone, ''), '\D', '', 'g'), 10);
begin
  if (p_tax_type = 'individual' and not private.is_valid_tckn(v_tax_id))
     or (p_tax_type = 'company' and not private.is_valid_vkn(v_tax_id)) then
    perform private.fail('invalid_tax_id');
  end if;
  if v_phone !~ '^5[0-9]{9}$' then
    perform private.fail('invalid_phone');
  end if;

  insert into private.host_accounts as h (user_id, tax_type, tax_id, tax_office, billing_address, emergency_phone, reachable_during_stay)
  values (v_uid, p_tax_type, v_tax_id, btrim(p_tax_office), btrim(p_billing_address), v_phone, p_reachable_during_stay)
  on conflict (user_id) do update
  set tax_type = excluded.tax_type,
      tax_id = excluded.tax_id,
      tax_office = excluded.tax_office,
      billing_address = excluded.billing_address,
      emergency_phone = excluded.emergency_phone,
      reachable_during_stay = excluded.reachable_during_stay;
end;
$$;

-- 92 · Kimlik belgeleri yüklendi (dosyalar identity-documents bucket'ında).
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
end;
$$;

-- 92 · IBAN. TR biçimi + mod-97; kimlik doğrulandıysa ad eşleşmeli.
create or replace function public.set_payout_account(p_account_holder text, p_iban text)
returns text
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_iban text := private.normalize_iban(p_iban);
  v_verified text;
begin
  if not private.is_valid_tr_iban(v_iban) then
    perform private.fail('invalid_iban');
  end if;
  select verified_name into v_verified from private.host_accounts where user_id = v_uid;
  if v_verified is not null and not private.same_name(p_account_holder, v_verified) then
    perform private.fail('iban_name_mismatch');
  end if;

  insert into private.host_accounts as h (user_id, iban, account_holder, payout_status)
  values (v_uid, v_iban, btrim(p_account_holder), 'pending')
  on conflict (user_id) do update
  set iban = excluded.iban,
      account_holder = excluded.account_holder,
      payout_status = 'pending',
      payout_reviewed_at = null;

  perform private.mark_host_listings_for_review(v_uid);
  return private.mask_tail(v_iban);
end;
$$;

-- Kimlik veya IBAN değişince yayındaki ilanlarda o bölüm incelemeye girer.
create or replace function private.mark_host_listings_for_review(p_host uuid)
returns void
language sql
set search_path = ''
as $$
  update public.listings
  set sections_in_review = sections_in_review || 'identity_and_payout'::public.wizard_step
  where host_id = p_host
    and status in ('published', 'paused')
    and not ('identity_and_payout' = any (sections_in_review));
$$;

-- 92 / 95 · Ev sahibi hesabı (maskeli).
create or replace function public.get_host_account()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select jsonb_build_object(
    'tax_type', h.tax_type,
    'tax_id_masked', private.mask_tail(h.tax_id),
    'tax_office', h.tax_office,
    'billing_address', h.billing_address,
    'emergency_phone', h.emergency_phone,
    'reachable_during_stay', h.reachable_during_stay,
    'identity_status', h.identity_status,
    'identity_review_note', h.identity_review_note,
    'verified_name', h.verified_name,
    'account_holder', h.account_holder,
    'iban_masked', private.mask_tail(h.iban),
    'payout_status', h.payout_status
  )
  from private.host_accounts h
  where h.user_id = auth.uid();
$$;

-- -----------------------------------------------------------------------------
-- RPC: yönetici (inceleme)
-- -----------------------------------------------------------------------------

create or replace function private.require_admin()
returns void
language plpgsql
stable
set search_path = ''
as $$
begin
  if not public.is_admin() then
    perform private.fail('forbidden');
  end if;
end;
$$;

create or replace function public.admin_review_listing(p_listing uuid, p_approve boolean, p_note text default null)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
begin
  perform private.require_admin();
  update public.listings
  set status = case when p_approve then 'published'::public.listing_status else 'rejected'::public.listing_status end,
      published_at = case when p_approve then coalesce(published_at, now()) else published_at end,
      review_note = p_note,
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
  return l;
end;
$$;

-- Yayındaki ilanda yeniden incelemeye giren bölümü onayla/reddet.
create or replace function public.admin_review_listing_section(
  p_listing uuid,
  p_section public.wizard_step,
  p_approve boolean,
  p_note text default null
)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
begin
  perform private.require_admin();
  update public.listings
  set sections_in_review = array_remove(sections_in_review, p_section),
      -- Reddedilen bölüm düzeltilene kadar ilan rezervasyona kapanır.
      status = case when p_approve then status else 'paused'::public.listing_status end,
      review_note = p_note
  where id = p_listing and p_section = any (sections_in_review)
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;
  if p_section = 'legal' then
    update public.listing_documents
    set status = case when p_approve then 'approved'::public.doc_status else 'rejected'::public.doc_status end,
        reviewed_at = now(), review_note = p_note
    where listing_id = p_listing and status = 'uploaded';
  end if;
  return l;
end;
$$;

create or replace function public.admin_review_identity(
  p_user uuid,
  p_approve boolean,
  p_verified_name text default null,
  p_note text default null
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  if p_approve and btrim(coalesce(p_verified_name, '')) = '' then
    perform private.fail('verified_name_required');
  end if;
  update private.host_accounts
  set identity_status = case when p_approve then 'approved'::public.verification_status else 'rejected'::public.verification_status end,
      verified_name = case when p_approve then btrim(p_verified_name) else verified_name end,
      identity_reviewed_at = now(),
      identity_review_note = p_note,
      -- Ad eşleşmiyorsa IBAN da reddedilir.
      payout_status = case
        when p_approve and iban is not null and not private.same_name(account_holder, p_verified_name) then 'rejected'::public.verification_status
        else payout_status
      end
  where user_id = p_user and identity_status = 'pending';
  if not found then
    perform private.fail('invalid_status');
  end if;
  if p_approve then
    update public.profiles set identity_verified = true where id = p_user;
  end if;
end;
$$;

create or replace function public.admin_review_payout(p_user uuid, p_approve boolean)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  update private.host_accounts
  set payout_status = case when p_approve then 'approved'::public.verification_status else 'rejected'::public.verification_status end,
      payout_reviewed_at = now()
  where user_id = p_user and payout_status = 'pending';
  if not found then
    perform private.fail('invalid_status');
  end if;
end;
$$;
