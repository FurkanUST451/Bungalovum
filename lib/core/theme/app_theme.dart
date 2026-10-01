import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tokens.dart';

/// Material varsayılanlarını (mor, elevation, ripple) tamamen token'larla
/// ezen tema. Uygulama yalnızca açık temada çalışır.
abstract final class KzTheme {
  static ThemeData light() {
    const c = KzColors.light;
    final scheme = ColorScheme.light(
      primary: c.forest,
      onPrimary: c.onForest,
      primaryContainer: c.forestSoft,
      onPrimaryContainer: c.forest,
      secondary: c.apricot,
      onSecondary: c.ink,
      secondaryContainer: c.apricotSoft,
      onSecondaryContainer: c.apricotText,
      tertiary: c.pool,
      tertiaryContainer: c.poolSoft,
      onTertiaryContainer: c.poolText,
      error: c.apricotText,
      onError: c.onForest,
      surface: c.surface,
      onSurface: c.ink,
      onSurfaceVariant: c.ink2,
      surfaceContainerHighest: c.sand,
      outline: c.line,
      outlineVariant: c.line,
      shadow: c.ink,
      scrim: c.scrim,
      surfaceTint: Colors.transparent,
    );

    final base = TextStyle(fontFamily: KzText.family, color: c.ink);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      fontFamily: KzText.family,
      extensions: const [c],
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme: TextTheme(
        displayLarge: KzText.display.merge(base),
        headlineLarge: KzText.h1.merge(base),
        headlineMedium: KzText.h2.merge(base),
        headlineSmall: KzText.h3.merge(base),
        titleLarge: KzText.h4.merge(base),
        titleMedium: KzText.title.merge(base),
        titleSmall: KzText.titleSm.merge(base),
        bodyLarge: KzText.body.merge(base),
        bodyMedium: KzText.bodySm.merge(base),
        bodySmall: KzText.caption.merge(base).copyWith(color: c.ink2),
        labelLarge: KzText.label.merge(base),
        labelMedium: KzText.captionBold.merge(base),
        labelSmall: KzText.micro.merge(base),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.forest,
        selectionColor: c.forestSoft,
        selectionHandleColor: c.forest,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      cupertinoOverrideTheme: CupertinoThemeData(primaryColor: c.forest),
    );
  }
}
