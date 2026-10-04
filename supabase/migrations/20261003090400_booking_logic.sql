-- =============================================================================
-- Bungalovum · 04 · Fiyat, müsaitlik, arama ve rezervasyon akışı
--
-- Akış (anında onay ve talep aynı yoldan geçer):
--   1. quote_booking()        → fiyat kalemleri (uygulamadaki PriceBreakdown)
--   2. create_booking()       → 'awaiting_payment', tarihler kısa süre tutulur
--   3. Edge Function ödemeyi alır (3D Secure) ve service_role ile
--      record_booking_payment() çağırır:
--        anında onay → 'confirmed' (ödeme çekildi)
--        talep       → 'pending'   (provizyon; ev sahibi 24 saatte yanıtlar)
--   4. respond_to_booking_request() → 'confirmed' | 'declined'
--   5. Zamanlanmış işler: ödenmeyen tutmalar ve yanıtsız talepler 'expired',
--      çıkışı geçenler 'completed' olur (bkz. 09_jobs).
--
-- Para hareketi gerektiren adımlar payments tablosuna 'pending' satır yazar;
-- Edge Function bunları ödeme sağlayıcısında işler ve complete_payment() ile
-- sonucu bildirir.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Fiyat ve müsaitlik yardımcıları
-- -----------------------------------------------------------------------------

-- Bir gecenin fiyatı: takvimdeki özel fiyat > hafta sonu fiyatı (Cuma, Cumartesi) > normal fiyat.
create or replace function private.night_price(p_listing public.listings, p_day date, p_override int)
returns int
language sql
immutable
set search_path = ''
as $$
  select coalesce(
    p_override,
    case
      when extract(isodow from p_day) in (5, 6) and p_listing.weekend_price is not null then p_listing.weekend_price
      else p_listing.nightly_price
    end
  );
$$;

-- Tarih aralığı (çıkış günü hariç) boş mu?
create or replace function private.is_range_available(
  p_listing uuid,
  p_check_in date,
  p_check_out date,
  p_ignore_booking uuid default null
)
returns boolean
language sql
stable
set search_path = ''
as $$
  select not exists (
      select 1 from public.listing_calendar c
      where c.listing_id = p_listing and c.blocked and c.day >= p_check_in and c.day < p_check_out
    )
    and not exists (
      select 1 from public.bookings b
      where b.listing_id = p_listing
        and b.status in ('awaiting_payment', 'pending', 'confirmed')
        and not (b.status = 'awaiting_payment' and b.hold_expires_at < now())
        and b.stay && daterange(p_check_in, p_check_out, '[)')
        and b.id is distinct from p_ignore_booking
    );
$$;

-- Fiyat teklifi. Hata kodları: listing_unavailable, invalid_dates, min_nights,
-- max_nights, too_many_guests, pets_not_allowed, coupon_not_applicable
create or replace function private.compute_quote(
  p_listing uuid,
  p_check_in date,
  p_check_out date,
  p_adults int,
  p_children int,
  p_pets int,
  p_user uuid,
  p_coupon text
)
returns jsonb
language plpgsql
stable
set search_path = ''
as $$
declare
  l public.listings;
  s public.platform_settings := private.settings();
  v_nights int := p_check_out - p_check_in;
  v_stay int;
  v_long_stay int := 0;
  v_coupon_discount int := 0;
  v_coupon public.coupons;
  v_code text := nullif(upper(btrim(coalesce(p_coupon, ''))), '');
  v_discount int := 0;
  v_discount_kind public.discount_kind;
  v_service int;
  v_host_base int;
  v_host_fee int;
begin
  select * into l from public.listings where id = p_listing and status = 'published';
  if l.id is null or l.nightly_price is null then
    perform private.fail('listing_unavailable');
  end if;
  if p_check_in is null or p_check_out is null or p_check_in < private.today() or v_nights < 1 then
    perform private.fail('invalid_dates');
  end if;
  if v_nights < l.min_nights then
    perform private.fail('min_nights', l.min_nights::text);
  end if;
  if v_nights > s.max_nights then
    perform private.fail('max_nights', s.max_nights::text);
  end if;
  if coalesce(p_adults, 0) < 1 or p_adults + coalesce(p_children, 0) > l.max_guests then
    perform private.fail('too_many_guests', l.max_guests::text);
  end if;
  if coalesce(p_pets, 0) > 0 and not l.pets_allowed then
    perform private.fail('pets_not_allowed');
  end if;

  select sum(private.night_price(l, d::date, c.price))::int into v_stay
  from generate_series(p_check_in, p_check_out - 1, interval '1 day') as d
  left join public.listing_calendar c on c.listing_id = l.id and c.day = d::date;

  -- Haftalık indirim (ev sahibi karşılar)
  if v_nights >= 7 and l.weekly_discount_percent > 0 then
    v_long_stay := round(v_stay * l.weekly_discount_percent / 100.0);
  end if;

  -- Kupon (platform karşılar)
  if v_code is not null then
    select c.* into v_coupon
    from public.coupons c
    join public.user_coupons uc on uc.code = c.code and uc.user_id = p_user
    where c.code = v_code
      and c.active
      and c.expires_at > now()
      and uc.used_at is null
      and (c.usage_limit is null or c.used_count < c.usage_limit)
      and c.min_total <= v_stay + l.cleaning_fee;
    if v_coupon.code is null then
      perform private.fail('coupon_not_applicable');
    end if;
    v_coupon_discount := case v_coupon.kind
      when 'percent' then least(round((v_stay + l.cleaning_fee) * v_coupon.value / 100.0)::int, coalesce(v_coupon.max_discount, 2147483647))
      else least(v_coupon.value, v_stay + l.cleaning_fee)
    end;
  end if;

  -- Tek indirim kalemi uygulanır: hangisi büyükse.
  if v_coupon_discount > 0 and v_coupon_discount >= v_long_stay then
    v_discount := v_coupon_discount;
    v_discount_kind := 'coupon';
  elsif v_long_stay > 0 then
    v_discount := v_long_stay;
    v_discount_kind := 'long_stay';
    v_code := null;
  else
    v_code := null;
  end if;

  v_service := round((v_stay + l.cleaning_fee) * s.guest_service_fee_percent / 100.0);
  v_host_base := v_stay + l.cleaning_fee - case when v_discount_kind = 'long_stay' then v_discount else 0 end;
  v_host_fee := round(v_host_base * s.host_service_fee_percent / 100.0);

  return jsonb_build_object(
    'listing_id', l.id,
    'check_in', p_check_in,
    'check_out', p_check_out,
    'nights', v_nights,
    -- Ortalama gecelik; kalemler için stay_total esas alınır.
    'nightly_rate', round(v_stay::numeric / v_nights)::int,
    'stay_total', v_stay,
    'cleaning_fee', l.cleaning_fee,
    'service_fee', v_service,
    'discount', v_discount,
    'discount_kind', v_discount_kind,
    'coupon_code', v_code,
    'total', v_stay + l.cleaning_fee + v_service - v_discount,
    'host_fee', v_host_fee,
    'host_payout', v_host_base - v_host_fee,
    'instant_book', l.instant_book
  );
end;
$$;

-- -----------------------------------------------------------------------------
-- RPC: misafir tarafı okuma
-- -----------------------------------------------------------------------------

-- 33 · Fiyat ayrıntısı. "available" false ise tarihler dolu.
create or replace function public.quote_booking(
  p_listing uuid,
  p_check_in date,
  p_check_out date,
  p_adults int default 2,
  p_children int default 0,
  p_pets int default 0,
  p_coupon text default null
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  return private.compute_quote(p_listing, p_check_in, p_check_out, p_adults, p_children, p_pets, auth.uid(), p_coupon)
    || jsonb_build_object('available', private.is_range_available(p_listing, p_check_in, p_check_out));
end;
$$;

-- 31 · Takvim: gün gün müsaitlik ve fiyat (en fazla 400 gün).
create or replace function public.listing_calendar_days(p_listing uuid, p_from date, p_to date)
returns table (day date, available boolean, price int, is_deal boolean)
language sql
stable
security definer
set search_path = ''
as $$
  select
    d::date,
    not coalesce(c.blocked, false)
      and d::date >= private.today()
      and not exists (
        select 1 from public.bookings b
        where b.listing_id = l.id
          and b.status in ('awaiting_payment', 'pending', 'confirmed')
          and not (b.status = 'awaiting_payment' and b.hold_expires_at < now())
          and b.stay @> d::date
      ),
    private.night_price(l, d::date, c.price),
    private.night_price(l, d::date, c.price) < l.nightly_price
  from public.listings l
  cross join generate_series(greatest(p_from, private.today() - 31), least(p_to, p_from + 400), interval '1 day') as d
  left join public.listing_calendar c on c.listing_id = l.id and c.day = d::date
  where l.id = p_listing
    and (l.status = 'published' or l.host_id = auth.uid());
$$;

-- Kartta gösterilen "tüm ücretler dahil" gecelik fiyat (varsayılan 2 gece
-- üzerinden). PostgREST hesaplanmış alanı: select=*,display_price
create or replace function public.display_price(l public.listings)
returns int
language sql
stable
set search_path = ''
as $$
  select round((l.nightly_price * 2 + l.cleaning_fee) * (1 + s.guest_service_fee_percent / 100.0) / 2)::int
  from public.platform_settings s
  where s.id;
$$;

-- Filtre çipleri (uygulamadaki SearchFeature) ve keşfet kategorileri.
create or replace function private.listing_has_feature(l public.listings, p_feature text)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select case p_feature
    when 'pool' then l.has_pool
    when 'heated_pool' then l.has_pool and l.pool_heated
    when 'jacuzzi' then 'jacuzzi' = any (l.amenities)
    when 'fireplace' then 'fireplace' = any (l.amenities)
    when 'air_conditioning' then 'air_conditioning' = any (l.amenities)
    when 'wifi' then 'wifi' = any (l.amenities)
    when 'parking' then 'parking' = any (l.amenities)
    when 'lake_view' then l.settings && array['lake_view', 'lakeside']::public.listing_setting[]
    when 'forest' then 'forest' = any (l.settings)
    when 'a_frame' then l.property_type = 'a_frame'
    else false
  end;
$$;

-- 13–17 · Keşfet, arama, filtre, harita. Sonuç listings satırlarıdır;
-- istemci select=*,display_price,listing_photos(...) ile ister.
create or replace function public.search_listings(
  p_location text default null,
  p_check_in date default null,
  p_check_out date default null,
  p_guests int default 1,
  p_pets boolean default false,
  p_price_min int default null,
  p_price_max int default null,
  -- SearchFeature: pool, heated_pool, jacuzzi, fireplace, lake_view, forest, air_conditioning, wifi, parking
  p_features text[] default '{}',
  -- ExploreCategory: pool, lake_view, forest, jacuzzi, fireplace, a_frame
  p_category text default null,
  -- 4 = 4 ve üzeri
  p_bedrooms int default null,
  p_instant_book boolean default false,
  p_free_cancellation boolean default false,
  p_pets_allowed boolean default false,
  p_accessible boolean default false,
  -- Harita görünümü
  p_min_lat double precision default null,
  p_max_lat double precision default null,
  p_min_lng double precision default null,
  p_max_lng double precision default null,
  -- recommended | price_low | price_high | rating
  p_sort text default 'recommended',
  p_limit int default 20,
  p_offset int default 0
)
returns setof public.listings
language sql
stable
security definer
set search_path = ''
as $$
  select l.*
  from public.listings l
  where l.status = 'published'
    and l.nightly_price is not null
    and (p_location is null or btrim(p_location) = '' or l.search_text like '%' || lower(btrim(p_location)) || '%')
    and l.max_guests >= greatest(coalesce(p_guests, 1), 1)
    and (not coalesce(p_pets, false) or l.pets_allowed)
    and (not coalesce(p_pets_allowed, false) or l.pets_allowed)
    and (p_price_min is null or public.display_price(l) >= p_price_min)
    and (p_price_max is null or public.display_price(l) <= p_price_max)
    and (select bool_and(private.listing_has_feature(l, f)) from unnest(coalesce(p_features, '{}')) f) is not false
    and (p_category is null or p_category = 'all' or private.listing_has_feature(l, p_category))
    and (p_bedrooms is null or (p_bedrooms >= 4 and l.bedrooms >= 4) or l.bedrooms = p_bedrooms)
    and (not coalesce(p_instant_book, false) or l.instant_book)
    and (not coalesce(p_free_cancellation, false) or l.cancellation_policy <> 'strict')
    and (not coalesce(p_accessible, false) or l.accessible)
    and (p_min_lat is null or l.latitude between p_min_lat and p_max_lat)
    and (p_min_lng is null or l.longitude between p_min_lng and p_max_lng)
    and (
      p_check_in is null or p_check_out is null
      or (
        p_check_out - p_check_in >= l.min_nights
        and private.is_range_available(l.id, p_check_in, p_check_out)
      )
    )
  order by
    case when p_sort = 'price_low' then public.display_price(l) end asc,
    case when p_sort = 'price_high' then public.display_price(l) end desc,
    case when p_sort = 'rating' then l.rating_avg end desc nulls last,
    (l.badge is not null) desc,
    l.rating_avg desc nulls last,
    l.review_count desc,
    l.published_at desc,
    l.id
  limit least(greatest(coalesce(p_limit, 20), 1), 50)
  offset greatest(coalesce(p_offset, 0), 0);
$$;

-- 89 · "Misafir ne öder, sana ne kalır?" + bölgedeki benzer ilanlar.
create or replace function public.estimate_host_earnings(
  p_nightly int,
  p_cleaning_fee int default 0,
  p_nights int default 2,
  p_region text default null
)
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  with s as (select * from public.platform_settings where id),
  calc as (
    select
      p_nightly * p_nights as stay_total,
      round((p_nightly * p_nights + p_cleaning_fee) * s.host_service_fee_percent / 100.0)::int as host_fee
    from s
  ),
  peers as (
    select
      percentile_disc(0.2) within group (order by nightly_price) as lo,
      percentile_disc(0.8) within group (order by nightly_price) as hi
    from public.listings
    where status = 'published'
      and (p_region is null or lower(region) = lower(btrim(p_region)))
  )
  select jsonb_build_object(
    'nights', p_nights,
    'nightly', p_nightly,
    'stay_total', calc.stay_total,
    'cleaning_fee', p_cleaning_fee,
    'service_fee', calc.host_fee,
    'host_earns', calc.stay_total + p_cleaning_fee - calc.host_fee,
    'similar_min', peers.lo,
    'similar_max', peers.hi
  )
  from calc, peers;
$$;

-- -----------------------------------------------------------------------------
-- Kupon kullanımı
-- -----------------------------------------------------------------------------

create or replace function private.consume_coupon(b public.bookings)
returns void
language sql
set search_path = ''
as $$
  update public.user_coupons set used_at = now(), booking_id = b.id
  where b.coupon_code is not null and user_id = b.guest_id and code = b.coupon_code and used_at is null;
  update public.coupons set used_count = used_count + 1
  where b.coupon_code is not null and code = b.coupon_code;
$$;

-- Rezervasyon gerçekleşmezse kupon geri verilir.
create or replace function private.release_coupon(b public.bookings)
returns void
language sql
set search_path = ''
as $$
  update public.coupons set used_count = greatest(used_count - 1, 0)
  where b.coupon_code is not null and code = b.coupon_code
    and exists (select 1 from public.user_coupons where user_id = b.guest_id and code = b.coupon_code and booking_id = b.id);
  update public.user_coupons set used_at = null, booking_id = null
  where b.coupon_code is not null and user_id = b.guest_id and code = b.coupon_code and booking_id = b.id;
$$;

-- -----------------------------------------------------------------------------
-- RPC: rezervasyon oluşturma
-- -----------------------------------------------------------------------------

create or replace function public.create_booking(
  p_listing uuid,
  p_check_in date,
  p_check_out date,
  p_adults int,
  p_children int default 0,
  p_infants int default 0,
  p_pets int default 0,
  p_message text default null,
  p_coupon text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  l public.listings;
  q jsonb;
  b public.bookings;
  i int;
begin
  select * into l from public.listings where id = p_listing and status = 'published';
  if l.id is null then
    perform private.fail('listing_unavailable');
  end if;
  if l.host_id = v_uid then
    perform private.fail('own_listing');
  end if;
  if not l.instant_book and char_length(btrim(coalesce(p_message, ''))) < 20 then
    perform private.fail('message_too_short', '20');
  end if;

  -- Süresi geçmiş tutmaları ve misafirin bu ilandaki önceki ödenmemiş
  -- denemesini bırak (farklı tarihle yeniden deneyebilsin).
  perform private.expire_booking_holds(p_listing);
  update public.bookings set status = 'expired'
  where listing_id = p_listing and guest_id = v_uid and status = 'awaiting_payment';

  q := private.compute_quote(p_listing, p_check_in, p_check_out, p_adults, p_children, p_pets, v_uid, p_coupon);
  if not private.is_range_available(p_listing, p_check_in, p_check_out) then
    perform private.fail('dates_unavailable');
  end if;

  for i in 1 .. 5 loop
    begin
      insert into public.bookings (
        code, listing_id, guest_id, host_id, check_in, check_out,
        adults, children, infants, pets, status, is_request, message,
        nights, nightly_rate, stay_total, cleaning_fee, service_fee, discount, discount_kind, coupon_code,
        total, host_fee, host_payout, hold_expires_at
      ) values (
        'BV-' || private.random_code(5), l.id, v_uid, l.host_id, p_check_in, p_check_out,
        p_adults, coalesce(p_children, 0), coalesce(p_infants, 0), coalesce(p_pets, 0),
        'awaiting_payment', not l.instant_book, nullif(btrim(coalesce(p_message, '')), ''),
        (q ->> 'nights')::int, (q ->> 'nightly_rate')::int, (q ->> 'stay_total')::int,
        (q ->> 'cleaning_fee')::int, (q ->> 'service_fee')::int, (q ->> 'discount')::int,
        (q ->> 'discount_kind')::public.discount_kind, q ->> 'coupon_code',
        (q ->> 'total')::int, (q ->> 'host_fee')::int, (q ->> 'host_payout')::int,
        now() + make_interval(mins => (private.settings()).booking_hold_minutes)
      )
      returning * into b;
      return b;
    exception
      when exclusion_violation then
        perform private.fail('dates_unavailable');
      when unique_violation then
        -- Rezervasyon kodu çakıştı; yeni kodla tekrar dene.
        null;
    end;
  end loop;
  perform private.fail('internal_error');
end;
$$;

-- -----------------------------------------------------------------------------
-- Ödeme sonuçları (yalnızca service_role / Edge Function)
-- -----------------------------------------------------------------------------

-- 3D Secure başarılı: anında onayda ödeme, talepte provizyon kaydedilir.
create or replace function public.record_booking_payment(
  p_booking uuid,
  p_provider text,
  p_provider_ref text,
  p_card_brand public.card_brand default 'unknown',
  p_card_last4 text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = ''
as $$
declare
  b public.bookings;
  s public.platform_settings := private.settings();
begin
  select * into b from public.bookings where id = p_booking for update;
  if b.id is null then
    perform private.fail('not_found');
  end if;

  -- Aynı webhook ikinci kez gelirse aynı sonucu dön.
  if exists (select 1 from public.payments where provider = p_provider and provider_ref = p_provider_ref and status = 'succeeded') then
    return b;
  end if;
  if b.status <> 'awaiting_payment' then
    -- Süre dolduysa Edge Function ödemeyi iade etmeli.
    perform private.fail('hold_expired');
  end if;

  insert into public.payments (booking_id, user_id, kind, status, amount, provider, provider_ref, card_brand, card_last4, processed_at)
  values (b.id, b.guest_id, case when b.is_request then 'provision'::public.payment_kind else 'payment'::public.payment_kind end,
          'succeeded', b.total, p_provider, p_provider_ref, p_card_brand, p_card_last4, now());

  if b.is_request then
    update public.bookings
    set status = 'pending', requested_at = now(),
        respond_by = now() + make_interval(hours => s.request_response_hours),
        hold_expires_at = null, card_brand = p_card_brand, card_last4 = p_card_last4
    where id = b.id
    returning * into b;
  else
    update public.bookings
    set status = 'confirmed', confirmed_at = now(), paid_at = now(),
        hold_expires_at = null, card_brand = p_card_brand, card_last4 = p_card_last4
    where id = b.id
    returning * into b;
  end if;

  perform private.consume_coupon(b);
  return b;
end;
$$;

-- 36 · Ödeme başarısız. Tutma süresi bitene kadar başka kartla denenebilir.
create or replace function public.record_payment_failure(
  p_booking uuid,
  p_provider text,
  p_provider_ref text,
  p_failure_code text,
  p_card_brand public.card_brand default 'unknown',
  p_card_last4 text default null
)
returns void
language sql
security definer
set search_path = ''
as $$
  insert into public.payments (booking_id, user_id, kind, status, amount, provider, provider_ref, card_brand, card_last4, failure_code, processed_at)
  select b.id, b.guest_id, case when b.is_request then 'provision'::public.payment_kind else 'payment'::public.payment_kind end,
         'failed', b.total, p_provider, p_provider_ref, p_card_brand, p_card_last4, p_failure_code, now()
  from public.bookings b
  where b.id = p_booking
  on conflict (provider, provider_ref) do nothing;
$$;

-- Bekleyen para hareketinin (provizyon çekimi, iade) sonucu.
create or replace function public.complete_payment(
  p_payment uuid,
  p_success boolean,
  p_provider text,
  p_provider_ref text default null,
  p_failure_code text default null
)
returns public.payments
language plpgsql
security definer
set search_path = ''
as $$
declare
  p public.payments;
begin
  update public.payments
  set status = case when p_success then 'succeeded'::public.payment_status else 'failed'::public.payment_status end,
      provider = coalesce(p_provider, provider),
      provider_ref = coalesce(p_provider_ref, provider_ref),
      failure_code = p_failure_code,
      processed_at = now()
  where id = p_payment and status = 'pending'
  returning * into p;
  if p.id is null then
    perform private.fail('invalid_status');
  end if;
  if p_success and p.kind = 'payment' then
    update public.bookings set paid_at = coalesce(paid_at, now()) where id = p.booking_id;
  end if;
  return p;
end;
$$;

-- Edge Function, kart kaydedildiğinde çağırır (token API'ye kapalı tabloda).
create or replace function public.register_payment_method(
  p_user uuid,
  p_provider text,
  p_customer_key text,
  p_card_token text,
  p_brand public.card_brand,
  p_last4 text,
  p_exp_month int,
  p_exp_year int
)
returns public.payment_methods
language plpgsql
security definer
set search_path = ''
as $$
declare
  m public.payment_methods;
begin
  insert into public.payment_methods (user_id, brand, last4, exp_month, exp_year, is_default)
  values (p_user, p_brand, p_last4, p_exp_month, p_exp_year,
          not exists (select 1 from public.payment_methods where user_id = p_user))
  returning * into m;
  insert into private.payment_method_tokens (method_id, provider, customer_key, card_token)
  values (m.id, p_provider, p_customer_key, p_card_token);
  return m;
end;
$$;

-- Edge Function ödeme alırken kayıtlı kartın token'ını okur.
create or replace function public.get_payment_method_token(p_method uuid, p_user uuid)
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select jsonb_build_object('provider', t.provider, 'customer_key', t.customer_key, 'card_token', t.card_token)
  from private.payment_method_tokens t
  join public.payment_methods m on m.id = t.method_id
  where m.id = p_method and m.user_id = p_user;
$$;

revoke execute on function public.record_booking_payment(uuid, text, text, public.card_brand, text) from public, anon, authenticated;
revoke execute on function public.record_payment_failure(uuid, text, text, text, public.card_brand, text) from public, anon, authenticated;
revoke execute on function public.complete_payment(uuid, boolean, text, text, text) from public, anon, authenticated;
revoke execute on function public.register_payment_method(uuid, text, text, text, public.card_brand, text, int, int) from public, anon, authenticated;
revoke execute on function public.get_payment_method_token(uuid, uuid) from public, anon, authenticated;
grant execute on function public.record_booking_payment(uuid, text, text, public.card_brand, text) to service_role;
grant execute on function public.record_payment_failure(uuid, text, text, text, public.card_brand, text) to service_role;
grant execute on function public.complete_payment(uuid, boolean, text, text, text) to service_role;
grant execute on function public.register_payment_method(uuid, text, text, text, public.card_brand, text, int, int) to service_role;
grant execute on function public.get_payment_method_token(uuid, uuid) to service_role;

-- 74 · Varsayılan kartı değiştir.
create or replace function public.set_default_payment_method(p_method uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
begin
  if not exists (select 1 from public.payment_methods where id = p_method and user_id = v_uid) then
    perform private.fail('not_found');
  end if;
  update public.payment_methods set is_default = false where user_id = v_uid and is_default;
  update public.payment_methods set is_default = true where id = p_method;
end;
$$;

-- -----------------------------------------------------------------------------
-- RPC: ev sahibi talebe yanıt (95)
-- -----------------------------------------------------------------------------

create or replace function public.respond_to_booking_request(p_booking uuid, p_approve boolean, p_reason text default null)
returns public.bookings
language plpgsql
security definer
set search_path = ''
as $$
declare
  b public.bookings;
begin
  select * into b from public.bookings
  where id = p_booking and host_id = private.require_user() and status = 'pending'
  for update;
  if b.id is null then
    perform private.fail('invalid_status');
  end if;
  if b.respond_by < now() then
    perform private.fail('request_expired');
  end if;

  if p_approve then
    update public.bookings
    set status = 'confirmed', responded_at = now(), confirmed_at = now()
    where id = b.id
    returning * into b;
    -- Provizyon çekime dönüştürülecek.
    insert into public.payments (booking_id, user_id, kind, amount, card_brand, card_last4)
    values (b.id, b.guest_id, 'payment', b.total, b.card_brand, b.card_last4);
  else
    update public.bookings
    set status = 'declined', responded_at = now(), decline_reason = nullif(btrim(coalesce(p_reason, '')), '')
    where id = b.id
    returning * into b;
    -- Provizyon serbest bırakılacak.
    insert into public.payments (booking_id, user_id, kind, amount, card_brand, card_last4)
    values (b.id, b.guest_id, 'refund', b.total, b.card_brand, b.card_last4);
    perform private.release_coupon(b);
  end if;
  return b;
end;
$$;

-- -----------------------------------------------------------------------------
-- İptal ve iade (54)
-- İade kuralları tek yerde; iş kararı değişirse yalnızca burası güncellenir:
--   esnek (flexible): girişten 24 saat öncesine kadar tam iade, sonra iade yok
--   orta (moderate):  girişten 5 gün öncesine kadar tam iade, sonra iade yok
--   katı (strict):    girişten 7 gün öncesine kadar %50 iade, sonra iade yok
--   Ev sahibi iptal ederse ya da talep onaylanmadıysa: tam iade.
-- -----------------------------------------------------------------------------

create or replace function private.cancellation_terms(b public.bookings, p_actor public.cancel_actor)
returns jsonb
language plpgsql
stable
set search_path = ''
as $$
declare
  l public.listings;
  v_check_in_at timestamptz;
  v_free_until timestamptz;
  v_paid int;
  v_refund int;
begin
  select * into l from public.listings where id = b.listing_id;
  v_check_in_at := private.local_moment(b.check_in, l.check_in_from);
  v_free_until := v_check_in_at - case l.cancellation_policy
    when 'flexible' then interval '24 hours'
    when 'moderate' then interval '5 days'
    else interval '7 days'
  end;
  v_paid := case when b.status in ('pending', 'confirmed') then b.total else 0 end;

  v_refund := case
    when v_paid = 0 then 0
    when b.status = 'pending' or p_actor <> 'guest' then v_paid
    when now() > v_free_until then 0
    when l.cancellation_policy = 'strict' then round(v_paid * 0.5)::int
    else v_paid
  end;

  return jsonb_build_object(
    'paid', v_paid,
    'deduction', v_paid - v_refund,
    'refund', v_refund,
    'free_until', v_free_until
  );
end;
$$;

create or replace function public.cancellation_quote(p_booking uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  b public.bookings;
begin
  select * into b from public.bookings where id = p_booking and (guest_id = v_uid or host_id = v_uid);
  if b.id is null then
    perform private.fail('not_found');
  end if;
  return private.cancellation_terms(b, case when b.host_id = v_uid then 'host'::public.cancel_actor else 'guest'::public.cancel_actor end);
end;
$$;

create or replace function public.cancel_booking(
  p_booking uuid,
  p_reason public.cancel_reason default 'other',
  p_note text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid uuid := private.require_user();
  b public.bookings;
  v_actor public.cancel_actor;
  v_terms jsonb;
  v_refund int;
begin
  select * into b from public.bookings
  where id = p_booking and (guest_id = v_uid or host_id = v_uid)
  for update;
  if b.id is null then
    perform private.fail('not_found');
  end if;
  if b.status not in ('awaiting_payment', 'pending', 'confirmed') then
    perform private.fail('invalid_status');
  end if;
  if b.check_in <= private.today() and b.status = 'confirmed' then
    -- Konaklama başladıysa iptal destek üzerinden yapılır.
    perform private.fail('stay_started');
  end if;

  v_actor := case when b.host_id = v_uid then 'host'::public.cancel_actor else 'guest'::public.cancel_actor end;
  v_terms := private.cancellation_terms(b, v_actor);
  v_refund := (v_terms ->> 'refund')::int;

  update public.bookings
  set status = 'cancelled', cancelled_at = now(), cancelled_by = v_actor,
      cancel_reason = p_reason, cancel_note = nullif(btrim(coalesce(p_note, '')), ''),
      refund_amount = v_refund, hold_expires_at = null
  where id = b.id
  returning * into b;

  if v_refund > 0 then
    insert into public.payments (booking_id, user_id, kind, amount, card_brand, card_last4)
    values (b.id, b.guest_id, 'refund', v_refund, b.card_brand, b.card_last4);
  end if;
  perform private.release_coupon(b);
  return b;
end;
$$;

-- -----------------------------------------------------------------------------
-- 49–50 · Konaklama erişim bilgileri. Tam adres, ev sahibi telefonu, anahtar
-- kutusu ve Wi-Fi yalnızca onaylı rezervasyonda, girişten access_reveal_hours
-- önce açılır (§10). Öncesinde yaklaşık konum döner.
-- -----------------------------------------------------------------------------

create or replace function public.get_trip_access(p_booking uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  b public.bookings;
  l public.listings;
  p public.listing_private;
  v_reveal_at timestamptz;
  v_revealed boolean;
  v_result jsonb;
begin
  select * into b from public.bookings
  where id = p_booking and guest_id = private.require_user() and status in ('confirmed', 'completed');
  if b.id is null then
    perform private.fail('not_found');
  end if;
  select * into l from public.listings where id = b.listing_id;
  select * into p from public.listing_private where listing_id = b.listing_id;

  v_reveal_at := private.local_moment(b.check_in, l.check_in_from)
    - make_interval(hours => (private.settings()).access_reveal_hours);
  v_revealed := b.status = 'confirmed' and now() >= v_reveal_at
    and private.today() <= b.check_out;

  v_result := jsonb_build_object(
    'reveal_at', v_reveal_at,
    'area_label', concat_ws(', ', nullif(l.district, ''), nullif(l.region, '')),
    'latitude', case when v_revealed then p.latitude else l.latitude end,
    'longitude', case when v_revealed then p.longitude else l.longitude end,
    'check_in_from', to_char(l.check_in_from, 'HH24:MI'),
    'check_out_by', to_char(l.check_out_by, 'HH24:MI'),
    'sections', p.guide_sections,
    'checkout_tasks', to_jsonb(p.checkout_tasks)
  );

  if v_revealed then
    v_result := v_result || jsonb_build_object(
      'address_lines', to_jsonb(regexp_split_to_array(p.address, '\s*\n\s*')),
      'host_phone', (select emergency_phone from private.host_accounts where user_id = b.host_id),
      'lockbox_code', nullif(p.lockbox_code, ''),
      'lockbox_hint', nullif(p.lockbox_hint, ''),
      'wifi_name', nullif(p.wifi_name, ''),
      'wifi_password', nullif(p.wifi_password, '')
    );
  end if;
  return v_result;
end;
$$;

-- -----------------------------------------------------------------------------
-- 39 · Misafir bilgileri (KBS). Kimlik numarası yalnızca burada yazılır,
-- uygulamaya son 2 hanesi döner.
-- -----------------------------------------------------------------------------

create or replace function public.add_stay_guest(
  p_booking uuid,
  p_full_name text,
  p_nationality public.nationality,
  p_id_number text,
  p_birth_date date,
  p_is_primary boolean default false
)
returns public.booking_guests
language plpgsql
security definer
set search_path = ''
as $$
declare
  b public.bookings;
  g public.booking_guests;
  v_id text := upper(btrim(coalesce(p_id_number, '')));
begin
  select * into b from public.bookings
  where id = p_booking and guest_id = private.require_user() and status in ('pending', 'confirmed')
  for update;
  if b.id is null then
    perform private.fail('not_found');
  end if;
  if (p_nationality = 'turkish' and not private.is_valid_tckn(v_id))
     or (p_nationality = 'foreign' and not private.is_valid_passport(v_id)) then
    perform private.fail('invalid_id_number');
  end if;
  if p_birth_date is null or p_birth_date > private.today() then
    perform private.fail('invalid_birth_date');
  end if;
  if (select count(*) from public.booking_guests where booking_id = b.id) >= b.adults + b.children then
    perform private.fail('guest_limit');
  end if;

  insert into public.booking_guests (booking_id, full_name, nationality, id_last2, is_primary)
  values (b.id, btrim(p_full_name), p_nationality, right(v_id, 2), coalesce(p_is_primary, false))
  returning * into g;
  insert into private.booking_guest_identities (guest_id, id_number, birth_date)
  values (g.id, v_id, p_birth_date);
  return g;
end;
$$;

create or replace function public.remove_stay_guest(p_guest uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  delete from public.booking_guests g
  using public.bookings b
  where g.id = p_guest and b.id = g.booking_id
    and b.guest_id = private.require_user()
    and b.status in ('pending', 'confirmed');
  if not found then
    perform private.fail('not_found');
  end if;
end;
$$;

-- -----------------------------------------------------------------------------
-- Zamanlanmış işler (09_jobs pg_cron ile çağırır)
-- -----------------------------------------------------------------------------

-- Ödemesi tamamlanmayan tutmaları bırakır.
create or replace function private.expire_booking_holds(p_listing uuid default null)
returns int
language plpgsql
set search_path = ''
as $$
declare
  v_count int;
begin
  update public.bookings
  set status = 'expired'
  where status = 'awaiting_payment'
    and hold_expires_at < now()
    and (p_listing is null or listing_id = p_listing);
  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

-- Ev sahibinin yanıt vermediği talepler düşer, provizyon serbest bırakılır.
create or replace function private.expire_booking_requests()
returns int
language plpgsql
set search_path = ''
as $$
declare
  b public.bookings;
  v_count int := 0;
begin
  for b in
    update public.bookings
    set status = 'expired', responded_at = now()
    where status = 'pending' and respond_by < now()
    returning *
  loop
    insert into public.payments (booking_id, user_id, kind, amount, card_brand, card_last4)
    values (b.id, b.guest_id, 'refund', b.total, b.card_brand, b.card_last4);
    perform private.release_coupon(b);
    v_count := v_count + 1;
  end loop;
  return v_count;
end;
$$;

-- Çıkışı geçen rezervasyonlar tamamlanır, ev sahibi aktarımı planlanır.
create or replace function private.complete_finished_bookings()
returns int
language plpgsql
set search_path = ''
as $$
declare
  v_count int;
begin
  with done as (
    update public.bookings
    set status = 'completed', completed_at = now()
    where status = 'confirmed' and check_out <= private.today()
    returning id, host_id, host_payout, check_in
  )
  insert into public.payouts (host_id, booking_id, amount, scheduled_for)
  select host_id, id, host_payout, check_in + 1 from done
  on conflict (booking_id) do nothing;
  get diagnostics v_count = row_count;
  return v_count;
end;
$$;
