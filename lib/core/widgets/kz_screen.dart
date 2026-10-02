import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../icons/kz_icons.dart';
import '../responsive/adaptive_layout.dart';
import '../utils/formatters.dart';
import '../responsive/breakpoints.dart';
import '../theme/tokens.dart';
import 'kz_circle_button.dart';

/// 46'lık yuvarlak geri / kapat butonu.
class KzNavButton extends StatelessWidget {
  const KzNavButton({
    super.key,
    required this.semanticLabel,
    this.close = false,
    this.onPressed,
  });

  final String semanticLabel;

  /// true: X (modal ekranlar), false: geri oku.
  final bool close;

  /// Verilmezse yığından çıkar.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return KzCircleButton(
      icon: close ? KzIcons.x : KzIcons.back,
      diameter: KzSize.backButton,
      iconSize: KzSize.iconMd,
      shadow: KzShadows.card,
      semanticLabel: semanticLabel,
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}

/// Üst satır: solda geri/kapat, ortada başlık (isteğe bağlı), sağda aksiyon.
class KzTopBar extends StatelessWidget {
  const KzTopBar({
    super.key,
    required this.leading,
    this.title,
    this.trailing,
    this.subtleTitle = false,
  });

  final Widget leading;
  final String? title;
  final Widget? trailing;

  /// Küçük ink2 başlık (sihirbaz "Adım 3 / 10").
  final bool subtleTitle;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    // Başlık yoksa sağ öğe (ör. "Tümünü okundu say") kalan alanı kullanır;
    // dar ekranda taşmak yerine alt satıra kayar.
    if (title == null) {
      return Padding(
        padding: const EdgeInsets.only(top: KzSpace.s8, bottom: KzSpace.s6),
        child: Row(
          children: [
            leading,
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: trailing ?? const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s8, bottom: KzSpace.s6),
      child: Row(
        children: [
          leading,
          Expanded(
            child: title == null
                ? const SizedBox.shrink()
                : Semantics(
                    header: true,
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subtleTitle
                          ? KzText.label.copyWith(color: kz.ink2)
                          : KzText.titleLg.copyWith(color: kz.ink),
                    ),
                  ),
          ),
          // Başlık ortada kalsın diye sol ve sağ eşit genişlikte.
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: KzSize.backButton),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              widthFactor: 1,
              heightFactor: 1,
              child: trailing ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Büyük başlık + alt başlık bloğu (Tarih Seç, Misafirler, Ödeme...).
class KzPageTitle extends StatelessWidget {
  const KzPageTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s14, bottom: KzSpace.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: KzText.h2.copyWith(color: kz.ink)),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: KzSpace.s6),
            Text(subtitle!, style: KzText.bodySm.copyWith(color: kz.ink2)),
          ],
        ],
      ),
    );
  }
}

/// Standart ekran iskeleti: bg zemin, SafeArea, kayan içerik (form
/// genişliğiyle sınırlı), isteğe bağlı sabit alt bar.
class KzScaffold extends StatelessWidget {
  const KzScaffold({
    super.key,
    required this.children,
    this.bottomBar,
    this.header,
    this.maxWidth = KzBreakpoints.formContent,
    this.padBottom = true,
  });

  /// Kaydırılmayan üst kısım (ör. arama başlığı).
  final Widget? header;
  final List<Widget> children;
  final Widget? bottomBar;
  final double maxWidth;
  final bool padBottom;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final gutter = context.screenGutter;
    return Scaffold(
      backgroundColor: kz.bg,
      bottomNavigationBar: bottomBar,
      body: SafeArea(
        bottom: bottomBar == null,
        child: Column(
          children: [
            if (header != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: gutter),
                child: KzMaxWidth(maxWidth: maxWidth, child: header!),
              ),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  gutter,
                  0,
                  gutter,
                  padBottom ? KzSpace.s24 : 0,
                ),
                child: KzMaxWidth(
                  maxWidth: maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bölüm başlığı (17/800) — Filtreler, ilan detayı bölümleri.
class KzSectionTitle extends StatelessWidget {
  const KzSectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      header: true,
      child: Row(
        children: [
          Expanded(
            child: Text(text, style: KzText.title.copyWith(color: kz.ink)),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Grup başlığı: "SON ARAMALAR" (Türkçe büyük harf).
class KzOverline extends StatelessWidget {
  const KzOverline(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      header: true,
      child: Text(
        text.toUpperCaseTr(),
        style: KzText.overline.copyWith(
          color: kz.ink2,
          fontSize: KzText.micro.fontSize,
        ),
      ),
    );
  }
}
