import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../explore/presentation/widgets/explore_message.dart';

/// Rezervasyon ekranları yüklenirken: başlık + kart iskeletleri.
class BookingLoading extends StatelessWidget {
  const BookingLoading({super.key, this.cards = 3});

  final int cards;

  @override
  Widget build(BuildContext context) => KzScaffold(
    header: KzTopBar(leading: KzNavButton(semanticLabel: context.l10n.back)),
    children: [
      const SizedBox(height: KzSpace.s14),
      KzSkeleton(
        width: KzSize.tile * 4,
        height: KzSpace.s32,
        borderRadius: KzRadii.all(KzRadii.xs),
      ),
      for (var i = 0; i < cards; i++) ...[
        const SizedBox(height: KzSpace.s16),
        KzSkeleton(
          height: KzSize.tabBar * 2,
          borderRadius: KzRadii.all(KzRadii.card),
        ),
      ],
    ],
  );
}

/// Yükleme hatası: geri + mesaj + tekrar dene.
class BookingError extends StatelessWidget {
  const BookingError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        ExploreMessage(
          title: l.loadErrorTitle,
          body: l.exploreErrorBody,
          actionLabel: l.retry,
          onAction: onRetry,
        ),
      ],
    );
  }
}

/// Rezervasyon ekranlarındaki beyaz kart: surface + line kenarlık, `card`
/// köşe, 18 iç boşluk.
class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(KzSpace.s18),
    this.title,
  });

  final Widget child;
  final EdgeInsets padding;

  /// Kartın üstündeki kalın başlık ("Seyahatin", "Fiyat ayrıntısı").
  final String? title;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.card),
        border: Border.all(color: kz.line),
      ),
      child: title == null
          ? child
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    title!,
                    style: KzText.title.copyWith(color: kz.ink),
                  ),
                ),
                const SizedBox(height: KzSpace.s14),
                child,
              ],
            ),
    );
  }
}

/// Etiket solda (ink2), değer sağda (ink, kalın) satır.
class BookingValueRow extends StatelessWidget {
  const BookingValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueWeight = KzText.bold,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight valueWeight;

  static const double _valueMaxFraction = 0.6;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final style = KzText.bodySm.copyWith(height: KzText.tightLeading);
    return MergeSemantics(
      // Değer doğal genişliğinde (en fazla %60), etiket kalan alanda; dar
      // ekranda ikisi de alt satıra kayabilir.
      child: LayoutBuilder(
        builder: (context, c) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(label, style: style.copyWith(color: kz.ink2)),
            ),
            const SizedBox(width: KzSpace.s12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: c.maxWidth * _valueMaxFraction,
              ),
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: style.copyWith(
                  color: valueColor ?? kz.ink,
                  fontWeight: valueWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 1 px ayırıcı.
class BookingDivider extends StatelessWidget {
  const BookingDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(height: KzSize.border, color: context.kz.line);
}

/// Ekran altı özet: büyük tutar + küçük not (alt bar solu).
class BookingTotalSummary extends StatelessWidget {
  const BookingTotalSummary({
    super.key,
    required this.amount,
    required this.note,
    this.semanticLabel,
    this.noteColor,
  });

  final String amount;
  final String note;
  final String? semanticLabel;
  final Color? noteColor;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            amount,
            maxLines: 1,
            style: KzText.titleLg.copyWith(color: kz.ink),
          ),
          const SizedBox(height: KzSpace.s2),
          Text(
            note,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: KzText.captionSemi.copyWith(
              color: noteColor ?? kz.ink2,
              height: KzText.tightLeading,
            ),
          ),
        ],
      ),
    );
  }
}

/// [until] anına kalan süreyi saniyede bir yeniden çizer.
class CountdownBuilder extends ConsumerStatefulWidget {
  const CountdownBuilder({
    super.key,
    required this.until,
    required this.builder,
  });

  final DateTime until;
  final Widget Function(BuildContext context, Duration left) builder;

  @override
  ConsumerState<CountdownBuilder> createState() => _CountdownBuilderState();
}

class _CountdownBuilderState extends ConsumerState<CountdownBuilder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left() <= Duration.zero) t.cancel();
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(CountdownBuilder old) {
    super.didUpdateWidget(old);
    if (old.until != widget.until) _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _left() => widget.until.difference(ref.read(clockProvider)());

  @override
  Widget build(BuildContext context) {
    final left = _left();
    return widget.builder(context, left.isNegative ? Duration.zero : left);
  }
}
