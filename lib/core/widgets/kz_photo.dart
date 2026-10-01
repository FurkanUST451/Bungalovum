import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';
import 'kz_skeleton.dart';

/// Ağdan gelen ilan fotoğrafı. Yüklenirken sand tonlu shimmer, hata ya da
/// boş URL'de düz sand zemin gösterir. Decode boyutu görünür genişlik × DPR
/// ile sınırlanır (§6.4).
class KzPhoto extends StatelessWidget {
  const KzPhoto({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final fallback = ColoredBox(color: kz.sand, child: const SizedBox.expand());
    final src = url;
    if (src == null || src.isEmpty) return fallback;
    return LayoutBuilder(
      builder: (context, constraints) {
        final dpr = MediaQuery.devicePixelRatioOf(context);
        final w = constraints.maxWidth.isFinite
            ? (constraints.maxWidth * dpr).round()
            : null;
        return CachedNetworkImage(
          imageUrl: src,
          memCacheWidth: w,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          fadeInDuration: KzMotion.of(context, KzMotion.transition),
          placeholder: (_, _) => const KzSkeleton(),
          errorWidget: (_, _, _) => fallback,
        );
      },
    );
  }
}
