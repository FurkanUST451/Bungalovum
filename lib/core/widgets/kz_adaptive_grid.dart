import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Telefonda tek kolon liste, tablette 2–3 kolon. Satır yüksekliği içerikten
/// gelir (sabit yükseklik yok); bu yüzden SliverGrid yerine satır satır
/// kurulur.
class KzAdaptiveSliverGrid<T> extends StatelessWidget {
  const KzAdaptiveSliverGrid({
    super.key,
    required this.items,
    required this.columns,
    required this.inset,
    required this.itemBuilder,
    this.rowGap = KzSpace.s26,
    this.columnGap = KzSpace.s16,
  });

  final List<T> items;
  final int columns;
  final double inset;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final double rowGap;
  final double columnGap;

  @override
  Widget build(BuildContext context) {
    final rows = (items.length / columns).ceil();
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: inset),
      sliver: SliverList.separated(
        itemCount: rows,
        separatorBuilder: (_, _) => SizedBox(height: rowGap),
        itemBuilder: (context, row) {
          final start = row * columns;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) SizedBox(width: columnGap),
                Expanded(
                  child: start + c < items.length
                      ? itemBuilder(context, items[start + c])
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
