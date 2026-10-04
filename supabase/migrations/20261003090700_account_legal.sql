-- =============================================================================
-- Bungalovum · 07 · Hesap, fatura, hukuki metinler, SSS, hesap kapatma
-- =============================================================================

create type public.billing_type as enum ('individual', 'corporate');
create type public.legal_doc as enum ('terms', 'kvkk', 'privacy', 'cookies', 'distance_sales', 'cancellation');

-- -----------------------------------------------------------------------------
-- billing_profiles (53 · Fatura Bilgileri) — TCKN ayrı, API'ye kapalı tabloda
-- -----------------------------------------------------------------------------

create table public.billing_profiles (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  type public.billing_type not null default 'individual',
  full_name text not null default '' check (char_length(full_name) <= 100),
  -- Bireyselde isteğe bağlı TCKN'nin son 2 hanesi
  tckn_last2 text check (char_length(tckn_last2) = 2),
  address text not null default '' check (char_length(address) <= 300),
  email text not null default '' check (char_length(email) <= 254),
  company_name text not null default '' check (char_length(company_name) <= 150),
  tax_office text not null default '' check (char_length(tax_office) <= 100),
  tax_number text not null default '' check (tax_number = '' or tax_number ~ '^[0-9]{10}$'),
  updated_at timestamptz not null default now()
);

create table private.billing_identities (
  user_id uuid primary key references public.billing_profiles (user_id) on delete cascade,
  tckn text not null
);

create trigger billing_profiles_updated_at before update on public.billing_profiles
for each row execute function private.set_updated_at();

alter table public.billing_profiles enable row level security;

create policy "Kendi fatura bilgisini görür"
on public.billing_profiles for select
to authenticated
using (user_id = (select auth.uid()));

create or replace function public.save_billing_info(
  p_type public.billing_type,
  p_full_name text,
  p_address text,
  p_email text,
  p_company_name text default '',
  p_tax_office text default '',
  p_tax_number text default '',
  -- null: mevcut TCKN korunur, '': silinir
  p_tckn text default null
)
returns public.billing_profiles
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_tckn text := regexp_replace(coalesce(p_tckn, ''), '\D', '', 'g');
  r public.billing_profiles;
begin
  if p_type = 'corporate' and (btrim(coalesce(p_company_name, '')) = '' or not private.is_valid_vkn(p_tax_number)) then
    perform private.fail('invalid_tax_id');
  end if;
  if p_tckn is not null and v_tckn <> '' and not private.is_valid_tckn(v_tckn) then
    perform private.fail('invalid_tckn');
  end if;

  insert into public.billing_profiles as b (user_id, type, full_name, address, email, company_name, tax_office, tax_number)
  values (v_uid, p_type, btrim(p_full_name), btrim(p_address), btrim(p_email),
          btrim(coalesce(p_company_name, '')), btrim(coalesce(p_tax_office, '')), coalesce(p_tax_number, ''))
  on conflict (user_id) do update
  set type = excluded.type, full_name = excluded.full_name, address = excluded.address, email = excluded.email,
      company_name = excluded.company_name, tax_office = excluded.tax_office, tax_number = excluded.tax_number;

  if p_tckn is not null then
    if v_tckn = '' then
      delete from private.billing_identities where user_id = v_uid;
      update public.billing_profiles set tckn_last2 = null where user_id = v_uid;
    else
      insert into private.billing_identities (user_id, tckn) values (v_uid, v_tckn)
      on conflict (user_id) do update set tckn = excluded.tckn;
      update public.billing_profiles set tckn_last2 = right(v_tckn, 2) where user_id = v_uid;
    end if;
  end if;

  select * into r from public.billing_profiles where user_id = v_uid;
  return r;
end;
$$;

-- -----------------------------------------------------------------------------
-- Hukuki metinler (72) ve onay kayıtları (KVKK)
-- -----------------------------------------------------------------------------

create table public.legal_documents (
  id uuid primary key default gen_random_uuid(),
  doc public.legal_doc not null,
  version int not null check (version >= 1),
  title text not null,
  -- Paragraflar; başlıklar "## " ile başlar (uygulamadaki LegalDocument)
  body text not null,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  unique (doc, version)
);

create table public.legal_consents (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  doc public.legal_doc not null,
  version int not null,
  accepted_at timestamptz not null default now(),
  unique (user_id, doc, version),
  foreign key (doc, version) references public.legal_documents (doc, version)
);

alter table public.legal_documents enable row level security;
alter table public.legal_consents enable row level security;

create policy "Yayındaki metinleri herkes okur"
on public.legal_documents for select
to anon, authenticated
using (published_at is not null and published_at <= now());

create policy "Kendi onaylarını görür"
on public.legal_consents for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi onayını kaydeder"
on public.legal_consents for insert
to authenticated
with check (user_id = (select auth.uid()));

-- Her belgenin yürürlükteki sürümü.
create or replace view public.current_legal_documents
with (security_invoker = true)
as
select distinct on (doc) *
from public.legal_documents
where published_at is not null and published_at <= now()
order by doc, version desc;

-- -----------------------------------------------------------------------------
-- SSS (71)
-- -----------------------------------------------------------------------------

create table public.faq_items (
  id uuid primary key default gen_random_uuid(),
  question text not null,
  answer text not null,
  position int not null default 0,
  published boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.faq_items enable row level security;

create policy "Yayındaki SSS'yi herkes okur"
on public.faq_items for select
to anon, authenticated
using (published);

-- -----------------------------------------------------------------------------
-- Hesabım (65) ve hesap kapatma (68)
-- -----------------------------------------------------------------------------

create or replace function public.my_account_stats()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select jsonb_build_object(
    'stays', (select count(*) from public.bookings where guest_id = auth.uid() and status = 'completed'),
    'reviews', (select count(*) from public.reviews where author_id = auth.uid()),
    'saved', (
      select count(distinct i.listing_id)
      from public.wishlist_items i join public.wishlists w on w.id = i.wishlist_id
      where w.owner_id = auth.uid()
    )
  );
$$;

create or replace function public.account_closure_impact()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select jsonb_build_object(
    -- Varsa hesap kapatılamaz.
    'upcoming_booking', (
      select jsonb_build_object('booking_id', b.id, 'title', l.title, 'check_in', b.check_in, 'check_out', b.check_out)
      from public.bookings b join public.listings l on l.id = b.listing_id
      where (b.guest_id = auth.uid() or b.host_id = auth.uid())
        and b.status in ('pending', 'confirmed') and b.check_out >= private.today()
      order by b.check_in
      limit 1
    ),
    'lists', (select count(*) from public.wishlists where owner_id = auth.uid()),
    'saved_listings', (
      select count(distinct i.listing_id)
      from public.wishlist_items i join public.wishlists w on w.id = i.wishlist_id
      where w.owner_id = auth.uid()
    )
  );
$$;

-- Silme talebi; Edge Function (auth.admin.deleteUser) yasal saklama
-- süreleri gözetilerek işler.
create table private.account_deletion_requests (
  user_id uuid primary key references auth.users (id) on delete cascade,
  reason text,
  requested_at timestamptz not null default now(),
  processed_at timestamptz
);

create or replace function public.request_account_deletion(p_reason text default null)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
begin
  if exists (
    select 1 from public.bookings
    where (guest_id = v_uid or host_id = v_uid)
      and status in ('awaiting_payment', 'pending', 'confirmed') and check_out >= private.today()
  ) then
    perform private.fail('upcoming_booking');
  end if;
  insert into private.account_deletion_requests (user_id, reason) values (v_uid, p_reason)
  on conflict (user_id) do update set reason = excluded.reason, requested_at = now(), processed_at = null;
end;
$$;

-- 77 · Kupon kodu ekle. Hata kodları uygulamadaki CouponError ile aynı.
create or replace function public.redeem_coupon(p_code text)
returns public.coupons
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_code text := upper(btrim(coalesce(p_code, '')));
  c public.coupons;
begin
  select * into c from public.coupons where code = v_code and active;
  if c.code is null then
    perform private.fail('not_found');
  end if;
  if c.expires_at <= now() or (c.usage_limit is not null and c.used_count >= c.usage_limit) then
    perform private.fail('expired');
  end if;
  insert into public.user_coupons (user_id, code) values (v_uid, c.code);
  return c;
exception
  when unique_violation then
    perform private.fail('already_added');
end;
$$;
