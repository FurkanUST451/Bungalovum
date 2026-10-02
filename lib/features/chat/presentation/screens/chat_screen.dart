import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../../saved/presentation/controllers/saved_listings_controller.dart';
import '../../domain/chat_models.dart';
import '../chat_labels.dart';
import '../controllers/chat_controllers.dart';

/// 63 · Sohbet.
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation = ref
        .watch(conversationsProvider)
        .value
        ?.where((c) => c.id == conversationId)
        .firstOrNull;
    if (conversation == null) {
      final all = ref.watch(conversationsProvider);
      // Yüklendi ama sohbet yok (silinmiş / geçersiz bağlantı) ya da hata.
      return all.hasError || all.hasValue
          ? BookingError(onRetry: () => ref.invalidate(conversationsProvider))
          : const BookingLoading(cards: 2);
    }
    return _Chat(conversation: conversation);
  }
}

class _Chat extends ConsumerStatefulWidget {
  const _Chat({required this.conversation});

  final Conversation conversation;

  @override
  ConsumerState<_Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<_Chat> {
  final _text = TextEditingController();

  static const double _maxBubbleFraction = 0.75;
  static const Size _photo = Size(200, 140);

  String get _id => widget.conversation.id;

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send([String? quick]) async {
    final text = (quick ?? _text.text).trim();
    if (text.isEmpty) return;
    HapticFeedback.lightImpact();
    if (quick == null) _text.clear();
    await ref.read(chatThreadProvider(_id).notifier).send(text: text);
  }

  Future<void> _attach() async {
    final f = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: KzPhotoPicker.maxDimension,
      maxHeight: KzPhotoPicker.maxDimension,
      imageQuality: KzPhotoPicker.quality,
    );
    if (f == null) return;
    await ref.read(chatThreadProvider(_id).notifier).send(photoPath: f.path);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final c = widget.conversation;
    final thread = ref.watch(chatThreadProvider(_id));
    final now = ref.watch(clockProvider)();
    final booking = c.bookingId == null
        ? null
        : ref.watch(bookingProvider(c.bookingId!)).value;
    final phone = c.bookingId == null
        ? null
        : ref.watch(tripAccessProvider(c.bookingId!)).value?.hostPhone;
    final host = c.listingId == null
        ? null
        : ref.watch(listingDetailProvider(c.listingId!)).value?.host;
    final messages = thread.value ?? const <ChatMessage>[];
    final replies = messages.isNotEmpty && !messages.last.fromMe
        ? ref.watch(quickRepliesProvider(_id)).value ?? const <String>[]
        : const <String>[];
    final maxBubble = math.min(
      MediaQuery.sizeOf(context).width * _maxBubbleFraction,
      KzBreakpoints.mediumContent * _maxBubbleFraction,
    );

    // Ters liste: en yeni en altta; gün ayraçları araya girer.
    final items = <Widget>[];
    DateTime? lastDay;
    for (final m in messages) {
      final day = DateUtils.dateOnly(m.sentAt);
      if (day != lastDay) {
        items.add(_DayChip(label: chatDayLabel(l, day, now)));
        lastDay = day;
      }
      items.add(
        _Bubble(
          message: m,
          maxWidth: maxBubble,
          photoSize: _photo,
          onRetry: () => ref.read(chatThreadProvider(_id).notifier).retry(m),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.screenGutter,
                KzSpace.s8,
                context.screenGutter,
                KzSpace.s12,
              ),
              child: Row(
                children: [
                  KzNavButton(semanticLabel: l.back),
                  const SizedBox(width: KzSpace.s12),
                  ChatAvatar(conversation: c, size: KzSize.backButton),
                  const SizedBox(width: KzSpace.s12),
                  Expanded(
                    child: MergeSemantics(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              c.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: KzText.bodyStrong.copyWith(
                                color: kz.ink,
                                fontWeight: KzText.extraBold,
                                height: KzText.tightLeading,
                              ),
                            ),
                          ),
                          const SizedBox(height: KzSpace.s2),
                          Row(
                            children: [
                              if (c.online) ...[
                                Container(
                                  width: KzSpace.s8,
                                  height: KzSpace.s8,
                                  decoration: BoxDecoration(
                                    color: kz.forest,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: KzSpace.s6),
                              ],
                              Flexible(
                                child: Text(
                                  c.online
                                      ? l.online
                                      : host == null
                                      ? ''
                                      : l.respondsWithin(
                                          host.responseTimeLabel(l),
                                        ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: KzText.captionSemi.copyWith(
                                    color: kz.ink2,
                                    height: KzText.tightLeading,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (phone != null)
                    KzCircleButton(
                      icon: KzIcons.phone,
                      diameter: KzSize.minTouch,
                      iconSize: KzSize.iconSm,
                      background: kz.sand,
                      semanticLabel: l.callHost,
                      onPressed: () async {
                        if (!await ExternalLinks.call(phone) &&
                            context.mounted) {
                          showKzToast(context, l.cannotOpenLink);
                        }
                      },
                    ),
                ],
              ),
            ),
            if (booking != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.screenGutter,
                  0,
                  context.screenGutter,
                  KzSpace.s8,
                ),
                child: _BookingStrip(booking: booking),
              ),
            Expanded(
              child: switch (thread) {
                AsyncData() => ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.screenGutter,
                    vertical: KzSpace.s8,
                  ),
                  children: [
                    if (replies.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: KzSpace.s6),
                        child: Wrap(
                          spacing: KzSpace.s8,
                          runSpacing: KzSpace.s8,
                          children: [
                            for (final r in replies)
                              KzChip(
                                label: r,
                                variant: KzChipVariant.outline,
                                onPressed: () => _send(r),
                              ),
                          ],
                        ),
                      ),
                    ...items.reversed,
                    Padding(
                      padding: const EdgeInsets.only(bottom: KzSpace.s8),
                      child: KzTip(
                        icon: KzIcons.shield,
                        message: messages.isEmpty && host != null
                            ? '${l.chatStartHint(host.responseTimeLabel(l))} '
                                  '${l.chatSafetyNote}'
                            : l.chatSafetyNote,
                      ),
                    ),
                  ],
                ),
                AsyncError() => Center(
                  child: Text(
                    l.loadErrorTitle,
                    style: KzText.bodySm.copyWith(color: kz.ink2),
                  ),
                ),
                _ => Padding(
                  padding: EdgeInsets.all(context.screenGutter),
                  child: Column(
                    children: [
                      for (var i = 0; i < 3; i++) ...[
                        Align(
                          alignment: i.isOdd
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: KzSkeleton(
                            width: KzSize.tile * 4,
                            height: KzSize.tile,
                            borderRadius: KzRadii.all(KzRadii.field),
                          ),
                        ),
                        const SizedBox(height: KzSpace.s10),
                      ],
                    ],
                  ),
                ),
              },
            ),
            _Composer(controller: _text, onSend: _send, onAttach: _attach),
          ],
        ),
      ),
    );
  }
}

/// Rezervasyon şeridi: fotoğraf + tarih/misafir + durum/kod + "Detay".
class _BookingStrip extends ConsumerWidget {
  const _BookingStrip({required this.booking});

  final Booking booking;

  static const double _thumb = 48;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final listing = ref.watch(listingSummaryProvider(b.listingId)).value;
    final status = switch (b.status) {
      BookingStatus.confirmed => l.statusConfirmed,
      BookingStatus.pending => l.statusPending,
      BookingStatus.completed => l.tabPast,
      BookingStatus.declined => l.statusDeclined,
      BookingStatus.cancelled => l.statusCancelled,
    };
    final route = b.status == BookingStatus.pending
        ? AppRoutes.requestSent(b.id)
        : AppRoutes.trip(b.id);
    return Container(
      padding: const EdgeInsets.all(KzSpace.s10),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.field),
        border: Border.all(color: kz.line),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: KzRadii.all(KzRadii.sm),
            child: SizedBox.square(
              dimension: _thumb,
              child: KzPhoto(url: listing?.photoUrls.firstOrNull),
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          Expanded(
            child: MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.dotJoin2(
                      KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
                      l.listingGuests(b.guests.total),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.label.copyWith(
                      color: kz.ink,
                      fontWeight: KzText.extraBold,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(
                    l.dotJoin2(status, b.code),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.captionSemi.copyWith(color: kz.forest),
                  ),
                ],
              ),
            ),
          ),
          KzChip(
            label: l.details,
            variant: KzChipVariant.soft,
            size: KzChipSize.small,
            onPressed: () => context.push(route),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: KzSpace.s8),
    child: Center(
      child: KzChip(
        label: label,
        variant: KzChipVariant.soft,
        size: KzChipSize.mini,
        labelColor: context.kz.ink2,
      ),
    ),
  );
}

/// Mesaj balonu: karşı taraf beyaz + kenarlık (sol alt köşe sivri), ben
/// forest (sağ alt köşe sivri).
class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.maxWidth,
    required this.photoSize,
    required this.onRetry,
  });

  final ChatMessage message;
  final double maxWidth;
  final Size photoSize;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final m = message;
    final me = m.fromMe;
    const big = Radius.circular(KzRadii.field);
    const tail = Radius.circular(KzSpace.s6);
    final radius = BorderRadius.only(
      topLeft: big,
      topRight: big,
      bottomLeft: me ? big : tail,
      bottomRight: me ? tail : big,
    );
    final metaColor = me ? kz.forestSoft : kz.ink2;
    final failed = m.status == MessageStatus.failed;
    final statusLabel = switch (m.status) {
      MessageStatus.sending => l.messageSending,
      MessageStatus.sent => l.messageSent,
      MessageStatus.read => l.messageRead,
      MessageStatus.failed => l.messageFailed,
    };

    final Widget content;
    if (m.photoUrl != null) {
      final url = m.photoUrl!;
      content = ClipRRect(
        borderRadius: radius,
        child: SizedBox.fromSize(
          size: photoSize,
          child: url.isNotEmpty && !url.contains('://')
              ? Image.file(
                  File(url),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => ColoredBox(color: kz.sand),
                )
              : KzPhoto(url: url.isEmpty ? null : url),
        ),
      );
    } else {
      content = Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(
          horizontal: KzSpace.s16,
          vertical: KzSpace.s12,
        ),
        decoration: BoxDecoration(
          color: me ? kz.forest : kz.surface,
          borderRadius: radius,
          border: me ? null : Border.all(color: kz.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              m.text ?? '',
              style: KzText.bodySm.copyWith(color: me ? kz.onForest : kz.ink),
            ),
            const SizedBox(height: KzSpace.s4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messageTime(m.sentAt),
                  style: KzText.nano.copyWith(color: metaColor),
                ),
                if (me) ...[
                  const SizedBox(width: KzSpace.s4),
                  KzIcon(
                    switch (m.status) {
                      MessageStatus.sending => KzIcons.clock,
                      MessageStatus.failed => KzIcons.alert,
                      _ => KzIcons.check,
                    },
                    size: KzSpace.s12,
                    color: failed ? kz.apricot : metaColor,
                  ),
                ],
              ],
            ),
          ],
        ),
      );
    }

    return Semantics(
      label: me ? statusLabel : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KzSpace.s3),
        child: Column(
          crossAxisAlignment: me
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            content,
            if (failed)
              KzPressable(
                onPressed: onRetry,
                semanticLabel: l.messageFailed,
                child: Padding(
                  padding: const EdgeInsets.only(top: KzSpace.s4),
                  child: Text(
                    l.messageFailed,
                    style: KzText.captionBold.copyWith(color: kz.apricotText),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Alt yazma alanı: fotoğraf ekle + metin + gönder. Klavyeyle yukarı çıkar.
class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.onSend,
    required this.onAttach,
  });

  final TextEditingController controller;
  final Future<void> Function([String?]) onSend;
  final VoidCallback onAttach;

  static const double _field = 48;
  static const int _maxLines = 4;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom > 0;
    final canSend = controller.text.trim().isNotEmpty;
    return Container(
      padding: EdgeInsets.fromLTRB(
        KzSpace.s16,
        KzSpace.s12,
        KzSpace.s16,
        keyboard
            ? KzSpace.s12
            : math.max(KzSpace.s30, media.padding.bottom + KzSpace.s12),
      ),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.top(KzRadii.lg),
        boxShadow: KzShadows.bottomBar,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          KzCircleButton(
            icon: KzIcons.plus,
            diameter: KzSize.minTouch,
            iconSize: KzSize.iconSm,
            background: kz.sand,
            semanticLabel: l.attachPhoto,
            onPressed: onAttach,
          ),
          const SizedBox(width: KzSpace.s10),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: _field),
              padding: const EdgeInsets.symmetric(
                horizontal: KzSpace.s16,
                vertical: KzSpace.s12,
              ),
              decoration: BoxDecoration(
                color: kz.bg,
                borderRadius: KzRadii.all(KzRadii.pill),
                border: Border.all(color: kz.line),
              ),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: _maxLines,
                maxLength: ChatPolicy.maxLength,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                cursorColor: kz.forest,
                style: KzText.bodySm.copyWith(color: kz.ink),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  counterText: '',
                  hintText: l.typeMessage,
                  hintStyle: KzText.bodySm.copyWith(color: kz.placeholder),
                ),
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s10),
          KzCircleButton(
            icon: KzIcons.send,
            diameter: _field,
            iconSize: KzSize.iconSm,
            background: kz.forest,
            iconColor: kz.onForest,
            shadow: canSend ? KzShadows.card : null,
            semanticLabel: l.sendMessageAction,
            onPressed: canSend ? onSend : null,
          ),
        ],
      ),
    );
  }
}
