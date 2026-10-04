-- =============================================================================
-- Bungalovum · 05 · Değerlendirmeler, sorun bildirimi, ilan şikayeti
-- =============================================================================

create type public.review_like as enum ('pool', 'view', 'quiet', 'cleanliness', 'host', 'location');
create type public.issue_topic as enum ('pool', 'hot_water', 'cleaning', 'wifi', 'climate', 'other');
create type public.issue_urgency as enum ('low', 'today', 'urgent');
create type public.ticket_status as enum ('open', 'in_progress', 'resolved');
create type public.report_reason as enum ('inaccurate', 'fraud', 'off_platform_payment', 'safety', 'other');

-- -----------------------------------------------------------------------------
-- reviews (23 · Değerlendirmeler, 55 · Değerlendirme Yaz)
-- -----------------------------------------------------------------------------

create table public.reviews (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null unique references public.bookings (id) on delete cascade,
  listing_id uuid not null references public.listings (id) on delete cascade,
  author_id uuid not null references public.profiles (id) on delete cascade,
  host_id uuid not null references public.profiles (id) on delete cascade,
  overall smallint not null check (overall between 1 and 5),
  cleanliness smallint not null check (cleanliness between 1 and 5),
  accuracy smallint not null check (accuracy between 1 and 5),
  communication smallint not null check (communication between 1 and 5),
  location smallint not null check (location between 1 and 5),
  value smallint not null check (value between 1 and 5),
  likes public.review_like[] not null default '{}',
  body text not null check (char_length(body) between 20 and 500),
  -- Cloudflare R2 adresleri
  photo_urls text[] not null default '{}' check (cardinality(photo_urls) <= 6),
  -- Yazarın "Değerlendirmelerde adımı göster" tercihi (yazıldığı andaki)
  show_author boolean not null default true,
  host_reply text check (char_length(host_reply) <= 1000),
  host_replied_at timestamptz,
  created_at timestamptz not null default now()
);

create index reviews_listing_idx on public.reviews (listing_id, created_at desc);
create index reviews_host_idx on public.reviews (host_id);

alter table public.reviews enable row level security;

create policy "Değerlendirmeleri herkes okur"
on public.reviews for select
to anon, authenticated
using (true);

-- İlan puanlarını yeniden hesaplar.
create or replace function private.refresh_listing_rating()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_listing uuid := case when tg_op = 'DELETE' then old.listing_id else new.listing_id end;
begin
  update public.listings l
  set review_count = s.cnt,
      rating_avg = s.overall,
      rating_cleanliness = s.cleanliness,
      rating_accuracy = s.accuracy,
      rating_communication = s.communication,
      rating_location = s.location,
      rating_value = s.value
  from (
    select
      count(*)::int as cnt,
      round(avg(overall), 2) as overall,
      round(avg(cleanliness), 2) as cleanliness,
      round(avg(accuracy), 2) as accuracy,
      round(avg(communication), 2) as communication,
      round(avg(location), 2) as location,
      round(avg(value), 2) as value
    from public.reviews where listing_id = v_listing
  ) s
  where l.id = v_listing;
  return null;
end;
$$;

create trigger reviews_refresh_rating
after insert or update of overall, cleanliness, accuracy, communication, location, value or delete
on public.reviews
for each row execute function private.refresh_listing_rating();

-- 23 · "Misafirler en çok neyi sevdi?" (ReviewTopicCount)
create or replace function public.listing_review_topics(p_listing uuid)
returns table (topic public.review_like, count int)
language sql
stable
set search_path = ''
as $$
  select t, count(*)::int
  from public.reviews r, unnest(r.likes) as t
  where r.listing_id = p_listing
  group by t
  order by 2 desc;
$$;

create or replace function public.submit_review(
  p_booking uuid,
  p_overall int,
  p_cleanliness int,
  p_accuracy int,
  p_communication int,
  p_location int,
  p_value int,
  p_likes public.review_like[] default '{}',
  p_body text default '',
  p_photo_urls text[] default '{}'
)
returns public.reviews
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  b public.bookings;
  r public.reviews;
begin
  select * into b from public.bookings
  where id = p_booking and guest_id = v_uid
    and (status = 'completed' or (status = 'confirmed' and check_out <= private.today()));
  if b.id is null then
    perform private.fail('review_not_allowed');
  end if;
  if private.today() > b.check_out + (private.settings()).review_window_days then
    perform private.fail('review_window_closed');
  end if;

  insert into public.reviews (
    booking_id, listing_id, author_id, host_id,
    overall, cleanliness, accuracy, communication, location, value,
    likes, body, photo_urls, show_author
  ) values (
    b.id, b.listing_id, v_uid, b.host_id,
    p_overall, p_cleanliness, p_accuracy, p_communication, p_location, p_value,
    coalesce(p_likes, '{}'), btrim(coalesce(p_body, '')), coalesce(p_photo_urls, '{}'),
    coalesce((select show_name_in_reviews from public.user_settings where user_id = v_uid), true)
  )
  returning * into r;
  return r;
exception
  when unique_violation then
    perform private.fail('already_reviewed');
end;
$$;

create or replace function public.reply_to_review(p_review uuid, p_reply text)
returns public.reviews
language plpgsql
security definer
set search_path = ''
as $$
declare
  r public.reviews;
begin
  update public.reviews
  set host_reply = nullif(btrim(coalesce(p_reply, '')), ''), host_replied_at = now()
  where id = p_review and host_id = private.require_user()
  returning * into r;
  if r.id is null then
    perform private.fail('not_found');
  end if;
  return r;
end;
$$;

-- -----------------------------------------------------------------------------
-- issue_reports (51 · Sorun Bildir) — fotoğraflar Storage › issue-photos
-- -----------------------------------------------------------------------------

create table public.issue_reports (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  reporter_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  topic public.issue_topic not null,
  urgency public.issue_urgency not null,
  description text not null check (char_length(description) between 10 and 1000),
  -- issue-photos bucket'ında: {booking_id}/{uuid}.jpg
  photo_paths text[] not null default '{}' check (cardinality(photo_paths) <= 5),
  status public.ticket_status not null default 'open',
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

create index issue_reports_booking_idx on public.issue_reports (booking_id);
create index issue_reports_open_idx on public.issue_reports (created_at) where status <> 'resolved';

alter table public.issue_reports enable row level security;

create policy "Misafir konaklaması için sorun bildirir"
on public.issue_reports for insert
to authenticated
with check (
  reporter_id = (select auth.uid())
  and status = 'open'
  and exists (
    select 1 from public.bookings b
    where b.id = booking_id and b.guest_id = (select auth.uid()) and b.status in ('confirmed', 'completed')
  )
);

create policy "Bildiren, ev sahibi ve yönetici görür"
on public.issue_reports for select
to authenticated
using (
  reporter_id = (select auth.uid())
  or (select public.is_booking_party(booking_id))
  or (select public.is_admin())
);

-- -----------------------------------------------------------------------------
-- listing_reports (29 · İlanı Bildir)
-- -----------------------------------------------------------------------------

create table public.listing_reports (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings (id) on delete cascade,
  reporter_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  reason public.report_reason not null,
  details text check (char_length(details) <= 1000),
  status public.ticket_status not null default 'open',
  created_at timestamptz not null default now(),
  resolved_at timestamptz,
  -- Aynı kişi aynı ilanı aynı nedenle bir kez bildirir.
  unique (listing_id, reporter_id, reason)
);

alter table public.listing_reports enable row level security;

create policy "Giriş yapan kullanıcı ilan bildirir"
on public.listing_reports for insert
to authenticated
with check (reporter_id = (select auth.uid()) and status = 'open');

create policy "Bildiren ve yönetici görür"
on public.listing_reports for select
to authenticated
using (reporter_id = (select auth.uid()) or (select public.is_admin()));

create policy "Yönetici bildirimleri günceller"
on public.listing_reports for update
to authenticated
using ((select public.is_admin()))
with check ((select public.is_admin()));

create policy "Yönetici sorun bildirimlerini günceller"
on public.issue_reports for update
to authenticated
using ((select public.is_admin()))
with check ((select public.is_admin()));
