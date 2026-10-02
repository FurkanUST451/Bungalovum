import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/services/connectivity.dart';
import '../../../../core/services/permissions.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';

/// Durum ekranlarının ortak iskeleti: görsel + başlık + metin, aksiyonlar
/// [centered] ise metnin altında, değilse ekranın altında.
class _StatusLayout extends StatelessWidget {
  const _StatusLayout({
    required this.art,
    required this.title,
    required this.body,
    required this.actions,
    this.centered = false,
  });

  final Widget art;
  final String title;
  final String body;
  final List<Widget> actions;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final gutter = context.screenGutter;
    final text = [
      Semantics(
        header: true,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: KzText.h4.copyWith(color: kz.ink),
        ),
      ),
      const SizedBox(height: KzSpace.s12),
      Text(
        body,
        textAlign: TextAlign.center,
        style: KzText.bodySm.copyWith(
          color: kz.ink2,
          height: KzText.body.height,
        ),
      ),
    ];
    List<Widget> spaced(List<Widget> items) => [
      for (final (i, a) in items.indexed) ...[
        if (i > 0) const SizedBox(height: KzSpace.s10),
        a,
      ],
    ];

    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: KzBreakpoints.formContent,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(gutter, 0, gutter, KzSpace.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) => SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: c.maxHeight),
                          child: Column(
                            mainAxisAlignment: centered
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: KzSpace.s24),
                              Center(child: art),
                              const SizedBox(height: KzSpace.s32),
                              ...text,
                              if (centered) ...[
                                const SizedBox(height: KzSpace.s32),
                                ...spaced(actions),
                              ],
                              const SizedBox(height: KzSpace.s24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!centered) ...spaced(actions),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 79 · Bağlantı Yok. Bağlantı gelince kendiliğinden kapanır.
class OfflineScreen extends ConsumerStatefulWidget {
  const OfflineScreen({super.key});

  @override
  ConsumerState<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends ConsumerState<OfflineScreen> {
  bool _checking = false;

  void _leave() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.explore);
    }
  }

  Future<void> _retry() async {
    if (_checking) return;
    setState(() => _checking = true);
    final online = await ref.read(connectivityServiceProvider).isOnline();
    if (!mounted) return;
    setState(() => _checking = false);
    if (online) {
      _leave();
    } else {
      showKzToast(context, context.l10n.stillOffline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    ref.listen(isOnlineProvider, (prev, next) {
      if (prev?.value == false && next.value == true) _leave();
    });
    return _StatusLayout(
      centered: true,
      art: const KzSpotIllustration(
        icon: KzIcons.wifioff,
        tone: KzSpotTone.apricot,
        badgeIcon: KzIcons.trees,
        badge: KzSpotBadge.forestSoft,
        dot: KzSpotDot.pool,
        large: true,
      ),
      title: l.offlineTitle,
      body: l.offlineBody,
      actions: [
        KzButton(label: l.retry, loading: _checking, onPressed: _retry),
        Center(
          child: KzLink(
            label: l.offlineSavedLink,
            onPressed: () => context.go(AppRoutes.saved),
          ),
        ),
      ],
    );
  }
}

/// İzin ekranlarının ortak davranışı: sistem iznini ister; kalıcı
/// reddedildiyse ayarlara yönlendirir. Sonucu `pop(bool)` ile döner.
mixin _PermissionFlow<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AppPermission get permission;

  bool busy = false;

  Future<void> allow() async {
    if (busy) return;
    final service = ref.read(permissionServiceProvider);
    setState(() => busy = true);
    try {
      final current = await service.status(permission);
      final result = current == AppPermissionStatus.blocked
          ? (await service.openSettings(), current).$2
          : await service.request(permission);
      ref.invalidate(permissionStatusProvider(permission));
      if (!mounted) return;
      if (result == AppPermissionStatus.granted) {
        context.pop(true);
      } else if (result == AppPermissionStatus.blocked) {
        showKzToast(context, context.l10n.permissionBlockedHint);
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  void later() => context.pop(false);
}

/// 80 · Konum İzni.
class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen>
    with _PermissionFlow {
  @override
  AppPermission get permission => AppPermission.location;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return _StatusLayout(
      art: const _MapArt(),
      title: l.locationPermissionTitle,
      body: l.locationPermissionBody,
      actions: [
        KzButton(label: l.allowLocation, loading: busy, onPressed: allow),
        KzButton(
          label: l.notNow,
          variant: KzButtonVariant.outline,
          onPressed: later,
        ),
      ],
    );
  }
}

/// 81 · Bildirim İzni.
class NotificationPermissionScreen extends ConsumerStatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  ConsumerState<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends ConsumerState<NotificationPermissionScreen>
    with _PermissionFlow {
  @override
  AppPermission get permission => AppPermission.notifications;

  @override
  void initState() {
    super.initState();
    // Aynı oturumda bir kez sorarız.
    Future.microtask(
      () => ref.read(notificationPromptShownProvider.notifier).markShown(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return _StatusLayout(
      art: const _NotificationArt(),
      title: l.notificationPermissionTitle,
      body: l.notificationPermissionBody,
      actions: [
        KzButton(label: l.enableNotifications, loading: busy, onPressed: allow),
        KzButton(
          label: l.maybeLater,
          variant: KzButtonVariant.outline,
          onPressed: later,
        ),
      ],
    );
  }
}

/// Bildirim ön-iznini (81) uygun anda bir kez gösterir: izin henüz
/// verilmemiş, kalıcı reddedilmemiş ve bu oturumda sorulmamışsa.
Future<void> maybeAskNotificationPermission(
  BuildContext context,
  WidgetRef ref,
) async {
  if (ref.read(notificationPromptShownProvider)) return;
  final status = await ref
      .read(permissionServiceProvider)
      .status(AppPermission.notifications);
  if (status != AppPermissionStatus.askable || !context.mounted) return;
  ref.read(notificationPromptShownProvider.notifier).markShown();
  await context.push<bool>(AppRoutes.notificationPermission);
}

/// Başarı ekranlarında (38, 41) bildirim ön-iznini bir kez tetikler.
class NotificationPromptTrigger extends ConsumerStatefulWidget {
  const NotificationPromptTrigger({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<NotificationPromptTrigger> createState() =>
      _NotificationPromptTriggerState();
}

class _NotificationPromptTriggerState
    extends ConsumerState<NotificationPromptTrigger> {
  /// Kullanıcı başarı mesajını gördükten sonra sorulur.
  static const _delay = Duration(milliseconds: 1200);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_delay, () {
      if (mounted) maybeAskNotificationPermission(context, ref);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Konum iznine ihtiyaç duyan aksiyonlar için: izin yoksa 80'i açar.
/// İzin verildiyse true döner.
Future<bool> ensureLocationPermission(
  BuildContext context,
  WidgetRef ref,
) async {
  final status = await ref
      .read(permissionServiceProvider)
      .status(AppPermission.location);
  if (status == AppPermissionStatus.granted) return true;
  if (!context.mounted) return false;
  return await context.push<bool>(AppRoutes.locationPermission) ?? false;
}

/// 80 · Kodla çizilmiş harita: göl, tepeler, konum halkası ve fiyat pinleri.
class _MapArt extends StatelessWidget {
  const _MapArt();

  static const double _aspect = 350 / 300;
  static const double _ring = 150;
  static const double _ringInner = 70;
  static const double _pin = 52;

  /// Pin konumları (genişlik/yükseklik oranı) ve örnek gecelik fiyatlar.
  static const _pins = [
    (Alignment(0.6, -0.53), 6850),
    (Alignment(-0.65, 0.43), 5400),
    (Alignment(0.55, 0.63), 4900),
  ];

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return ExcludeSemantics(
      child: AspectRatio(
        aspectRatio: _aspect,
        child: ClipRRect(
          borderRadius: KzRadii.all(KzRadii.hero),
          child: ColoredBox(
            color: kz.forestSoft,
            child: Stack(
              children: [
                // Göl
                Align(
                  alignment: const Alignment(-0.6, -1.4),
                  child: FractionallySizedBox(
                    widthFactor: 0.75,
                    heightFactor: 0.6,
                    child: ClipOval(child: ColoredBox(color: kz.poolSoft)),
                  ),
                ),
                // Tepeler: arkadaki açık, öndeki koyu.
                for (final (align, width, height, alpha) in const [
                  (Alignment(1.2, 1.5), 1.1, 0.7, KzOpacity.tint),
                  (Alignment(-0.9, 2.1), 1.5, 0.75, KzOpacity.wash),
                ])
                  Align(
                    alignment: align,
                    child: FractionallySizedBox(
                      widthFactor: width,
                      heightFactor: height,
                      child: ClipOval(
                        child: ColoredBox(
                          color: kz.forest.withValues(alpha: alpha),
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Container(
                    width: _ring,
                    height: _ring,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kz.forest.withValues(alpha: KzOpacity.tint),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: _ringInner,
                      height: _ringInner,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kz.forest.withValues(alpha: KzOpacity.tint),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: _pin,
                        height: _pin,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kz.forest,
                          boxShadow: KzShadows.strong,
                        ),
                        child: Center(
                          child: KzIcon(
                            KzIcons.nav,
                            size: KzSize.iconMd,
                            color: kz.onForest,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (final (align, price) in _pins)
                  Align(
                    alignment: align,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KzSpace.s12,
                        vertical: KzSpace.s6,
                      ),
                      decoration: BoxDecoration(
                        color: kz.surface,
                        borderRadius: KzRadii.all(KzRadii.pill),
                        boxShadow: KzShadows.card,
                      ),
                      child: Text(
                        KzFormat.currency(price),
                        style: KzText.micro.copyWith(
                          color: kz.ink,
                          fontWeight: KzText.extraBold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 81 · Örnek bildirim kartları yığını.
class _NotificationArt extends StatelessWidget {
  const _NotificationArt();

  static const double _box = 36;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final items = [
      (
        KzIcons.check,
        kz.forest,
        l.sampleNotifApprovedTitle,
        l.sampleNotifApprovedBody,
      ),
      (
        KzIcons.heart,
        kz.apricot,
        l.sampleNotifPriceTitle,
        l.sampleNotifPriceBody,
      ),
      (
        KzIcons.chat,
        kz.pool,
        l.sampleNotifMessageTitle,
        l.sampleNotifMessageBody,
      ),
    ];
    return ExcludeSemantics(
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: kz.forestSoft,
          borderRadius: KzRadii.all(KzRadii.hero),
        ),
        child: Column(
          children: [
            for (final (i, (icon, color, title, body)) in items.indexed) ...[
              if (i > 0) const SizedBox(height: KzSpace.s10),
              Container(
                padding: const EdgeInsets.all(KzSpace.s12),
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(KzRadii.tile),
                  boxShadow: KzShadows.soft,
                ),
                child: Row(
                  children: [
                    Container(
                      width: _box,
                      height: _box,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: KzRadii.all(KzRadii.sm),
                      ),
                      child: Center(
                        child: KzIcon(
                          icon,
                          size: KzSize.iconSm,
                          color: kz.onForest,
                        ),
                      ),
                    ),
                    const SizedBox(width: KzSpace.s10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.label.copyWith(color: kz.ink),
                          ),
                          const SizedBox(height: KzSpace.s2),
                          Text(
                            body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.micro.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
