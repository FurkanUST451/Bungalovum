-- =============================================================================
-- Bungalovum · 00 · Temel
-- Eklentiler, şemalar, ortak yardımcılar ve platform ayarları.
--
-- Şema düzeni:
--   public  → API'den erişilen tablolar (hepsinde RLS açık) ve RPC fonksiyonları
--   private → API'ye kapalı: hassas veriler (TCKN, IBAN, kart token'ı, misafir
--             kimlik numaraları) ve iç fonksiyonlar. anon/authenticated bu
--             şemaya hiç erişemez; okuma/yazma yalnızca RPC'ler üzerinden olur.
--
-- Kurallar:
--   * Para: tam TRY (kuruşsuz) integer. Uygulamadaki int alanlarla aynı.
--   * Tarih: konaklama günleri `date`, anlar `timestamptz`. "Bugün" her zaman
--     Europe/Istanbul saatine göre hesaplanır (private.today()).
--   * Enum değerleri Dart enum adlarının snake_case karşılığıdır
--     (inReview → in_review).
--   * Tüm fonksiyonlar `set search_path = ''` ile yazılır, isimler tam nitelenir.
-- =============================================================================

create extension if not exists btree_gist with schema extensions;
create extension if not exists pg_trgm with schema extensions;

create schema if not exists private;
revoke all on schema private from public, anon, authenticated;
grant usage on schema private to service_role;

-- private şemasındaki fonksiyonlar varsayılan olarak herkese açık olmasın.
alter default privileges in schema private revoke execute on functions from public;

-- -----------------------------------------------------------------------------
-- Ortak yardımcılar
-- -----------------------------------------------------------------------------

create or replace function private.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

-- Not: "Bu kolonu yalnızca RPC değiştirebilir" kuralı trigger'larda
-- `current_user in ('anon', 'authenticated')` kontrolüyle uygulanır. Security
-- definer RPC'lerin içinde current_user fonksiyon sahibidir, kontrol geçer.
-- Bu trigger'lar invoker yetkisiyle çalıştığı için içlerinde private.*
-- fonksiyon çağrılmaz (anon/authenticated'ın private şemasına erişimi yok).

-- Türkiye saatine göre bugünün tarihi.
create or replace function private.today()
returns date
language sql
stable
set search_path = ''
as $$
  select (now() at time zone 'Europe/Istanbul')::date;
$$;

-- Konaklama gününün belirli saatindeki an (Türkiye saati).
create or replace function private.local_moment(p_day date, p_time time)
returns timestamptz
language sql
stable
set search_path = ''
as $$
  select (p_day + p_time) at time zone 'Europe/Istanbul';
$$;

-- Hatalar uygulamaya sabit kodlarla döner: message = kod (örn. 'dates_unavailable'),
-- uygulama bu kodu ARB'deki Türkçe metne eşler.
create or replace function private.fail(p_code text, p_detail text default null)
returns void
language plpgsql
set search_path = ''
as $$
begin
  if p_detail is null then
    raise exception using errcode = 'P0001', message = p_code;
  end if;
  raise exception using errcode = 'P0001', message = p_code, detail = p_detail;
end;
$$;

-- Kimliği doğrulanmış kullanıcı; yoksa hata.
create or replace function private.require_user()
returns uuid
language plpgsql
stable
set search_path = ''
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    perform private.fail('auth_required');
  end if;
  return v_uid;
end;
$$;

-- -----------------------------------------------------------------------------
-- Doğrulayıcılar (uygulamadaki IdValidators / IbanValidator ile aynı kurallar)
-- -----------------------------------------------------------------------------

-- T.C. kimlik no: 11 hane, ilk hane 0 değil, 10. ve 11. haneler kontrol hanesi.
create or replace function private.is_valid_tckn(p text)
returns boolean
language plpgsql
immutable
set search_path = ''
as $$
declare
  d int[];
  odd int;
  even int;
begin
  if p is null or p !~ '^[1-9][0-9]{10}$' then
    return false;
  end if;
  select array_agg(c::int order by i) into d
  from unnest(string_to_array(p, null)) with ordinality as t(c, i);
  odd := d[1] + d[3] + d[5] + d[7] + d[9];
  even := d[2] + d[4] + d[6] + d[8];
  if ((odd * 7 - even) % 10 + 10) % 10 <> d[10] then
    return false;
  end if;
  return (d[1] + d[2] + d[3] + d[4] + d[5] + d[6] + d[7] + d[8] + d[9] + d[10]) % 10 = d[11];
end;
$$;

-- Vergi kimlik no: 10 hane (biçim kontrolü).
create or replace function private.is_valid_vkn(p text)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select p is not null and p ~ '^[0-9]{10}$';
$$;

create or replace function private.is_valid_passport(p text)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select p is not null and btrim(p) ~ '^[A-Za-z0-9]{6,9}$';
$$;

-- "TR12 0006 …" → "TR120006…"
create or replace function private.normalize_iban(p text)
returns text
language sql
immutable
set search_path = ''
as $$
  select upper(regexp_replace(coalesce(p, ''), '\s', '', 'g'));
$$;

-- TR IBAN biçimi + ISO 13616 mod-97.
create or replace function private.is_valid_tr_iban(p text)
returns boolean
language plpgsql
immutable
set search_path = ''
as $$
declare
  s text := private.normalize_iban(p);
  rearranged text;
  ch text;
  digits text;
  rem int := 0;
  i int;
  j int;
begin
  if s !~ '^TR[0-9]{24}$' then
    return false;
  end if;
  rearranged := substr(s, 5) || substr(s, 1, 4);
  for i in 1 .. length(rearranged) loop
    ch := substr(rearranged, i, 1);
    digits := case when ch ~ '[A-Z]' then (ascii(ch) - 55)::text else ch end;
    for j in 1 .. length(digits) loop
      rem := (rem * 10 + substr(digits, j, 1)::int) % 97;
    end loop;
  end loop;
  return rem = 1;
end;
$$;

-- "•••• 89 01" (KVKK: ekranda maskeli).
create or replace function private.mask_tail(p text)
returns text
language sql
immutable
set search_path = ''
as $$
  select case
    when p is null or length(p) < 4 then p
    else '•••• ' || substr(p, length(p) - 3, 2) || ' ' || right(p, 2)
  end;
$$;

-- Türkçe büyük/küçük harf ve boşluk farklarını yok sayan ad karşılaştırması
-- (uygulamadaki NameMatcher ile aynı).
create or replace function private.same_name(a text, b text)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select lower(regexp_replace(replace(replace(btrim(coalesce(a, '')), 'I', 'ı'), 'İ', 'i'), '\s+', ' ', 'g'))
       = lower(regexp_replace(replace(replace(btrim(coalesce(b, '')), 'I', 'ı'), 'İ', 'i'), '\s+', ' ', 'g'));
$$;

-- Okunması kolay rastgele kod (karışan 0/O, 1/I harfleri yok).
create or replace function private.random_code(p_length int)
returns text
language sql
volatile
set search_path = ''
as $$
  select string_agg(substr('23456789ABCDEFGHJKLMNPQRSTUVWXYZ', 1 + floor(random() * 32)::int, 1), '')
  from generate_series(1, p_length);
$$;

-- -----------------------------------------------------------------------------
-- Yöneticiler
-- -----------------------------------------------------------------------------

create table private.admins (
  user_id uuid primary key references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from private.admins where user_id = auth.uid());
$$;

-- -----------------------------------------------------------------------------
-- Platform ayarları (tek satır). Komisyon ve süreler burada; kodda sabit oran
-- yazılmaz (CLAUDE.md §10). Değerler başlangıç varsayımıdır, iş kararına göre
-- güncellenir.
-- -----------------------------------------------------------------------------

create table public.platform_settings (
  id boolean primary key default true check (id),
  -- Misafirden alınan hizmet bedeli (konaklama + temizlik üzerinden, %).
  guest_service_fee_percent numeric(5, 2) not null default 10 check (guest_service_fee_percent between 0 and 50),
  -- Ev sahibinden kesilen hizmet bedeli (%).
  host_service_fee_percent numeric(5, 2) not null default 3 check (host_service_fee_percent between 0 and 50),
  -- Ödeme sırasında tarihlerin tutulduğu süre.
  booking_hold_minutes int not null default 15 check (booking_hold_minutes between 5 and 60),
  -- Ev sahibinin talebe yanıt süresi.
  request_response_hours int not null default 24 check (request_response_hours between 1 and 72),
  -- Giriş bilgilerinin (adres, anahtar kutusu, Wi-Fi) açıldığı süre (girişten önce).
  access_reveal_hours int not null default 24 check (access_reveal_hours between 0 and 168),
  -- Konaklama sonrası değerlendirme yazma süresi.
  review_window_days int not null default 14 check (review_window_days between 1 and 60),
  -- En uzun konaklama.
  max_nights int not null default 30 check (max_nights between 1 and 365),
  -- Ev sahibi sihirbazı kuralları (uygulamadaki ListingRules ile aynı).
  min_listing_photos int not null default 8,
  updated_at timestamptz not null default now()
);

insert into public.platform_settings (id) values (true);

create trigger platform_settings_updated_at
before update on public.platform_settings
for each row execute function private.set_updated_at();

alter table public.platform_settings enable row level security;

create policy "Ayarları herkes okur"
on public.platform_settings for select
to anon, authenticated
using (true);

create or replace function private.settings()
returns public.platform_settings
language sql
stable
set search_path = ''
as $$
  select * from public.platform_settings where id;
$$;
