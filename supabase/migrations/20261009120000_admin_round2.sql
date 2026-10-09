-- =============================================================================
-- Bungalovum · 13 · Yönetici paneli 2. tur
--
-- - Şikayetler: ilan bildirimi + konaklama sorunu listesi ve durum güncelleme
-- - Değerlendirmeler: gizleme (reviews.hidden_at); gizli değerlendirme
--   misafire görünmez ve puan ortalamasına girmez
-- - Kuponlar: oluşturma, pasifleştirme, kullanım
-- - Hesap silme talepleri: işleme alma (kalıcı silme yok, bkz. aşağı)
-- - İçerik: hukuki metinlerde yeni sürüm yayınlama, SSS
-- - Destek sohbetleri: liste, yanıt
-- - İşlem kaydı: kodla tanınan hedefler (kupon kodu, hukuki metin) için
--   target_key; yeni hedef türlerinin etiketleri
--
-- Kurallar 20261009090000_admin.sql ile aynı (security definer,
-- search_path = '', ilk satır private.require_admin()).
-- =============================================================================

-- -----------------------------------------------------------------------------
-- İşlem kaydı: kodla tanınan hedefler
-- -----------------------------------------------------------------------------

alter table private.admin_actions add column target_key text;

create index admin_actions_target_key_idx on private.admin_actions (target_type, target_key)
  where target_key is not null;

-- Hedefi uuid olmayan işlemler (kupon kodu, "terms v3").
create or replace function private.log_admin_action_key(
  p_action public.admin_action_kind,
  p_target_type public.admin_target,
  p_target_key text,
  p_before jsonb default null,
  p_after jsonb default null,
  p_note text default null
)
returns void
language sql
set search_path = ''
as $$
  insert into private.admin_actions (admin_id, action, target_type, target_key, before, after, note)
  values (auth.uid(), p_action, p_target_type, p_target_key, p_before, p_after, nullif(btrim(coalesce(p_note, '')), ''));
$$;

-- -----------------------------------------------------------------------------
-- Menü rozetleri: bekleyen destek sohbetleri eklendi
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
    -- Son mesajı kullanıcı yazmış destek sohbetleri (yanıt bekliyor).
    'support_waiting', (
      select count(*) from public.conversations
      where kind = 'support' and last_sender_id = guest_id
    )
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Şikayetler (listing_reports, issue_reports)
-- -----------------------------------------------------------------------------

-- p_kind: listing (ilan bildirimi) | issue (konaklama sorunu). En yeni üstte;
-- açıklar önce.
create or replace function public.admin_list_reports(
  p_kind text default 'listing',
  p_status public.ticket_status default null,
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
  if p_kind not in ('listing', 'issue') then
    perform private.fail('invalid_filter');
  end if;

  if p_kind = 'listing' then
    with base as (
      select
        r.id, r.status, r.reason, r.details, r.created_at, r.resolved_at,
        r.listing_id, l.listing_no, l.title as listing_title, l.status as listing_status,
        l.host_id, private.join_name(hp.first_name, ha.last_name) as host_name,
        r.reporter_id, private.join_name(rp.first_name, ra.last_name) as reporter_name,
        ru.email::text as reporter_email
      from public.listing_reports r
      join public.listings l on l.id = r.listing_id
      left join public.profiles hp on hp.id = l.host_id
      left join public.account_details ha on ha.user_id = l.host_id
      left join public.profiles rp on rp.id = r.reporter_id
      left join public.account_details ra on ra.user_id = r.reporter_id
      left join auth.users ru on ru.id = r.reporter_id
      where p_status is null or r.status = p_status
    )
    select jsonb_build_object(
      'total', (select count(*) from base),
      'rows', coalesce((
        select jsonb_agg(to_jsonb(x) order by x.resolved_at is not null, x.created_at desc)
        from (
          select * from base
          order by resolved_at is not null, created_at desc
          limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
        ) x
      ), '[]'::jsonb)
    ) into v_result;
  else
    with base as (
      select
        r.id, r.status, r.topic, r.urgency, r.description, r.photo_paths, r.created_at, r.resolved_at,
        r.booking_id, b.code as booking_code, b.check_in, b.check_out,
        b.listing_id, l.listing_no, l.title as listing_title,
        b.host_id, private.join_name(hp.first_name, ha.last_name) as host_name, ha.phone as host_phone,
        r.reporter_id, private.join_name(rp.first_name, ra.last_name) as reporter_name,
        ru.email::text as reporter_email, ra.phone as reporter_phone
      from public.issue_reports r
      join public.bookings b on b.id = r.booking_id
      join public.listings l on l.id = b.listing_id
      left join public.profiles hp on hp.id = b.host_id
      left join public.account_details ha on ha.user_id = b.host_id
      left join public.profiles rp on rp.id = r.reporter_id
      left join public.account_details ra on ra.user_id = r.reporter_id
      left join auth.users ru on ru.id = r.reporter_id
      where p_status is null or r.status = p_status
    )
    select jsonb_build_object(
      'total', (select count(*) from base),
      'rows', coalesce((
        select jsonb_agg(to_jsonb(x) order by x.resolved_at is not null, x.created_at desc)
        from (
          select * from base
          order by resolved_at is not null, created_at desc
          limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
        ) x
      ), '[]'::jsonb)
    ) into v_result;
  end if;
  return v_result;
end;
$$;

create or replace function public.admin_set_report_status(
  p_kind text,
  p_id uuid,
  p_status public.ticket_status,
  p_note text default null
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_old public.ticket_status;
begin
  perform private.require_admin();
  if p_kind = 'listing' then
    select status into v_old from public.listing_reports where id = p_id for update;
    if not found then
      perform private.fail('not_found');
    end if;
    update public.listing_reports
    set status = p_status,
        resolved_at = case when p_status = 'resolved' then coalesce(resolved_at, now()) else null end
    where id = p_id;
  elsif p_kind = 'issue' then
    select status into v_old from public.issue_reports where id = p_id for update;
    if not found then
      perform private.fail('not_found');
    end if;
    update public.issue_reports
    set status = p_status,
        resolved_at = case when p_status = 'resolved' then coalesce(resolved_at, now()) else null end
    where id = p_id;
  else
    perform private.fail('invalid_filter');
  end if;

  perform private.log_admin_action(
    'report_updated', 'report', p_id,
    jsonb_build_object('kind', p_kind, 'status', v_old),
    jsonb_build_object('kind', p_kind, 'status', p_status),
    p_note
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Değerlendirmeler: gizleme
-- -----------------------------------------------------------------------------

alter table public.reviews
  add column hidden_at timestamptz,
  add column hidden_reason text check (char_length(hidden_reason) <= 1000);

-- Gizli değerlendirme yalnızca yazarına, ev sahibine ve yöneticiye görünür.
drop policy "Değerlendirmeleri herkes okur" on public.reviews;

create policy "Gizlenmemiş değerlendirmeleri herkes okur"
on public.reviews for select
to anon, authenticated
using (
  hidden_at is null
  or author_id = (select auth.uid())
  or host_id = (select auth.uid())
  or (select public.is_admin())
);

-- Puan ortalaması gizli değerlendirmeleri saymaz.
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
    from public.reviews where listing_id = v_listing and hidden_at is null
  ) s
  where l.id = v_listing;
  return null;
end;
$$;

drop trigger reviews_refresh_rating on public.reviews;

create trigger reviews_refresh_rating
after insert or update of overall, cleanliness, accuracy, communication, location, value, hidden_at or delete
on public.reviews
for each row execute function private.refresh_listing_rating();

create or replace function public.listing_review_topics(p_listing uuid)
returns table (topic public.review_like, count int)
language sql
stable
set search_path = ''
as $$
  select t, count(*)::int
  from public.reviews r, unnest(r.likes) as t
  where r.listing_id = p_listing and r.hidden_at is null
  group by t
  order by 2 desc;
$$;

-- p_filter: all | visible | hidden. Arama: ilan no / başlığı, yazar, metin.
create or replace function public.admin_list_reviews(
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
  v_like text := private.like_pattern(btrim(coalesce(p_search, '')));
  v_result jsonb;
begin
  perform private.require_admin();
  if coalesce(p_filter, 'all') not in ('all', 'visible', 'hidden') then
    perform private.fail('invalid_filter');
  end if;

  with base as (
    select
      r.id, r.booking_id, b.code as booking_code,
      r.listing_id, l.listing_no, l.title as listing_title,
      r.author_id, private.join_name(ap.first_name, aa.last_name) as author_name, au.email::text as author_email,
      r.host_id, private.join_name(hp.first_name, ha.last_name) as host_name,
      r.overall, r.cleanliness, r.accuracy, r.communication, r.location, r.value,
      r.likes, r.body, r.photo_urls, r.show_author, r.host_reply, r.host_replied_at,
      r.hidden_at, r.hidden_reason, r.created_at
    from public.reviews r
    join public.listings l on l.id = r.listing_id
    left join public.bookings b on b.id = r.booking_id
    left join public.profiles ap on ap.id = r.author_id
    left join public.account_details aa on aa.user_id = r.author_id
    left join auth.users au on au.id = r.author_id
    left join public.profiles hp on hp.id = r.host_id
    left join public.account_details ha on ha.user_id = r.host_id
    where case coalesce(p_filter, 'all')
        when 'visible' then r.hidden_at is null
        when 'hidden' then r.hidden_at is not null
        else true
      end
      and (
        v_q is null
        or l.listing_no ilike v_like
        or l.title ilike v_like
        or r.body ilike v_like
        or private.join_name(ap.first_name, aa.last_name) ilike v_like
        or au.email ilike v_like
      )
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.created_at desc)
      from (
        select * from base
        order by created_at desc
        limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
      ) x
    ), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;

-- Gizlerken gerekçe zorunlu (işlem kaydına ve hidden_reason'a yazılır).
create or replace function public.admin_set_review_hidden(p_review uuid, p_hidden boolean, p_note text default null)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
  v_was timestamptz;
begin
  perform private.require_admin();
  if p_hidden then
    perform private.require_note(v_note);
  end if;
  select hidden_at into v_was from public.reviews where id = p_review for update;
  if not found then
    perform private.fail('not_found');
  end if;
  if (v_was is not null) = p_hidden then
    perform private.fail('invalid_status');
  end if;

  update public.reviews
  set hidden_at = case when p_hidden then now() else null end,
      hidden_reason = case when p_hidden then v_note else null end
  where id = p_review;

  perform private.log_admin_action(
    case when p_hidden then 'review_hidden'::public.admin_action_kind else 'review_unhidden'::public.admin_action_kind end,
    'review', p_review,
    jsonb_build_object('hidden', v_was is not null),
    jsonb_build_object('hidden', p_hidden),
    v_note
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- Kuponlar
-- -----------------------------------------------------------------------------

-- p_filter: all | active | inactive | expired. Eklenen / kullanılan sayıları
-- user_coupons'tan.
create or replace function public.admin_list_coupons(
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
  v_like text := private.like_pattern(upper(btrim(coalesce(p_search, ''))));
  v_result jsonb;
begin
  perform private.require_admin();
  if coalesce(p_filter, 'all') not in ('all', 'active', 'inactive', 'expired') then
    perform private.fail('invalid_filter');
  end if;

  with base as (
    select
      c.*,
      (select count(*) from public.user_coupons uc where uc.code = c.code) as added_count,
      (select count(*) from public.user_coupons uc where uc.code = c.code and uc.used_at is not null) as redeemed_count
    from public.coupons c
    where c.code ilike v_like
      and case coalesce(p_filter, 'all')
        when 'active' then c.active and c.expires_at > now()
        when 'inactive' then not c.active
        when 'expired' then c.expires_at <= now()
        else true
      end
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.created_at desc)
      from (
        select * from base
        order by created_at desc
        limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
      ) x
    ), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;

create or replace function public.admin_create_coupon(
  p_code text,
  p_kind public.coupon_kind,
  p_value int,
  p_expires_at timestamptz,
  p_max_discount int default null,
  p_min_total int default 0,
  p_usage_limit int default null
)
returns public.coupons
language plpgsql
security definer
set search_path = ''
as $$
declare
  c public.coupons;
begin
  perform private.require_admin();
  if p_expires_at is null or p_expires_at <= now() then
    perform private.fail('invalid_coupon');
  end if;
  begin
    insert into public.coupons (code, kind, value, max_discount, min_total, expires_at, usage_limit)
    values (
      upper(btrim(coalesce(p_code, ''))), p_kind, p_value,
      case when p_kind = 'percent' then p_max_discount end,
      coalesce(p_min_total, 0), p_expires_at, p_usage_limit
    )
    returning * into c;
  exception
    when unique_violation then
      perform private.fail('coupon_exists');
    when check_violation or not_null_violation then
      perform private.fail('invalid_coupon');
  end;

  perform private.log_admin_action_key('coupon_created', 'coupon', c.code, null, to_jsonb(c), null);
  return c;
end;
$$;

create or replace function public.admin_set_coupon_active(p_code text, p_active boolean, p_note text default null)
returns public.coupons
language plpgsql
security definer
set search_path = ''
as $$
declare
  c public.coupons;
begin
  perform private.require_admin();
  update public.coupons set active = p_active
  where code = p_code and active <> p_active
  returning * into c;
  if c.code is null then
    perform private.fail('invalid_status');
  end if;
  perform private.log_admin_action_key(
    case when p_active then 'coupon_activated'::public.admin_action_kind else 'coupon_deactivated'::public.admin_action_kind end,
    'coupon', p_code,
    jsonb_build_object('active', not p_active),
    jsonb_build_object('active', p_active),
    p_note
  );
  return c;
end;
$$;

-- Kuponu hesabına ekleyen / kullanan kullanıcılar.
create or replace function public.admin_coupon_usage(p_code text)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return coalesce((
    select jsonb_agg(jsonb_build_object(
      'user_id', uc.user_id,
      'full_name', private.join_name(p.first_name, a.last_name),
      'email', u.email,
      'added_at', uc.added_at,
      'used_at', uc.used_at,
      'booking_id', uc.booking_id,
      'booking_code', b.code
    ) order by uc.added_at desc)
    from public.user_coupons uc
    left join public.profiles p on p.id = uc.user_id
    left join public.account_details a on a.user_id = uc.user_id
    left join auth.users u on u.id = uc.user_id
    left join public.bookings b on b.id = uc.booking_id
    where uc.code = p_code
  ), '[]'::jsonb);
end;
$$;

-- -----------------------------------------------------------------------------
-- Hesap silme talepleri
--
-- Panel talebi "işlendi" olarak işaretler (isteğe bağlı olarak hesabı
-- admin-user-ban ile süresiz askıya alır). Kalıcı silme (auth.admin.deleteUser)
-- yasal saklama süreleri (KVKK, fatura, KBS) netleşince ayrı bir Edge
-- Function ile eklenecek; rezervasyonu olan profil `on delete restrict`
-- nedeniyle zaten silinemez.
-- -----------------------------------------------------------------------------

alter table private.account_deletion_requests
  add column processed_by uuid references auth.users (id) on delete set null,
  add column process_note text check (char_length(process_note) <= 1000);

-- p_filter: open | processed | all
create or replace function public.admin_list_deletion_requests(p_filter text default 'open')
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  if coalesce(p_filter, 'open') not in ('open', 'processed', 'all') then
    perform private.fail('invalid_filter');
  end if;
  return coalesce((
    select jsonb_agg(jsonb_build_object(
      'user_id', d.user_id,
      'full_name', private.join_name(p.first_name, a.last_name),
      'email', u.email,
      'phone', a.phone,
      'reason', d.reason,
      'requested_at', d.requested_at,
      'processed_at', d.processed_at,
      'process_note', d.process_note,
      'processed_by_email', pu.email,
      'banned_until', u.banned_until,
      'is_host', coalesce(p.is_host, false),
      'listing_count', (select count(*) from public.listings l where l.host_id = d.user_id),
      'booking_count', (
        select count(*) from public.bookings b where b.guest_id = d.user_id or b.host_id = d.user_id
      ),
      'upcoming_bookings', (
        select count(*) from public.bookings b
        where (b.guest_id = d.user_id or b.host_id = d.user_id)
          and b.status in ('awaiting_payment', 'pending', 'confirmed')
          and b.check_out >= private.today()
      )
    ) order by d.processed_at is not null, d.requested_at)
    from private.account_deletion_requests d
    left join auth.users u on u.id = d.user_id
    left join auth.users pu on pu.id = d.processed_by
    left join public.profiles p on p.id = d.user_id
    left join public.account_details a on a.user_id = d.user_id
    where case coalesce(p_filter, 'open')
        when 'open' then d.processed_at is null
        when 'processed' then d.processed_at is not null
        else true
      end
  ), '[]'::jsonb);
end;
$$;

create or replace function public.admin_process_deletion_request(p_user uuid, p_note text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  perform private.require_admin();
  perform private.require_note(v_note);
  update private.account_deletion_requests
  set processed_at = now(), processed_by = auth.uid(), process_note = v_note
  where user_id = p_user and processed_at is null;
  if not found then
    perform private.fail('invalid_status');
  end if;
  perform private.log_admin_action(
    'deletion_processed', 'deletion_request', p_user,
    jsonb_build_object('processed', false),
    jsonb_build_object('processed', true),
    v_note
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- İçerik: hukuki metinler ve SSS
-- -----------------------------------------------------------------------------

-- Tüm sürümler (yayında olmayan / ileri tarihli dahil).
create or replace function public.admin_list_legal_documents()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return coalesce((
    select jsonb_agg(jsonb_build_object(
      'id', d.id,
      'doc', d.doc,
      'version', d.version,
      'title', d.title,
      'body', d.body,
      'published_at', d.published_at,
      'created_at', d.created_at,
      'consent_count', (select count(*) from public.legal_consents c where c.doc = d.doc and c.version = d.version)
    ) order by d.doc, d.version desc)
    from public.legal_documents d
  ), '[]'::jsonb);
end;
$$;

-- Yeni sürüm: sürüm no bir artar; p_publish_at boşsa hemen yayında.
create or replace function public.admin_publish_legal_document(
  p_doc public.legal_doc,
  p_title text,
  p_body text,
  p_publish_at timestamptz default null
)
returns public.legal_documents
language plpgsql
security definer
set search_path = ''
as $$
declare
  d public.legal_documents;
  v_version int;
begin
  perform private.require_admin();
  if btrim(coalesce(p_title, '')) = '' or btrim(coalesce(p_body, '')) = '' then
    perform private.fail('invalid_content');
  end if;
  -- Aynı belgeye eşzamanlı iki sürüm yazılmasın.
  perform pg_advisory_xact_lock(hashtext('legal_document:' || p_doc::text));
  select coalesce(max(version), 0) + 1 into v_version from public.legal_documents where doc = p_doc;

  insert into public.legal_documents (doc, version, title, body, published_at)
  values (p_doc, v_version, btrim(p_title), p_body, coalesce(p_publish_at, now()))
  returning * into d;

  perform private.log_admin_action_key(
    'legal_published', 'legal_document', p_doc::text || ' v' || v_version,
    null,
    jsonb_build_object('doc', p_doc, 'version', v_version, 'published_at', d.published_at),
    null
  );
  return d;
end;
$$;

create or replace function public.admin_list_faq()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  return coalesce((
    select jsonb_agg(to_jsonb(f) order by f.position, f.created_at)
    from public.faq_items f
  ), '[]'::jsonb);
end;
$$;

-- p_id boşsa yeni soru.
create or replace function public.admin_save_faq(
  p_id uuid,
  p_question text,
  p_answer text,
  p_position int default 0,
  p_published boolean default true
)
returns public.faq_items
language plpgsql
security definer
set search_path = ''
as $$
declare
  f public.faq_items;
  v_old public.faq_items;
begin
  perform private.require_admin();
  if btrim(coalesce(p_question, '')) = '' or btrim(coalesce(p_answer, '')) = '' then
    perform private.fail('invalid_content');
  end if;
  if p_id is null then
    insert into public.faq_items (question, answer, position, published)
    values (btrim(p_question), btrim(p_answer), coalesce(p_position, 0), coalesce(p_published, true))
    returning * into f;
  else
    select * into v_old from public.faq_items where id = p_id for update;
    update public.faq_items
    set question = btrim(p_question), answer = btrim(p_answer),
        position = coalesce(p_position, 0), published = coalesce(p_published, true)
    where id = p_id
    returning * into f;
    if f.id is null then
      perform private.fail('not_found');
    end if;
  end if;
  perform private.log_admin_action(
    'faq_saved', 'faq', f.id,
    case when v_old.id is null then null else to_jsonb(v_old) end,
    to_jsonb(f),
    null
  );
  return f;
end;
$$;

create or replace function public.admin_delete_faq(p_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_old public.faq_items;
begin
  perform private.require_admin();
  delete from public.faq_items where id = p_id returning * into v_old;
  if v_old.id is null then
    perform private.fail('not_found');
  end if;
  perform private.log_admin_action('faq_deleted', 'faq', p_id, to_jsonb(v_old), null, null);
end;
$$;

-- -----------------------------------------------------------------------------
-- Destek sohbetleri
--
-- Yönetici destek sohbetlerini RLS ile okuyabilir (is_conversation_member).
-- Yanıt bu fonksiyonla yazılır: gönderen yöneticinin profilidir, işlem
-- kaydına yazılır ve misafire "message" bildirimi trigger ile gider.
-- -----------------------------------------------------------------------------

-- p_filter: all | waiting (son mesaj kullanıcıdan) | answered
create or replace function public.admin_list_support(
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
  v_like text := private.like_pattern(btrim(coalesce(p_search, '')));
  v_result jsonb;
begin
  perform private.require_admin();
  if coalesce(p_filter, 'all') not in ('all', 'waiting', 'answered') then
    perform private.fail('invalid_filter');
  end if;

  with base as (
    select
      c.id, c.ticket_no, c.created_at, c.last_message_at, c.last_message_preview,
      coalesce(c.last_sender_id = c.guest_id, false) as waiting,
      c.guest_id, private.join_name(p.first_name, a.last_name) as guest_name,
      u.email::text as guest_email, p.avatar_url,
      c.booking_id, b.code as booking_code,
      (select count(*) from public.messages m where m.conversation_id = c.id) as message_count
    from public.conversations c
    left join public.profiles p on p.id = c.guest_id
    left join public.account_details a on a.user_id = c.guest_id
    left join auth.users u on u.id = c.guest_id
    left join public.bookings b on b.id = c.booking_id
    where c.kind = 'support'
      and case coalesce(p_filter, 'all')
        when 'waiting' then c.last_sender_id = c.guest_id
        when 'answered' then c.last_sender_id is distinct from c.guest_id
        else true
      end
      and (
        v_q is null
        or c.ticket_no::text = ltrim(v_q, '#')
        or private.join_name(p.first_name, a.last_name) ilike v_like
        or u.email ilike v_like
        or b.code ilike v_like
      )
  )
  select jsonb_build_object(
    'total', (select count(*) from base),
    'rows', coalesce((
      select jsonb_agg(to_jsonb(x) order by x.waiting desc, coalesce(x.last_message_at, x.created_at) desc)
      from (
        select * from base
        order by waiting desc, coalesce(last_message_at, created_at) desc
        limit private.page_limit(p_limit) offset greatest(coalesce(p_offset, 0), 0)
      ) x
    ), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;

create or replace function public.admin_support_messages(p_conversation uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform private.require_admin();
  if not exists (select 1 from public.conversations where id = p_conversation and kind = 'support') then
    perform private.fail('not_found');
  end if;
  return coalesce((
    select jsonb_agg(jsonb_build_object(
      'id', m.id,
      'sender_id', m.sender_id,
      'sender_name', coalesce(private.join_name(p.first_name, a.last_name), u.email),
      'from_guest', m.sender_id = c.guest_id,
      'body', m.body,
      'attachment_path', m.attachment_path,
      'created_at', m.created_at
    ) order by m.created_at)
    from public.messages m
    join public.conversations c on c.id = m.conversation_id
    left join public.profiles p on p.id = m.sender_id
    left join public.account_details a on a.user_id = m.sender_id
    left join auth.users u on u.id = m.sender_id
    where m.conversation_id = p_conversation
  ), '[]'::jsonb);
end;
$$;

create or replace function public.admin_send_support_message(p_conversation uuid, p_body text)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_id uuid;
  v_body text := btrim(coalesce(p_body, ''));
begin
  perform private.require_admin();
  if v_body = '' or char_length(v_body) > 1000 then
    perform private.fail('invalid_content');
  end if;
  if not exists (select 1 from public.conversations where id = p_conversation and kind = 'support') then
    perform private.fail('not_found');
  end if;
  insert into public.messages (conversation_id, sender_id, body)
  values (p_conversation, auth.uid(), v_body)
  returning id into v_id;
  perform private.log_admin_action('support_replied', 'conversation', p_conversation, null, null, left(v_body, 200));
  return v_id;
end;
$$;

-- -----------------------------------------------------------------------------
-- İşlem kaydı listesi: target_key ve yeni hedef türlerinin etiketleri
-- (imza 20261009090000_admin.sql ile aynı)
-- -----------------------------------------------------------------------------

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
      aa.id, aa.action, aa.target_type, aa.target_id, aa.target_key, aa.before, aa.after, aa.note, aa.created_at,
      aa.admin_id,
      au.email::text as admin_email,
      private.join_name(ap.first_name, aad.last_name) as admin_name,
      case aa.target_type::text
        when 'listing' then (select concat_ws(' · ', l.listing_no, nullif(l.title, '')) from public.listings l where l.id = aa.target_id)
        when 'user' then (
          select coalesce(private.join_name(p.first_name, a.last_name), u.email::text)
          from auth.users u
          left join public.profiles p on p.id = u.id
          left join public.account_details a on a.user_id = u.id
          where u.id = aa.target_id
        )
        when 'deletion_request' then (
          select coalesce(private.join_name(p.first_name, a.last_name), u.email::text)
          from auth.users u
          left join public.profiles p on p.id = u.id
          left join public.account_details a on a.user_id = u.id
          where u.id = aa.target_id
        )
        when 'booking' then (select b.code from public.bookings b where b.id = aa.target_id)
        when 'report' then coalesce(
          (select l.listing_no from public.listing_reports r join public.listings l on l.id = r.listing_id where r.id = aa.target_id),
          (select b.code from public.issue_reports r join public.bookings b on b.id = r.booking_id where r.id = aa.target_id)
        )
        when 'review' then (
          select concat_ws(' · ', l.listing_no, b.code)
          from public.reviews r
          join public.listings l on l.id = r.listing_id
          left join public.bookings b on b.id = r.booking_id
          where r.id = aa.target_id
        )
        when 'faq' then coalesce(
          (select left(f.question, 80) from public.faq_items f where f.id = aa.target_id),
          left(aa.before ->> 'question', 80)
        )
        when 'conversation' then (select '#' || c.ticket_no from public.conversations c where c.id = aa.target_id)
        else aa.target_key
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
-- Yetki: yeni yönetici fonksiyonları da anonim kullanıcıya kapalı.
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
