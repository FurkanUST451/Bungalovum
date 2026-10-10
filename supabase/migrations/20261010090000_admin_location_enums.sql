-- =============================================================================
-- Bungalovum · 14 · Yönetici: ilan konumu — işlem kaydı türü
--
-- Enum'a eklenen değer aynı işlemde kullanılamadığı için ayrı migration:
-- 20261010090100_admin_location.sql bunu kullanır.
-- =============================================================================

alter type public.admin_action_kind add value if not exists 'listing_location_set';
