/// Figma `Kozalak / Ölçü` boşlukları: `xs 4 · sm 8 · md 16 · lg 24 · xl 32`
/// ve ekranlarda sık kullanılan ara aralıklar.
abstract final class KzSpace {
  static const double s2 = 2;
  static const double s3 = 3;
  static const double s4 = 4;
  static const double s5 = 5;
  static const double s6 = 6;
  static const double s7 = 7;
  static const double s8 = 8;
  static const double s9 = 9;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s13 = 13;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s32 = 32;
  static const double s34 = 34;
  static const double s36 = 36;
  static const double s40 = 40;

  static const double xs = s4;
  static const double sm = s8;
  static const double md = s16;
  static const double lg = s24;
  static const double xl = s32;

  /// Telefon ekran yatay kenar boşluğu.
  static const double screen = s20;

  /// ≤ 360 dp cihazlarda ekran kenar boşluğu.
  static const double screenNarrow = s16;
}

/// Sabit ölçülü bileşen boyutları (ikon, avatar, buton, bar).
abstract final class KzSize {
  // İkon
  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 20;
  static const double iconLg = 22;
  static const double iconXl = 24;
  static const double iconHero = 30;

  // Dokunma ve buton
  static const double minTouch = 44;
  static const double circleSm = 40;
  static const double circleMd = 48;
  static const double circleLg = 64;
  static const double tile = 60;
  static const double button = 58;
  static const double input = 66;

  // Tab bar
  static const double tabBar = 72;
  static const double tabItem = 50;
  static const double tabItemNarrow = 46;
  static const double navRail = 96;

  // Bildirim noktası
  static const double badgeDot = 10;
  static const double badgeStroke = 2;
  static const double countBadge = 20;

  // Avatar
  static const double avatarSm = 42;
  static const double avatar = 56;
  static const double avatarLg = 96;

  // Sayfa göstergesi
  static const double dot = 6;
  static const double dotActive = 16;

  // Form
  static const double backButton = 46;
  static const double socialButton = 56;
  static const double segment = 42;
  static const double checkbox = 22;
  static const double checkboxLg = 24;
  static const double otpCellWidth = 50;
  static const double otpCellHeight = 62;
  static const double otpCaretHeight = 26;
  static const double caretWidth = 2;
  static const double strengthBar = 6;
  static const double grabberWidth = 44;
  static const double grabberHeight = 5;

  /// Kenarlık kalınlıkları (Figma INSIDE hizalı).
  static const double border = 1;
  static const double borderFocus = 2;
  static const double borderCheckbox = 1.5;
}
