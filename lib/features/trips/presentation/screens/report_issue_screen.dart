import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../domain/trip_models.dart';

extension IssueTopicUi on IssueTopic {
  KzIcons get icon => switch (this) {
    IssueTopic.pool => KzIcons.waves,
    IssueTopic.hotWater => KzIcons.flame,
    IssueTopic.cleaning => KzIcons.sparkles,
    IssueTopic.wifi => KzIcons.wifi,
    IssueTopic.climate => KzIcons.snow,
    IssueTopic.other => KzIcons.help,
  };

  String label(AppLocalizations l) => switch (this) {
    IssueTopic.pool => l.issuePool,
    IssueTopic.hotWater => l.issueHotWater,
    IssueTopic.cleaning => l.issueCleaning,
    IssueTopic.wifi => l.issueWifi,
    IssueTopic.climate => l.issueClimate,
    IssueTopic.other => l.issueOther,
  };
}

/// 51 · Sorun Bildir.
class ReportIssueScreen extends ConsumerStatefulWidget {
  const ReportIssueScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends ConsumerState<ReportIssueScreen> {
  final _text = TextEditingController();
  IssueTopic? _topic;
  IssueUrgency _urgency = IssueUrgency.today;
  List<String> _photos = const [];
  bool _submitted = false;
  bool _sending = false;

  static const double _tileHeight = 92;
  static const int _columns = 3;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _textOk => _text.text.trim().length >= IssuePolicy.minLength;

  Future<void> _send() async {
    setState(() => _submitted = true);
    if (_topic == null || !_textOk || _sending) return;
    HapticFeedback.lightImpact();
    setState(() => _sending = true);
    try {
      await ref
          .read(bookingRepositoryProvider)
          .reportIssue(
            widget.bookingId,
            IssueReport(
              topic: _topic!,
              urgency: _urgency,
              description: _text.text.trim(),
              photoPaths: _photos,
            ),
          );
      if (!mounted) return;
      showKzToast(context, context.l10n.issueSent);
      context.pop();
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final booking = ref.watch(bookingProvider(widget.bookingId)).value;
    final host = booking == null
        ? null
        : ref.watch(listingDetailProvider(booking.listingId)).value?.host;

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.issueSubmit,
          loading: _sending,
          onPressed: _topic == null ? null : _send,
        ),
      ),
      children: [
        KzPageTitle(title: l.issueTitle, subtitle: l.issueSubtitle),
        LayoutBuilder(
          builder: (context, c) {
            final w = (c.maxWidth - KzSpace.s10 * (_columns - 1)) / _columns;
            return Wrap(
              spacing: KzSpace.s10,
              runSpacing: KzSpace.s10,
              children: [
                for (final t in IssueTopic.values)
                  _TopicTile(
                    width: w,
                    height: _tileHeight,
                    topic: t,
                    selected: t == _topic,
                    onPressed: () => setState(() => _topic = t),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: KzSpace.s20),
        Text(
          l.issueUrgencyTitle,
          style: KzText.titleSm.copyWith(color: kz.ink),
        ),
        const SizedBox(height: KzSpace.s10),
        KzSegmented<IssueUrgency>(
          segments: [
            (IssueUrgency.low, l.urgencyLow),
            (IssueUrgency.today, l.urgencyToday),
            (IssueUrgency.urgent, l.urgencyHigh),
          ],
          selected: _urgency,
          compact: true,
          onChanged: (u) => setState(() => _urgency = u),
        ),
        if (_urgency == IssueUrgency.urgent) ...[
          const SizedBox(height: KzSpace.s12),
          KzTip(
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
            message: l.urgentCallNote,
          ),
        ],
        const SizedBox(height: KzSpace.s16),
        KzTextArea(
          label: l.issueDescribe,
          hint: l.issueDescribeHint,
          controller: _text,
          minLines: 3,
          errorText: _submitted && !_textOk
              ? l.errorIssueShort(IssuePolicy.minLength)
              : null,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: KzSpace.s16),
        Text(l.issuePhotos, style: KzText.titleSm.copyWith(color: kz.ink)),
        const SizedBox(height: KzSpace.s10),
        KzPhotoPicker(
          paths: _photos,
          max: IssuePolicy.maxPhotos,
          addLabel: l.photoAdd,
          removeLabel: l.photoRemove,
          onChanged: (p) => setState(() => _photos = p),
        ),
        if (host != null) ...[
          const SizedBox(height: KzSpace.s16),
          KzTip(
            icon: KzIcons.clock,
            tone: KzTipTone.info,
            message: l.issueResponseNote(host.responseTimeLabel(l)),
          ),
        ],
      ],
    );
  }
}

/// Konu seçim kutusu: seçili forestSoft + 2px forest, değil surface + line.
class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.width,
    required this.height,
    required this.topic,
    required this.selected,
    required this.onPressed,
  });

  final double width;
  final double height;
  final IssueTopic topic;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final fg = selected ? kz.forest : kz.ink;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: topic.label(l),
        child: AnimatedContainer(
          duration: KzMotion.of(context, KzMotion.micro),
          width: width,
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s6,
            vertical: KzSpace.s12,
          ),
          decoration: BoxDecoration(
            color: selected ? kz.forestSoft : kz.surface,
            borderRadius: KzRadii.all(KzRadii.field),
            border: Border.all(
              color: selected ? kz.forest : kz.line,
              width: selected ? KzSize.borderFocus : KzSize.border,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KzIcon(topic.icon, size: KzSize.iconLg, color: fg),
              const SizedBox(height: KzSpace.s8),
              Text(
                topic.label(l),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: KzText.captionHeavy.copyWith(color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
