-- =============================================================================
-- Bungalovum · 08 · Supabase Storage
--
-- İlan ve değerlendirme fotoğrafları Cloudflare R2'de tutulur (bkz. Edge
-- Function r2-upload-url). Supabase Storage yalnızca gizli/küçük dosyalar için:
--
--   host-documents     (gizli) {host_id}/{listing_id}/{kind}-{uuid}.pdf
--   identity-documents (gizli) {user_id}/{front|back|selfie}-{uuid}.jpg
--   chat-attachments   (gizli) {conversation_id}/{uuid}.jpg
--   issue-photos       (gizli) {booking_id}/{uuid}.jpg
--   avatars            (açık)  {user_id}/{uuid}.jpg
--
-- Gizli dosyalar uygulamada kısa süreli imzalı adresle (createSignedUrl)
-- gösterilir ve cihazda önbelleğe alınmaz (KVKK).
-- =============================================================================

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  ('host-documents', 'host-documents', false, 10485760,
   array['application/pdf', 'image/jpeg', 'image/png', 'image/webp', 'image/heic']),
  ('identity-documents', 'identity-documents', false, 10485760,
   array['image/jpeg', 'image/png', 'image/webp', 'image/heic']),
  ('chat-attachments', 'chat-attachments', false, 10485760,
   array['image/jpeg', 'image/png', 'image/webp', 'image/heic']),
  ('issue-photos', 'issue-photos', false, 10485760,
   array['image/jpeg', 'image/png', 'image/webp', 'image/heic']),
  ('avatars', 'avatars', true, 2097152,
   array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

-- Klasör adını uuid'ye çevirir; geçersizse null (politika reddeder).
create or replace function public.storage_folder_uuid(p_name text, p_index int default 1)
returns uuid
language plpgsql
immutable
set search_path = ''
as $$
begin
  return (storage.foldername(p_name))[p_index]::uuid;
exception
  when invalid_text_representation then
    return null;
end;
$$;

-- host-documents ------------------------------------------------------------

create policy "Ev sahibi kendi belgelerini yükler"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'host-documents'
  and public.storage_folder_uuid(name, 1) = (select auth.uid())
  and public.is_listing_host(public.storage_folder_uuid(name, 2))
);

create policy "Ev sahibi ve yönetici belgeleri görür"
on storage.objects for select
to authenticated
using (
  bucket_id = 'host-documents'
  and (public.storage_folder_uuid(name, 1) = (select auth.uid()) or (select public.is_admin()))
);

create policy "Ev sahibi kendi belgesini siler"
on storage.objects for delete
to authenticated
using (bucket_id = 'host-documents' and public.storage_folder_uuid(name, 1) = (select auth.uid()));

-- identity-documents --------------------------------------------------------

create policy "Kullanıcı kimlik belgesini yükler"
on storage.objects for insert
to authenticated
with check (bucket_id = 'identity-documents' and public.storage_folder_uuid(name, 1) = (select auth.uid()));

create policy "Kullanıcı ve yönetici kimlik belgesini görür"
on storage.objects for select
to authenticated
using (
  bucket_id = 'identity-documents'
  and (public.storage_folder_uuid(name, 1) = (select auth.uid()) or (select public.is_admin()))
);

create policy "Kullanıcı kimlik belgesini siler"
on storage.objects for delete
to authenticated
using (bucket_id = 'identity-documents' and public.storage_folder_uuid(name, 1) = (select auth.uid()));

-- chat-attachments ----------------------------------------------------------

create policy "Sohbet üyeleri ek yükler"
on storage.objects for insert
to authenticated
with check (bucket_id = 'chat-attachments' and public.is_conversation_member(public.storage_folder_uuid(name, 1)));

create policy "Sohbet üyeleri ekleri görür"
on storage.objects for select
to authenticated
using (bucket_id = 'chat-attachments' and public.is_conversation_member(public.storage_folder_uuid(name, 1)));

-- issue-photos --------------------------------------------------------------

create policy "Misafir sorun fotoğrafı yükler"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'issue-photos'
  and exists (
    select 1 from public.bookings b
    where b.id = public.storage_folder_uuid(name, 1) and b.guest_id = (select auth.uid())
  )
);

create policy "Rezervasyon tarafları sorun fotoğraflarını görür"
on storage.objects for select
to authenticated
using (
  bucket_id = 'issue-photos'
  and (public.is_booking_party(public.storage_folder_uuid(name, 1)) or (select public.is_admin()))
);

-- avatars (açık bucket: okuma herkese açık adresle) --------------------------

create policy "Kullanıcı avatar yükler"
on storage.objects for insert
to authenticated
with check (bucket_id = 'avatars' and public.storage_folder_uuid(name, 1) = (select auth.uid()));

create policy "Kullanıcı avatarını değiştirir"
on storage.objects for update
to authenticated
using (bucket_id = 'avatars' and public.storage_folder_uuid(name, 1) = (select auth.uid()))
with check (bucket_id = 'avatars' and public.storage_folder_uuid(name, 1) = (select auth.uid()));

create policy "Kullanıcı avatarını siler"
on storage.objects for delete
to authenticated
using (bucket_id = 'avatars' and public.storage_folder_uuid(name, 1) = (select auth.uid()));
