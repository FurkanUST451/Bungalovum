import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/services/connectivity.dart';
import '../core/theme/app_theme.dart';
import '../l10n/l10n.dart';
import 'router.dart';

class KozalakApp extends ConsumerStatefulWidget {
  const KozalakApp({
    super.key,
    this.initialLocation = AppRoutes.welcome,
    this.router,
  });

  /// Testlerde doğrudan bir ekrandan başlamak için.
  final String initialLocation;

  /// Testlerde tek ekranı göstermek için özel router.
  final GoRouter? router;

  /// Sistem yazı ölçeği bu aralıkta tutulur (§6.3).
  static const double minTextScale = 0.85;
  static const double maxTextScale = 1.3;

  @override
  ConsumerState<KozalakApp> createState() => _KozalakAppState();
}

class _KozalakAppState extends ConsumerState<KozalakApp> {
  late final GoRouter _router =
      widget.router ?? buildRouter(initialLocation: widget.initialLocation);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  /// Bağlantı koparsa 79 · Bağlantı Yok açılır; gelince ekran kendini kapatır.
  void _onConnectivity(AsyncValue<bool>? prev, AsyncValue<bool> next) {
    if (next.value != false || prev?.value == false) return;
    final path = _router.routerDelegate.currentConfiguration.uri.path;
    if (path != AppRoutes.offline) _router.push(AppRoutes.offline);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isOnlineProvider, _onConnectivity);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.tabExplore,
      debugShowCheckedModeBanner: false,
      theme: KzTheme.light(),
      themeMode: ThemeMode.light,
      locale: const Locale('tr', 'TR'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: KozalakApp.minTextScale,
        maxScaleFactor: KozalakApp.maxTextScale,
        // Scaffold kullanmayan ekranlar için metin varsayılanlarını sağlar;
        // şeffaf olduğu için Material görünümü (elevation/renk) sızmaz.
        child: Material(type: MaterialType.transparency, child: child),
      ),
    );
  }
}
