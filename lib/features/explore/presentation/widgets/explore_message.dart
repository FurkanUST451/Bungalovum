import 'package:flutter/widgets.dart';

import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';

/// Boş ve hata durumları için ortalanmış başlık + açıklama (+ aksiyon).
class ExploreMessage extends StatelessWidget {
  const ExploreMessage({
    super.key,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s32),
      child: Column(
        children: [
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: KzText.title.copyWith(color: kz.ink),
            ),
          ),
          const SizedBox(height: KzSpace.s8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(color: kz.ink2),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: KzSpace.s20),
            KzButton(
              label: actionLabel!,
              onPressed: onAction,
              variant: KzButtonVariant.secondary,
              expand: false,
            ),
          ],
        ],
      ),
    );
  }
}
