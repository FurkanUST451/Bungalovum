-- =============================================================================
-- Bungalovum · 12 · Yönetici paneli 2. tur — işlem kaydı türleri
--
-- Enum'a eklenen değer aynı işlemde kullanılamadığı için ayrı migration:
-- 20261009120000_admin_round2.sql bunları kullanır.
-- =============================================================================

alter type public.admin_target add value if not exists 'report';
alter type public.admin_target add value if not exists 'review';
alter type public.admin_target add value if not exists 'coupon';
alter type public.admin_target add value if not exists 'deletion_request';
alter type public.admin_target add value if not exists 'legal_document';
alter type public.admin_target add value if not exists 'faq';
alter type public.admin_target add value if not exists 'conversation';

alter type public.admin_action_kind add value if not exists 'report_updated';
alter type public.admin_action_kind add value if not exists 'review_hidden';
alter type public.admin_action_kind add value if not exists 'review_unhidden';
alter type public.admin_action_kind add value if not exists 'coupon_created';
alter type public.admin_action_kind add value if not exists 'coupon_activated';
alter type public.admin_action_kind add value if not exists 'coupon_deactivated';
alter type public.admin_action_kind add value if not exists 'deletion_processed';
alter type public.admin_action_kind add value if not exists 'legal_published';
alter type public.admin_action_kind add value if not exists 'faq_saved';
alter type public.admin_action_kind add value if not exists 'faq_deleted';
alter type public.admin_action_kind add value if not exists 'support_replied';
