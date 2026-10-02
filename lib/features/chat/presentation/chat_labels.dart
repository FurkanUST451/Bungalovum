import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/icons/kz_icons.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/kz_icon.dart';
import '../../../l10n/l10n.dart';
import '../../listing/presentation/listing_detail_labels.dart';
import '../domain/chat_models.dart';

final _hm = DateFormat('HH:mm', kzLocale);
final _weekdayShort = DateFormat('EEE', kzLocale);

/// Sohbet listesi zamanı: "09:41", "Dün", "Pzt", "12 Eyl".
String chatListTime(AppLocalizations l, DateTime at, DateTime now) {
  final days = DateUtils.dateOnly(
    now,
  ).difference(DateUtils.dateOnly(at)).inDays;
  if (days <= 0) return _hm.format(at);
  if (days == 1) return l.yesterday;
  if (days < DateTime.daysPerWeek) return _weekdayShort.format(at);
  return KzFormat.dayMonth(at);
}

/// Mesaj balonu saati: "18:02".
String messageTime(DateTime at) => _hm.format(at);

/// Gün ayracı: "Bugün", "Dün", "6 Kasım Cuma".
String chatDayLabel(AppLocalizations l, DateTime day, DateTime now) {
  final days = DateUtils.dateOnly(
    now,
  ).difference(DateUtils.dateOnly(day)).inDays;
  if (days <= 0) return l.today;
  if (days == 1) return l.yesterday;
  return KzFormat.dayLong(day);
}

/// Bildirim zamanı: "Az önce", "12 dakika önce", "2 saat önce", "4 gün önce".
String notificationAgo(AppLocalizations l, DateTime at, DateTime now) {
  final d = now.difference(at);
  if (d.inMinutes < 1) return l.justNow;
  if (d.inHours < 1) return l.minutesAgo(d.inMinutes);
  if (d.inDays < 1) return l.hoursAgo(d.inHours);
  return relativeDate(l, at, now);
}

/// Sohbet avatarı: destekte forest + yardım ikonu, kişilerde baş harf.
class ChatAvatar extends StatelessWidget {
  const ChatAvatar({super.key, required this.conversation, this.size = 52});

  final Conversation conversation;
  final double size;

  static const double _initialRatio = 0.38;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final c = conversation;
    final palette = [
      (kz.apricot, kz.ink),
      (kz.poolSoft, kz.poolText),
      (kz.sand, kz.ink),
      (kz.forestSoft, kz.forest),
    ];
    final (bg, fg) = c.isSupport
        ? (kz.forest, kz.onForest)
        : palette[c.title.codeUnitAt(0) % palette.length];
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: c.isSupport
            ? KzIcon(KzIcons.help, size: KzSize.iconLg, color: fg)
            : Text(
                c.title.characters.first.toUpperCaseTr(),
                style: KzText.h4.copyWith(
                  color: fg,
                  fontSize: size * _initialRatio,
                ),
              ),
      ),
    );
  }
}
