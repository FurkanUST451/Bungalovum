-- =============================================================================
-- Bungalovum · 06 · Kaydedilenler, son bakılanlar, sohbet, bildirimler, cihazlar
-- =============================================================================

create type public.conversation_kind as enum ('stay', 'request', 'support');
create type public.notification_kind as enum (
  -- Misafir
  'booking_confirmed', 'request_approved', 'request_declined', 'request_expired',
  'booking_cancelled', 'message', 'price_drop', 'review_reminder', 'weather',
  -- Ev sahibi
  'booking_request_received', 'booking_received', 'listing_approved', 'listing_rejected'
);
create type public.device_platform as enum ('ios', 'android');

-- -----------------------------------------------------------------------------
-- wishlists (56–59)
-- -----------------------------------------------------------------------------

create table public.wishlists (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  name text not null check (char_length(btrim(name)) between 1 and 50),
  -- Bağlantıya sahip olanlar listeyi görebilir.
  shareable boolean not null default false,
  share_token uuid not null unique default gen_random_uuid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index wishlists_owner_idx on public.wishlists (owner_id, updated_at desc);

create table public.wishlist_items (
  wishlist_id uuid not null references public.wishlists (id) on delete cascade,
  listing_id uuid not null references public.listings (id) on delete cascade,
  -- Kişisel not ("Annemlerle gidebiliriz")
  note text check (char_length(note) <= 200),
  added_at timestamptz not null default now(),
  primary key (wishlist_id, listing_id)
);

create index wishlist_items_listing_idx on public.wishlist_items (listing_id);

create trigger wishlists_updated_at before update on public.wishlists
for each row execute function private.set_updated_at();

create or replace function private.touch_wishlist()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.wishlists set updated_at = now()
  where id = case when tg_op = 'DELETE' then old.wishlist_id else new.wishlist_id end;
  return null;
end;
$$;

create trigger wishlist_items_touch after insert or update or delete on public.wishlist_items
for each row execute function private.touch_wishlist();

alter table public.wishlists enable row level security;
alter table public.wishlist_items enable row level security;

create policy "Kendi listelerini yönetir"
on public.wishlists for all
to authenticated
using (owner_id = (select auth.uid()))
with check (owner_id = (select auth.uid()));

create or replace function public.is_wishlist_owner(p_wishlist uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.wishlists where id = p_wishlist and owner_id = auth.uid());
$$;

create policy "Kendi listelerinin ilanlarını yönetir"
on public.wishlist_items for all
to authenticated
using ((select public.is_wishlist_owner(wishlist_id)))
with check ((select public.is_wishlist_owner(wishlist_id)));

-- Paylaşılan liste (bağlantı ile).
create or replace function public.get_shared_wishlist(p_token uuid)
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select jsonb_build_object(
    'id', w.id,
    'name', w.name,
    'owner_name', coalesce(p.display_name, p.first_name),
    'listing_ids', coalesce((
      select jsonb_agg(i.listing_id order by i.added_at desc)
      from public.wishlist_items i
      join public.listings l on l.id = i.listing_id and l.status = 'published'
      where i.wishlist_id = w.id
    ), '[]'::jsonb)
  )
  from public.wishlists w
  join public.profiles p on p.id = w.owner_id
  where w.share_token = p_token and w.shareable;
$$;

-- -----------------------------------------------------------------------------
-- recent_views (60) — 30 günden eskiler silinir (09_jobs)
-- -----------------------------------------------------------------------------

create table public.recent_views (
  user_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  listing_id uuid not null references public.listings (id) on delete cascade,
  viewed_at timestamptz not null default now(),
  primary key (user_id, listing_id)
);

create index recent_views_user_idx on public.recent_views (user_id, viewed_at desc);

alter table public.recent_views enable row level security;

create policy "Kendi geçmişini yönetir"
on public.recent_views for all
to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));

create or replace function public.record_listing_view(p_listing uuid)
returns void
language sql
security invoker
set search_path = ''
as $$
  insert into public.recent_views (user_id, listing_id)
  values (auth.uid(), p_listing)
  on conflict (user_id, listing_id) do update set viewed_at = now();
$$;

-- -----------------------------------------------------------------------------
-- Sohbet (61–63)
-- -----------------------------------------------------------------------------

create sequence public.support_ticket_seq start 2001;

create table public.conversations (
  id uuid primary key default gen_random_uuid(),
  kind public.conversation_kind not null,
  listing_id uuid references public.listings (id) on delete set null,
  booking_id uuid references public.bookings (id) on delete set null,
  guest_id uuid not null references public.profiles (id) on delete cascade,
  -- Destek sohbetinde null (karşı taraf Bungalovum ekibi)
  host_id uuid references public.profiles (id) on delete cascade,
  -- Destek talep numarası: 2041
  ticket_no int unique,
  last_message_at timestamptz,
  last_message_preview text,
  last_sender_id uuid,
  created_at timestamptz not null default now(),
  check ((kind = 'support') = (host_id is null))
);

-- Misafir–ev sahibi arasında ilan başına tek sohbet; kullanıcı başına tek destek sohbeti.
create unique index conversations_pair_idx on public.conversations (guest_id, host_id, listing_id) where kind <> 'support';
create unique index conversations_support_idx on public.conversations (guest_id) where kind = 'support';

create table public.conversation_members (
  conversation_id uuid not null references public.conversations (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  last_read_at timestamptz not null default now(),
  muted boolean not null default false,
  primary key (conversation_id, user_id)
);

create index conversation_members_user_idx on public.conversation_members (user_id);

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations (id) on delete cascade,
  sender_id uuid not null default auth.uid() references public.profiles (id) on delete cascade,
  body text check (char_length(body) between 1 and 1000),
  -- chat-attachments bucket'ında: {conversation_id}/{uuid}.jpg
  attachment_path text,
  created_at timestamptz not null default now(),
  check (body is not null or attachment_path is not null)
);

create index messages_conversation_idx on public.messages (conversation_id, created_at desc);

create or replace function public.is_conversation_member(p_conversation uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.conversation_members
    where conversation_id = p_conversation and user_id = auth.uid()
  )
  or (
    -- Yöneticiler destek sohbetlerine katılır.
    exists (select 1 from private.admins where user_id = auth.uid())
    and exists (select 1 from public.conversations where id = p_conversation and kind = 'support')
  );
$$;

alter table public.conversations enable row level security;
alter table public.conversation_members enable row level security;
alter table public.messages enable row level security;

create policy "Üyeler sohbeti görür"
on public.conversations for select
to authenticated
using ((select public.is_conversation_member(id)));

create policy "Üyeler katılımcıları görür"
on public.conversation_members for select
to authenticated
using ((select public.is_conversation_member(conversation_id)));

create policy "Üyeler mesajları görür"
on public.messages for select
to authenticated
using ((select public.is_conversation_member(conversation_id)));

create policy "Üyeler mesaj gönderir"
on public.messages for insert
to authenticated
with check (sender_id = (select auth.uid()) and (select public.is_conversation_member(conversation_id)));

-- Son mesaj özeti, gönderenin okuma anı ve alıcıya bildirim.
create or replace function private.on_message_insert()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.conversations
  set last_message_at = new.created_at,
      last_message_preview = left(coalesce(new.body, ''), 120),
      last_sender_id = new.sender_id
  where id = new.conversation_id;

  update public.conversation_members
  set last_read_at = new.created_at
  where conversation_id = new.conversation_id and user_id = new.sender_id;

  -- Alıcı başına sohbet için tek okunmamış bildirim tutulur.
  update public.notifications n
  set created_at = new.created_at, data = jsonb_build_object('sender_id', new.sender_id)
  from public.conversation_members m
  where m.conversation_id = new.conversation_id and m.user_id <> new.sender_id and not m.muted
    and n.user_id = m.user_id and n.kind = 'message' and n.target_id = new.conversation_id and n.read_at is null;

  insert into public.notifications (user_id, kind, target_id, data)
  select m.user_id, 'message', new.conversation_id, jsonb_build_object('sender_id', new.sender_id)
  from public.conversation_members m
  where m.conversation_id = new.conversation_id and m.user_id <> new.sender_id and not m.muted
    and not exists (
      select 1 from public.notifications n
      where n.user_id = m.user_id and n.kind = 'message' and n.target_id = new.conversation_id and n.read_at is null
    );
  return null;
end;
$$;

-- Misafir ile ev sahibi arasında sohbet başlatır (varsa mevcut olanı döner).
create or replace function public.start_conversation(p_listing uuid, p_booking uuid default null)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_host uuid;
  v_kind public.conversation_kind := 'stay';
  v_id uuid;
begin
  select host_id into v_host from public.listings where id = p_listing and status in ('published', 'paused');
  if v_host is null then
    perform private.fail('listing_unavailable');
  end if;
  if v_host = v_uid then
    perform private.fail('own_listing');
  end if;
  if p_booking is not null then
    select case when status = 'pending' then 'request'::public.conversation_kind else 'stay'::public.conversation_kind end
    into v_kind
    from public.bookings where id = p_booking and guest_id = v_uid and listing_id = p_listing;
    if not found then
      perform private.fail('not_found');
    end if;
  end if;

  select id into v_id from public.conversations
  where guest_id = v_uid and host_id = v_host and listing_id = p_listing and kind <> 'support';

  if v_id is null then
    insert into public.conversations (kind, listing_id, booking_id, guest_id, host_id)
    values (v_kind, p_listing, p_booking, v_uid, v_host)
    returning id into v_id;
    insert into public.conversation_members (conversation_id, user_id)
    values (v_id, v_uid), (v_id, v_host);
  elsif p_booking is not null then
    update public.conversations set booking_id = p_booking, kind = v_kind where id = v_id;
  end if;
  return v_id;
end;
$$;

-- Bungalovum destek sohbeti; yoksa açar.
create or replace function public.open_support_conversation(p_booking uuid default null)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  v_id uuid;
begin
  select id into v_id from public.conversations where guest_id = v_uid and kind = 'support';
  if v_id is null then
    insert into public.conversations (kind, booking_id, guest_id, ticket_no)
    values ('support', p_booking, v_uid, nextval('public.support_ticket_seq'))
    returning id into v_id;
    insert into public.conversation_members (conversation_id, user_id) values (v_id, v_uid);
  elsif p_booking is not null then
    update public.conversations set booking_id = p_booking where id = v_id;
  end if;
  return v_id;
end;
$$;

-- 62 · Sohbet listesi: karşı taraf, son mesaj ve okunmamış sayısı.
create or replace function public.my_conversations()
returns table (
  id uuid,
  kind public.conversation_kind,
  listing_id uuid,
  booking_id uuid,
  ticket_no int,
  other_user_id uuid,
  title text,
  avatar_url text,
  last_message text,
  last_at timestamptz,
  last_from_me boolean,
  unread int
)
language sql
stable
security definer
set search_path = ''
as $$
  select
    c.id, c.kind, c.listing_id, c.booking_id, c.ticket_no,
    o.id,
    -- Destek sohbetinde başlık uygulamada ARB'den gelir.
    coalesce(o.display_name, o.first_name),
    o.avatar_url,
    c.last_message_preview,
    coalesce(c.last_message_at, c.created_at),
    c.last_sender_id = auth.uid(),
    (select count(*)::int from public.messages msg
     where msg.conversation_id = c.id and msg.sender_id <> auth.uid() and msg.created_at > me.last_read_at)
  from public.conversation_members me
  join public.conversations c on c.id = me.conversation_id
  left join public.profiles o on o.id = case when c.guest_id = auth.uid() then c.host_id else c.guest_id end
  where me.user_id = auth.uid()
  order by coalesce(c.last_message_at, c.created_at) desc;
$$;

-- -----------------------------------------------------------------------------
-- notifications (64) — metinler uygulamada kind + data'dan üretilir (ARB)
-- -----------------------------------------------------------------------------

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  kind public.notification_kind not null,
  -- Türüne göre rezervasyon, sohbet ya da ilan kimliği
  target_id uuid,
  data jsonb not null default '{}',
  read_at timestamptz,
  -- Push gönderildi mi (Edge Function işaretler)
  pushed_at timestamptz,
  created_at timestamptz not null default now()
);

create index notifications_user_idx on public.notifications (user_id, created_at desc);
create index notifications_push_idx on public.notifications (created_at) where pushed_at is null;

alter table public.notifications enable row level security;

create policy "Kendi bildirimlerini görür"
on public.notifications for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi bildirimini siler"
on public.notifications for delete
to authenticated
using (user_id = (select auth.uid()));

create trigger messages_after_insert after insert on public.messages
for each row execute function private.on_message_insert();

-- null → tümünü okundu yap.
create or replace function public.mark_notifications_read(p_ids uuid[] default null)
returns void
language sql
security definer
set search_path = ''
as $$
  update public.notifications set read_at = now()
  where user_id = auth.uid() and read_at is null and (p_ids is null or id = any (p_ids));
$$;

-- 63 · Sohbet açıldığında okundu işaretlenir (mesaj bildirimi de kapanır).
create or replace function public.mark_conversation_read(p_conversation uuid)
returns void
language sql
security definer
set search_path = ''
as $$
  update public.conversation_members set last_read_at = now()
  where conversation_id = p_conversation and user_id = auth.uid();
  update public.notifications set read_at = now()
  where user_id = auth.uid() and kind = 'message' and target_id = p_conversation and read_at is null;
$$;

-- Rezervasyon durum değişiklikleri → bildirim.
create or replace function private.notify_booking_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_data jsonb := jsonb_build_object('listing_id', new.listing_id, 'check_in', new.check_in, 'check_out', new.check_out);
begin
  if new.status is not distinct from old.status then
    return null;
  end if;

  if new.status = 'pending' then
    insert into public.notifications (user_id, kind, target_id, data)
    values (new.host_id, 'booking_request_received', new.id, v_data || jsonb_build_object('respond_by', new.respond_by));
  elsif new.status = 'confirmed' and old.status = 'pending' then
    insert into public.notifications (user_id, kind, target_id, data)
    values (new.guest_id, 'request_approved', new.id, v_data);
  elsif new.status = 'confirmed' then
    insert into public.notifications (user_id, kind, target_id, data)
    values (new.guest_id, 'booking_confirmed', new.id, v_data),
           (new.host_id, 'booking_received', new.id, v_data);
  elsif new.status = 'declined' then
    insert into public.notifications (user_id, kind, target_id, data)
    values (new.guest_id, 'request_declined', new.id, v_data);
  elsif new.status = 'expired' and old.status = 'pending' then
    insert into public.notifications (user_id, kind, target_id, data)
    values (new.guest_id, 'request_expired', new.id, v_data);
  elsif new.status = 'cancelled' and old.status in ('pending', 'confirmed') then
    insert into public.notifications (user_id, kind, target_id, data)
    values (
      case when new.cancelled_by = 'host' then new.guest_id else new.host_id end,
      'booking_cancelled', new.id, v_data || jsonb_build_object('cancelled_by', new.cancelled_by)
    );
  end if;
  return null;
end;
$$;

create trigger bookings_notify after update of status on public.bookings
for each row execute function private.notify_booking_change();

-- İlan inceleme sonucu → bildirim.
create or replace function private.notify_listing_review()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if old.status = 'in_review' and new.status in ('published', 'rejected') then
    insert into public.notifications (user_id, kind, target_id, data)
    values (
      new.host_id,
      case when new.status = 'published' then 'listing_approved'::public.notification_kind else 'listing_rejected'::public.notification_kind end,
      new.id,
      jsonb_build_object('title', new.title, 'note', new.review_note)
    );
  end if;
  return null;
end;
$$;

create trigger listings_notify_review after update of status on public.listings
for each row execute function private.notify_listing_review();

-- -----------------------------------------------------------------------------
-- devices (push bildirim token'ları — Firebase Cloud Messaging)
-- -----------------------------------------------------------------------------

create table public.devices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  push_token text not null unique,
  platform public.device_platform not null,
  -- "iPhone 15", "Pixel 8"
  device_name text check (char_length(device_name) <= 100),
  app_version text check (char_length(app_version) <= 20),
  last_seen_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create index devices_user_idx on public.devices (user_id);

alter table public.devices enable row level security;

create policy "Kendi cihazlarını görür"
on public.devices for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Kendi cihazını siler"
on public.devices for delete
to authenticated
using (user_id = (select auth.uid()));

-- Uygulama açılışında çağrılır. Token başka hesaba aitse bu hesaba taşınır
-- (aynı telefonda hesap değişimi).
create or replace function public.register_device(
  p_push_token text,
  p_platform public.device_platform,
  p_device_name text default null,
  p_app_version text default null
)
returns void
language sql
security definer
set search_path = ''
as $$
  insert into public.devices (user_id, push_token, platform, device_name, app_version)
  values (auth.uid(), p_push_token, p_platform, p_device_name, p_app_version)
  on conflict (push_token) do update
  set user_id = excluded.user_id,
      platform = excluded.platform,
      device_name = excluded.device_name,
      app_version = excluded.app_version,
      last_seen_at = now();
$$;

-- -----------------------------------------------------------------------------
-- Realtime: sohbet ve bildirimler anlık güncellenir (RLS uygulanır).
-- -----------------------------------------------------------------------------

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    alter publication supabase_realtime add table public.messages, public.notifications, public.conversations;
  end if;
end;
$$;
