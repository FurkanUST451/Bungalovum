-- =============================================================================
-- Bungalovum · 09 · Zamanlanmış işler (pg_cron)
-- Supabase panelinde: Integrations › Cron. Saatler UTC'dir.
-- =============================================================================

create extension if not exists pg_cron with schema pg_catalog;

-- Ödemesi tamamlanmayan tutmalar (her dakika).
select cron.schedule('expire-booking-holds', '* * * * *', $$select private.expire_booking_holds()$$);

-- Ev sahibinin 24 saatte yanıtlamadığı talepler (her 5 dakika).
select cron.schedule('expire-booking-requests', '*/5 * * * *', $$select private.expire_booking_requests()$$);

-- Çıkışı geçen konaklamalar tamamlanır, ev sahibi aktarımı planlanır
-- (her gün 09:00 UTC = 12:00 Türkiye).
select cron.schedule('complete-finished-bookings', '0 9 * * *', $$select private.complete_finished_bookings()$$);

-- Son baktıkların 30 günden eskileri ve okunmuş eski bildirimler
-- (her gün 03:00 UTC).
select cron.schedule(
  'purge-old-activity',
  '0 3 * * *',
  $$
    delete from public.recent_views where viewed_at < now() - interval '30 days';
    delete from public.notifications where read_at is not null and created_at < now() - interval '180 days';
  $$
);
