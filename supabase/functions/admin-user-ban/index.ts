// Bungalovum · admin-user-ban
//
// Yönetici panelinden (bungalovum-admin) hesabı askıya alır ya da askıyı
// kaldırır. Supabase Auth'ta ban service_role gerektirdiği için burada
// yapılır; panel service_role anahtarını hiçbir zaman görmez.
//
// 1. Çağıranın oturumuyla public.is_admin() → değilse 403 forbidden.
// 2. service_role ile auth.admin.updateUserById(ban_duration).
// 3. Çağıranın oturumuyla public.admin_record_user_ban() → işlem kaydı
//    (auth.users'taki gerçek ban durumuna göre yazılır).
//
// İstek (Authorization: Bearer <yöneticinin oturumu>):
//   { "user_id": "...", "ban": true, "duration_hours": 168 | null, "note": "..." }
//   duration_hours boşsa süresiz.
// Yanıt: { "banned_until": "2026-10-16T…" | null, "logged": true }

import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

// Panel şimdilik yalnızca localhost'ta çalışır. İnternete açılırsa adresi
// Supabase secrets'a ekle: ADMIN_ALLOWED_ORIGINS=https://panel.ornek.com
const EXTRA_ORIGINS = (Deno.env.get('ADMIN_ALLOWED_ORIGINS') ?? '')
  .split(',')
  .map((o) => o.trim())
  .filter(Boolean);
const LOCAL_ORIGIN = /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/;

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
// Süresiz: ~100 yıl (Supabase Auth "none" dışında süre ister).
const FOREVER_HOURS = 876000;
const MAX_NOTE = 1000;

function corsHeaders(origin: string | null): Record<string, string> {
  const allowed = origin && (LOCAL_ORIGIN.test(origin) || EXTRA_ORIGINS.includes(origin));
  return allowed
    ? {
        'Access-Control-Allow-Origin': origin!,
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        Vary: 'Origin',
      }
    : {};
}

Deno.serve(async (req) => {
  const cors = corsHeaders(req.headers.get('Origin'));
  const json = (body: unknown, status = 200) =>
    new Response(JSON.stringify(body), {
      status,
      headers: { ...cors, 'Content-Type': 'application/json' },
    });

  if (req.method === 'OPTIONS') return new Response('ok', { headers: cors });
  if (req.method !== 'POST') return json({ error: 'method_not_allowed' }, 405);

  const authorization = req.headers.get('Authorization');
  if (!authorization) return json({ error: 'auth_required' }, 401);

  const caller = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: authorization } },
  });
  const { data: auth } = await caller.auth.getUser();
  if (!auth.user) return json({ error: 'auth_required' }, 401);

  const { data: isAdmin, error: adminError } = await caller.rpc('is_admin');
  if (adminError) return json({ error: 'internal_error' }, 500);
  if (isAdmin !== true) return json({ error: 'forbidden' }, 403);

  let body: { user_id?: string; ban?: boolean; duration_hours?: number | null; note?: string | null };
  try {
    body = await req.json();
  } catch {
    return json({ error: 'invalid_request' }, 400);
  }
  const userId = body.user_id ?? '';
  const ban = body.ban;
  const hours = body.duration_hours ?? null;
  const note = (body.note ?? '').trim();
  if (!UUID.test(userId) || typeof ban !== 'boolean') return json({ error: 'invalid_request' }, 400);
  if (hours !== null && (!Number.isInteger(hours) || hours < 1 || hours > FOREVER_HOURS)) {
    return json({ error: 'invalid_request' }, 400);
  }
  if (note.length > MAX_NOTE) return json({ error: 'invalid_request' }, 400);
  if (ban && note === '') return json({ error: 'note_required' }, 400);
  // Yönetici kendini kilitleyemez.
  if (ban && userId === auth.user.id) return json({ error: 'cannot_ban_self' }, 400);

  const service = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data: updated, error: banError } = await service.auth.admin.updateUserById(userId, {
    ban_duration: ban ? `${hours ?? FOREVER_HOURS}h` : 'none',
  });
  if (banError) {
    return banError.status === 404 ? json({ error: 'not_found' }, 404) : json({ error: 'auth_error' }, 502);
  }

  // Ban yapıldı; kayıt yazılamazsa panel uyarı gösterir.
  const { error: logError } = await caller.rpc('admin_record_user_ban', {
    p_user: userId,
    p_note: note === '' ? null : note,
  });

  return json({
    banned_until: (updated.user as { banned_until?: string | null })?.banned_until ?? null,
    logged: !logError,
  });
});
