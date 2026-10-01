import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';

/// Konum + karşılama başlığı + bildirim butonu.
class ExploreHeader extends StatelessWidget {
  const ExploreHeader({
    super.key,
    required this.locationLabel,
    required this.hasUnreadNotifications,
    required this.onNotifications,
  });

  /// null iken (yükleniyor) iskelet gösterilir.
  final String? locationLabel;
  final bool hasUnreadNotifications;
  final VoidCallback onNotifications;

  static const double _locationSkeletonWidth = 112;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s10, bottom: KzSpace.s6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    KzIcon(
                      KzIcons.pin,
                      size: KzSize.iconXs,
                      color: kz.apricotText,
                    ),
                    const SizedBox(width: KzSpace.s6),
                    Flexible(
                      child: locationLabel == null
                          ? KzSkeleton(
                              width: _locationSkeletonWidth,
                              height: KzSize.iconXs,
                              borderRadius: KzRadii.all(KzRadii.xs),
                            )
                          : Text(
                              locationLabel!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: KzText.labelSemi.copyWith(color: kz.ink2),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: KzSpace.s4),
                Semantics(
                  header: true,
                  child: Text(
                    l.exploreGreeting,
                    style: KzText.h3.copyWith(color: kz.ink),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          KzCircleButton(
            icon: KzIcons.bell,
            iconSize: KzSize.iconMd,
            diameter: KzSize.circleMd,
            shadow: KzShadows.card,
            showBadge: hasUnreadNotifications,
            semanticLabel: hasUnreadNotifications
                ? l.exploreNotificationsUnread
                : l.exploreNotifications,
            onPressed: onNotifications,
          ),
        ],
      ),
    );
  }
}
