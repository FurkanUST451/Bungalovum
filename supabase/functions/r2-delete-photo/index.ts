// Bungalovum · r2-delete-photo
//
// Ev sahibinin kaldırdığı ilan fotoğrafını Cloudflare R2'den ve
// listing_photos tablosundan siler. Yetki kontrolü kullanıcının kendi
// oturumuyla (RLS) yapılır; R2 anahtarları yalnızca burada durur.
//
// İstek (Authorization: Bearer <kullanıcı oturumu>):
//   { "photo_id": "..." }
// Yanıt: { "deleted": true }

import { createClient } from 'npm:@supabase/supabase-js@2';
import { AwsV4Signer } from 'npm:aws4fetch@1.0.20';

const R2_ACCOUNT_ID = Deno.env.get('R2_ACCOUNT_ID')!;
const R2_ACCESS_KEY_ID = Deno.env.get('R2_ACCESS_KEY_ID')!;
const R2_SECRET_ACCESS_KEY = Deno.env.get('R2_SECRET_ACCESS_KEY')!;
const R2_BUCKET = Deno.env.get('R2_BUCKET') ?? 'bungalovum-photos';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!;

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });

Deno.serve(async (req) => {
  if (req.method !== 'POST') return json({ error: 'method_not_allowed' }, 405);

  const authorization = req.headers.get('Authorization');
  if (!authorization) return json({ error: 'auth_required' }, 401);

  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: authorization } },
  });
  const { data: auth } = await supabase.auth.getUser();
  if (!auth.user) return json({ error: 'auth_required' }, 401);

  let photoId: string | undefined;
  try {
    photoId = (await req.json()).photo_id;
  } catch {
    return json({ error: 'invalid_request' }, 400);
  }
  if (!UUID.test(photoId ?? '')) return json({ error: 'invalid_request' }, 400);

  const { data: photo, error } = await supabase
    .from('listing_photos')
    .select('id, listing_id, storage_key')
    .eq('id', photoId)
    .maybeSingle();
  if (error) return json({ error: 'internal_error' }, 500);
  if (!photo) return json({ deleted: true });

  const { data: isHost, error: hostError } = await supabase.rpc('is_listing_host', {
    p_listing: photo.listing_id,
  });
  if (hostError) return json({ error: 'internal_error' }, 500);
  if (!isHost) return json({ error: 'forbidden' }, 403);

  const signed = await new AwsV4Signer({
    url: `https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com/${R2_BUCKET}/${photo.storage_key}`,
    method: 'DELETE',
    accessKeyId: R2_ACCESS_KEY_ID,
    secretAccessKey: R2_SECRET_ACCESS_KEY,
    service: 's3',
    region: 'auto',
  }).sign();
  const r2 = await fetch(signed.url, { method: 'DELETE', headers: signed.headers });
  // 404: nesne zaten yok; satır yine silinir.
  if (!r2.ok && r2.status !== 404) return json({ error: 'storage_error' }, 502);

  const { error: deleteError } = await supabase.from('listing_photos').delete().eq('id', photo.id);
  if (deleteError) return json({ error: 'internal_error' }, 500);
  return json({ deleted: true });
});
