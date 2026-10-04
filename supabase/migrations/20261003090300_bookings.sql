-- =============================================================================
-- Bungalovum · 03 · Takvim, rezervasyon ve ödeme tabloları
--
-- listing_calendar   → ev sahibinin kapattığı günler ve özel gecelik fiyatlar
-- bookings           → rezervasyonlar; çifte rezervasyon veritabanı kısıtıyla
--                      imkansız (bookings_no_overlap)
-- booking_guests     → kimlik bildirimi (KBS) için misafirler (maskeli);
--                      kimlik numaraları private.booking_guest_identities'te
-- payments           → ödeme / provizyon / iade hareketleri (Edge Function yazar)
-- payment_methods    → kayıtlı kartlar (yalnızca marka + son 4 hane);
--                      sağlayıcı token'ı private.payment_method_tokens'ta
-- payouts            → ev sahibine aktarılacak tutarlar
-- coupons / user_coupons
--
-- Kart numarası hiçbir tabloda tutulmaz (PCI kapsamı ödeme sağlayıcısında).
-- =============================================================================

create type public.booking_status as enum (
  -- Ödeme bekleniyor; tarihler booking_hold_minutes boyunca tutulur.
  'awaiting_payment',
  -- Talep: ev sahibi onayı bekleniyor (provizyon alındı).
  'pending',
  'confirmed',
  'declined',
  -- Ödeme süresi ya da ev sahibi yanıt süresi doldu.
  'expired',
  'cancelled',
  'completed'
);
create type public.cancel_actor as enum ('guest', 'host', 'system');
create type public.cancel_reason as enum ('plans_changed', 'found_other', 'host_asked', 'other');
create type public.discount_kind as enum ('early_booking', 'last_minute', 'long_stay', 'coupon', 'special');
create type public.card_brand as enum ('visa', 'mastercard', 'troy', 'amex', 'unknown');
create type public.payment_kind as enum ('payment', 'provision', 'refund');
create type public.payment_status as enum ('pending', 'succeeded', 'failed');
create type public.payout_status as enum ('scheduled', 'paid', 'failed', 'cancelled');
create type public.nationality as enum ('turkish', 'foreign');
create type public.coupon_kind as enum ('percent', 'amount');

-- -----------------------------------------------------------------------------
-- listing_calendar
-- -----------------------------------------------------------------------------

create table public.listing_calendar (
  listing_id uuid not null references public.listings (id) on delete cascade,
  day date not null,
  -- Ev sahibi bu geceyi kapattı.
  blocked boolean not null default false,
  -- Bu gece için özel fiyat (TRY); null = ilanın normal fiyatı.
  price int check (price > 0),
  primary key (listing_id, day)
);

alter table public.listing_calendar enable row level security;

create policy "Görünen ilanın takvimini herkes görür"
on public.listing_calendar for select
to anon, authenticated
using ((select public.is_listing_visible(listing_id)));

create policy "Ev sahibi takvim ekler"
on public.listing_calendar for insert
to authenticated
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi takvimi düzenler"
on public.listing_calendar for update
to authenticated
using ((select public.is_listing_host(listing_id)))
with check ((select public.is_listing_host(listing_id)));

create policy "Ev sahibi takvimden siler"
on public.listing_calendar for delete
to authenticated
using ((select public.is_listing_host(listing_id)));

-- -----------------------------------------------------------------------------
-- coupons
-- -----------------------------------------------------------------------------

create table public.coupons (
  code text primary key check (code ~ '^[A-Z0-9]{4,20}$'),
  kind public.coupon_kind not null,
  -- Yüzde (10) ya da tutar (500)
  value int not null check (value > 0),
  -- Yüzdelik kuponda en fazla indirim
  max_discount int check (max_discount > 0),
  -- En düşük sepet tutarı
  min_total int not null default 0 check (min_total >= 0),
  expires_at timestamptz not null,
  -- Toplam kullanım hakkı; null = sınırsız
  usage_limit int check (usage_limit > 0),
  used_count int not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  check (kind <> 'percent' or value <= 100)
);

create table public.user_coupons (
  user_id uuid not null references public.profiles (id) on delete cascade,
  code text not null references public.coupons (code) on delete cascade,
  added_at timestamptz not null default now(),
  used_at timestamptz,
  booking_id uuid,
  primary key (user_id, code)
);

alter table public.coupons enable row level security;
alter table public.user_coupons enable row level security;

-- Kupon kodları tahmin edilemesin: yalnızca hesaba eklenmiş kuponlar görünür.
create policy "Hesabındaki kuponları görür"
on public.coupons for select
to authenticated
using (exists (
  select 1 from public.user_coupons uc
  where uc.code = coupons.code and uc.user_id = (select auth.uid())
));

create policy "Kendi kuponlarını görür"
on public.user_coupons for select
to authenticated
using (user_id = (select auth.uid()));

-- -----------------------------------------------------------------------------
-- bookings
-- -----------------------------------------------------------------------------

create table public.bookings (
  id uuid primary key default gen_random_uuid(),
  -- Misafire gösterilen kod: "BV-48K2Q"
  code text not null unique,
  listing_id uuid not null references public.listings (id) on delete restrict,
  guest_id uuid not null references public.profiles (id) on delete restrict,
  -- RLS ve ev sahibi sorguları için ilanın sahibi (rezervasyon anında).
  host_id uuid not null references public.profiles (id) on delete restrict,

  check_in date not null,
  check_out date not null,
  stay daterange generated always as (daterange(check_in, check_out, '[)')) stored,
  adults smallint not null check (adults >= 1),
  children smallint not null default 0 check (children >= 0),
  infants smallint not null default 0 check (infants >= 0),
  pets smallint not null default 0 check (pets >= 0),

  status public.booking_status not null default 'awaiting_payment',
  -- Ev sahibi onaylı talep (40–43)
  is_request boolean not null,
  -- Talepte ev sahibine tanışma mesajı
  message text check (char_length(message) <= 1000),

  -- Fiyat kalemleri (rezervasyon anındaki; makbuz bunlardan üretilir)
  nights smallint not null check (nights >= 1),
  nightly_rate int not null,
  stay_total int not null,
  cleaning_fee int not null default 0,
  service_fee int not null default 0,
  discount int not null default 0,
  discount_kind public.discount_kind,
  coupon_code text references public.coupons (code),
  total int not null check (total >= 0),
  host_fee int not null default 0,
  host_payout int not null default 0,

  -- Ödeme
  hold_expires_at timestamptz,
  paid_at timestamptz,
  card_brand public.card_brand not null default 'unknown',
  card_last4 text check (card_last4 ~ '^[0-9]{4}$'),

  -- Talep
  requested_at timestamptz,
  respond_by timestamptz,
  responded_at timestamptz,
  decline_reason text check (char_length(decline_reason) <= 500),

  confirmed_at timestamptz,
  cancelled_at timestamptz,
  cancelled_by public.cancel_actor,
  cancel_reason public.cancel_reason,
  cancel_note text check (char_length(cancel_note) <= 500),
  refund_amount int check (refund_amount >= 0),
  completed_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  check (check_out > check_in),
  check (guest_id <> host_id),
  -- Aynı ilanda aktif rezervasyonlar çakışamaz (çifte rezervasyon engeli).
  constraint bookings_no_overlap exclude using gist (listing_id with =, stay with &&)
    where (status in ('awaiting_payment', 'pending', 'confirmed'))
);

create index bookings_guest_idx on public.bookings (guest_id, check_in desc);
create index bookings_host_idx on public.bookings (host_id, check_in desc);
create index bookings_listing_idx on public.bookings (listing_id, check_in);
create index bookings_hold_idx on public.bookings (hold_expires_at) where status = 'awaiting_payment';
create index bookings_request_idx on public.bookings (respond_by) where status = 'pending';

create trigger bookings_updated_at before update on public.bookings
for each row execute function private.set_updated_at();

alter table public.user_coupons
  add constraint user_coupons_booking_fk foreign key (booking_id) references public.bookings (id) on delete set null;

alter table public.bookings enable row level security;

-- Yazma yalnızca RPC'ler üzerinden (create_booking, cancel_booking, …).
create policy "Misafir, ev sahibi ve yönetici rezervasyonu görür"
on public.bookings for select
to authenticated
using (
  guest_id = (select auth.uid())
  or host_id = (select auth.uid())
  or (select public.is_admin())
);

create or replace function public.is_booking_party(p_booking uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.bookings
    where id = p_booking and (guest_id = auth.uid() or host_id = auth.uid())
  );
$$;

-- -----------------------------------------------------------------------------
-- booking_guests (KBS) — kimlik numarası ayrı, API'ye kapalı tabloda
-- -----------------------------------------------------------------------------

create table public.booking_guests (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  full_name text not null check (char_length(full_name) between 3 and 100),
  nationality public.nationality not null,
  -- Kimlik / pasaport numarasının son 2 hanesi
  id_last2 text not null check (char_length(id_last2) = 2),
  -- Rezervasyonu yapan kullanıcı
  is_primary boolean not null default false,
  created_at timestamptz not null default now()
);

create index booking_guests_booking_idx on public.booking_guests (booking_id);

create table private.booking_guest_identities (
  guest_id uuid primary key references public.booking_guests (id) on delete cascade,
  id_number text not null,
  birth_date date not null
);

alter table public.booking_guests enable row level security;

create policy "Rezervasyonun tarafları misafir listesini görür"
on public.booking_guests for select
to authenticated
using ((select public.is_booking_party(booking_id)) or (select public.is_admin()));

-- -----------------------------------------------------------------------------
-- payments
-- -----------------------------------------------------------------------------

create table public.payments (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete restrict,
  user_id uuid not null references public.profiles (id) on delete restrict,
  kind public.payment_kind not null,
  status public.payment_status not null default 'pending',
  amount int not null check (amount > 0),
  -- Ödeme sağlayıcısı ve işlem kimliği (webhook tekrarlarına karşı benzersiz)
  provider text,
  provider_ref text,
  card_brand public.card_brand not null default 'unknown',
  card_last4 text check (card_last4 ~ '^[0-9]{4}$'),
  failure_code text,
  created_at timestamptz not null default now(),
  processed_at timestamptz,
  unique (provider, provider_ref)
);

create index payments_user_idx on public.payments (user_id, created_at desc);
create index payments_booking_idx on public.payments (booking_id);
create index payments_pending_idx on public.payments (created_at) where status = 'pending';

alter table public.payments enable row level security;

create policy "Kendi ödemelerini görür"
on public.payments for select
to authenticated
using (user_id = (select auth.uid()) or (select public.is_admin()));

-- -----------------------------------------------------------------------------
-- payment_methods (kayıtlı kart)
-- -----------------------------------------------------------------------------

create table public.payment_methods (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  brand public.card_brand not null,
  last4 text not null check (last4 ~ '^[0-9]{4}$'),
  exp_month smallint not null check (exp_month between 1 and 12),
  -- İki haneli yıl: 28
  exp_year smallint not null check (exp_year between 0 and 99),
  is_default boolean not null default false,
  created_at timestamptz not null default now()
);

create unique index payment_methods_default_idx on public.payment_methods (user_id) where is_default;

create table private.payment_method_tokens (
  method_id uuid primary key references public.payment_methods (id) on delete cascade,
  provider text not null,
  -- Sağlayıcının kullanıcı ve kart anahtarları (örn. iyzico cardUserKey / cardToken)
  customer_key text not null,
  card_token text not null
);

alter table public.payment_methods enable row level security;

create policy "Kendi kartlarını görür"
on public.payment_methods for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi kartını siler"
on public.payment_methods for delete
to authenticated
using (user_id = (select auth.uid()));

-- -----------------------------------------------------------------------------
-- payouts (ev sahibine aktarım)
-- -----------------------------------------------------------------------------

create table public.payouts (
  id uuid primary key default gen_random_uuid(),
  host_id uuid not null references public.profiles (id) on delete restrict,
  booking_id uuid not null unique references public.bookings (id) on delete restrict,
  amount int not null check (amount >= 0),
  status public.payout_status not null default 'scheduled',
  -- Genelde girişten sonraki iş günü
  scheduled_for date not null,
  paid_at timestamptz,
  provider_ref text,
  created_at timestamptz not null default now()
);

create index payouts_host_idx on public.payouts (host_id, scheduled_for desc);

alter table public.payouts enable row level security;

create policy "Ev sahibi kendi aktarımlarını görür"
on public.payouts for select
to authenticated
using (host_id = (select auth.uid()) or (select public.is_admin()));
