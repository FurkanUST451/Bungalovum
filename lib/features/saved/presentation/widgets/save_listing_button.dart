import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/login_required_sheet.dart';
import '../controllers/saved_listings_controller.dart';
import 'add_to_list_sheet.dart';

/// Görsel üstü kalp. Kaydedilince apricot dolguya geçer ve küçük bir
/// "pop" (1 → 1.2 → 1) yapar.
class SaveListingButton extends ConsumerStatefulWidget {
  const SaveListingButton({
    super.key,
    required this.listingId,
    this.background,
    this.shadow,
  });

  final String listingId;

  /// Görsel üstünde surface (varsayılan); kart içinde sand.
  final Color? background;
  final List<BoxShadow>? shadow;

  @override
  ConsumerState<SaveListingButton> createState() => _SaveListingButtonState();
}

class _SaveListingButtonState extends ConsumerState<SaveListingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: KzMotion.transition,
  );

  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: KzMotion.popScale,
      ).chain(CurveTween(curve: KzMotion.enter)),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: KzMotion.popScale,
        end: 1.0,
      ).chain(CurveTween(curve: KzMotion.exit)),
      weight: 1,
    ),
  ]).animate(_pop);

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  /// Misafir kaydetmek isterse önce Giriş Gerekli (12) açılır; giriş
  /// yaparsa kaydetme devam eder.
  Future<void> _toggle(bool saved) async {
    if (ref.read(authSessionProvider) == null) {
      final signedIn = await showLoginRequiredSheet(context);
      if (!signedIn || !mounted) return;
    }
    if (!mounted) return;
    if (saved) {
      await ref.read(wishlistsProvider.notifier).unsave(widget.listingId);
      return;
    }
    // 30 · Listeye Ekle: hangi listelere kaydedileceği seçilir.
    final added = await showAddToListSheet(context, widget.listingId);
    if (added && mounted && !MediaQuery.disableAnimationsOf(context)) {
      _pop.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final saved = ref.watch(
      savedListingIdsProvider.select((ids) => ids.contains(widget.listingId)),
    );
    return ScaleTransition(
      scale: _scale,
      child: KzCircleButton(
        icon: saved ? KzIcons.heartFilled : KzIcons.heart,
        iconColor: saved ? kz.apricot : kz.ink,
        semanticLabel: saved
            ? context.l10n.listingUnsave
            : context.l10n.listingSave,
        selected: saved,
        haptic: true,
        background: widget.background,
        shadow: widget.shadow ?? KzShadows.raised,
        onPressed: () => _toggle(saved),
      ),
    );
  }
}
