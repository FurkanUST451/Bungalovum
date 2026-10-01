import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../l10n/l10n.dart';

/// Giriş/kayıt ekranlarının ortak iskeleti: geri butonu, başlık, alt başlık,
/// kayan form. Klavye açıldığında içerik kayar; tablette form 600'e sınırlanır.
class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.gap = KzSpace.s14,
    this.showBack = true,
  });

  final String title;

  /// Düz metin ya da zengin metin (kalın e-posta/telefon içeren).
  final Widget? subtitle;
  final List<Widget> children;

  /// Form öğeleri arası boşluk.
  final double gap;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            context.screenGutter,
            KzSpace.s8,
            context.screenGutter,
            KzSpace.s32,
          ),
          child: KzMaxWidth(
            maxWidth: KzBreakpoints.formContent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showBack)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthBackButton(),
                  ),
                const SizedBox(height: KzSpace.s22),
                Semantics(
                  header: true,
                  child: Text(title, style: KzText.h1.copyWith(color: kz.ink)),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: KzSpace.s8),
                  subtitle!,
                ],
                const SizedBox(height: KzSpace.s18),
                for (final (i, child) in children.indexed) ...[
                  if (i > 0) SizedBox(height: gap),
                  child,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 46'lık geri butonu. Yığın boşsa Hoş Geldin'e döner.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KzCircleButton(
      icon: KzIcons.back,
      diameter: KzSize.backButton,
      iconSize: KzSize.iconMd,
      shadow: KzShadows.card,
      semanticLabel: context.l10n.back,
      onPressed: () =>
          context.canPop() ? context.pop() : context.go(AppRoutes.welcome),
    );
  }
}

/// Alt başlık metni (14/500 ink2).
class AuthBody extends StatelessWidget {
  const AuthBody(this.text, {super.key, this.bold, this.center = false});

  /// [text] içinde kalın gösterilecek kısım (ör. maskeli telefon).
  final String text;
  final String? bold;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final style = KzText.bodySm.copyWith(
      color: kz.ink2,
      height: KzText.body.height,
    );
    final b = bold;
    final align = center ? TextAlign.center : TextAlign.start;
    if (b == null || !text.contains(b)) {
      return Text(text, style: style, textAlign: align);
    }
    final i = text.indexOf(b);
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: text.substring(0, i)),
          TextSpan(
            text: b,
            style: TextStyle(fontWeight: KzText.extraBold, color: kz.ink),
          ),
          TextSpan(text: text.substring(i + b.length)),
        ],
      ),
      textAlign: align,
    );
  }
}
