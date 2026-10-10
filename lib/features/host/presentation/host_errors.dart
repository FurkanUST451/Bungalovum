import '../../../l10n/l10n.dart';
import '../domain/listing_draft.dart';
import 'host_labels.dart';

/// Ev sahibi işlemlerinde backend hata kodunu çözüm odaklı metne çevirir
/// (§11, §14). Tanınmayan hatalar bağlantı hatası sayılır.
String hostErrorMessage(AppLocalizations l, Object error) => switch (error) {
  HostFailure(code: 'listing_incomplete', :final detail) => switch (_steps(
    detail,
  )) {
    [] => l.errorListingIncomplete,
    final steps => l.errorListingIncompleteSteps(
      steps.map((s) => s.label(l)).join(', '),
    ),
  },
  HostFailure(code: 'consents_required') => l.errorConsents,
  HostFailure(code: 'listing_in_review') => l.errorListingInReview,
  HostFailure(code: 'invalid_iban') => l.errorIban,
  HostFailure(code: 'iban_name_mismatch') => l.errorIbanHolder,
  HostFailure(code: 'invalid_tax_id') => l.errorTaxId,
  HostFailure(code: 'invalid_phone') => l.errorPhone,
  HostFailure(code: 'has_upcoming_bookings') => l.errorUnpublishBookings,
  HostFailure(code: 'auth_required') => l.errorSessionExpired,
  HostFailure(code: 'address_not_found') => l.errorAddressNotFound,
  HostFailure(code: 'iban_required') => l.errorIbanRequired,
  HostFailure(code: 'file_too_large' || 'unsupported_type') =>
    l.errorPhotoUpload,
  _ => l.errorNetwork,
};

/// Backend'in eksik adım listesi: "legal,identity_and_payout" → adımlar.
List<WizardStep> _steps(String? detail) => [
  for (final raw in (detail ?? '').split(','))
    for (final s in WizardStep.values)
      if (_snake(s.name) == raw.trim()) s,
];

String _snake(String camel) =>
    camel.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');
