import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/domain/auth_validators.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../domain/account_models.dart';
import '../controllers/account_controllers.dart';
import 'account_screen.dart' show ProfileAvatar;

/// Tek ya da iki alanlı düzenleme sheet'i; kaydedilen değerleri döner.
class _FieldSpec {
  const _FieldSpec({
    required this.label,
    required this.initial,
    required this.icon,
    this.keyboard = TextInputType.text,
    this.formatters = const [],
    this.validator,
    this.capitalization = TextCapitalization.none,
  });

  final String label;
  final String initial;
  final KzIcons icon;
  final TextInputType keyboard;
  final List<TextInputFormatter> formatters;

  /// Hata metni ya da geçerliyse null.
  final String? Function(String value)? validator;
  final TextCapitalization capitalization;
}

Future<List<String>?> _editSheet(
  BuildContext context, {
  required String title,
  required List<_FieldSpec> fields,
  String? note,
}) => showKzSheet<List<String>>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _EditForm(fields: fields, note: note),
);

class _EditForm extends StatefulWidget {
  const _EditForm({required this.fields, this.note});

  final List<_FieldSpec> fields;
  final String? note;

  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  late final _controllers = [
    for (final f in widget.fields) TextEditingController(text: f.initial),
  ];
  bool _submitted = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  String? _error(int i) {
    if (!_submitted) return null;
    final v = _controllers[i].text.trim();
    return widget.fields[i].validator?.call(v);
  }

  void _save() {
    setState(() => _submitted = true);
    for (var i = 0; i < widget.fields.length; i++) {
      if (_error(i) != null) return;
    }
    Navigator.of(context).pop([for (final c in _controllers) c.text.trim()]);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, f) in widget.fields.indexed) ...[
            const SizedBox(height: KzSpace.s12),
            KzInput(
              label: f.label,
              icon: f.icon,
              controller: _controllers[i],
              errorText: _error(i),
              keyboardType: f.keyboard,
              inputFormatters: f.formatters,
              textCapitalization: f.capitalization,
              textInputAction: i == widget.fields.length - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) {
                if (i == widget.fields.length - 1) _save();
              },
            ),
          ],
          if (widget.note != null) ...[
            const SizedBox(height: KzSpace.s12),
            KzTip(icon: KzIcons.info, message: widget.note!),
          ],
          const SizedBox(height: KzSpace.s16),
          KzButton(label: l.save, onPressed: _save),
        ],
      ),
    );
  }
}

/// 66 · Bilgilerim.
class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  static const double _avatar = 60;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return switch (profile) {
      AsyncData(:final value) => _content(context, ref, value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(profileProvider),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }

  Widget _content(BuildContext context, WidgetRef ref, UserProfile p) {
    final kz = context.kz;
    final l = context.l10n;
    final notifier = ref.read(profileProvider.notifier);
    String? required(String v) => v.isEmpty ? l.errorName : null;

    Future<void> save(UserProfile next) async {
      await notifier.save(next);
      if (context.mounted) showKzToast(context, l.saved);
    }

    Widget link(bool has, VoidCallback onTap) => KzLink(
      label: has ? l.edit : l.add,
      style: KzText.bodySm,
      onPressed: onTap,
    );

    Future<void> editName() async {
      final r = await _editSheet(
        context,
        title: l.fieldFullName,
        fields: [
          _FieldSpec(
            label: l.fieldFirstName,
            initial: p.firstName,
            icon: KzIcons.user,
            validator: required,
            capitalization: TextCapitalization.words,
          ),
          _FieldSpec(
            label: l.fieldLastName,
            initial: p.lastName,
            icon: KzIcons.user,
            validator: required,
            capitalization: TextCapitalization.words,
          ),
        ],
      );
      if (r != null) await save(p.copyWith(firstName: r[0], lastName: r[1]));
    }

    Future<void> editDisplayName() async {
      final r = await _editSheet(
        context,
        title: l.fieldDisplayName,
        fields: [
          _FieldSpec(
            label: l.fieldDisplayName,
            initial: p.displayName ?? '',
            icon: KzIcons.idcard,
            capitalization: TextCapitalization.words,
          ),
        ],
      );
      if (r != null) {
        await save(p.copyWith(displayName: r[0].isEmpty ? null : r[0]));
      }
    }

    Future<void> editPhone() async {
      final r = await _editSheet(
        context,
        title: l.fieldPhone,
        note: l.verifyNote(l.fieldPhone.toLowerCase()),
        fields: [
          _FieldSpec(
            label: l.fieldPhoneNumber,
            initial: p.phone == null ? '' : KzFormat.phone(p.phone!),
            icon: KzIcons.phone,
            keyboard: TextInputType.phone,
            formatters: [TrPhoneInputFormatter()],
            validator: (v) =>
                AuthValidators.isTrMobile(v) ? null : l.errorPhone,
          ),
        ],
      );
      if (r != null) {
        await save(p.copyWith(phone: r[0].replaceAll(RegExp(r'\D'), '')));
      }
    }

    Future<void> editEmail() async {
      final r = await _editSheet(
        context,
        title: l.fieldEmail,
        note: l.verifyNote(l.fieldEmail.toLowerCase()),
        fields: [
          _FieldSpec(
            label: l.fieldEmail,
            initial: p.email,
            icon: KzIcons.mail,
            keyboard: TextInputType.emailAddress,
            validator: (v) => AuthValidators.isEmail(v) ? null : l.errorEmail,
          ),
        ],
      );
      if (r != null) await save(p.copyWith(email: r[0]));
    }

    Future<void> editAddress() async {
      final r = await _editSheet(
        context,
        title: l.fieldAddress,
        fields: [
          _FieldSpec(
            label: l.fieldAddress,
            initial: p.address ?? '',
            icon: KzIcons.pin,
            capitalization: TextCapitalization.words,
          ),
        ],
      );
      if (r != null) {
        await save(p.copyWith(address: r[0].isEmpty ? null : r[0]));
      }
    }

    Future<void> editEmergency() async {
      final e = p.emergencyContact;
      final r = await _editSheet(
        context,
        title: l.fieldEmergencyContact,
        fields: [
          _FieldSpec(
            label: l.fieldEmergencyName,
            initial: e?.name ?? '',
            icon: KzIcons.user,
            validator: required,
            capitalization: TextCapitalization.words,
          ),
          _FieldSpec(
            label: l.fieldEmergencyPhone,
            initial: e == null ? '' : KzFormat.phone(e.phone),
            icon: KzIcons.phone,
            keyboard: TextInputType.phone,
            formatters: [TrPhoneInputFormatter()],
            validator: (v) =>
                AuthValidators.isTrMobile(v) ? null : l.errorPhone,
          ),
        ],
      );
      if (r != null) {
        await save(
          p.copyWith(
            emergencyContact: EmergencyContact(
              name: r[0],
              phone: r[1].replaceAll(RegExp(r'\D'), ''),
            ),
          ),
        );
      }
    }

    Future<void> changePhoto() async {
      final f = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: KzPhotoPicker.maxDimension,
        maxHeight: KzPhotoPicker.maxDimension,
        imageQuality: KzPhotoPicker.quality,
      );
      if (f != null) await notifier.setAvatar(f.path);
    }

    final e = p.emergencyContact;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(
          title: l.personalInfoTitle,
          subtitle: l.personalInfoSubtitle,
        ),
        BookingCard(
          padding: const EdgeInsets.all(KzSpace.s16),
          child: Row(
            children: [
              ProfileAvatar(profile: p, size: _avatar),
              const SizedBox(width: KzSpace.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.profilePhoto,
                      style: KzText.titleSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s3),
                    Text(
                      l.profilePhotoSub,
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
              KzChip(
                label: l.change,
                icon: KzIcons.edit,
                variant: KzChipVariant.selected,
                size: KzChipSize.small,
                semanticLabel: '${l.change}, ${l.profilePhoto}',
                onPressed: changePhoto,
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupContact,
          rows: [
            KzRow(
              icon: KzIcons.user,
              title: l.fieldFullName,
              subtitle: p.fullName,
              trailing: link(true, editName),
            ),
            KzRow(
              icon: KzIcons.idcard,
              title: l.fieldDisplayName,
              subtitle: p.displayName ?? l.notAdded,
              trailing: link(p.displayName != null, editDisplayName),
            ),
            KzRow(
              icon: KzIcons.phone,
              title: l.fieldPhone,
              subtitle: p.phone == null
                  ? l.phoneNotAdded
                  : KzFormat.maskedPhone(p.phone!),
              trailing: link(p.phone != null, editPhone),
            ),
            KzRow(
              icon: KzIcons.mail,
              title: l.fieldEmail,
              subtitle: KzFormat.maskedEmail(p.email),
              trailing: link(true, editEmail),
            ),
            KzRow(
              icon: KzIcons.pin,
              title: l.fieldAddress,
              subtitle: p.address ?? l.notAdded,
              trailing: link(p.address != null, editAddress),
            ),
            KzRow(
              icon: KzIcons.users,
              title: l.fieldEmergencyContact,
              subtitle: e == null
                  ? l.notAdded
                  : l.emergencyLine(e.name, KzFormat.maskedPhone(e.phone)),
              trailing: link(e != null, editEmergency),
            ),
          ],
        ),
      ],
    );
  }
}
