// Bungalovum · geocode-address
//
// İlan adresinden harita konumu bulur (OpenStreetMap Nominatim, ücretsiz,
// anahtarsız). Önce tam adres, bulunamazsa "ilçe, il" denenir. Sonuç
// yalnızca Türkiye içindeyse döner.
//
// Nominatim kullanım kuralları: saniyede en fazla 1 istek ve tanımlayıcı
// User-Agent. Uygulama bu fonksiyonu yalnızca adres değişince çağırır.
//
// İstek (Authorization: Bearer <kullanıcı oturumu>):
//   { "address": "Kırkpınar Mah. Göl Sk. No: 12", "district": "Sapanca", "city": "Sakarya" }
// Yanıt:
//   { "latitude": 40.69, "longitude": 30.27, "precision": "address" | "district" }
//   404 { "error": "not_found" }

import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!;

const NOMINATIM = 'https://nominatim.openstreetmap.org/search';
const USER_AGENT = 'Bungalovum/0.1 (bungalov kiralama; geocode-address)';

// listings tablosundaki check kısıtlarıyla aynı sınırlar.
const inTurkey = (lat: number, lng: number) => lat >= 35 && lat <= 43 && lng >= 25 && lng <= 45;

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });

const clean = (v: unknown) => (typeof v === 'string' ? v.trim().slice(0, 200) : '');

async function search(q: string): Promise<{ lat: number; lng: number } | null> {
  const url = new URL(NOMINATIM);
  url.searchParams.set('q', q);
  url.searchParams.set('format', 'jsonv2');
  url.searchParams.set('countrycodes', 'tr');
  url.searchParams.set('limit', '1');
  url.searchParams.set('accept-language', 'tr');
  const res = await fetch(url, { headers: { 'User-Agent': USER_AGENT } });
  if (!res.ok) return null;
  const rows = await res.json();
  if (!Array.isArray(rows) || rows.length === 0) return null;
  const lat = Number(rows[0].lat);
  const lng = Number(rows[0].lon);
  return Number.isFinite(lat) && Number.isFinite(lng) && inTurkey(lat, lng) ? { lat, lng } : null;
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return json({ error: 'method_not_allowed' }, 405);

  const authorization = req.headers.get('Authorization');
  if (!authorization) return json({ error: 'auth_required' }, 401);
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: authorization } },
  });
  const { data: auth } = await supabase.auth.getUser();
  if (!auth.user) return json({ error: 'auth_required' }, 401);

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return json({ error: 'invalid_request' }, 400);
  }
  const address = clean(body.address);
  const district = clean(body.district);
  const city = clean(body.city);
  if (!district || !city) return json({ error: 'invalid_request' }, 400);

  const area = `${district}, ${city}`;
  const exact = address ? await search(`${address}, ${area}`) : null;
  if (exact) return json({ latitude: exact.lat, longitude: exact.lng, precision: 'address' });

  const rough = await search(area);
  if (rough) return json({ latitude: rough.lat, longitude: rough.lng, precision: 'district' });

  return json({ error: 'not_found' }, 404);
});
