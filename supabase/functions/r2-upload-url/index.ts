// Bungalovum · r2-upload-url
//
// İlan ve değerlendirme fotoğraflarını Cloudflare R2'ye doğrudan yüklemek için
// kısa süreli imzalı adres üretir. R2 anahtarları yalnızca burada (Supabase
// secrets) durur; uygulamaya hiçbir zaman gönderilmez.
//
// İstek (Authorization: Bearer <kullanıcı oturumu>):
//   { "purpose": "listing_photo", "listing_id": "...", "content_type": "image/jpeg", "size": 412345 }
//   { "purpose": "review_photo",  "booking_id": "...", "content_type": "image/webp", "size": 210000 }
// Yanıt:
//   { "upload_url", "method": "PUT", "headers": { "Content-Type" }, "key", "public_url", "expires_in" }
//
// Uygulama dosyayı upload_url'e PUT eder (gövde uzunluğu "size" ile aynı
// olmalı), ardından listing_photos satırını key + public_url ile ekler.

import { createClient } from 'npm:@supabase/supabase-js@2';
import { AwsV4Signer } from 'npm:aws4fetch@1.0.20';

const R2_ACCOUNT_ID = Deno.env.get('R2_ACCOUNT_ID')!;
const R2_ACCESS_KEY_ID = Deno.env.get('R2_ACCESS_KEY_ID')!;
const R2_SECRET_ACCESS_KEY = Deno.env.get('R2_SECRET_ACCESS_KEY')!;
const R2_BUCKET = Deno.env.get('R2_BUCKET') ?? 'bungalovum-photos';
// Örn. https://pub-xxxx.r2.dev ya da https://cdn.bungalovum.com
const R2_PUBLIC_URL = Deno.env.get('R2_PUBLIC_URL')!.replace(/\/$/, '');

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!;

/** Uygulama fotoğrafı yüklemeden önce küçültür; bu üst sınır güvenlik içindir. */
const MAX_BYTES = 5 * 1024 * 1024;
const EXPIRES_IN = 300;
const EXTENSIONS: Record<string, string> = {
  'image/jpeg': 'jpg',
  'image/webp': 'webp',
};
const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

type UploadRequest = {
  purpose?: 'listing_photo' | 'review_photo';
  listing_id?: string;
  booking_id?: string;
  content_type?: string;
  size?: number;
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });

Deno.serve(async (req) => {
  if (req.method !== 'POST') return json({ error: 'method_not_allowed' }, 405);

  const authorization = req.headers.get('Authorization');
  if (!authorization) return json({ error: 'auth_required' }, 401);

  // Kullanıcının kendi oturumuyla: RLS ve RPC yetki kontrolleri geçerli.
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: authorization } },
  });
  const { data: auth } = await supabase.auth.getUser();
  if (!auth.user) return json({ error: 'auth_required' }, 401);

  let body: UploadRequest;
  try {
    body = await req.json();
  } catch {
    return json({ error: 'invalid_request' }, 400);
  }

  const ext = EXTENSIONS[body.content_type ?? ''];
  if (!ext) return json({ error: 'unsupported_type' }, 400);
  const size = Number(body.size);
  if (!Number.isInteger(size) || size <= 0 || size > MAX_BYTES) {
    return json({ error: 'file_too_large', max_bytes: MAX_BYTES }, 400);
  }

  let key: string;
  switch (body.purpose) {
    case 'listing_photo': {
      if (!UUID.test(body.listing_id ?? '')) return json({ error: 'invalid_request' }, 400);
      const { data: isHost, error } = await supabase.rpc('is_listing_host', { p_listing: body.listing_id });
      if (error) return json({ error: 'internal_error' }, 500);
      if (!isHost) return json({ error: 'forbidden' }, 403);
      key = `listings/${body.listing_id}/${crypto.randomUUID()}.${ext}`;
      break;
    }
    case 'review_photo': {
      if (!UUID.test(body.booking_id ?? '')) return json({ error: 'invalid_request' }, 400);
      // RLS: misafir yalnızca kendi rezervasyonunu görür.
      const { data: booking, error } = await supabase
        .from('bookings')
        .select('id')
        .eq('id', body.booking_id)
        .eq('guest_id', auth.user.id)
        .in('status', ['confirmed', 'completed'])
        .maybeSingle();
      if (error) return json({ error: 'internal_error' }, 500);
      if (!booking) return json({ error: 'forbidden' }, 403);
      key = `reviews/${body.booking_id}/${crypto.randomUUID()}.${ext}`;
      break;
    }
    default:
      return json({ error: 'invalid_request' }, 400);
  }

  const url = new URL(`https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com/${R2_BUCKET}/${key}`);
  url.searchParams.set('X-Amz-Expires', String(EXPIRES_IN));

  // Content-Type ve Content-Length imzaya dahil: farklı tür ya da boyutta
  // dosya yüklenemez.
  const signed = await new AwsV4Signer({
    url: url.toString(),
    method: 'PUT',
    headers: { 'Content-Type': body.content_type!, 'Content-Length': String(size) },
    accessKeyId: R2_ACCESS_KEY_ID,
    secretAccessKey: R2_SECRET_ACCESS_KEY,
    service: 's3',
    region: 'auto',
    signQuery: true,
    allHeaders: true,
  }).sign();

  return json({
    upload_url: signed.url.toString(),
    method: 'PUT',
    headers: { 'Content-Type': body.content_type },
    key,
    public_url: `${R2_PUBLIC_URL}/${key}`,
    expires_in: EXPIRES_IN,
  });
});
