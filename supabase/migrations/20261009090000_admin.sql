-- =============================================================================
-- Bungalovum · 11 · Yönetici paneli (1. tur)
--
-- Panel ayrı repoda (bungalovum-admin, Flutter web). Şema yalnızca burada
-- değişir.
--
-- - private.admin_actions: yöneticinin durum değiştiren her işlemi
-- - Mevcut inceleme fonksiyonları işlem kaydı yazacak şekilde yeniden tanımlanır
-- - Panelin okuma RPC'leri: gösterge, menü rozetleri, kullanıcılar, ilanlar,
--   rezervasyonlar, inceleme kuyrukları, işlem kaydı
-- - Yönetici işlemleri: ilanı rezervasyona kapatma/açma, yayından kaldırma,
--   platform ayarları, hesap askıya alma kaydı (askıya alma Edge Function'da)
--
-- Kurallar: public şemada, security definer, set search_path = '', ilk satır
-- private.require_admin() (yetkisizse 'forbidden'). Hassas alanlar (TCKN,
-- IBAN, telefon, adres, KBS kimlik no) panelde maskesiz döner: kullanıcının
-- açık kararı (bungalovum-admin/CLAUDE.md §10).
-- =============================================================================

-- -----------------------------------------------------------------------------
-- İşlem kaydı
-- -----------------------------------------------------------------------------

create type public.admin_action_kind as enum (
  'listing_approved',
  'listing_rejected',
  'listing_section_approved',
  'listing_section_rejected',
  'listing_paused',
  'listing_resumed',
  'listing_unpublished',
  'identity_approved',
  'identity_rejected',
  'payout_approved',
  'payout_rejected',
  'user_banned',
  'user_unbanned',
  'settings_updated'
);

create type public.admin_target as enum ('listing', 'user', 'booking', 'settings');

create table private.admin_actions (
  id bigint generated always as identity primary key,
  admin_id uuid references auth.users (id) on delete set null,
  action public.admin_action_kind not null,
  target_type public.admin_target not null,
  -- İlan / kullanıcı / rezervasyon kimliği; ayarlarda null.
  target_id uuid,
  -- Değişen alanların önceki ve sonraki hali.
  before jsonb,
  after jsonb,
  note text check (char_length(note) <= 1000),
  created_at timestamptz not null default now()
);

create index admin_actions_created_idx on private.admin_actions (created_at desc);
create index admin_actions_target_idx on private.admin_actions (target_type, target_id, created_at desc);
create index admin_actions_admin_idx on private.admin_actions (admin_id, created_at desc);

create or replace function private.log_admin_action(
  p_action public.admin_action_kind,
  p_target_type public.admin_target,
  p_target_id uuid,
  p_before jsonb default null,
  p_after jsonb default null,
  p_note text default null
)
returns void
language sql
set search_path = ''
as $$
  insert into private.admin_actions (admin_id, action, target_type, target_id, before, after, note)
  values (auth.uid(), p_action, p_target_type, p_target_id, p_before, p_after, nullif(btrim(coalesce(p_note, '')), ''));
$$;

-- -----------------------------------------------------------------------------
-- Yardımcılar
-- -----------------------------------------------------------------------------

-- "Ayşe" + "Yılmaz" → "Ayşe Yılmaz"; ikisi de boşsa null.
create or replace function private.join_name(p_first text, p_last text)
returns text
language sql
immutable
set search_path = ''
as $$
  select nullif(btrim(regexp_replace(coalesce(p_first, '') || ' ' || coalesce(p_last, ''), '\s+', ' ', 'g')), '');
$$;

-- Arama metni → ILIKE deseni (% ve _ harfiyen aranır).
create or replace function private.like_pattern(p text)
returns text
language sql
immutable
set search_path = ''
as $$
  select '%' || replace(replace(replace(p, '\', '\\'), '%', '\%'), '_', '\_') || '%';
$$;

-- Sayfa boyutu 1–200 arası.
create or replace function private.page_limit(p int)
returns int
language sql
immutable
set search_path = ''
as $$
  select least(greatest(coalesce(p, 50), 1), 200);
$$;

-- Reddederken ev sahibine gidecek gerekçe zorunlu.
create or replace function private.require_note(p_note text)
returns void
language plpgsql
set search_path = ''
as $$
begin
  if btrim(coalesce(p_note, '')) = '' then
    perform private.fail('note_required');
  end if;
end;
$$;

-- -----------------------------------------------------------------------------
-- Mevcut inceleme fonksiyonları: işlem kaydı + ret gerekçesi zorunlu
-- (davranış 20261003090200_listings.sql ile aynı)
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
  v_old_status public.listing_status;
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  if not p_approve then
    perform private.require_note(v_note);
  end if;

  select status into v_old_status from public.listings where id = p_listing for update;

  update public.listings
  set sections_in_review = array_remove(sections_in_review, p_section),
      -- Reddedilen bölüm düzeltilene kadar ilan rezervasyona kapanır.
      status = case when p_approve then status else 'paused'::public.listing_status end,
      review_note = v_note
  where id = p_listing and p_section = any (sections_in_review)
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;
  if p_section = 'legal' then
    update public.listing_documents
    set status = case when p_approve then 'approved'::public.doc_status else 'rejected'::public.doc_status end,
        reviewed_at = now(), review_note = v_note
    where listing_id = p_listing and status = 'uploaded';
  end if;

  perform private.log_admin_action(
    case when p_approve then 'listing_section_approved'::public.admin_action_kind else 'listing_section_rejected'::public.admin_action_kind end,
    'listing', p_listing,
    jsonb_build_object('section', p_section, 'status', v_old_status),
    jsonb_build_object('section', p_section, 'status', l.status),
    v_note
  );
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
declare
  v_old private.host_accounts;
  v_new private.host_accounts;
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  if p_approve and btrim(coalesce(p_verified_name, '')) = '' then
    perform private.fail('verified_name_required');
  end if;
  if not p_approve then
    perform private.require_note(v_note);
  end if;

  select * into v_old from private.host_accounts where user_id = p_user for update;

  update private.host_accounts
  set identity_status = case when p_approve then 'approved'::public.verification_status else 'rejected'::public.verification_status end,
      verified_name = case when p_approve then btrim(p_verified_name) else verified_name end,
      identity_reviewed_at = now(),
      identity_review_note = v_note,
      -- Ad eşleşmiyorsa IBAN da reddedilir.
      payout_status = case
        when p_approve and iban is not null and not private.same_name(account_holder, p_verified_name) then 'rejected'::public.verification_status
        else payout_status
      end
  where user_id = p_user and identity_status = 'pending'
  returning * into v_new;
  if v_new.user_id is null then
    perform private.fail('invalid_status');
  end if;
  if p_approve then
    update public.profiles set identity_verified = true where id = p_user;
  end if;

  perform private.log_admin_action(
    case when p_approve then 'identity_approved'::public.admin_action_kind else 'identity_rejected'::public.admin_action_kind end,
    'user', p_user,
    jsonb_build_object('identity_status', v_old.identity_status, 'verified_name', v_old.verified_name, 'payout_status', v_old.payout_status),
    jsonb_build_object('identity_status', v_new.identity_status, 'verified_name', v_new.verified_name, 'payout_status', v_new.payout_status),
    v_note
  );
end;
$$;

-- Not parametresi eklendi (yalnızca işlem kaydına yazılır).
drop function public.admin_review_payout(uuid, boolean);

create or replace function public.admin_review_payout(p_user uuid, p_approve boolean, p_note text default null)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  if not p_approve then
    perform private.require_note(v_note);
  end if;

  update private.host_accounts
  set payout_status = case when p_approve then 'approved'::public.verification_status else 'rejected'::public.verification_status end,
      payout_reviewed_at = now()
  where user_id = p_user and payout_status = 'pending';
  if not found then
    perform private.fail('invalid_status');
  end if;

  perform private.log_admin_action(
    case when p_approve then 'payout_approved'::public.admin_action_kind else 'payout_rejected'::public.admin_action_kind end,
    'user', p_user,
    jsonb_build_object('payout_status', 'pending'),
    jsonb_build_object('payout_status', case when p_approve then 'approved' else 'rejected' end),
    v_note
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Menü rozetleri ve gösterge paneli
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
    'deletion_requests_open', (select count(*) from private.account_deletion_requests where processed_at is null)
  );
end;
$$;

create or replace function public.admin_dashboard()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_today date := private.today();
  v_day_start timestamptz := private.local_moment(v_today, '00:00');
  v_month_start timestamptz := private.local_moment(date_trunc('month', v_today)::date, '00:00');
begin
  perform private.require_admin();
  return jsonb_build_object(
    'today', v_today,
    'users', (
      select jsonb_build_object(
        'total', count(*),
        'new_today', count(*) filter (where u.created_at >= v_day_start),
        'new_7d', count(*) filter (where u.created_at >= now() - interval '7 days'),
        'new_30d', count(*) filter (where u.created_at >= now() - interval '30 days'),
        'hosts', count(*) filter (where p.is_host),
        'identity_verified', count(*) filter (where p.identity_verified),
        'active_7d', count(*) filter (where u.last_sign_in_at >= now() - interval '7 days')
      )
      from auth.users u
      left join public.profiles p on p.id = u.id
    ),
    'listings', (
      select jsonb_build_object(
        'total', count(*),
        'draft', count(*) filter (where status = 'draft'),
        'in_review', count(*) filter (where status = 'in_review'),
        'published', count(*) filter (where status = 'published'),
        'paused', count(*) filter (where status = 'paused'),
        'rejected', count(*) filter (where status = 'rejected')
      )
      from public.listings
    ),
    'pending', public.admin_badge_counts(),
    'bookings', (
      select jsonb_build_object(
        'total', count(*),
        'check_ins_today', count(*) filter (where status = 'confirmed' and check_in = v_today),
        'check_outs_today', count(*) filter (where status in ('confirmed', 'completed') and check_out = v_today),
        'in_house', count(*) filter (where status = 'confirmed' and check_in <= v_today and check_out > v_today),
        'upcoming', count(*) filter (where status = 'confirmed' and check_in > v_today),
        'awaiting_host', count(*) filter (where status = 'pending'),
        'awaiting_payment', count(*) filter (where status = 'awaiting_payment'),
        'cancelled', count(*) filter (where status = 'cancelled')
      )
      from public.bookings
    ),
    -- Ciro: onaylı ve tamamlanmış rezervasyonların toplamı (iptaller hariç).
    -- Komisyon: misafir hizmet bedeli + ev sahibi hizmet bedeli.
    'revenue', (
      select jsonb_build_object(
        'bookings', count(*),
        'gross', coalesce(sum(total), 0),
        'commission', coalesce(sum(service_fee + host_fee), 0),
        'host_payout', coalesce(sum(host_payout), 0),
        'gross_month', coalesce(sum(total) filter (where coalesce(confirmed_at, created_at) >= v_month_start), 0),
        'commission_month', coalesce(sum(service_fee + host_fee) filter (where coalesce(confirmed_at, created_at) >= v_month_start), 0)
      )
      from public.bookings
      where status in ('confirmed', 'completed')
    ),
    'settings', (
      select jsonb_build_object(
        'auto_approve_reviews', s.auto_approve_reviews,
        'guest_service_fee_percent', s.guest_service_fee_percent,
        'host_service_fee_percent', s.host_service_fee_percent
      )
      from public.platform_settings s where s.id
    )
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Kullanıcılar
-- -----------------------------------------------------------------------------

-- p_filter: all | hosts | verified | banned | deletion_requested
-- Arama: ad soyad, e-posta, telefon (0532…, +90 532…, 532…) ya da kullanıcı id.
create or replace function public.admin_list_users(
  p_search text default null,
  p_filter text default 'all',
  p_limit int default 50,
  p_offset int default 0
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_q text := nullif(btrim(coalesce(p_search, '')), '');
  v_like text;
  v_digits text := regexp_replace(coalesce(p_search, ''), '\D', '', 'g');
  v_filter text := coalesce(p_filter, 'all');
  v_result jsonb;
begin
  perform private.require_admin();
  if v_filter not in ('all', 'hosts', 'verified', 'banned', 'deletion_requested') then
    perform private.fail('invalid_filter');
  end if;
  v_like := private.like_pattern(coalesce(v_q, ''));
  v_digits := case
    when v_digits like '90%' and length(v_digits) > 10 then substr(v_digits, 3)
    else ltrim(v_digits, '0')
  end;

  with base as (
    select
      u.id,
      u.email::text as email,
      u.created_at,
      u.last_sign_in_at,
      u.banned_until,
      u.email_confirmed_at,
      p.first_name,
      a.last_name,
      p.display_name,
      private.join_name(p.first_name, a.last_name) as full_name,
      a.phone,
      p.avatar_url,
      p.city,
      coalesce(p.is_host, false) as is_host,
      coalesce(p.identity_verified, false) as identity_verified,
      (d.user_id is not null and d.processed_at is null) as deletion_requested
    from auth.users u
    left join public.profiles p on p.id = u.id
    left join public.account_details a on a.user_id = u.id
    left join private.account_deletion_requests d on d.user_id = u.id
    where (
        v_q is null
        or u.email ilike v_like
        or private.join_name(p.first_name, a.last_name) ilike v_like
        or p.display_name ilike v_like
        or (length(v_digits) >= 3 and a.phone like '%' || v_digits || '%')
        or u.id::text = lower(v_q)
      )
      and case v_filter
        when 'hosts' then coalesce(p.is_host, false)
        when 'verified' then coalesce(p.identity_verified, false)
        when 'banned' then coalesce(u.banned_until > now(), false)
        when 'deletion_requested' then d.user_id is not null and d.processed_at is null
        else true
      end
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(
        to_jsonb(r) || jsonb_build_object(
          'listing_count', (select count(*) from public.listings l where l.host_id = r.id),
          'booking_count', (select count(*) from public.bookings b where b.guest_id = r.id)
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

create or replace function public.admin_get_user(p_user uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_result jsonb;
begin
  perform private.require_admin();

  select jsonb_build_object(
    'id', u.id,
    'email', u.email,
    'email_confirmed_at', u.email_confirmed_at,
    'created_at', u.created_at,
    'last_sign_in_at', u.last_sign_in_at,
    'banned_until', u.banned_until,
    'providers', coalesce(u.raw_app_meta_data -> 'providers', '[]'::jsonb),
    'full_name', private.join_name(p.first_name, a.last_name),
    'profile', case when p.id is null then null else to_jsonb(p) end,
    'account', case when a.user_id is null then null else to_jsonb(a) end,
    'settings', case when s.user_id is null then null else to_jsonb(s) end,
    'host_account', case when h.user_id is null then null else to_jsonb(h) end,
    'billing', case when bp.user_id is null then null else to_jsonb(bp) || jsonb_build_object('tckn', bi.tckn) end,
    'deletion_request', case when d.user_id is null then null else to_jsonb(d) end,
    'listings', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', l.id,
        'listing_no', l.listing_no,
        'title', l.title,
        'status', l.status,
        'sections_in_review', l.sections_in_review,
        'city', l.city,
        'district', l.district,
        'nightly_price', l.nightly_price,
        'cover_url', ph.url,
        'created_at', l.created_at,
        'published_at', l.published_at
      ) order by l.created_at desc)
      from public.listings l
      left join public.listing_photos ph on ph.id = l.cover_photo_id
      where l.host_id = u.id
    ), '[]'::jsonb),
    'guest_bookings', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.check_in desc)
      from (
        select b.id, b.code, b.status, b.check_in, b.check_out, b.nights, b.total, b.created_at,
               l.id as listing_id, l.listing_no, l.title as listing_title
        from public.bookings b
        join public.listings l on l.id = b.listing_id
        where b.guest_id = u.id
        order by b.check_in desc
        limit 50
      ) x
    ), '[]'::jsonb),
    'host_bookings', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.check_in desc)
      from (
        select b.id, b.code, b.status, b.check_in, b.check_out, b.nights, b.total, b.host_payout, b.created_at,
               l.id as listing_id, l.listing_no, l.title as listing_title,
               private.join_name(gp.first_name, ga.last_name) as guest_name
        from public.bookings b
        join public.listings l on l.id = b.listing_id
        left join public.profiles gp on gp.id = b.guest_id
        left join public.account_details ga on ga.user_id = b.guest_id
        where b.host_id = u.id
        order by b.check_in desc
        limit 50
      ) x
    ), '[]'::jsonb),
    'issue_reports', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', r.id, 'booking_id', r.booking_id, 'booking_code', b.code, 'topic', r.topic,
        'urgency', r.urgency, 'status', r.status, 'description', r.description, 'created_at', r.created_at
      ) order by r.created_at desc)
      from public.issue_reports r
      join public.bookings b on b.id = r.booking_id
      where r.reporter_id = u.id or b.host_id = u.id
    ), '[]'::jsonb),
    'listing_reports_filed', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', r.id, 'listing_id', r.listing_id, 'listing_no', l.listing_no, 'listing_title', l.title,
        'reason', r.reason, 'details', r.details, 'status', r.status, 'created_at', r.created_at
      ) order by r.created_at desc)
      from public.listing_reports r
      join public.listings l on l.id = r.listing_id
      where r.reporter_id = u.id
    ), '[]'::jsonb),
    'listing_reports_received', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', r.id, 'listing_id', r.listing_id, 'listing_no', l.listing_no, 'listing_title', l.title,
        'reason', r.reason, 'details', r.details, 'status', r.status, 'created_at', r.created_at
      ) order by r.created_at desc)
      from public.listing_reports r
      join public.listings l on l.id = r.listing_id
      where l.host_id = u.id
    ), '[]'::jsonb),
    'actions', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.created_at desc)
      from (
        select aa.id, aa.action, aa.target_type, aa.target_id, aa.before, aa.after, aa.note, aa.created_at,
               aa.admin_id, au.email::text as admin_email
        from private.admin_actions aa
        left join auth.users au on au.id = aa.admin_id
        where aa.target_type = 'user' and aa.target_id = u.id
        order by aa.created_at desc
        limit 50
      ) x
    ), '[]'::jsonb)
  )
  into v_result
  from auth.users u
  left join public.profiles p on p.id = u.id
  left join public.account_details a on a.user_id = u.id
  left join public.user_settings s on s.user_id = u.id
  left join private.host_accounts h on h.user_id = u.id
  left join public.billing_profiles bp on bp.user_id = u.id
  left join private.billing_identities bi on bi.user_id = u.id
  left join private.account_deletion_requests d on d.user_id = u.id
  where u.id = p_user;

  if v_result is null then
    perform private.fail('not_found');
  end if;
  return v_result;
end;
$$;

-- Askıya alma Supabase Auth'ta yapılır (service_role gerekir): Edge Function
-- admin-user-ban çağıranın yönetici olduğunu doğrular, kullanıcıyı banlar,
-- sonra bu fonksiyonu yöneticinin oturumuyla çağırır. Kayıt, auth.users'taki
-- gerçek duruma göre yazılır.
create or replace function public.admin_record_user_ban(p_user uuid, p_note text default null)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_until timestamptz;
begin
  perform private.require_admin();
  select banned_until into v_until from auth.users where id = p_user;
  if not found then
    perform private.fail('not_found');
  end if;
  perform private.log_admin_action(
    case when v_until > now() then 'user_banned'::public.admin_action_kind else 'user_unbanned'::public.admin_action_kind end,
    'user', p_user,
    null,
    jsonb_build_object('banned_until', v_until),
    p_note
  );
  return jsonb_build_object('banned_until', v_until);
end;
$$;

-- -----------------------------------------------------------------------------
-- İlanlar
-- -----------------------------------------------------------------------------

-- Arama: ilan no (BV-1001), başlık, bölge/il/ilçe, ev sahibi adı ya da e-postası.
create or replace function public.admin_list_listings(
  p_search text default null,
  p_status public.listing_status default null,
  p_limit int default 50,
  p_offset int default 0
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
      u.email::text as host_email
    from public.listings l
    left join public.listing_photos ph on ph.id = l.cover_photo_id
    left join public.profiles p on p.id = l.host_id
    left join public.account_details a on a.user_id = l.host_id
    left join auth.users u on u.id = l.host_id
    where (p_status is null or l.status = p_status)
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

-- İnceleme ekranı ve ilan detayı: ilan + özel bilgiler + fotoğraflar +
-- belgeler (dosya yolu; panel imzalı adres üretir) + ev sahibi + eksikler.
create or replace function public.admin_get_listing(p_listing uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_result jsonb;
begin
  perform private.require_admin();

  select jsonb_build_object(
    'listing', to_jsonb(l),
    'private', case when lp.listing_id is null then null else to_jsonb(lp) end,
    'missing_steps', to_jsonb(private.listing_missing_steps(l.id)),
    'photos', coalesce((
      select jsonb_agg(to_jsonb(ph) order by ph.position, ph.created_at)
      from public.listing_photos ph where ph.listing_id = l.id
    ), '[]'::jsonb),
    'documents', coalesce((
      select jsonb_agg(to_jsonb(d) order by d.kind)
      from public.listing_documents d where d.listing_id = l.id
    ), '[]'::jsonb),
    'host', jsonb_build_object(
      'id', l.host_id,
      'email', u.email,
      'full_name', private.join_name(p.first_name, a.last_name),
      'first_name', p.first_name,
      'last_name', a.last_name,
      'display_name', p.display_name,
      'phone', a.phone,
      'avatar_url', p.avatar_url,
      'is_host', p.is_host,
      'identity_verified', p.identity_verified,
      'hosting_since', p.hosting_since,
      'created_at', u.created_at,
      'banned_until', u.banned_until,
      'listing_count', (select count(*) from public.listings x where x.host_id = l.host_id)
    ),
    'host_account', case when h.user_id is null then null else to_jsonb(h) end,
    'booking_stats', (
      select jsonb_build_object(
        'total', count(*),
        'upcoming', count(*) filter (where b.status in ('awaiting_payment', 'pending', 'confirmed') and b.check_out >= private.today()),
        'completed', count(*) filter (where b.status = 'completed'),
        'gross', coalesce(sum(b.total) filter (where b.status in ('confirmed', 'completed')), 0)
      )
      from public.bookings b where b.listing_id = l.id
    ),
    'bookings', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.check_in desc)
      from (
        select b.id, b.code, b.status, b.check_in, b.check_out, b.nights, b.total, b.created_at,
               private.join_name(gp.first_name, ga.last_name) as guest_name
        from public.bookings b
        left join public.profiles gp on gp.id = b.guest_id
        left join public.account_details ga on ga.user_id = b.guest_id
        where b.listing_id = l.id
        order by b.check_in desc
        limit 20
      ) x
    ), '[]'::jsonb),
    'reports', coalesce((
      select jsonb_agg(to_jsonb(r) order by r.created_at desc)
      from public.listing_reports r where r.listing_id = l.id
    ), '[]'::jsonb),
    'actions', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.created_at desc)
      from (
        select aa.id, aa.action, aa.target_type, aa.target_id, aa.before, aa.after, aa.note, aa.created_at,
               aa.admin_id, au.email::text as admin_email
        from private.admin_actions aa
        left join auth.users au on au.id = aa.admin_id
        where aa.target_type = 'listing' and aa.target_id = l.id
        order by aa.created_at desc
        limit 50
      ) x
    ), '[]'::jsonb),
    'rules', (
      select jsonb_build_object(
        'min_listing_photos', s.min_listing_photos,
        'auto_approve_reviews', s.auto_approve_reviews
      )
      from public.platform_settings s where s.id
    )
  )
  into v_result
  from public.listings l
  left join public.listing_private lp on lp.listing_id = l.id
  left join public.profiles p on p.id = l.host_id
  left join public.account_details a on a.user_id = l.host_id
  left join auth.users u on u.id = l.host_id
  left join private.host_accounts h on h.user_id = l.host_id
  where l.id = p_listing;

  if v_result is null then
    perform private.fail('not_found');
  end if;
  return v_result;
end;
$$;

-- İnceleme kuyruğu: incelemedeki ilanlar (en eski üstte) ve yayındaki
-- ilanlarda yeniden incelemeye giren bölümler.
create or replace function public.admin_review_queue()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return jsonb_build_object(
    'listings', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', l.id,
        'listing_no', l.listing_no,
        'title', l.title,
        'status', l.status,
        'property_type', l.property_type,
        'region', l.region,
        'city', l.city,
        'district', l.district,
        'submitted_at', l.submitted_at,
        'cover_url', ph.url,
        'photo_count', (select count(*) from public.listing_photos x where x.listing_id = l.id),
        'missing_steps', to_jsonb(private.listing_missing_steps(l.id)),
        'host_id', l.host_id,
        'host_name', private.join_name(p.first_name, a.last_name),
        'host_email', u.email,
        'identity_status', h.identity_status,
        'payout_status', h.payout_status,
        -- Daha önce reddedilip yeniden gönderilmiş mi?
        'previously_rejected', exists (
          select 1 from private.admin_actions aa
          where aa.target_type = 'listing' and aa.target_id = l.id and aa.action = 'listing_rejected'
        )
      ) order by l.submitted_at nulls first, l.created_at)
      from public.listings l
      left join public.listing_photos ph on ph.id = l.cover_photo_id
      left join public.profiles p on p.id = l.host_id
      left join public.account_details a on a.user_id = l.host_id
      left join auth.users u on u.id = l.host_id
      left join private.host_accounts h on h.user_id = l.host_id
      where l.status = 'in_review'
    ), '[]'::jsonb),
    'sections', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', l.id,
        'listing_no', l.listing_no,
        'title', l.title,
        'status', l.status,
        'sections_in_review', l.sections_in_review,
        'city', l.city,
        'district', l.district,
        'updated_at', l.updated_at,
        'cover_url', ph.url,
        'host_id', l.host_id,
        'host_name', private.join_name(p.first_name, a.last_name),
        'host_email', u.email,
        'identity_status', h.identity_status,
        'payout_status', h.payout_status
      ) order by l.updated_at)
      from public.listings l
      left join public.listing_photos ph on ph.id = l.cover_photo_id
      left join public.profiles p on p.id = l.host_id
      left join public.account_details a on a.user_id = l.host_id
      left join auth.users u on u.id = l.host_id
      left join private.host_accounts h on h.user_id = l.host_id
      where l.status in ('published', 'paused') and cardinality(l.sections_in_review) > 0
    ), '[]'::jsonb)
  );
end;
$$;

-- İlanı rezervasyona kapat (published → paused) ya da aç (paused → published).
create or replace function public.admin_set_listing_paused(p_listing uuid, p_paused boolean, p_note text default null)
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
  set status = case when p_paused then 'paused'::public.listing_status else 'published'::public.listing_status end
  where id = p_listing
    and status = case when p_paused then 'published'::public.listing_status else 'paused'::public.listing_status end
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;

  perform private.log_admin_action(
    case when p_paused then 'listing_paused'::public.admin_action_kind else 'listing_resumed'::public.admin_action_kind end,
    'listing', p_listing,
    jsonb_build_object('status', case when p_paused then 'published' else 'paused' end),
    jsonb_build_object('status', l.status),
    p_note
  );
  return l;
end;
$$;

-- Yayından kaldır: ilan taslağa döner, gerekçe ev sahibine review_note ile
-- görünür. Yaklaşan rezervasyonu olan ilan kaldırılamaz.
create or replace function public.admin_unpublish_listing(p_listing uuid, p_note text)
returns public.listings
language plpgsql
security definer
set search_path = ''
as $$
declare
  l public.listings;
  v_old_status public.listing_status;
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  perform private.require_note(v_note);

  if exists (
    select 1 from public.bookings
    where listing_id = p_listing
      and status in ('awaiting_payment', 'pending', 'confirmed')
      and check_out >= private.today()
  ) then
    perform private.fail('has_upcoming_bookings');
  end if;

  select status into v_old_status from public.listings where id = p_listing for update;

  update public.listings
  set status = 'draft', sections_in_review = '{}', review_note = v_note
  where id = p_listing and status in ('published', 'paused')
  returning * into l;
  if l.id is null then
    perform private.fail('invalid_status');
  end if;

  perform private.log_admin_action(
    'listing_unpublished', 'listing', p_listing,
    jsonb_build_object('status', v_old_status),
    jsonb_build_object('status', l.status),
    v_note
  );
  return l;
end;
$$;

-- -----------------------------------------------------------------------------
-- Rezervasyonlar (şimdilik yalnızca görüntüleme; ödeme sağlayıcısı seçilmedi)
-- -----------------------------------------------------------------------------

-- Arama: rezervasyon kodu, ilan no / başlığı, misafir ya da ev sahibi adı /
-- e-postası. Tarih filtresi giriş tarihine göredir.
create or replace function public.admin_list_bookings(
  p_search text default null,
  p_status public.booking_status default null,
  p_from date default null,
  p_to date default null,
  p_listing uuid default null,
  p_user uuid default null,
  p_limit int default 50,
  p_offset int default 0
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
      b.id, b.code, b.status, b.is_request, b.check_in, b.check_out, b.nights,
      b.adults, b.children, b.infants, b.pets,
      b.total, b.service_fee, b.host_fee, b.host_payout, b.discount, b.refund_amount,
      b.created_at, b.confirmed_at, b.cancelled_at, b.cancelled_by,
      b.listing_id, l.listing_no, l.title as listing_title,
      b.guest_id, private.join_name(gp.first_name, ga.last_name) as guest_name, gu.email::text as guest_email,
      b.host_id, private.join_name(hp.first_name, ha.last_name) as host_name, hu.email::text as host_email
    from public.bookings b
    join public.listings l on l.id = b.listing_id
    left join public.profiles gp on gp.id = b.guest_id
    left join public.account_details ga on ga.user_id = b.guest_id
    left join auth.users gu on gu.id = b.guest_id
    left join public.profiles hp on hp.id = b.host_id
    left join public.account_details ha on ha.user_id = b.host_id
    left join auth.users hu on hu.id = b.host_id
    where (p_status is null or b.status = p_status)
      and (p_from is null or b.check_in >= p_from)
      and (p_to is null or b.check_in <= p_to)
      and (p_listing is null or b.listing_id = p_listing)
      and (p_user is null or b.guest_id = p_user or b.host_id = p_user)
      and (
        v_q is null
        or b.code ilike v_like
        or l.listing_no ilike v_like
        or l.title ilike v_like
        or private.join_name(gp.first_name, ga.last_name) ilike v_like
        or private.join_name(hp.first_name, ha.last_name) ilike v_like
        or gu.email ilike v_like
        or hu.email ilike v_like
        or b.id::text = lower(v_q)
      )
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'sum_total', (select coalesce(sum(total), 0) from base where status in ('confirmed', 'completed')),
    'sum_commission', (select coalesce(sum(service_fee + host_fee), 0) from base where status in ('confirmed', 'completed')),
    'rows', coalesce((
      select jsonb_agg(to_jsonb(r) order by r.created_at desc)
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

create or replace function public.admin_get_booking(p_booking uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_result jsonb;
begin
  perform private.require_admin();

  select jsonb_build_object(
    'booking', to_jsonb(b),
    'listing', jsonb_build_object(
      'id', l.id,
      'listing_no', l.listing_no,
      'title', l.title,
      'status', l.status,
      'city', l.city,
      'district', l.district,
      'cover_url', ph.url,
      'cancellation_policy', l.cancellation_policy,
      'check_in_from', l.check_in_from,
      'check_out_by', l.check_out_by
    ),
    'guest', jsonb_build_object(
      'id', b.guest_id,
      'email', gu.email,
      'full_name', private.join_name(gp.first_name, ga.last_name),
      'phone', ga.phone,
      'avatar_url', gp.avatar_url
    ),
    'host', jsonb_build_object(
      'id', b.host_id,
      'email', hu.email,
      'full_name', private.join_name(hp.first_name, ha.last_name),
      'phone', ha.phone,
      'avatar_url', hp.avatar_url
    ),
    -- KBS misafir listesi (kimlik no maskesiz).
    'guests', coalesce((
      select jsonb_agg(to_jsonb(g) || jsonb_build_object('id_number', gi.id_number, 'birth_date', gi.birth_date)
                       order by g.is_primary desc, g.created_at)
      from public.booking_guests g
      left join private.booking_guest_identities gi on gi.guest_id = g.id
      where g.booking_id = b.id
    ), '[]'::jsonb),
    'payments', coalesce((
      select jsonb_agg(to_jsonb(pm) order by pm.created_at)
      from public.payments pm where pm.booking_id = b.id
    ), '[]'::jsonb),
    'payout', (select to_jsonb(po) from public.payouts po where po.booking_id = b.id),
    'issue_reports', coalesce((
      select jsonb_agg(to_jsonb(r) order by r.created_at desc)
      from public.issue_reports r where r.booking_id = b.id
    ), '[]'::jsonb),
    'review', (select to_jsonb(rv) from public.reviews rv where rv.booking_id = b.id),
    'coupon', (select to_jsonb(c) from public.coupons c where c.code = b.coupon_code),
    'actions', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.created_at desc)
      from (
        select aa.id, aa.action, aa.target_type, aa.target_id, aa.before, aa.after, aa.note, aa.created_at,
               aa.admin_id, au.email::text as admin_email
        from private.admin_actions aa
        left join auth.users au on au.id = aa.admin_id
        where aa.target_type = 'booking' and aa.target_id = b.id
        order by aa.created_at desc
        limit 50
      ) x
    ), '[]'::jsonb)
  )
  into v_result
  from public.bookings b
  join public.listings l on l.id = b.listing_id
  left join public.listing_photos ph on ph.id = l.cover_photo_id
  left join public.profiles gp on gp.id = b.guest_id
  left join public.account_details ga on ga.user_id = b.guest_id
  left join auth.users gu on gu.id = b.guest_id
  left join public.profiles hp on hp.id = b.host_id
  left join public.account_details ha on ha.user_id = b.host_id
  left join auth.users hu on hu.id = b.host_id
  where b.id = p_booking;

  if v_result is null then
    perform private.fail('not_found');
  end if;
  return v_result;
end;
$$;

-- -----------------------------------------------------------------------------
-- Kimlik ve IBAN kuyruğu
-- -----------------------------------------------------------------------------

-- Bekleyen kimlikler (fotoğraf yolları identity-documents bucket'ında; panel
-- imzalı adres üretir) ve bekleyen IBAN'lar. En eski üstte.
create or replace function public.admin_verification_queue()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return jsonb_build_object(
    'identities', coalesce((
      select jsonb_agg(jsonb_build_object(
        'user_id', h.user_id,
        'full_name', private.join_name(p.first_name, a.last_name),
        'email', u.email,
        'phone', a.phone,
        'birth_date', a.birth_date,
        'identity_front_path', h.identity_front_path,
        'identity_back_path', h.identity_back_path,
        'selfie_path', h.selfie_path,
        'tax_type', h.tax_type,
        'tax_id', h.tax_id,
        'account_holder', h.account_holder,
        'iban', h.iban,
        'payout_status', h.payout_status,
        'updated_at', h.updated_at,
        'listings', coalesce((
          select jsonb_agg(jsonb_build_object('id', l.id, 'listing_no', l.listing_no, 'title', l.title, 'status', l.status))
          from public.listings l where l.host_id = h.user_id
        ), '[]'::jsonb)
      ) order by h.updated_at)
      from private.host_accounts h
      left join public.profiles p on p.id = h.user_id
      left join public.account_details a on a.user_id = h.user_id
      left join auth.users u on u.id = h.user_id
      where h.identity_status = 'pending'
    ), '[]'::jsonb),
    'payouts', coalesce((
      select jsonb_agg(jsonb_build_object(
        'user_id', h.user_id,
        'full_name', private.join_name(p.first_name, a.last_name),
        'email', u.email,
        'account_holder', h.account_holder,
        'iban', h.iban,
        'iban_valid', private.is_valid_tr_iban(h.iban),
        'identity_status', h.identity_status,
        'verified_name', h.verified_name,
        'name_matches', case
          when h.verified_name is null then null
          else private.same_name(h.account_holder, h.verified_name)
        end,
        'updated_at', h.updated_at
      ) order by h.updated_at)
      from private.host_accounts h
      left join public.profiles p on p.id = h.user_id
      left join public.account_details a on a.user_id = h.user_id
      left join auth.users u on u.id = h.user_id
      where h.payout_status = 'pending'
    ), '[]'::jsonb)
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Ayarlar
-- -----------------------------------------------------------------------------

alter table public.platform_settings
  add constraint platform_settings_min_listing_photos_check check (min_listing_photos between 1 and 50);

-- Yalnızca gönderilen anahtarlar değişir: {"auto_approve_reviews": false}.
-- İşlem kaydına yalnızca gerçekten değişen alanlar yazılır.
create or replace function public.admin_update_settings(p_changes jsonb)
returns public.platform_settings
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_allowed constant text[] := array[
    'guest_service_fee_percent', 'host_service_fee_percent', 'booking_hold_minutes',
    'request_response_hours', 'access_reveal_hours', 'review_window_days', 'max_nights',
    'min_listing_photos', 'auto_approve_reviews'
  ];
  v_key text;
  v_old public.platform_settings;
  v_new public.platform_settings;
  v_before jsonb;
  v_after jsonb;
begin
  perform private.require_admin();
  if p_changes is null or jsonb_typeof(p_changes) <> 'object' then
    perform private.fail('invalid_settings');
  end if;
  for v_key in select jsonb_object_keys(p_changes) loop
    if not (v_key = any (v_allowed)) or jsonb_typeof(p_changes -> v_key) = 'null' then
      perform private.fail('invalid_settings', v_key);
    end if;
  end loop;

  select * into v_old from public.platform_settings where id for update;

  begin
    update public.platform_settings
    set guest_service_fee_percent = coalesce((p_changes ->> 'guest_service_fee_percent')::numeric, guest_service_fee_percent),
        host_service_fee_percent = coalesce((p_changes ->> 'host_service_fee_percent')::numeric, host_service_fee_percent),
        booking_hold_minutes = coalesce((p_changes ->> 'booking_hold_minutes')::int, booking_hold_minutes),
        request_response_hours = coalesce((p_changes ->> 'request_response_hours')::int, request_response_hours),
        access_reveal_hours = coalesce((p_changes ->> 'access_reveal_hours')::int, access_reveal_hours),
        review_window_days = coalesce((p_changes ->> 'review_window_days')::int, review_window_days),
        max_nights = coalesce((p_changes ->> 'max_nights')::int, max_nights),
        min_listing_photos = coalesce((p_changes ->> 'min_listing_photos')::int, min_listing_photos),
        auto_approve_reviews = coalesce((p_changes ->> 'auto_approve_reviews')::boolean, auto_approve_reviews)
    where id
    returning * into v_new;
  exception
    when check_violation or invalid_text_representation or numeric_value_out_of_range then
      perform private.fail('invalid_settings');
  end;

  select jsonb_object_agg(k, to_jsonb(v_old) -> k), jsonb_object_agg(k, to_jsonb(v_new) -> k)
  into v_before, v_after
  from jsonb_object_keys(p_changes) as k
  where (to_jsonb(v_old) -> k) is distinct from (to_jsonb(v_new) -> k);

  if v_after is not null then
    perform private.log_admin_action('settings_updated', 'settings', null, v_before, v_after, null);
  end if;
  return v_new;
end;
$$;

-- -----------------------------------------------------------------------------
-- İşlem kaydı listesi
-- -----------------------------------------------------------------------------

-- Tarih filtresi Türkiye saatine göre gün olarak (p_from–p_to dahil).
create or replace function public.admin_list_actions(
  p_admin uuid default null,
  p_action public.admin_action_kind default null,
  p_target_type public.admin_target default null,
  p_target_id uuid default null,
  p_from date default null,
  p_to date default null,
  p_limit int default 50,
  p_offset int default 0
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_result jsonb;
begin
  perform private.require_admin();

  with base as (
    select
      aa.id, aa.action, aa.target_type, aa.target_id, aa.before, aa.after, aa.note, aa.created_at,
      aa.admin_id,
      au.email::text as admin_email,
      private.join_name(ap.first_name, aad.last_name) as admin_name,
      case aa.target_type
        when 'listing' then (select concat_ws(' · ', l.listing_no, nullif(l.title, '')) from public.listings l where l.id = aa.target_id)
        when 'user' then (
          select coalesce(private.join_name(p.first_name, a.last_name), u.email::text)
          from auth.users u
          left join public.profiles p on p.id = u.id
          left join public.account_details a on a.user_id = u.id
          where u.id = aa.target_id
        )
        when 'booking' then (select b.code from public.bookings b where b.id = aa.target_id)
      end as target_label
    from private.admin_actions aa
    left join auth.users au on au.id = aa.admin_id
    left join public.profiles ap on ap.id = aa.admin_id
    left join public.account_details aad on aad.user_id = aa.admin_id
    where (p_admin is null or aa.admin_id = p_admin)
      and (p_action is null or aa.action = p_action)
      and (p_target_type is null or aa.target_type = p_target_type)
      and (p_target_id is null or aa.target_id = p_target_id)
      and (p_from is null or aa.created_at >= private.local_moment(p_from, '00:00'))
      and (p_to is null or aa.created_at < private.local_moment(p_to + 1, '00:00'))
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(to_jsonb(r) order by r.created_at desc, r.id desc)
      from (
        select * from base
        order by created_at desc, id desc
        limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
      ) r
    ), '[]'::jsonb),
    -- Filtre için yönetici listesi.
    'admins', coalesce((
      select jsonb_agg(jsonb_build_object(
        'user_id', ad.user_id,
        'email', u.email,
        'full_name', private.join_name(p.first_name, a.last_name)
      ) order by u.email)
      from private.admins ad
      join auth.users u on u.id = ad.user_id
      left join public.profiles p on p.id = ad.user_id
      left join public.account_details a on a.user_id = ad.user_id
    ), '[]'::jsonb)
  )
  into v_result;
  return v_result;
end;
$$;

-- -----------------------------------------------------------------------------
-- Yetki: yönetici fonksiyonları anonim kullanıcıya kapalı (asıl denetim yine
-- private.require_admin(); giriş yapmış ama yönetici olmayan 'forbidden' alır).
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
