-- =============================================================================
-- Bungalovum · Misafir tarafı: gerçek ilanlarla gözatma (Keşfet, arama, detay)
--
-- - private.tr_fold: Türkçe harf/şapka farkını yok sayan arama anahtarı
--   ("istanbul" ↔ "İstanbul", "sanliurfa" ↔ "Şanlıurfa").
-- - search_listings: konum eşleşmesi tr_fold ile (bölge, il, ilçe, başlık).
-- - search_listing_cards: arama sonucu kartları + fiyat kalemleri tek seferde.
-- - listing_cards: verilen ilanların kartları (kaydedilenler, son baktıkların).
-- - listing_detail: İlan Detayı ve alt ekranlarının verisi.
-- - listing_price_estimate: detayda seçili gece sayısı için fiyat kalemleri.
--
-- Fiyat veritabanında hesaplanır (CLAUDE.md §14); uygulama formül tutmaz.
-- =============================================================================

create or replace function private.tr_fold(p text)
returns text
language sql
immutable
set search_path = ''
as $$
  select translate(
    lower(translate(replace(replace(btrim(coalesce(p, '')), 'İ', 'i'), 'I', 'ı'),
                    'ŞĞÜÖÇÂÎÛ', 'şğüöçâîû')),
    'ışğüöçâîû',
    'isguocaiu'
  );
$$;

-- 13–17 · Keşfet, arama, filtre, harita. Yalnızca konum eşleşmesi değişti.
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
    and (
      p_location is null or btrim(p_location) = ''
      or private.tr_fold(l.region || ' ' || l.city || ' ' || l.district || ' ' || l.title)
         like '%' || private.tr_fold(p_location) || '%'
    )
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

-- Kart alanları (uygulamadaki Listing modeli). Kapak fotoğrafı ilk sıradadır.
create or replace function private.listing_card(l public.listings)
returns jsonb
language sql
stable
set search_path = ''
as $$
  select jsonb_build_object(
    'id', l.id,
    'title', l.title,
    'region', l.region,
    'city', l.city,
    'district', l.district,
    'property_type', l.property_type,
    'settings', to_jsonb(l.settings),
    'amenities', to_jsonb(l.amenities),
    'has_pool', l.has_pool,
    'pool_heated', l.pool_heated,
    'max_guests', l.max_guests,
    'bedrooms', l.bedrooms,
    'rating', l.rating_avg,
    'review_count', l.review_count,
    'badge', l.badge,
    'tagline', l.tagline,
    'instant_book', l.instant_book,
    'cancellation_policy', l.cancellation_policy,
    'pets_allowed', l.pets_allowed,
    'accessible', l.accessible,
    'latitude', l.latitude,
    'longitude', l.longitude,
    'display_price', public.display_price(l),
    'photos', coalesce((
      select jsonb_agg(p.url order by (p.id = l.cover_photo_id) desc, p.position, p.created_at)
      from public.listing_photos p
      where p.listing_id = l.id
    ), '[]'::jsonb)
  );
$$;

-- Fiyat kalemleri (uygulamadaki PriceBreakdown). Tarih verilirse o gecelerin
-- fiyatı (hafta sonu ve takvim özel fiyatı dahil), yoksa p_nights × gecelik.
-- Haftalık indirim compute_quote ile aynı kuraldır.
create or replace function private.offer_price(
  l public.listings,
  p_check_in date,
  p_check_out date,
  p_nights int
)
returns jsonb
language plpgsql
stable
set search_path = ''
as $$
declare
  s public.platform_settings := private.settings();
  v_nights int;
  v_stay int;
  v_discount int := 0;
begin
  if p_check_in is not null and p_check_out is not null and p_check_out > p_check_in then
    v_nights := p_check_out - p_check_in;
    select sum(private.night_price(l, d::date, c.price))::int into v_stay
    from generate_series(p_check_in, p_check_out - 1, interval '1 day') as d
    left join public.listing_calendar c on c.listing_id = l.id and c.day = d::date;
  else
    v_nights := greatest(coalesce(p_nights, 2), 1);
    v_stay := l.nightly_price * v_nights;
  end if;

  if v_nights >= 7 and l.weekly_discount_percent > 0 then
    v_discount := round(v_stay * l.weekly_discount_percent / 100.0);
  end if;

  return jsonb_build_object(
    'nights', v_nights,
    'nightly_rate', round(v_stay::numeric / v_nights)::int,
    'cleaning_fee', l.cleaning_fee,
    'service_fee', round((v_stay + l.cleaning_fee) * s.guest_service_fee_percent / 100.0)::int,
    'discount', v_discount,
    'discount_kind', case when v_discount > 0 then 'long_stay' end
  );
end;
$$;

-- 16–17 · Arama sonuçları ve harita: kartlar + fiyat, search_listings sırasıyla.
create or replace function public.search_listing_cards(
  p_location text default null,
  p_check_in date default null,
  p_check_out date default null,
  p_guests int default 1,
  p_pets boolean default false,
  p_price_min int default null,
  p_price_max int default null,
  p_features text[] default '{}',
  p_category text default null,
  p_bedrooms int default null,
  p_instant_book boolean default false,
  p_free_cancellation boolean default false,
  p_pets_allowed boolean default false,
  p_accessible boolean default false,
  p_min_lat double precision default null,
  p_max_lat double precision default null,
  p_min_lng double precision default null,
  p_max_lng double precision default null,
  p_sort text default 'recommended',
  p_limit int default 20,
  p_offset int default 0,
  p_nights int default 2
)
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce(jsonb_agg(x.card order by x.n), '[]'::jsonb)
  from (
    select
      t.n,
      private.listing_card(t.l)
        || jsonb_build_object('price', private.offer_price(t.l, p_check_in, p_check_out, p_nights)) as card
    from (
      select l, row_number() over () as n
      from public.search_listings(
        p_location, p_check_in, p_check_out, p_guests, p_pets, p_price_min, p_price_max,
        p_features, p_category, p_bedrooms, p_instant_book, p_free_cancellation,
        p_pets_allowed, p_accessible, p_min_lat, p_max_lat, p_min_lng, p_max_lng,
        p_sort, p_limit, p_offset
      ) as l
    ) t
  ) x;
$$;

-- Kaydedilenler / son baktıkların: yalnızca yayındaki ilanlar, verilen sırayla.
create or replace function public.listing_cards(p_ids uuid[])
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce(jsonb_agg(private.listing_card(l) order by array_position(p_ids, l.id)), '[]'::jsonb)
  from public.listings l
  where l.id = any (p_ids) and l.status = 'published';
$$;

-- 20 · İlan detayı. Yayındaki ilanı herkes; taslağı yalnızca sahibi ve
-- yönetici görür. Tam adres ve giriş bilgileri burada YOK (get_trip_access).
create or replace function public.listing_detail(p_listing uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  l public.listings;
  h public.profiles;
begin
  if not public.is_listing_visible(p_listing) then
    perform private.fail('not_found');
  end if;
  select * into l from public.listings where id = p_listing;
  select * into h from public.profiles where id = l.host_id;

  return private.listing_card(l) || jsonb_build_object(
    'listing_no', l.listing_no,
    'permit_no', l.permit_no,
    'beds', l.beds,
    'bathrooms', l.bathrooms,
    'min_nights', l.min_nights,
    'ratings', jsonb_build_object(
      'cleanliness', l.rating_cleanliness,
      'accuracy', l.rating_accuracy,
      'communication', l.rating_communication,
      'location', l.rating_location
    ),
    'pool', case when l.has_pool then jsonb_build_object(
      'private', l.pool_private,
      'heated', l.pool_heated,
      'temperature_c', l.pool_temp_c,
      'width_m', l.pool_width_m,
      'length_m', l.pool_length_m,
      'depth_min_m', l.pool_depth_min_m,
      'depth_max_m', l.pool_depth_max_m,
      'season_start', l.pool_season_start,
      'season_end', l.pool_season_end,
      'note', l.pool_note
    ) end,
    'summary', l.summary,
    'space', l.space,
    'guest_access', l.guest_access,
    'other_notes', l.other_notes,
    'highlights', to_jsonb(l.highlights),
    'rules', jsonb_build_object(
      'check_in_from', to_char(l.check_in_from, 'HH24:MI'),
      'check_in_to', to_char(l.check_in_to, 'HH24:MI'),
      'check_out_by', to_char(l.check_out_by, 'HH24:MI'),
      'self_check_in', l.self_check_in,
      'quiet_hours', l.quiet_hours,
      'quiet_from', to_char(l.quiet_from, 'HH24:MI'),
      'quiet_to', to_char(l.quiet_to, 'HH24:MI'),
      'smoking_allowed', l.smoking_allowed,
      'events_allowed', l.events_allowed
    ),
    'safety', to_jsonb(l.safety),
    'outdoor_camera_note', l.outdoor_camera_note,
    'photo_rooms', coalesce((
      select jsonb_agg(r.room_json order by r.first_pos)
      from (
        select
          min(p.position) as first_pos,
          jsonb_build_object(
            'room', p.room,
            'photos', jsonb_agg(
              jsonb_build_object('url', p.url, 'caption', p.caption)
              order by p.position, p.created_at
            )
          ) as room_json
        from public.listing_photos p
        where p.listing_id = l.id
        group by p.room
      ) r
    ), '[]'::jsonb),
    'host', jsonb_build_object(
      'id', h.id,
      'name', coalesce(nullif(btrim(h.display_name), ''), h.first_name),
      'avatar_url', h.avatar_url,
      'level', h.host_level,
      'hosting_since', h.hosting_since,
      'identity_verified', h.identity_verified,
      'about', h.about,
      'languages', to_jsonb(h.languages),
      'response_rate', h.response_rate,
      'response_minutes', h.response_minutes,
      'listing_ids', coalesce((
        select jsonb_agg(o.id order by o.published_at)
        from public.listings o
        where o.host_id = h.id and o.status = 'published'
      ), '[]'::jsonb),
      'review_count', coalesce((
        select sum(o.review_count) from public.listings o
        where o.host_id = h.id and o.status = 'published'
      ), 0),
      'rating', (
        select round(sum(o.rating_avg * o.review_count) / nullif(sum(o.review_count), 0), 2)
        from public.listings o
        where o.host_id = h.id and o.status = 'published' and o.rating_avg is not null
      )
    ),
    'reviews', coalesce((
      select jsonb_agg(x.r order by x.created_at desc)
      from (
        select
          rv.created_at,
          jsonb_build_object(
            'id', rv.id,
            'author', case when rv.show_author then a.first_name else '' end,
            'city', coalesce(a.city, ''),
            'rating', rv.overall,
            'date', rv.created_at,
            'text', rv.body,
            'likes', to_jsonb(rv.likes)
          ) as r
        from public.reviews rv
        join public.profiles a on a.id = rv.author_id
        where rv.listing_id = l.id
        order by rv.created_at desc
        limit 20
      ) x
    ), '[]'::jsonb),
    'nearby_listing_ids', coalesce((
      select jsonb_agg(n.id)
      from (
        select o.id from public.listings o
        where o.status = 'published' and o.id <> l.id
          and private.tr_fold(o.region) = private.tr_fold(l.region)
        order by o.rating_avg desc nulls last, o.published_at desc
        limit 6
      ) n
    ), '[]'::jsonb)
  );
end;
$$;

-- 20 · Detayda tarih seçilmeden gösterilen fiyat kalemleri.
create or replace function public.listing_price_estimate(p_listing uuid, p_nights int default 2)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  l public.listings;
begin
  if not public.is_listing_visible(p_listing) then
    perform private.fail('not_found');
  end if;
  select * into l from public.listings where id = p_listing;
  if l.nightly_price is null then
    perform private.fail('listing_unavailable');
  end if;
  return private.offer_price(l, null, null, p_nights);
end;
$$;
