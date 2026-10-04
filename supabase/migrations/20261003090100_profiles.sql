-- =============================================================================
-- Bungalovum · 01 · Kullanıcılar
-- profiles        → herkese açık profil (ev sahibi kartı, değerlendirme yazarı)
-- account_details → yalnızca kullanıcının kendisi (soyad, telefon, adres…)
-- user_settings   → bildirim ve gizlilik tercihleri
-- E-posta ve şifre auth.users'ta (Supabase Auth) tutulur.
-- =============================================================================

create type public.host_level as enum ('standard', 'superhost');

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  first_name text not null default '' check (char_length(first_name) <= 50),
  -- Ev sahiplerine görünen kısa ad; boşsa first_name kullanılır.
  display_name text check (char_length(display_name) <= 50),
  avatar_url text,
  city text check (char_length(city) <= 60),
  about text not null default '' check (char_length(about) <= 1000),
  languages text[] not null default '{tr}',
  -- Aşağıdakileri yalnızca sistem değiştirir (protect_profile_columns).
  is_host boolean not null default false,
  host_level public.host_level not null default 'standard',
  identity_verified boolean not null default false,
  hosting_since date,
  -- Yüzde (0–100) ve dakika; mesaj istatistiklerinden hesaplanır.
  response_rate smallint check (response_rate between 0 and 100),
  response_minutes int check (response_minutes >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.profiles is 'Herkese açık profil. Hassas alanlar account_details''tadır.';

create table public.account_details (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  last_name text not null default '' check (char_length(last_name) <= 50),
  -- 10 haneli TR cep numarası: 5XXXXXXXXX
  phone text check (phone ~ '^5[0-9]{9}$'),
  birth_date date check (birth_date > date '1900-01-01'),
  address text check (char_length(address) <= 300),
  emergency_contact_name text check (char_length(emergency_contact_name) <= 100),
  emergency_contact_phone text check (emergency_contact_phone ~ '^5[0-9]{9}$'),
  -- İYS (ticari ileti) izni.
  marketing_consent boolean not null default false,
  marketing_consent_at timestamptz,
  updated_at timestamptz not null default now()
);

create table public.user_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  -- { "promotions": ["push","email"], "stay_reminders": [...], ... }
  -- Konular: promotions, stay_reminders, news, surveys, rule_updates
  -- Kanallar: push, email, sms
  notification_prefs jsonb not null default '{
    "promotions": [],
    "stay_reminders": ["push", "email"],
    "news": [],
    "surveys": [],
    "rule_updates": ["email"]
  }'::jsonb,
  show_profile_to_hosts boolean not null default true,
  show_name_in_reviews boolean not null default true,
  personalized_recs boolean not null default true,
  updated_at timestamptz not null default now()
);

create trigger profiles_updated_at before update on public.profiles
for each row execute function private.set_updated_at();
create trigger account_details_updated_at before update on public.account_details
for each row execute function private.set_updated_at();
create trigger user_settings_updated_at before update on public.user_settings
for each row execute function private.set_updated_at();

-- Ev sahibi rozeti, kimlik doğrulaması ve istatistikleri uygulama değiştiremez.
create or replace function private.protect_profile_columns()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  if current_user in ('anon', 'authenticated') and (
    new.id is distinct from old.id
    or new.is_host is distinct from old.is_host
    or new.host_level is distinct from old.host_level
    or new.identity_verified is distinct from old.identity_verified
    or new.hosting_since is distinct from old.hosting_since
    or new.response_rate is distinct from old.response_rate
    or new.response_minutes is distinct from old.response_minutes
    or new.created_at is distinct from old.created_at
  ) then
    raise exception using errcode = '42501', message = 'protected_column';
  end if;
  return new;
end;
$$;

create trigger profiles_protect before update on public.profiles
for each row execute function private.protect_profile_columns();

create or replace function private.protect_account_details()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  if new.user_id is distinct from old.user_id then
    raise exception using errcode = '42501', message = 'protected_column';
  end if;
  -- İzin değiştiğinde zaman damgası tutulur (İYS kaydı).
  if new.marketing_consent is distinct from old.marketing_consent then
    new.marketing_consent_at := now();
  end if;
  return new;
end;
$$;

create trigger account_details_protect before update on public.account_details
for each row execute function private.protect_account_details();

-- -----------------------------------------------------------------------------
-- Kayıtta otomatik profil. E-posta kaydında uygulama şu metadata'yı gönderir:
--   first_name, last_name, phone, birth_date (YYYY-MM-DD), marketing_consent
-- Google girişinde given_name / family_name / full_name / avatar_url gelir.
-- -----------------------------------------------------------------------------

create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  m jsonb := coalesce(new.raw_user_meta_data, '{}'::jsonb);
  v_full text := btrim(coalesce(m ->> 'full_name', m ->> 'name', ''));
  v_first text;
  v_last text;
  v_phone text := regexp_replace(coalesce(m ->> 'phone', ''), '\D', '', 'g');
  v_birth text := m ->> 'birth_date';
  v_marketing boolean := coalesce(m ->> 'marketing_consent' in ('true', '1'), false);
begin
  v_first := btrim(coalesce(m ->> 'first_name', m ->> 'given_name', ''));
  v_last := btrim(coalesce(m ->> 'last_name', m ->> 'family_name', ''));
  -- Yalnızca tam ad geldiyse: son kelime soyad.
  if v_first = '' and v_full <> '' then
    v_first := btrim(regexp_replace(v_full, '\s+\S+$', ''));
    v_last := case when v_full ~ '\s' then substring(v_full from '(\S+)$') else '' end;
    if v_first = '' then
      v_first := v_full;
    end if;
  end if;

  -- 0 veya 90 ile başlayan numaraları 10 haneye indir.
  v_phone := right(v_phone, 10);
  if v_phone !~ '^5[0-9]{9}$' then
    v_phone := null;
  end if;

  insert into public.profiles (id, first_name, avatar_url)
  values (new.id, left(v_first, 50), coalesce(m ->> 'avatar_url', m ->> 'picture'));

  insert into public.account_details (user_id, last_name, phone, birth_date, marketing_consent, marketing_consent_at)
  values (
    new.id,
    left(v_last, 50),
    v_phone,
    case when v_birth ~ '^\d{4}-\d{2}-\d{2}$' then v_birth::date end,
    v_marketing,
    case when v_marketing then now() end
  );

  insert into public.user_settings (user_id, notification_prefs)
  values (
    new.id,
    case when v_marketing then
      '{"promotions": ["push","email"], "stay_reminders": ["push","email"], "news": ["push"], "surveys": [], "rule_updates": ["email"]}'::jsonb
    else
      '{"promotions": [], "stay_reminders": ["push","email"], "news": [], "surveys": [], "rule_updates": ["email"]}'::jsonb
    end
  );

  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute function private.handle_new_user();

-- -----------------------------------------------------------------------------
-- RLS
-- -----------------------------------------------------------------------------

alter table public.profiles enable row level security;
alter table public.account_details enable row level security;
alter table public.user_settings enable row level security;

create policy "Profilleri herkes okur"
on public.profiles for select
to anon, authenticated
using (true);

create policy "Kendi profilini düzenler"
on public.profiles for update
to authenticated
using (id = (select auth.uid()))
with check (id = (select auth.uid()));

create policy "Kendi hesap bilgilerini okur"
on public.account_details for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi hesap bilgilerini düzenler"
on public.account_details for update
to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));

create policy "Kendi ayarlarını okur"
on public.user_settings for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi ayarlarını düzenler"
on public.user_settings for update
to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));
