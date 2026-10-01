import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('tr')];

  /// No description provided for @tabExplore.
  ///
  /// In tr, this message translates to:
  /// **'Keşfet'**
  String get tabExplore;

  /// No description provided for @tabSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı'**
  String get tabSaved;

  /// No description provided for @tabTrips.
  ///
  /// In tr, this message translates to:
  /// **'Seyahatler'**
  String get tabTrips;

  /// No description provided for @tabChats.
  ///
  /// In tr, this message translates to:
  /// **'Sohbetler'**
  String get tabChats;

  /// No description provided for @tabAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabım'**
  String get tabAccount;

  /// No description provided for @retry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get retry;

  /// No description provided for @seeAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü gör'**
  String get seeAll;

  /// No description provided for @exploreGreeting.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta sonu\nnereye kaçıyoruz?'**
  String get exploreGreeting;

  /// No description provided for @exploreNotifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get exploreNotifications;

  /// No description provided for @exploreNotificationsUnread.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler, okunmamış bildirim var'**
  String get exploreNotificationsUnread;

  /// No description provided for @exploreSearchTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nereye gidiyorsun?'**
  String get exploreSearchTitle;

  /// No description provided for @exploreSearchSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Tarih seç · Misafir ekle'**
  String get exploreSearchSubtitle;

  /// No description provided for @exploreFilters.
  ///
  /// In tr, this message translates to:
  /// **'Filtreler'**
  String get exploreFilters;

  /// No description provided for @categoryAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get categoryAll;

  /// No description provided for @categoryPool.
  ///
  /// In tr, this message translates to:
  /// **'Havuzlu'**
  String get categoryPool;

  /// No description provided for @categoryLakeView.
  ///
  /// In tr, this message translates to:
  /// **'Göl manzaralı'**
  String get categoryLakeView;

  /// No description provided for @categoryForest.
  ///
  /// In tr, this message translates to:
  /// **'Orman içi'**
  String get categoryForest;

  /// No description provided for @categoryJacuzzi.
  ///
  /// In tr, this message translates to:
  /// **'Jakuzili'**
  String get categoryJacuzzi;

  /// No description provided for @categoryFireplace.
  ///
  /// In tr, this message translates to:
  /// **'Şömineli'**
  String get categoryFireplace;

  /// No description provided for @categoryAFrame.
  ///
  /// In tr, this message translates to:
  /// **'A-frame'**
  String get categoryAFrame;

  /// region, bulunma ekiyle gelir: Sapanca'da
  ///
  /// In tr, this message translates to:
  /// **'{region} en sevilenler'**
  String explorePopularTitle(String region);

  /// No description provided for @explorePopularSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Gecelik fiyat · tüm ücretler dahil'**
  String get explorePopularSubtitle;

  /// No description provided for @exploreWeekendTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta sonu boş olanlar'**
  String get exploreWeekendTitle;

  /// No description provided for @exploreWeekendSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{dates} · {nights} gecelik toplam, ücretler dahil'**
  String exploreWeekendSubtitle(String dates, int nights);

  /// No description provided for @exploreEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu kategoride şimdilik bungalov yok'**
  String get exploreEmptyTitle;

  /// No description provided for @exploreEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Başka bir kategoriye göz at, yenileri sürekli ekleniyor.'**
  String get exploreEmptyBody;

  /// No description provided for @exploreErrorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovlar yüklenemedi'**
  String get exploreErrorTitle;

  /// No description provided for @exploreErrorBody.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantını kontrol edip tekrar dene.'**
  String get exploreErrorBody;

  /// No description provided for @weatherTemperature.
  ///
  /// In tr, this message translates to:
  /// **'{degrees}°'**
  String weatherTemperature(int degrees);

  /// No description provided for @weatherDayCondition.
  ///
  /// In tr, this message translates to:
  /// **'{weekday} · {condition}'**
  String weatherDayCondition(String weekday, String condition);

  /// No description provided for @weatherSunny.
  ///
  /// In tr, this message translates to:
  /// **'Güneşli'**
  String get weatherSunny;

  /// No description provided for @weatherPartlyCloudy.
  ///
  /// In tr, this message translates to:
  /// **'Parçalı bulutlu'**
  String get weatherPartlyCloudy;

  /// No description provided for @weatherCloudy.
  ///
  /// In tr, this message translates to:
  /// **'Bulutlu'**
  String get weatherCloudy;

  /// No description provided for @weatherRainy.
  ///
  /// In tr, this message translates to:
  /// **'Yağmurlu'**
  String get weatherRainy;

  /// No description provided for @weatherSnowy.
  ///
  /// In tr, this message translates to:
  /// **'Karlı'**
  String get weatherSnowy;

  /// No description provided for @weatherPoolDay.
  ///
  /// In tr, this message translates to:
  /// **'Havuz keyfi için ideal hafta sonu — {count} bungalov müsait.'**
  String weatherPoolDay(int count);

  /// No description provided for @weatherAvailable.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta sonu {count} bungalov müsait.'**
  String weatherAvailable(int count);

  /// No description provided for @badgeGuestFavorite.
  ///
  /// In tr, this message translates to:
  /// **'Misafirlerin gözdesi'**
  String get badgeGuestFavorite;

  /// No description provided for @badgeNightsLeft.
  ///
  /// In tr, this message translates to:
  /// **'Son {count} gece!'**
  String badgeNightsLeft(int count);

  /// No description provided for @photoCounter.
  ///
  /// In tr, this message translates to:
  /// **'{current} / {total}'**
  String photoCounter(int current, int total);

  /// No description provided for @photoOf.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf {current} / {total}'**
  String photoOf(int current, int total);

  /// No description provided for @listingSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get listingSave;

  /// No description provided for @listingUnsave.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlılardan çıkar'**
  String get listingUnsave;

  /// No description provided for @listingPerNight.
  ///
  /// In tr, this message translates to:
  /// **'/ gece'**
  String get listingPerNight;

  /// No description provided for @listingNightsTotal.
  ///
  /// In tr, this message translates to:
  /// **'· {nights} gece toplam'**
  String listingNightsTotal(int nights);

  /// No description provided for @listingRating.
  ///
  /// In tr, this message translates to:
  /// **'Puan {rating}'**
  String listingRating(String rating);

  /// No description provided for @listingNightlySemantics.
  ///
  /// In tr, this message translates to:
  /// **'Gecelik {price}'**
  String listingNightlySemantics(String price);

  /// No description provided for @listingTotalSemantics.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece toplam {price}'**
  String listingTotalSemantics(int nights, String price);

  /// No description provided for @listingDiscountSemantics.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece toplam {price}, indirimsiz {original}'**
  String listingDiscountSemantics(int nights, String price, String original);

  /// No description provided for @listingGuests.
  ///
  /// In tr, this message translates to:
  /// **'{count} misafir'**
  String listingGuests(int count);

  /// No description provided for @propertyBungalow.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov'**
  String get propertyBungalow;

  /// No description provided for @propertyTreeHouse.
  ///
  /// In tr, this message translates to:
  /// **'Ağaç ev'**
  String get propertyTreeHouse;

  /// No description provided for @propertyAFrame.
  ///
  /// In tr, this message translates to:
  /// **'A-frame'**
  String get propertyAFrame;

  /// No description provided for @propertyCabin.
  ///
  /// In tr, this message translates to:
  /// **'Kulübe'**
  String get propertyCabin;

  /// No description provided for @settingLakeView.
  ///
  /// In tr, this message translates to:
  /// **'Göl manzaralı'**
  String get settingLakeView;

  /// No description provided for @settingLakeside.
  ///
  /// In tr, this message translates to:
  /// **'Göl kıyısı'**
  String get settingLakeside;

  /// No description provided for @settingForest.
  ///
  /// In tr, this message translates to:
  /// **'Orman içi'**
  String get settingForest;

  /// No description provided for @amenityPool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get amenityPool;

  /// No description provided for @amenityHeatedPool.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmalı havuz'**
  String get amenityHeatedPool;

  /// No description provided for @amenityJacuzzi.
  ///
  /// In tr, this message translates to:
  /// **'Jakuzi'**
  String get amenityJacuzzi;

  /// No description provided for @amenityFireplace.
  ///
  /// In tr, this message translates to:
  /// **'Şömine'**
  String get amenityFireplace;

  /// No description provided for @back.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get back;

  /// No description provided for @close.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get close;

  /// No description provided for @or.
  ///
  /// In tr, this message translates to:
  /// **'veya'**
  String get or;

  /// No description provided for @continueLabel.
  ///
  /// In tr, this message translates to:
  /// **'Devam et'**
  String get continueLabel;

  /// No description provided for @showPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi göster'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi gizle'**
  String get hidePassword;

  /// No description provided for @fieldEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get fieldPassword;

  /// No description provided for @fieldPhone.
  ///
  /// In tr, this message translates to:
  /// **'Telefon'**
  String get fieldPhone;

  /// No description provided for @fieldPhoneNumber.
  ///
  /// In tr, this message translates to:
  /// **'Telefon numarası'**
  String get fieldPhoneNumber;

  /// No description provided for @fieldFirstName.
  ///
  /// In tr, this message translates to:
  /// **'Ad'**
  String get fieldFirstName;

  /// No description provided for @fieldLastName.
  ///
  /// In tr, this message translates to:
  /// **'Soyad'**
  String get fieldLastName;

  /// No description provided for @fieldBirthDate.
  ///
  /// In tr, this message translates to:
  /// **'Doğum tarihi'**
  String get fieldBirthDate;

  /// No description provided for @fieldNewPassword.
  ///
  /// In tr, this message translates to:
  /// **'Yeni şifre'**
  String get fieldNewPassword;

  /// No description provided for @fieldNewPasswordRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Yeni şifre (tekrar)'**
  String get fieldNewPasswordRepeat;

  /// No description provided for @hintPhone.
  ///
  /// In tr, this message translates to:
  /// **'5XX XXX XX XX'**
  String get hintPhone;

  /// No description provided for @hintBirthDate.
  ///
  /// In tr, this message translates to:
  /// **'GG / AA / YYYY'**
  String get hintBirthDate;

  /// No description provided for @countryCodeTr.
  ///
  /// In tr, this message translates to:
  /// **'+90'**
  String get countryCodeTr;

  /// No description provided for @verificationCode.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulama kodu'**
  String get verificationCode;

  /// No description provided for @welcomeBrand.
  ///
  /// In tr, this message translates to:
  /// **'kozalak'**
  String get welcomeBrand;

  /// No description provided for @welcomeStats.
  ///
  /// In tr, this message translates to:
  /// **'4,9 · 1.200+ bungalov'**
  String get welcomeStats;

  /// No description provided for @welcomeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Doğaya en yakın\nkaçamak burada.'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In tr, this message translates to:
  /// **'Havuzlu, göl manzaralı, orman içi bungalovları keşfet; birkaç dokunuşla rezervasyonunu yap.'**
  String get welcomeBody;

  /// No description provided for @welcomeCreateAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesap oluştur'**
  String get welcomeCreateAccount;

  /// No description provided for @welcomeSignIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get welcomeSignIn;

  /// No description provided for @welcomeBrowse.
  ///
  /// In tr, this message translates to:
  /// **'Şimdilik göz at'**
  String get welcomeBrowse;

  /// No description provided for @signInTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar hoş geldin'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaçamaklarına kaldığın yerden devam et.'**
  String get signInSubtitle;

  /// No description provided for @signInRememberMe.
  ///
  /// In tr, this message translates to:
  /// **'Beni hatırla'**
  String get signInRememberMe;

  /// No description provided for @signInForgot.
  ///
  /// In tr, this message translates to:
  /// **'Şifremi unuttum'**
  String get signInForgot;

  /// No description provided for @signInSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get signInSubmit;

  /// No description provided for @signInGoogle.
  ///
  /// In tr, this message translates to:
  /// **'Google ile devam et'**
  String get signInGoogle;

  /// No description provided for @signInApple.
  ///
  /// In tr, this message translates to:
  /// **'Apple ile devam et'**
  String get signInApple;

  /// No description provided for @signInGoogleBadge.
  ///
  /// In tr, this message translates to:
  /// **'G'**
  String get signInGoogleBadge;

  /// No description provided for @signInNoAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın yok mu?'**
  String get signInNoAccount;

  /// No description provided for @signInRegister.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt ol'**
  String get signInRegister;

  /// No description provided for @signInPhoneNote.
  ///
  /// In tr, this message translates to:
  /// **'Numarana 6 haneli bir doğrulama kodu göndereceğiz.'**
  String get signInPhoneNote;

  /// No description provided for @signInSendSms.
  ///
  /// In tr, this message translates to:
  /// **'SMS kodu gönder'**
  String get signInSendSms;

  /// No description provided for @signInInvalidCredentials.
  ///
  /// In tr, this message translates to:
  /// **'E-posta veya şifre hatalı. {count} deneme hakkın kaldı.'**
  String signInInvalidCredentials(int count);

  /// No description provided for @signInLocked.
  ///
  /// In tr, this message translates to:
  /// **'Deneme hakkın doldu. Şifreni sıfırlayarak devam edebilirsin.'**
  String get signInLocked;

  /// No description provided for @errorEmail.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta adresi gir'**
  String get errorEmail;

  /// No description provided for @errorPasswordShort.
  ///
  /// In tr, this message translates to:
  /// **'Şifren en az 8 karakter olmalı'**
  String get errorPasswordShort;

  /// No description provided for @errorPhone.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir cep telefonu numarası gir'**
  String get errorPhone;

  /// No description provided for @errorName.
  ///
  /// In tr, this message translates to:
  /// **'Bu alanı doldur'**
  String get errorName;

  /// No description provided for @errorBirthDate.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir tarih gir'**
  String get errorBirthDate;

  /// No description provided for @errorUnderage.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt için 18 yaşından büyük olmalısın.'**
  String get errorUnderage;

  /// No description provided for @errorPasswordRule.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter ve 1 rakam kullan'**
  String get errorPasswordRule;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In tr, this message translates to:
  /// **'Şifreler aynı değil'**
  String get errorPasswordMismatch;

  /// No description provided for @errorInvalidCode.
  ///
  /// In tr, this message translates to:
  /// **'Kod hatalı. Kontrol edip tekrar dene.'**
  String get errorInvalidCode;

  /// No description provided for @errorEmailInUse.
  ///
  /// In tr, this message translates to:
  /// **'Bu e-posta ile zaten bir hesap var. Giriş yapmayı dene.'**
  String get errorEmailInUse;

  /// No description provided for @errorNetwork.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı kurulamadı. İnternetini kontrol edip tekrar dene.'**
  String get errorNetwork;

  /// No description provided for @smsTitle.
  ///
  /// In tr, this message translates to:
  /// **'SMS kodunu gir'**
  String get smsTitle;

  /// No description provided for @smsBody.
  ///
  /// In tr, this message translates to:
  /// **'{phone} numarasına 6 haneli bir kod gönderdik.'**
  String smsBody(String phone);

  /// No description provided for @smsChangeNumber.
  ///
  /// In tr, this message translates to:
  /// **'Numarayı değiştir'**
  String get smsChangeNumber;

  /// No description provided for @resendCode.
  ///
  /// In tr, this message translates to:
  /// **'Kodu tekrar gönder'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In tr, this message translates to:
  /// **'Kodu tekrar gönder · '**
  String get resendCodeIn;

  /// No description provided for @registerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabını oluştur'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir dakikada kaydol, ilk kaçamağını planlamaya başla.'**
  String get registerSubtitle;

  /// No description provided for @registerAgeNote.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt için 18 yaşından büyük olmalısın.'**
  String get registerAgeNote;

  /// No description provided for @registerPasswordHint.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter, 1 rakam'**
  String get registerPasswordHint;

  /// No description provided for @passwordWeak.
  ///
  /// In tr, this message translates to:
  /// **'Zayıf'**
  String get passwordWeak;

  /// No description provided for @passwordMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta güçte'**
  String get passwordMedium;

  /// No description provided for @passwordStrong.
  ///
  /// In tr, this message translates to:
  /// **'Güçlü'**
  String get passwordStrong;

  /// No description provided for @registerTermsLink.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get registerTermsLink;

  /// No description provided for @registerTermsMiddle.
  ///
  /// In tr, this message translates to:
  /// **'’nı ve '**
  String get registerTermsMiddle;

  /// No description provided for @registerKvkkLink.
  ///
  /// In tr, this message translates to:
  /// **'KVKK Aydınlatma Metni'**
  String get registerKvkkLink;

  /// No description provided for @registerTermsEnd.
  ///
  /// In tr, this message translates to:
  /// **'’ni okudum, kabul ediyorum.'**
  String get registerTermsEnd;

  /// No description provided for @registerTermsSemantics.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları’nı ve KVKK Aydınlatma Metni’ni okudum, kabul ediyorum.'**
  String get registerTermsSemantics;

  /// No description provided for @registerMarketing.
  ///
  /// In tr, this message translates to:
  /// **'Kampanya ve fırsatlardan e-posta/SMS ile haberdar olmak istiyorum. (İsteğe bağlı)'**
  String get registerMarketing;

  /// No description provided for @registerHaveAccount.
  ///
  /// In tr, this message translates to:
  /// **'Zaten hesabın var mı?'**
  String get registerHaveAccount;

  /// No description provided for @registerSignIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get registerSignIn;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In tr, this message translates to:
  /// **'E-postanı doğrula'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailBody.
  ///
  /// In tr, this message translates to:
  /// **'{email} adresine 6 haneli bir kod gönderdik. Kodu aşağıya yaz.'**
  String verifyEmailBody(String email);

  /// No description provided for @verifyEmailSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Doğrula'**
  String get verifyEmailSubmit;

  /// No description provided for @verifyEmailChange.
  ///
  /// In tr, this message translates to:
  /// **'E-posta adresini değiştir'**
  String get verifyEmailChange;

  /// No description provided for @forgotTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şifreni mi unuttun?'**
  String get forgotTitle;

  /// No description provided for @forgotBody.
  ///
  /// In tr, this message translates to:
  /// **'Dert etme. Hesabına bağlı e-postanı yaz, sana bir sıfırlama kodu gönderelim.'**
  String get forgotBody;

  /// No description provided for @forgotSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Kod gönder'**
  String get forgotSubmit;

  /// No description provided for @forgotRemembered.
  ///
  /// In tr, this message translates to:
  /// **'Şifreni hatırladın mı?'**
  String get forgotRemembered;

  /// No description provided for @forgotSignIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get forgotSignIn;

  /// No description provided for @resetCodeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kodu gir'**
  String get resetCodeTitle;

  /// No description provided for @resetCodeBody.
  ///
  /// In tr, this message translates to:
  /// **'{email} adresine gönderdiğimiz 6 haneli kodu yaz.'**
  String resetCodeBody(String email);

  /// No description provided for @resetCodeTip.
  ///
  /// In tr, this message translates to:
  /// **'Kod gelmediyse spam/gereksiz klasörünü kontrol et.'**
  String get resetCodeTip;

  /// No description provided for @newPasswordTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni şifreni belirle'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordBody.
  ///
  /// In tr, this message translates to:
  /// **'Daha önce kullanmadığın, tahmin edilmesi zor bir şifre seç.'**
  String get newPasswordBody;

  /// No description provided for @newPasswordRulesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şifren şunları içermeli'**
  String get newPasswordRulesTitle;

  /// No description provided for @ruleMinLength.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter'**
  String get ruleMinLength;

  /// No description provided for @ruleUppercase.
  ///
  /// In tr, this message translates to:
  /// **'En az bir büyük harf'**
  String get ruleUppercase;

  /// No description provided for @ruleDigit.
  ///
  /// In tr, this message translates to:
  /// **'En az bir rakam'**
  String get ruleDigit;

  /// No description provided for @ruleSpecial.
  ///
  /// In tr, this message translates to:
  /// **'En az bir özel karakter (!, ?, #)'**
  String get ruleSpecial;

  /// No description provided for @newPasswordSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi güncelle'**
  String get newPasswordSubmit;

  /// No description provided for @passwordUpdatedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şifren güncellendi!'**
  String get passwordUpdatedTitle;

  /// No description provided for @passwordUpdatedBody.
  ///
  /// In tr, this message translates to:
  /// **'Artık yeni şifrenle giriş yapabilirsin. Güvenliğin için diğer cihazlardaki oturumlarını kapattık.'**
  String get passwordUpdatedBody;

  /// No description provided for @passwordUpdatedSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get passwordUpdatedSubmit;

  /// No description provided for @loginRequiredTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaydetmek için giriş yap'**
  String get loginRequiredTitle;

  /// No description provided for @loginRequiredBody.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiğin bungalovları listelere eklemek ve rezervasyon yapmak için bir hesaba ihtiyacın var.'**
  String get loginRequiredBody;

  /// No description provided for @loginRequiredEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta ile devam et'**
  String get loginRequiredEmail;

  /// No description provided for @amenityAirConditioning.
  ///
  /// In tr, this message translates to:
  /// **'Klima'**
  String get amenityAirConditioning;

  /// No description provided for @amenityWifi.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi'**
  String get amenityWifi;

  /// No description provided for @amenityParking.
  ///
  /// In tr, this message translates to:
  /// **'Otopark'**
  String get amenityParking;

  /// No description provided for @badgeRareFind.
  ///
  /// In tr, this message translates to:
  /// **'Nadir fırsat'**
  String get badgeRareFind;

  /// No description provided for @featureLakeView.
  ///
  /// In tr, this message translates to:
  /// **'Göl manzarası'**
  String get featureLakeView;

  /// No description provided for @clearAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü temizle'**
  String get clearAll;

  /// No description provided for @clear.
  ///
  /// In tr, this message translates to:
  /// **'Temizle'**
  String get clear;

  /// No description provided for @reset.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırla'**
  String get reset;

  /// No description provided for @save.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get save;

  /// No description provided for @searchTabListings.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovlar'**
  String get searchTabListings;

  /// No description provided for @searchTabMap.
  ///
  /// In tr, this message translates to:
  /// **'Haritada ara'**
  String get searchTabMap;

  /// No description provided for @searchWhereTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nereye?'**
  String get searchWhereTitle;

  /// No description provided for @searchLocationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Konum'**
  String get searchLocationLabel;

  /// No description provided for @searchLocationHint.
  ///
  /// In tr, this message translates to:
  /// **'Bölge ya da bungalov ara'**
  String get searchLocationHint;

  /// No description provided for @searchRecent.
  ///
  /// In tr, this message translates to:
  /// **'Son aramalar'**
  String get searchRecent;

  /// No description provided for @searchPopularRoutes.
  ///
  /// In tr, this message translates to:
  /// **'Popüler rotalar'**
  String get searchPopularRoutes;

  /// No description provided for @searchWhen.
  ///
  /// In tr, this message translates to:
  /// **'Ne zaman?'**
  String get searchWhen;

  /// No description provided for @searchWho.
  ///
  /// In tr, this message translates to:
  /// **'Kim?'**
  String get searchWho;

  /// No description provided for @searchAnyDate.
  ///
  /// In tr, this message translates to:
  /// **'Esnek tarih'**
  String get searchAnyDate;

  /// No description provided for @searchAddDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarih ekle'**
  String get searchAddDates;

  /// No description provided for @searchSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov ara'**
  String get searchSubmit;

  /// No description provided for @searchSummary.
  ///
  /// In tr, this message translates to:
  /// **'{dates} · {guests}'**
  String searchSummary(String dates, String guests);

  /// No description provided for @searchAnywhere.
  ///
  /// In tr, this message translates to:
  /// **'Her yer'**
  String get searchAnywhere;

  /// No description provided for @filtersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Filtreler'**
  String get filtersTitle;

  /// No description provided for @filtersPrice.
  ///
  /// In tr, this message translates to:
  /// **'Gecelik fiyat'**
  String get filtersPrice;

  /// No description provided for @filtersPriceNote.
  ///
  /// In tr, this message translates to:
  /// **'Vergiler ve ücretler dahil'**
  String get filtersPriceNote;

  /// No description provided for @filtersMin.
  ///
  /// In tr, this message translates to:
  /// **'En az'**
  String get filtersMin;

  /// No description provided for @filtersMax.
  ///
  /// In tr, this message translates to:
  /// **'En çok'**
  String get filtersMax;

  /// No description provided for @filtersFeatures.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov özellikleri'**
  String get filtersFeatures;

  /// No description provided for @filtersBedrooms.
  ///
  /// In tr, this message translates to:
  /// **'Yatak odası'**
  String get filtersBedrooms;

  /// No description provided for @filtersAnyBedrooms.
  ///
  /// In tr, this message translates to:
  /// **'Farketmez'**
  String get filtersAnyBedrooms;

  /// No description provided for @filtersBedroomsPlus.
  ///
  /// In tr, this message translates to:
  /// **'{count}+'**
  String filtersBedroomsPlus(int count);

  /// No description provided for @filtersBooking.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon tercihleri'**
  String get filtersBooking;

  /// No description provided for @filtersInstant.
  ///
  /// In tr, this message translates to:
  /// **'Anında onay'**
  String get filtersInstant;

  /// No description provided for @filtersInstantNote.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi onayı beklemeden rezervasyon'**
  String get filtersInstantNote;

  /// No description provided for @filtersFreeCancel.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz iptal'**
  String get filtersFreeCancel;

  /// No description provided for @filtersFreeCancelNote.
  ///
  /// In tr, this message translates to:
  /// **'Girişten 24 saat öncesine kadar'**
  String get filtersFreeCancelNote;

  /// No description provided for @filtersPets.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan kabul eden'**
  String get filtersPets;

  /// No description provided for @filtersPetsNote.
  ///
  /// In tr, this message translates to:
  /// **'Patili dostunla gel'**
  String get filtersPetsNote;

  /// No description provided for @filtersAccessible.
  ///
  /// In tr, this message translates to:
  /// **'Engelsiz erişim'**
  String get filtersAccessible;

  /// No description provided for @filtersAccessibleNote.
  ///
  /// In tr, this message translates to:
  /// **'Basamaksız giriş, geniş kapılar'**
  String get filtersAccessibleNote;

  /// No description provided for @filtersShow.
  ///
  /// In tr, this message translates to:
  /// **'{count} bungalovu göster'**
  String filtersShow(int count);

  /// No description provided for @filtersPriceChip.
  ///
  /// In tr, this message translates to:
  /// **'₺{min}–{max}'**
  String filtersPriceChip(String min, String max);

  /// No description provided for @filtersActive.
  ///
  /// In tr, this message translates to:
  /// **'{count} filtre etkin'**
  String filtersActive(int count);

  /// No description provided for @removeFilter.
  ///
  /// In tr, this message translates to:
  /// **'{name} filtresini kaldır'**
  String removeFilter(String name);

  /// No description provided for @resultsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} bungalov'**
  String resultsCount(int count);

  /// No description provided for @sortRecommended.
  ///
  /// In tr, this message translates to:
  /// **'Önerilen'**
  String get sortRecommended;

  /// No description provided for @sortPriceLow.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat (artan)'**
  String get sortPriceLow;

  /// No description provided for @sortPriceHigh.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat (azalan)'**
  String get sortPriceHigh;

  /// No description provided for @sortRating.
  ///
  /// In tr, this message translates to:
  /// **'En yüksek puan'**
  String get sortRating;

  /// No description provided for @sortTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sırala'**
  String get sortTitle;

  /// No description provided for @resultsMap.
  ///
  /// In tr, this message translates to:
  /// **'Harita'**
  String get resultsMap;

  /// No description provided for @resultsList.
  ///
  /// In tr, this message translates to:
  /// **'Liste'**
  String get resultsList;

  /// No description provided for @mapPriceNote.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gecelik toplam fiyatlar · ücretler dahil'**
  String mapPriceNote(int nights);

  /// No description provided for @mapMyLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konumuma git'**
  String get mapMyLocation;

  /// No description provided for @mapListingLine.
  ///
  /// In tr, this message translates to:
  /// **'{rating} · {setting}'**
  String mapListingLine(String rating, String setting);

  /// No description provided for @nightsTotalShort.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece toplam'**
  String nightsTotalShort(int nights);

  /// No description provided for @noResultsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu kriterlere uygun\nbungalov bulamadık'**
  String get noResultsTitle;

  /// No description provided for @noResultsBody.
  ///
  /// In tr, this message translates to:
  /// **'Birkaç filtreyi gevşetmeyi dene. Şu öneriler işine yarayabilir:'**
  String get noResultsBody;

  /// No description provided for @relaxDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarihleri ±2 gün esnet'**
  String get relaxDates;

  /// No description provided for @relaxHeatedPool.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmalı havuzu kaldır'**
  String get relaxHeatedPool;

  /// No description provided for @relaxPrice.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat aralığını genişlet'**
  String get relaxPrice;

  /// No description provided for @relaxExtra.
  ///
  /// In tr, this message translates to:
  /// **'{count} bungalov daha çıkıyor'**
  String relaxExtra(int count);

  /// No description provided for @clearAllFilters.
  ///
  /// In tr, this message translates to:
  /// **'Tüm filtreleri temizle'**
  String get clearAllFilters;

  /// No description provided for @datesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ne zaman geliyorsun?'**
  String get datesTitle;

  /// No description provided for @datesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Fiyatlar gece başına. Yeşil noktalı günler daha uygun.'**
  String get datesSubtitle;

  /// No description provided for @datesPrevMonth.
  ///
  /// In tr, this message translates to:
  /// **'Önceki ay'**
  String get datesPrevMonth;

  /// No description provided for @datesNextMonth.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki ay'**
  String get datesNextMonth;

  /// No description provided for @datesLegendSelected.
  ///
  /// In tr, this message translates to:
  /// **'Seçili'**
  String get datesLegendSelected;

  /// No description provided for @datesLegendStay.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama'**
  String get datesLegendStay;

  /// No description provided for @datesLegendDeal.
  ///
  /// In tr, this message translates to:
  /// **'Uygun fiyat'**
  String get datesLegendDeal;

  /// No description provided for @datesLegendBooked.
  ///
  /// In tr, this message translates to:
  /// **'Dolu'**
  String get datesLegendBooked;

  /// No description provided for @datesSummary.
  ///
  /// In tr, this message translates to:
  /// **'{dates} · {nights} gece'**
  String datesSummary(String dates, int nights);

  /// No description provided for @datesPickCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş tarihini seç'**
  String get datesPickCheckIn;

  /// No description provided for @datesPickCheckOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış tarihini seç'**
  String get datesPickCheckOut;

  /// No description provided for @datesClear.
  ///
  /// In tr, this message translates to:
  /// **'Tarihleri temizle'**
  String get datesClear;

  /// No description provided for @dayPriceShort.
  ///
  /// In tr, this message translates to:
  /// **'{price}b'**
  String dayPriceShort(String price);

  /// No description provided for @dayUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'{day}, dolu'**
  String dayUnavailable(String day);

  /// No description provided for @guestsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kimler geliyor?'**
  String get guestsTitle;

  /// No description provided for @guestsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafir sayısı fiyatı ve kuralları etkileyebilir.'**
  String get guestsSubtitle;

  /// No description provided for @guestsAdults.
  ///
  /// In tr, this message translates to:
  /// **'Yetişkin'**
  String get guestsAdults;

  /// No description provided for @guestsAdultsNote.
  ///
  /// In tr, this message translates to:
  /// **'13 yaş ve üzeri'**
  String get guestsAdultsNote;

  /// No description provided for @guestsChildren.
  ///
  /// In tr, this message translates to:
  /// **'Çocuk'**
  String get guestsChildren;

  /// No description provided for @guestsChildrenNote.
  ///
  /// In tr, this message translates to:
  /// **'2–12 yaş'**
  String get guestsChildrenNote;

  /// No description provided for @guestsInfants.
  ///
  /// In tr, this message translates to:
  /// **'Bebek'**
  String get guestsInfants;

  /// No description provided for @guestsInfantsNote.
  ///
  /// In tr, this message translates to:
  /// **'2 yaş altı · kapasiteye sayılmaz'**
  String get guestsInfantsNote;

  /// No description provided for @guestsPets.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan'**
  String get guestsPets;

  /// No description provided for @guestsPetsNote.
  ///
  /// In tr, this message translates to:
  /// **'Patili dostlar'**
  String get guestsPetsNote;

  /// No description provided for @guestsPetsNotAllowed.
  ///
  /// In tr, this message translates to:
  /// **'Bu bungalov evcil hayvan kabul etmiyor'**
  String get guestsPetsNotAllowed;

  /// No description provided for @guestsCapacity.
  ///
  /// In tr, this message translates to:
  /// **'Bu bungalov en fazla {count} misafir kabul ediyor.'**
  String guestsCapacity(int count);

  /// No description provided for @counterDecrease.
  ///
  /// In tr, this message translates to:
  /// **'{name} azalt'**
  String counterDecrease(String name);

  /// No description provided for @counterIncrease.
  ///
  /// In tr, this message translates to:
  /// **'{name} artır'**
  String counterIncrease(String name);

  /// No description provided for @weekdaysShort.
  ///
  /// In tr, this message translates to:
  /// **'Pt,Sa,Ça,Pe,Cu,Ct,Pz'**
  String get weekdaysShort;

  /// No description provided for @share.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get share;

  /// No description provided for @photoTour.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf turu'**
  String get photoTour;

  /// No description provided for @photoTourSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{title} · {count} fotoğraf'**
  String photoTourSubtitle(String title, int count);

  /// No description provided for @photoCountShort.
  ///
  /// In tr, this message translates to:
  /// **'{count} fotoğraf'**
  String photoCountShort(int count);

  /// No description provided for @pinchToZoom.
  ///
  /// In tr, this message translates to:
  /// **'İki parmakla yakınlaştır'**
  String get pinchToZoom;

  /// No description provided for @roomLiving.
  ///
  /// In tr, this message translates to:
  /// **'Oturma odası'**
  String get roomLiving;

  /// No description provided for @roomBedroom.
  ///
  /// In tr, this message translates to:
  /// **'Yatak odası'**
  String get roomBedroom;

  /// No description provided for @roomBathroom.
  ///
  /// In tr, this message translates to:
  /// **'Banyo'**
  String get roomBathroom;

  /// No description provided for @roomOutdoor.
  ///
  /// In tr, this message translates to:
  /// **'Dış alan'**
  String get roomOutdoor;

  /// No description provided for @roomPool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get roomPool;

  /// No description provided for @photoProgress.
  ///
  /// In tr, this message translates to:
  /// **'{current} / {total} fotoğraf'**
  String photoProgress(int current, int total);

  /// No description provided for @propertyBadgeBungalow.
  ///
  /// In tr, this message translates to:
  /// **'Ahşap bungalov'**
  String get propertyBadgeBungalow;

  /// No description provided for @statGuests.
  ///
  /// In tr, this message translates to:
  /// **'{count} misafir'**
  String statGuests(int count);

  /// No description provided for @statRooms.
  ///
  /// In tr, this message translates to:
  /// **'{count} oda'**
  String statRooms(int count);

  /// No description provided for @statBeds.
  ///
  /// In tr, this message translates to:
  /// **'{count} yatak'**
  String statBeds(int count);

  /// No description provided for @statBaths.
  ///
  /// In tr, this message translates to:
  /// **'{count} banyo'**
  String statBaths(int count);

  /// No description provided for @guestFavoriteTwoLine.
  ///
  /// In tr, this message translates to:
  /// **'Misafirlerin\ngözdesi'**
  String get guestFavoriteTwoLine;

  /// No description provided for @topPercent.
  ///
  /// In tr, this message translates to:
  /// **'En iyi %{percent}'**
  String topPercent(int percent);

  /// No description provided for @reviewsLabel.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirme'**
  String get reviewsLabel;

  /// No description provided for @hostLine.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi: {name}'**
  String hostLine(String name);

  /// No description provided for @hostSuperhost.
  ///
  /// In tr, this message translates to:
  /// **'Altın Kozalak Ev Sahibi'**
  String get hostSuperhost;

  /// No description provided for @hostStandard.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi'**
  String get hostStandard;

  /// No description provided for @hostYears.
  ///
  /// In tr, this message translates to:
  /// **'{years} yıl'**
  String hostYears(int years);

  /// No description provided for @hostSubline.
  ///
  /// In tr, this message translates to:
  /// **'{level} · {years}'**
  String hostSubline(String level, String years);

  /// No description provided for @messageHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibine yaz'**
  String get messageHost;

  /// No description provided for @poolTitle.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get poolTitle;

  /// No description provided for @poolPrivate.
  ///
  /// In tr, this message translates to:
  /// **'Sana özel · paylaşımsız'**
  String get poolPrivate;

  /// No description provided for @poolShared.
  ///
  /// In tr, this message translates to:
  /// **'Ortak kullanım'**
  String get poolShared;

  /// No description provided for @poolTemperature.
  ///
  /// In tr, this message translates to:
  /// **'Sıcaklık'**
  String get poolTemperature;

  /// No description provided for @poolSize.
  ///
  /// In tr, this message translates to:
  /// **'Boyut'**
  String get poolSize;

  /// No description provided for @poolDepth.
  ///
  /// In tr, this message translates to:
  /// **'Derinlik'**
  String get poolDepth;

  /// No description provided for @poolSeason.
  ///
  /// In tr, this message translates to:
  /// **'Açık olduğu'**
  String get poolSeason;

  /// No description provided for @poolHeated.
  ///
  /// In tr, this message translates to:
  /// **'{temp}°C · Isıtmalı'**
  String poolHeated(int temp);

  /// No description provided for @poolUnheated.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmasız'**
  String get poolUnheated;

  /// No description provided for @poolSizeValue.
  ///
  /// In tr, this message translates to:
  /// **'{w} × {l} m'**
  String poolSizeValue(String w, String l);

  /// No description provided for @poolDepthValue.
  ///
  /// In tr, this message translates to:
  /// **'{min} – {max} m'**
  String poolDepthValue(String min, String max);

  /// No description provided for @readMore.
  ///
  /// In tr, this message translates to:
  /// **'Devamını oku'**
  String get readMore;

  /// No description provided for @guestsLoved.
  ///
  /// In tr, this message translates to:
  /// **'Misafirler bunu sevdi'**
  String get guestsLoved;

  /// No description provided for @topicPool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get topicPool;

  /// No description provided for @topicCleanliness.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik'**
  String get topicCleanliness;

  /// No description provided for @topicHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi'**
  String get topicHost;

  /// No description provided for @topicCount.
  ///
  /// In tr, this message translates to:
  /// **'{topic} · {count}'**
  String topicCount(String topic, int count);

  /// No description provided for @allReviews.
  ///
  /// In tr, this message translates to:
  /// **'{count} değerlendirmenin tümü'**
  String allReviews(int count);

  /// No description provided for @whatOffers.
  ///
  /// In tr, this message translates to:
  /// **'Bu mekân neler sunuyor?'**
  String get whatOffers;

  /// No description provided for @allAmenities.
  ///
  /// In tr, this message translates to:
  /// **'{count} olanağın tümü'**
  String allAmenities(int count);

  /// No description provided for @amenityCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} olanak'**
  String amenityCount(int count);

  /// No description provided for @whereYouWillBe.
  ///
  /// In tr, this message translates to:
  /// **'Nerede olacaksın?'**
  String get whereYouWillBe;

  /// No description provided for @locationAfterBooking.
  ///
  /// In tr, this message translates to:
  /// **'Tam konum rezervasyondan sonra paylaşılır.'**
  String get locationAfterBooking;

  /// No description provided for @addressAfterBooking.
  ///
  /// In tr, this message translates to:
  /// **'Tam adres rezervasyondan sonra paylaşılır.'**
  String get addressAfterBooking;

  /// No description provided for @nearbyMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{name} · {minutes} dk'**
  String nearbyMinutes(String name, int minutes);

  /// No description provided for @expandMap.
  ///
  /// In tr, this message translates to:
  /// **'Haritayı büyüt'**
  String get expandMap;

  /// No description provided for @availability.
  ///
  /// In tr, this message translates to:
  /// **'Uygunluk'**
  String get availability;

  /// No description provided for @changeDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarihleri değiştir'**
  String get changeDates;

  /// No description provided for @thingsToKnow.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmesi gerekenler'**
  String get thingsToKnow;

  /// No description provided for @cancellationPolicy.
  ///
  /// In tr, this message translates to:
  /// **'İptal politikası'**
  String get cancellationPolicy;

  /// No description provided for @cancellationSummary.
  ///
  /// In tr, this message translates to:
  /// **'{hours} saat ücretsiz iptal, sonrasında iade yok.'**
  String cancellationSummary(int hours);

  /// No description provided for @houseRules.
  ///
  /// In tr, this message translates to:
  /// **'Ev kuralları'**
  String get houseRules;

  /// No description provided for @houseRulesSummary.
  ///
  /// In tr, this message translates to:
  /// **'Giriş {checkIn} · Çıkış {checkOut} · En fazla {guests} misafir'**
  String houseRulesSummary(String checkIn, String checkOut, int guests);

  /// No description provided for @safetyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik ve mekân'**
  String get safetyTitle;

  /// No description provided for @reportListing.
  ///
  /// In tr, this message translates to:
  /// **'Bu ilanı bildir'**
  String get reportListing;

  /// No description provided for @nearbyListings.
  ///
  /// In tr, this message translates to:
  /// **'Yakındaki diğer bungalovlar'**
  String get nearbyListings;

  /// No description provided for @rareFindBanner.
  ///
  /// In tr, this message translates to:
  /// **'Nadir fırsat! Bu yer genelde dolu'**
  String get rareFindBanner;

  /// No description provided for @bookNow.
  ///
  /// In tr, this message translates to:
  /// **'Rezerve et'**
  String get bookNow;

  /// No description provided for @requestToBook.
  ///
  /// In tr, this message translates to:
  /// **'Talep gönder'**
  String get requestToBook;

  /// No description provided for @nightsAndDates.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece · {dates}'**
  String nightsAndDates(int nights, String dates);

  /// No description provided for @addDatesForPrice.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat için tarih ekle'**
  String get addDatesForPrice;

  /// No description provided for @perNightPrice.
  ///
  /// In tr, this message translates to:
  /// **'{price} / gece'**
  String perNightPrice(String price);

  /// No description provided for @aboutListing.
  ///
  /// In tr, this message translates to:
  /// **'Bu bungalov hakkında'**
  String get aboutListing;

  /// No description provided for @descSpace.
  ///
  /// In tr, this message translates to:
  /// **'Mekân'**
  String get descSpace;

  /// No description provided for @descGuestAccess.
  ///
  /// In tr, this message translates to:
  /// **'Misafir erişimi'**
  String get descGuestAccess;

  /// No description provided for @descOther.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmesi gerekenler'**
  String get descOther;

  /// No description provided for @listingNumbers.
  ///
  /// In tr, this message translates to:
  /// **'İlan no: {listingNo}  ·  İzin belge no: {permitNo}'**
  String listingNumbers(String listingNo, String permitNo);

  /// No description provided for @reviewsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirmeler'**
  String get reviewsTitle;

  /// No description provided for @reviewsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} değerlendirme'**
  String reviewsCount(int count);

  /// No description provided for @ratingCleanliness.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik'**
  String get ratingCleanliness;

  /// No description provided for @ratingAccuracy.
  ///
  /// In tr, this message translates to:
  /// **'Doğruluk'**
  String get ratingAccuracy;

  /// No description provided for @ratingCommunication.
  ///
  /// In tr, this message translates to:
  /// **'İletişim'**
  String get ratingCommunication;

  /// No description provided for @ratingLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konum'**
  String get ratingLocation;

  /// No description provided for @all.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get all;

  /// No description provided for @daysAgo.
  ///
  /// In tr, this message translates to:
  /// **'{count} gün önce'**
  String daysAgo(int count);

  /// No description provided for @weeksAgo.
  ///
  /// In tr, this message translates to:
  /// **'{count} hafta önce'**
  String weeksAgo(int count);

  /// No description provided for @monthsAgo.
  ///
  /// In tr, this message translates to:
  /// **'{count} ay önce'**
  String monthsAgo(int count);

  /// No description provided for @today.
  ///
  /// In tr, this message translates to:
  /// **'Bugün'**
  String get today;

  /// No description provided for @starsLabel.
  ///
  /// In tr, this message translates to:
  /// **'{count} yıldız'**
  String starsLabel(int count);

  /// No description provided for @groupOutdoor.
  ///
  /// In tr, this message translates to:
  /// **'Dış alan'**
  String get groupOutdoor;

  /// No description provided for @groupIndoor.
  ///
  /// In tr, this message translates to:
  /// **'İç mekân'**
  String get groupIndoor;

  /// No description provided for @groupNotIncluded.
  ///
  /// In tr, this message translates to:
  /// **'Dahil olmayanlar'**
  String get groupNotIncluded;

  /// No description provided for @amenPrivatePool.
  ///
  /// In tr, this message translates to:
  /// **'Özel havuz'**
  String get amenPrivatePool;

  /// No description provided for @amenJacuzzi.
  ///
  /// In tr, this message translates to:
  /// **'Jakuzi'**
  String get amenJacuzzi;

  /// No description provided for @amenBarbecue.
  ///
  /// In tr, this message translates to:
  /// **'Mangal alanı'**
  String get amenBarbecue;

  /// No description provided for @amenParking.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz otopark'**
  String get amenParking;

  /// No description provided for @amenKitchen.
  ///
  /// In tr, this message translates to:
  /// **'Tam donanımlı mutfak'**
  String get amenKitchen;

  /// No description provided for @amenWifi.
  ///
  /// In tr, this message translates to:
  /// **'Hızlı Wi-Fi'**
  String get amenWifi;

  /// No description provided for @amenAirConditioning.
  ///
  /// In tr, this message translates to:
  /// **'Klima'**
  String get amenAirConditioning;

  /// No description provided for @amenOrthopedicBed.
  ///
  /// In tr, this message translates to:
  /// **'Ortopedik yatak'**
  String get amenOrthopedicBed;

  /// No description provided for @amenFireplace.
  ///
  /// In tr, this message translates to:
  /// **'Şömine'**
  String get amenFireplace;

  /// No description provided for @amenPets.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan'**
  String get amenPets;

  /// No description provided for @amenStepFree.
  ///
  /// In tr, this message translates to:
  /// **'Engelsiz giriş'**
  String get amenStepFree;

  /// No description provided for @rulesTabHouse.
  ///
  /// In tr, this message translates to:
  /// **'Ev kuralları'**
  String get rulesTabHouse;

  /// No description provided for @rulesTabCancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get rulesTabCancel;

  /// No description provided for @rulesTabSafety.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik'**
  String get rulesTabSafety;

  /// No description provided for @rulesCheckInOut.
  ///
  /// In tr, this message translates to:
  /// **'Giriş ve çıkış'**
  String get rulesCheckInOut;

  /// No description provided for @rulesDuringStay.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama sırasında'**
  String get rulesDuringStay;

  /// No description provided for @rulesCancelPreview.
  ///
  /// In tr, this message translates to:
  /// **'İptal politikası (önizleme)'**
  String get rulesCancelPreview;

  /// No description provided for @ruleCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş {from} – {to}'**
  String ruleCheckIn(String from, String to);

  /// No description provided for @ruleCheckOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış {time}’e kadar'**
  String ruleCheckOut(String time);

  /// No description provided for @ruleKeybox.
  ///
  /// In tr, this message translates to:
  /// **'Anahtar kutusu ile kendin giriş yap'**
  String get ruleKeybox;

  /// No description provided for @ruleSmartLock.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı kilit ile kendin giriş yap'**
  String get ruleSmartLock;

  /// No description provided for @ruleHostCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi seni karşılar'**
  String get ruleHostCheckIn;

  /// No description provided for @ruleMaxGuests.
  ///
  /// In tr, this message translates to:
  /// **'En fazla {count} misafir'**
  String ruleMaxGuests(int count);

  /// No description provided for @rulePetsNo.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan kabul edilmez'**
  String get rulePetsNo;

  /// No description provided for @rulePetsYes.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan kabul edilir'**
  String get rulePetsYes;

  /// No description provided for @ruleQuiet.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz saatler {from} – {to}'**
  String ruleQuiet(String from, String to);

  /// No description provided for @ruleNoSmoking.
  ///
  /// In tr, this message translates to:
  /// **'Kapalı alanda sigara içilmez'**
  String get ruleNoSmoking;

  /// No description provided for @cancelUntil.
  ///
  /// In tr, this message translates to:
  /// **'{date}’e kadar'**
  String cancelUntil(String date);

  /// No description provided for @cancelAfter.
  ///
  /// In tr, this message translates to:
  /// **'{date}’ten sonra'**
  String cancelAfter(String date);

  /// No description provided for @cancelFullRefund.
  ///
  /// In tr, this message translates to:
  /// **'Ücretin tamamı iade edilir'**
  String get cancelFullRefund;

  /// No description provided for @cancelNoRefund.
  ///
  /// In tr, this message translates to:
  /// **'İade yapılmaz'**
  String get cancelNoRefund;

  /// No description provided for @cancelPickDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarih seçtiğinde iptal tarihleri burada görünür.'**
  String get cancelPickDates;

  /// No description provided for @safetyCo.
  ///
  /// In tr, this message translates to:
  /// **'Karbonmonoksit alarmı'**
  String get safetyCo;

  /// No description provided for @safetySmoke.
  ///
  /// In tr, this message translates to:
  /// **'Duman dedektörü'**
  String get safetySmoke;

  /// No description provided for @safetyFirstAid.
  ///
  /// In tr, this message translates to:
  /// **'İlk yardım çantası'**
  String get safetyFirstAid;

  /// No description provided for @safetyExtinguisher.
  ///
  /// In tr, this message translates to:
  /// **'Yangın söndürücü'**
  String get safetyExtinguisher;

  /// No description provided for @safetyCamera.
  ///
  /// In tr, this message translates to:
  /// **'Dış mekân kamerası'**
  String get safetyCamera;

  /// No description provided for @approxLocation.
  ///
  /// In tr, this message translates to:
  /// **'{area} · yaklaşık konum'**
  String approxLocation(String area);

  /// No description provided for @whatsNearby.
  ///
  /// In tr, this message translates to:
  /// **'Yakında neler var?'**
  String get whatsNearby;

  /// No description provided for @distanceWalk.
  ///
  /// In tr, this message translates to:
  /// **'{distance} · {minutes} dk yürüme'**
  String distanceWalk(String distance, int minutes);

  /// No description provided for @distanceDrive.
  ///
  /// In tr, this message translates to:
  /// **'{distance} · {minutes} dk'**
  String distanceDrive(String distance, int minutes);

  /// No description provided for @meters.
  ///
  /// In tr, this message translates to:
  /// **'{value} m'**
  String meters(String value);

  /// No description provided for @kilometers.
  ///
  /// In tr, this message translates to:
  /// **'{value} km'**
  String kilometers(String value);

  /// No description provided for @yourHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibin'**
  String get yourHost;

  /// No description provided for @hostResponseRate.
  ///
  /// In tr, this message translates to:
  /// **'Yanıt oranı'**
  String get hostResponseRate;

  /// No description provided for @hostResponseTime.
  ///
  /// In tr, this message translates to:
  /// **'Yanıt süresi'**
  String get hostResponseTime;

  /// No description provided for @hostLanguages.
  ///
  /// In tr, this message translates to:
  /// **'Konuştuğu diller'**
  String get hostLanguages;

  /// No description provided for @hostIdentity.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik'**
  String get hostIdentity;

  /// No description provided for @hostVerified.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulandı'**
  String get hostVerified;

  /// No description provided for @hostNotVerified.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulanmadı'**
  String get hostNotVerified;

  /// No description provided for @withinHour.
  ///
  /// In tr, this message translates to:
  /// **'1 saat içinde'**
  String get withinHour;

  /// No description provided for @withinHours.
  ///
  /// In tr, this message translates to:
  /// **'{hours} saat içinde'**
  String withinHours(int hours);

  /// No description provided for @percentValue.
  ///
  /// In tr, this message translates to:
  /// **'%{value}'**
  String percentValue(int value);

  /// No description provided for @about.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get about;

  /// No description provided for @hostListings.
  ///
  /// In tr, this message translates to:
  /// **'{name}’ın bungalovları'**
  String hostListings(String name);

  /// No description provided for @ratingLabel.
  ///
  /// In tr, this message translates to:
  /// **'Puan'**
  String get ratingLabel;

  /// No description provided for @copyLink.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantıyı kopyala'**
  String get copyLink;

  /// No description provided for @linkCopied.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı kopyalandı'**
  String get linkCopied;

  /// No description provided for @shareWhatsapp.
  ///
  /// In tr, this message translates to:
  /// **'WhatsApp'**
  String get shareWhatsapp;

  /// No description provided for @shareMessages.
  ///
  /// In tr, this message translates to:
  /// **'Mesajlar'**
  String get shareMessages;

  /// No description provided for @shareEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get shareEmail;

  /// No description provided for @shareOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get shareOther;

  /// No description provided for @ratingAndRegion.
  ///
  /// In tr, this message translates to:
  /// **'{rating} · {region}'**
  String ratingAndRegion(String rating, String region);

  /// No description provided for @reportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu ilanı neden bildiriyorsun?'**
  String get reportTitle;

  /// No description provided for @reportSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimin ev sahibiyle paylaşılmaz. Ekibimiz 24 saat içinde inceler.'**
  String get reportSubtitle;

  /// No description provided for @reportInaccurate.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflar ya da bilgiler gerçeği yansıtmıyor'**
  String get reportInaccurate;

  /// No description provided for @reportFraud.
  ///
  /// In tr, this message translates to:
  /// **'Dolandırıcılık şüphesi'**
  String get reportFraud;

  /// No description provided for @reportOffPlatform.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama dışında ödeme istendi'**
  String get reportOffPlatform;

  /// No description provided for @reportSafety.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik sorunu'**
  String get reportSafety;

  /// No description provided for @reportOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get reportOther;

  /// No description provided for @reportDetails.
  ///
  /// In tr, this message translates to:
  /// **'Ayrıntı ekle (isteğe bağlı)'**
  String get reportDetails;

  /// No description provided for @reportDetailsHint.
  ///
  /// In tr, this message translates to:
  /// **'Ne gördüğünü kısaca anlat…'**
  String get reportDetailsHint;

  /// No description provided for @reportEmergency.
  ///
  /// In tr, this message translates to:
  /// **'Acil bir güvenlik durumu varsa önce 112’yi ara.'**
  String get reportEmergency;

  /// No description provided for @reportSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimi gönder'**
  String get reportSubmit;

  /// No description provided for @reportSent.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimin alındı. Teşekkürler!'**
  String get reportSent;

  /// No description provided for @saveToList.
  ///
  /// In tr, this message translates to:
  /// **'Listeye kaydet'**
  String get saveToList;

  /// No description provided for @newList.
  ///
  /// In tr, this message translates to:
  /// **'Yeni liste oluştur'**
  String get newList;

  /// No description provided for @listItems.
  ///
  /// In tr, this message translates to:
  /// **'{count} kayıt'**
  String listItems(int count);

  /// No description provided for @emptyList.
  ///
  /// In tr, this message translates to:
  /// **'Boş liste'**
  String get emptyList;

  /// No description provided for @listName.
  ///
  /// In tr, this message translates to:
  /// **'Liste adı'**
  String get listName;

  /// No description provided for @listNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn. Yaz tatili'**
  String get listNameHint;

  /// No description provided for @create.
  ///
  /// In tr, this message translates to:
  /// **'Oluştur'**
  String get create;

  /// No description provided for @lakeName.
  ///
  /// In tr, this message translates to:
  /// **'{region} Gölü'**
  String lakeName(String region);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
