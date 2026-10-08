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
  /// **'bungalovum'**
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
  /// **'Altın Bungalovum Ev Sahibi'**
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
  /// **'{date} kadar'**
  String cancelUntil(String date);

  /// No description provided for @cancelAfter.
  ///
  /// In tr, this message translates to:
  /// **'{date} sonra'**
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

  /// No description provided for @wizardContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get wizardContinue;

  /// No description provided for @wizPoolPrivate.
  ///
  /// In tr, this message translates to:
  /// **'Özel havuz'**
  String get wizPoolPrivate;

  /// No description provided for @wizPoolShared.
  ///
  /// In tr, this message translates to:
  /// **'Ortak havuz'**
  String get wizPoolShared;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get cancel;

  /// No description provided for @show.
  ///
  /// In tr, this message translates to:
  /// **'Göster'**
  String get show;

  /// No description provided for @hide.
  ///
  /// In tr, this message translates to:
  /// **'Gizle'**
  String get hide;

  /// No description provided for @start.
  ///
  /// In tr, this message translates to:
  /// **'Başla'**
  String get start;

  /// No description provided for @done.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get done;

  /// No description provided for @increase.
  ///
  /// In tr, this message translates to:
  /// **'Artır'**
  String get increase;

  /// No description provided for @decrease.
  ///
  /// In tr, this message translates to:
  /// **'Azalt'**
  String get decrease;

  /// No description provided for @tapToSet.
  ///
  /// In tr, this message translates to:
  /// **'Belirle'**
  String get tapToSet;

  /// No description provided for @draftSaved.
  ///
  /// In tr, this message translates to:
  /// **'Taslağın kaydedildi. Kaldığın yerden devam edebilirsin.'**
  String get draftSaved;

  /// No description provided for @saveAndExit.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet ve çık'**
  String get saveAndExit;

  /// No description provided for @sectionSentToReview.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedildi. Bu bölüm yeniden incelemeye alındı; ilanın yayında kalır.'**
  String get sectionSentToReview;

  /// No description provided for @sectionInReview.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden inceleniyor'**
  String get sectionInReview;

  /// No description provided for @monthFrom.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç'**
  String get monthFrom;

  /// No description provided for @monthTo.
  ///
  /// In tr, this message translates to:
  /// **'Bitiş'**
  String get monthTo;

  /// No description provided for @wizardStepOf.
  ///
  /// In tr, this message translates to:
  /// **'Adım {step} / {total}'**
  String wizardStepOf(int step, int total);

  /// No description provided for @countOf.
  ///
  /// In tr, this message translates to:
  /// **'{count} / {total}'**
  String countOf(int count, int total);

  /// No description provided for @selectedCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} seçildi'**
  String selectedCount(int count);

  /// No description provided for @rangeValue.
  ///
  /// In tr, this message translates to:
  /// **'{from} – {to}'**
  String rangeValue(String from, String to);

  /// No description provided for @sizeValue.
  ///
  /// In tr, this message translates to:
  /// **'{width} × {length}'**
  String sizeValue(String width, String length);

  /// No description provided for @metersValue.
  ///
  /// In tr, this message translates to:
  /// **'{value} m'**
  String metersValue(String value);

  /// No description provided for @celsius.
  ///
  /// In tr, this message translates to:
  /// **'{value}°C'**
  String celsius(int value);

  /// No description provided for @squareMeters.
  ///
  /// In tr, this message translates to:
  /// **'{value} m²'**
  String squareMeters(int value);

  /// No description provided for @bedroomsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =0{Yatak odası yok} other{{count} yatak odası}}'**
  String bedroomsCount(int count);

  /// No description provided for @amenitiesCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} olanak'**
  String amenitiesCount(int count);

  /// No description provided for @photoCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} fotoğraf'**
  String photoCount(int count);

  /// No description provided for @photosSummary.
  ///
  /// In tr, this message translates to:
  /// **'{count} fotoğraf · {rooms} alan'**
  String photosSummary(int count, int rooms);

  /// No description provided for @photoIndex.
  ///
  /// In tr, this message translates to:
  /// **'{index} / {total}'**
  String photoIndex(int index, int total);

  /// No description provided for @safetySummary.
  ///
  /// In tr, this message translates to:
  /// **'{count} donanım · Giriş {checkIn} · Çıkış {checkOut}'**
  String safetySummary(int count, String checkIn, String checkOut);

  /// No description provided for @permitNoShort.
  ///
  /// In tr, this message translates to:
  /// **'İzin no {no}'**
  String permitNoShort(String no);

  /// No description provided for @ibanShort.
  ///
  /// In tr, this message translates to:
  /// **'IBAN {masked}'**
  String ibanShort(String masked);

  /// No description provided for @nightsTimesPrice.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece × {price}'**
  String nightsTimesPrice(int nights, String price);

  /// No description provided for @similarRange.
  ///
  /// In tr, this message translates to:
  /// **'Benzer bungalovlar: {min} – {max}'**
  String similarRange(String min, String max);

  /// No description provided for @missingSteps.
  ///
  /// In tr, this message translates to:
  /// **'{count} adım eksik'**
  String missingSteps(int count);

  /// No description provided for @todayAt.
  ///
  /// In tr, this message translates to:
  /// **'Bugün {time}'**
  String todayAt(String time);

  /// No description provided for @addPhotoTo.
  ///
  /// In tr, this message translates to:
  /// **'{room} için fotoğraf ekle'**
  String addPhotoTo(String room);

  /// No description provided for @removeItem.
  ///
  /// In tr, this message translates to:
  /// **'{item} maddesini sil'**
  String removeItem(String item);

  /// No description provided for @bedDouble.
  ///
  /// In tr, this message translates to:
  /// **'{count} çift kişilik'**
  String bedDouble(int count);

  /// No description provided for @bedSingle.
  ///
  /// In tr, this message translates to:
  /// **'{count} tek kişilik'**
  String bedSingle(int count);

  /// No description provided for @bedSofa.
  ///
  /// In tr, this message translates to:
  /// **'{count} tek kişilik kanepe'**
  String bedSofa(int count);

  /// No description provided for @bedBunk.
  ///
  /// In tr, this message translates to:
  /// **'{count} ranza'**
  String bedBunk(int count);

  /// No description provided for @wizHighlights.
  ///
  /// In tr, this message translates to:
  /// **'Öne çıkan {count} özellik'**
  String wizHighlights(int count);

  /// No description provided for @wizHighlightsFull.
  ///
  /// In tr, this message translates to:
  /// **'En fazla {count} özellik seçebilirsin. Önce birini kaldır.'**
  String wizHighlightsFull(int count);

  /// No description provided for @wizPhotosRule.
  ///
  /// In tr, this message translates to:
  /// **'En az {min} · Önerilen {recommended}+'**
  String wizPhotosRule(int min, int recommended);

  /// No description provided for @hostProgram.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi programı'**
  String get hostProgram;

  /// No description provided for @hostHeroTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovun boş kalmasın'**
  String get hostHeroTitle;

  /// No description provided for @hostHeroBody.
  ///
  /// In tr, this message translates to:
  /// **'Doğa kaçamağı arayan misafirlerle buluş. Takvimini, fiyatını ve kurallarını sen belirle.'**
  String get hostHeroBody;

  /// No description provided for @hostStep1.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovunu anlat'**
  String get hostStep1;

  /// No description provided for @hostStep1Body.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflar, havuz, olanaklar ve kurallar'**
  String get hostStep1Body;

  /// No description provided for @hostStep2.
  ///
  /// In tr, this message translates to:
  /// **'Belgelerini ekle'**
  String get hostStep2;

  /// No description provided for @hostStep2Body.
  ///
  /// In tr, this message translates to:
  /// **'İzin belgesi, kimlik ve ödeme bilgileri'**
  String get hostStep2Body;

  /// No description provided for @hostStep3.
  ///
  /// In tr, this message translates to:
  /// **'İncelemeden sonra yayına al'**
  String get hostStep3;

  /// No description provided for @hostStep3Body.
  ///
  /// In tr, this message translates to:
  /// **'Ekibimiz 1–2 iş günü içinde kontrol eder'**
  String get hostStep3Body;

  /// No description provided for @hostPrepTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başlamadan hazırla'**
  String get hostPrepTitle;

  /// No description provided for @hostPrep1.
  ///
  /// In tr, this message translates to:
  /// **'Turizm amaçlı kiralama izin belgesi (veya işletme belgesi)'**
  String get hostPrep1;

  /// No description provided for @hostPrep2.
  ///
  /// In tr, this message translates to:
  /// **'Tapu ya da malik izin yazısı'**
  String get hostPrep2;

  /// No description provided for @hostPrep3.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik kartın ve kendi adına IBAN'**
  String get hostPrep3;

  /// No description provided for @hostPrep4.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 net fotoğraf'**
  String get hostPrep4;

  /// No description provided for @letsStart.
  ///
  /// In tr, this message translates to:
  /// **'Hadi başlayalım'**
  String get letsStart;

  /// No description provided for @continueWhereLeft.
  ///
  /// In tr, this message translates to:
  /// **'Kaldığın yerden devam et'**
  String get continueWhereLeft;

  /// No description provided for @stepTypeLocation.
  ///
  /// In tr, this message translates to:
  /// **'Tür, konum ve kapasite'**
  String get stepTypeLocation;

  /// No description provided for @stepBasics.
  ///
  /// In tr, this message translates to:
  /// **'Temel bilgiler'**
  String get stepBasics;

  /// No description provided for @stepPoolAmenities.
  ///
  /// In tr, this message translates to:
  /// **'Havuz ve olanaklar'**
  String get stepPoolAmenities;

  /// No description provided for @stepPhotos.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflar'**
  String get stepPhotos;

  /// No description provided for @stepTitleDescription.
  ///
  /// In tr, this message translates to:
  /// **'Başlık ve açıklama'**
  String get stepTitleDescription;

  /// No description provided for @stepSafetyRules.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik ve kurallar'**
  String get stepSafetyRules;

  /// No description provided for @stepPricing.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat ve rezervasyon'**
  String get stepPricing;

  /// No description provided for @stepCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş ve ev kılavuzu'**
  String get stepCheckIn;

  /// No description provided for @stepLegal.
  ///
  /// In tr, this message translates to:
  /// **'Yasal belgeler'**
  String get stepLegal;

  /// No description provided for @stepIdentityPayout.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik ve ödeme'**
  String get stepIdentityPayout;

  /// No description provided for @wizTypeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovun nasıl bir yer?'**
  String get wizTypeTitle;

  /// No description provided for @wizTypeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafirlerin aramada seni doğru kategoride bulsun.'**
  String get wizTypeSubtitle;

  /// No description provided for @wizTypeSection.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov türü'**
  String get wizTypeSection;

  /// No description provided for @wizSettingSection.
  ///
  /// In tr, this message translates to:
  /// **'Çevresi'**
  String get wizSettingSection;

  /// No description provided for @wizAddressSection.
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get wizAddressSection;

  /// No description provided for @wizAddressLabel.
  ///
  /// In tr, this message translates to:
  /// **'Açık adres'**
  String get wizAddressLabel;

  /// No description provided for @wizCity.
  ///
  /// In tr, this message translates to:
  /// **'İl'**
  String get wizCity;

  /// No description provided for @wizDistrict.
  ///
  /// In tr, this message translates to:
  /// **'İlçe'**
  String get wizDistrict;

  /// No description provided for @wizPinHint.
  ///
  /// In tr, this message translates to:
  /// **'Pini sürükleyerek konumu düzelt'**
  String get wizPinHint;

  /// No description provided for @wizAddressPrivacy.
  ///
  /// In tr, this message translates to:
  /// **'Tam adres yalnızca rezervasyonu onaylanan misafirle paylaşılır.'**
  String get wizAddressPrivacy;

  /// No description provided for @wizBasicsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaç kişi ağırlayabilirsin?'**
  String get wizBasicsTitle;

  /// No description provided for @wizBasicsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu bilgiler ilan detayındaki özellik kutucuklarında görünür.'**
  String get wizBasicsSubtitle;

  /// No description provided for @wizGuests.
  ///
  /// In tr, this message translates to:
  /// **'Misafir'**
  String get wizGuests;

  /// No description provided for @wizGuestsHint.
  ///
  /// In tr, this message translates to:
  /// **'En fazla kaç kişi kalabilir?'**
  String get wizGuestsHint;

  /// No description provided for @wizBedrooms.
  ///
  /// In tr, this message translates to:
  /// **'Yatak odası'**
  String get wizBedrooms;

  /// No description provided for @wizBeds.
  ///
  /// In tr, this message translates to:
  /// **'Yatak'**
  String get wizBeds;

  /// No description provided for @wizBathrooms.
  ///
  /// In tr, this message translates to:
  /// **'Banyo'**
  String get wizBathrooms;

  /// No description provided for @wizBedTypes.
  ///
  /// In tr, this message translates to:
  /// **'Yatak tipleri'**
  String get wizBedTypes;

  /// No description provided for @wizAddBed.
  ///
  /// In tr, this message translates to:
  /// **'Yatak ekle'**
  String get wizAddBed;

  /// No description provided for @wizSize.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov büyüklüğü'**
  String get wizSize;

  /// No description provided for @wizIndoorM2.
  ///
  /// In tr, this message translates to:
  /// **'Kapalı alan (m²)'**
  String get wizIndoorM2;

  /// No description provided for @wizGardenM2.
  ///
  /// In tr, this message translates to:
  /// **'Bahçe (m²)'**
  String get wizGardenM2;

  /// No description provided for @wizWholePlace.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovun tamamı mı?'**
  String get wizWholePlace;

  /// No description provided for @wizWholePlaceYes.
  ///
  /// In tr, this message translates to:
  /// **'Tamamı misafire ait'**
  String get wizWholePlaceYes;

  /// No description provided for @wizSharedGarden.
  ///
  /// In tr, this message translates to:
  /// **'Ortak bahçe'**
  String get wizSharedGarden;

  /// No description provided for @wizPoolTitle.
  ///
  /// In tr, this message translates to:
  /// **'Havuzunu ve olanaklarını anlat'**
  String get wizPoolTitle;

  /// No description provided for @wizPoolSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Havuz bilgisi, misafirlerin ilan detayında ilk baktığı yerlerden biri.'**
  String get wizPoolSubtitle;

  /// No description provided for @wizHasPool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz var'**
  String get wizHasPool;

  /// No description provided for @wizHeated.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmalı'**
  String get wizHeated;

  /// No description provided for @wizPoolTemp.
  ///
  /// In tr, this message translates to:
  /// **'Sıcaklık'**
  String get wizPoolTemp;

  /// No description provided for @wizPoolDepth.
  ///
  /// In tr, this message translates to:
  /// **'Derinlik'**
  String get wizPoolDepth;

  /// No description provided for @wizPoolSize.
  ///
  /// In tr, this message translates to:
  /// **'Boyut'**
  String get wizPoolSize;

  /// No description provided for @wizPoolSeason.
  ///
  /// In tr, this message translates to:
  /// **'Açık olduğu aylar'**
  String get wizPoolSeason;

  /// No description provided for @wizMin.
  ///
  /// In tr, this message translates to:
  /// **'En az (m)'**
  String get wizMin;

  /// No description provided for @wizMax.
  ///
  /// In tr, this message translates to:
  /// **'En çok (m)'**
  String get wizMax;

  /// No description provided for @wizWidth.
  ///
  /// In tr, this message translates to:
  /// **'En (m)'**
  String get wizWidth;

  /// No description provided for @wizLength.
  ///
  /// In tr, this message translates to:
  /// **'Boy (m)'**
  String get wizLength;

  /// No description provided for @wizAmenities.
  ///
  /// In tr, this message translates to:
  /// **'Olanaklar'**
  String get wizAmenities;

  /// No description provided for @wheelHint.
  ///
  /// In tr, this message translates to:
  /// **'Kaydır ya da ortadaki değere dokunup yaz'**
  String get wheelHint;

  /// No description provided for @minCharsHint.
  ///
  /// In tr, this message translates to:
  /// **'Devam etmek için en az {min} karakter yaz · {count} / {min}'**
  String minCharsHint(int count, int min);

  /// No description provided for @wheelUnitCelsius.
  ///
  /// In tr, this message translates to:
  /// **'°C'**
  String get wheelUnitCelsius;

  /// No description provided for @wheelUnitPercent.
  ///
  /// In tr, this message translates to:
  /// **'%'**
  String get wheelUnitPercent;

  /// No description provided for @wheelUnitNights.
  ///
  /// In tr, this message translates to:
  /// **'gece'**
  String get wheelUnitNights;

  /// No description provided for @poolHeatedShort.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmalı'**
  String get poolHeatedShort;

  /// No description provided for @wizPhotosTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflarını ekle'**
  String get wizPhotosTitle;

  /// No description provided for @wizPhotosSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Odalara göre yükle; misafirler fotoğraf turunda aynı sırayla görür.'**
  String get wizPhotosSubtitle;

  /// No description provided for @coverPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Kapak fotoğrafı'**
  String get coverPhoto;

  /// No description provided for @photoActions.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf seçenekleri'**
  String get photoActions;

  /// No description provided for @makeCover.
  ///
  /// In tr, this message translates to:
  /// **'Kapak fotoğrafı yap'**
  String get makeCover;

  /// No description provided for @moveEarlier.
  ///
  /// In tr, this message translates to:
  /// **'Öne al'**
  String get moveEarlier;

  /// No description provided for @moveLater.
  ///
  /// In tr, this message translates to:
  /// **'Sona al'**
  String get moveLater;

  /// No description provided for @deletePhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafı sil'**
  String get deletePhoto;

  /// No description provided for @errorPhotoUpload.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf yüklenemedi. Bağlantını kontrol edip tekrar dene.'**
  String get errorPhotoUpload;

  /// No description provided for @wizPhotosTip.
  ///
  /// In tr, this message translates to:
  /// **'Gün ışığında, yatay çekilmiş fotoğraflar daha çok tıklanır. Havuzun akşam aydınlatmalı halini de ekle.'**
  String get wizPhotosTip;

  /// No description provided for @wizTitleTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovunu anlat'**
  String get wizTitleTitle;

  /// No description provided for @wizTitleSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu metinler ilan detayında ve açıklama panelinde görünür.'**
  String get wizTitleSubtitle;

  /// No description provided for @wizListingTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlan başlığı'**
  String get wizListingTitle;

  /// No description provided for @wizTitleLabel.
  ///
  /// In tr, this message translates to:
  /// **'Başlık'**
  String get wizTitleLabel;

  /// No description provided for @wizTitleHint.
  ///
  /// In tr, this message translates to:
  /// **'Kısa ve akılda kalıcı olsun; konumu ve en güçlü özelliği vurgula.'**
  String get wizTitleHint;

  /// No description provided for @wizDescription.
  ///
  /// In tr, this message translates to:
  /// **'Açıklama'**
  String get wizDescription;

  /// No description provided for @wizSpace.
  ///
  /// In tr, this message translates to:
  /// **'Mekân'**
  String get wizSpace;

  /// No description provided for @wizGuestAccess.
  ///
  /// In tr, this message translates to:
  /// **'Misafir erişimi'**
  String get wizGuestAccess;

  /// No description provided for @wizOtherNotes.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmesi gerekenler'**
  String get wizOtherNotes;

  /// No description provided for @tagLakeView.
  ///
  /// In tr, this message translates to:
  /// **'Göl manzarası'**
  String get tagLakeView;

  /// No description provided for @tagHeatedPool.
  ///
  /// In tr, this message translates to:
  /// **'Isıtmalı havuz'**
  String get tagHeatedPool;

  /// No description provided for @tagSelfCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Kendi kendine giriş'**
  String get tagSelfCheckIn;

  /// No description provided for @tagInForest.
  ///
  /// In tr, this message translates to:
  /// **'Orman içinde'**
  String get tagInForest;

  /// No description provided for @tagSunsetTerrace.
  ///
  /// In tr, this message translates to:
  /// **'Gün batımı terası'**
  String get tagSunsetTerrace;

  /// No description provided for @tagQuietArea.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz bölge'**
  String get tagQuietArea;

  /// No description provided for @wizSafetyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik ve ev kuralları'**
  String get wizSafetyTitle;

  /// No description provided for @wizSafetySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafirler bunları rezervasyondan önce “Bilinmesi gerekenler” bölümünde görür.'**
  String get wizSafetySubtitle;

  /// No description provided for @wizSafetyGear.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik donanımı'**
  String get wizSafetyGear;

  /// No description provided for @wizCoNote.
  ///
  /// In tr, this message translates to:
  /// **'Şömine, soba veya gazlı ısıtıcı varsa şiddetle önerilir'**
  String get wizCoNote;

  /// No description provided for @wizPoolFenceNote.
  ///
  /// In tr, this message translates to:
  /// **'Çocuklu misafirler için önemli'**
  String get wizPoolFenceNote;

  /// No description provided for @wizCameraNote.
  ///
  /// In tr, this message translates to:
  /// **'Varsa yerini belirtmelisin. İç mekânda kameraya izin verilmez.'**
  String get wizCameraNote;

  /// No description provided for @safetyPoolFence.
  ///
  /// In tr, this message translates to:
  /// **'Havuz çiti veya güvenlik kapağı'**
  String get safetyPoolFence;

  /// No description provided for @wizCameraLocation.
  ///
  /// In tr, this message translates to:
  /// **'Kameranın yeri'**
  String get wizCameraLocation;

  /// No description provided for @wizCameraLocationRequired.
  ///
  /// In tr, this message translates to:
  /// **'Dış kameranın yerini yazman gerekiyor.'**
  String get wizCameraLocationRequired;

  /// No description provided for @wizPoolSafety.
  ///
  /// In tr, this message translates to:
  /// **'Havuz güvenliği'**
  String get wizPoolSafety;

  /// No description provided for @wizNoLifeguard.
  ///
  /// In tr, this message translates to:
  /// **'Havuzda cankurtaran olmadığını misafire bildiriyorum'**
  String get wizNoLifeguard;

  /// No description provided for @wizDepthMarked.
  ///
  /// In tr, this message translates to:
  /// **'Havuz derinliği havuz başında yazılı'**
  String get wizDepthMarked;

  /// No description provided for @wizHouseRules.
  ///
  /// In tr, this message translates to:
  /// **'Ev kuralları'**
  String get wizHouseRules;

  /// No description provided for @checkInTime.
  ///
  /// In tr, this message translates to:
  /// **'Giriş saati'**
  String get checkInTime;

  /// No description provided for @checkOutTime.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış saati'**
  String get checkOutTime;

  /// No description provided for @wizPets.
  ///
  /// In tr, this message translates to:
  /// **'Evcil hayvan kabul edilir'**
  String get wizPets;

  /// No description provided for @wizSmoking.
  ///
  /// In tr, this message translates to:
  /// **'Kapalı alanda sigara içilebilir'**
  String get wizSmoking;

  /// No description provided for @wizEvents.
  ///
  /// In tr, this message translates to:
  /// **'Etkinlik ve parti'**
  String get wizEvents;

  /// No description provided for @wizQuietHours.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz saatler'**
  String get wizQuietHours;

  /// No description provided for @wizPriceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fiyatını ve rezervasyon tercihini belirle'**
  String get wizPriceTitle;

  /// No description provided for @wizPriceSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Fiyatı istediğin zaman takvimden gün gün değiştirebilirsin.'**
  String get wizPriceSubtitle;

  /// No description provided for @nightlyPrice.
  ///
  /// In tr, this message translates to:
  /// **'Gecelik fiyat'**
  String get nightlyPrice;

  /// No description provided for @weekendPrice.
  ///
  /// In tr, this message translates to:
  /// **'Hafta sonu'**
  String get weekendPrice;

  /// No description provided for @cleaningFee.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik ücreti'**
  String get cleaningFee;

  /// No description provided for @weeklyDiscount.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık indirim'**
  String get weeklyDiscount;

  /// No description provided for @minNights.
  ///
  /// In tr, this message translates to:
  /// **'En az konaklama'**
  String get minNights;

  /// No description provided for @earningsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafir ne öder, sana ne kalır?'**
  String get earningsTitle;

  /// No description provided for @serviceFeeExample.
  ///
  /// In tr, this message translates to:
  /// **'Hizmet bedeli (örnek oran)'**
  String get serviceFeeExample;

  /// No description provided for @youEarn.
  ///
  /// In tr, this message translates to:
  /// **'Sana kalan (tahmini)'**
  String get youEarn;

  /// No description provided for @earningsNote.
  ///
  /// In tr, this message translates to:
  /// **'Komisyon oranı ve vergiler netleşince burada gerçek değer görünecek.'**
  String get earningsNote;

  /// No description provided for @wizBookingType.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon tipi'**
  String get wizBookingType;

  /// No description provided for @instantBook.
  ///
  /// In tr, this message translates to:
  /// **'Anında onay'**
  String get instantBook;

  /// No description provided for @instantBookBody.
  ///
  /// In tr, this message translates to:
  /// **'Misafir müsait günlerde doğrudan rezervasyon yapar. Aramada daha üstte çıkarsın.'**
  String get instantBookBody;

  /// No description provided for @requestBook.
  ///
  /// In tr, this message translates to:
  /// **'Benim onayımla'**
  String get requestBook;

  /// No description provided for @requestBookBody.
  ///
  /// In tr, this message translates to:
  /// **'Her talebi 24 saat içinde onaylar ya da reddedersin.'**
  String get requestBookBody;

  /// No description provided for @instantBookShort.
  ///
  /// In tr, this message translates to:
  /// **'Anında onay'**
  String get instantBookShort;

  /// No description provided for @requestBookShort.
  ///
  /// In tr, this message translates to:
  /// **'Onaylı talep'**
  String get requestBookShort;

  /// No description provided for @policyFlexible.
  ///
  /// In tr, this message translates to:
  /// **'Esnek'**
  String get policyFlexible;

  /// No description provided for @policyFlexibleBody.
  ///
  /// In tr, this message translates to:
  /// **'Girişten 24 saat öncesine kadar tam iade'**
  String get policyFlexibleBody;

  /// No description provided for @policyModerate.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get policyModerate;

  /// No description provided for @policyModerateBody.
  ///
  /// In tr, this message translates to:
  /// **'Girişten 5 gün öncesine kadar tam iade'**
  String get policyModerateBody;

  /// No description provided for @policyStrict.
  ///
  /// In tr, this message translates to:
  /// **'Katı'**
  String get policyStrict;

  /// No description provided for @policyStrictBody.
  ///
  /// In tr, this message translates to:
  /// **'7 gün öncesine kadar %50 iade'**
  String get policyStrictBody;

  /// No description provided for @availabilityCalendar.
  ///
  /// In tr, this message translates to:
  /// **'Müsaitlik takvimi'**
  String get availabilityCalendar;

  /// No description provided for @availabilityCalendarSub.
  ///
  /// In tr, this message translates to:
  /// **'Dolu günleri ve özel fiyatları işaretle'**
  String get availabilityCalendarSub;

  /// No description provided for @calendar.
  ///
  /// In tr, this message translates to:
  /// **'Takvim'**
  String get calendar;

  /// No description provided for @calendarSoon.
  ///
  /// In tr, this message translates to:
  /// **'Takvim yönetimi çok yakında burada olacak.'**
  String get calendarSoon;

  /// No description provided for @wizCheckInTitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafirin içeri nasıl girecek?'**
  String get wizCheckInTitle;

  /// No description provided for @wizCheckInSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu bilgiler yalnızca onaylı misafire, girişten bir gün önce görünür.'**
  String get wizCheckInSubtitle;

  /// No description provided for @wizCheckInMethod.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yöntemi'**
  String get wizCheckInMethod;

  /// No description provided for @checkInKeybox.
  ///
  /// In tr, this message translates to:
  /// **'Anahtar kutusu'**
  String get checkInKeybox;

  /// No description provided for @checkInSmartLock.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı kilit'**
  String get checkInSmartLock;

  /// No description provided for @checkInInPerson.
  ///
  /// In tr, this message translates to:
  /// **'Ben karşılarım'**
  String get checkInInPerson;

  /// No description provided for @wizCheckInInfo.
  ///
  /// In tr, this message translates to:
  /// **'Giriş bilgileri'**
  String get wizCheckInInfo;

  /// No description provided for @smartLockCode.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı kilit kodu'**
  String get smartLockCode;

  /// No description provided for @lockboxPlace.
  ///
  /// In tr, this message translates to:
  /// **'Kutunun yeri'**
  String get lockboxPlace;

  /// No description provided for @wifiName.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi adı'**
  String get wifiName;

  /// No description provided for @wifiPassword.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi şifresi'**
  String get wifiPassword;

  /// No description provided for @wifiShort.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi'**
  String get wifiShort;

  /// No description provided for @checkoutListShort.
  ///
  /// In tr, this message translates to:
  /// **'çıkış listesi'**
  String get checkoutListShort;

  /// No description provided for @wizInstructions.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım talimatları'**
  String get wizInstructions;

  /// No description provided for @wizPoolInstructions.
  ///
  /// In tr, this message translates to:
  /// **'Havuz ve jakuzi'**
  String get wizPoolInstructions;

  /// No description provided for @wizHouseInstructions.
  ///
  /// In tr, this message translates to:
  /// **'Ev düzeni'**
  String get wizHouseInstructions;

  /// No description provided for @wizCheckoutList.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış listesi'**
  String get wizCheckoutList;

  /// No description provided for @wizCheckoutItem.
  ///
  /// In tr, this message translates to:
  /// **'Madde'**
  String get wizCheckoutItem;

  /// No description provided for @addItem.
  ///
  /// In tr, this message translates to:
  /// **'Madde ekle'**
  String get addItem;

  /// No description provided for @wizLegalTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yasal belgelerini ekle'**
  String get wizLegalTitle;

  /// No description provided for @wizLegalSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Belgeler yalnızca ekibimiz tarafından incelenir, misafirlerle paylaşılmaz.'**
  String get wizLegalSubtitle;

  /// No description provided for @wizLegalLaw.
  ///
  /// In tr, this message translates to:
  /// **'7464 sayılı Kanun gereği konutunu turizm amaçlı kiralamak için Kültür ve Turizm Bakanlığı’ndan izin belgesi alman gerekir. Belgesiz ilanlar yayına alınmaz.'**
  String get wizLegalLaw;

  /// No description provided for @wizPermitType.
  ///
  /// In tr, this message translates to:
  /// **'Belge türü'**
  String get wizPermitType;

  /// No description provided for @permitTourismRental.
  ///
  /// In tr, this message translates to:
  /// **'Turizm amaçlı kiralama izin belgesi'**
  String get permitTourismRental;

  /// No description provided for @permitTourismRentalBody.
  ///
  /// In tr, this message translates to:
  /// **'e-Devlet üzerinden Bakanlıktan alınır'**
  String get permitTourismRentalBody;

  /// No description provided for @permitTourismOperation.
  ///
  /// In tr, this message translates to:
  /// **'Turizm işletme belgesi'**
  String get permitTourismOperation;

  /// No description provided for @permitTourismOperationBody.
  ///
  /// In tr, this message translates to:
  /// **'Bakanlık belgeli tesisler için'**
  String get permitTourismOperationBody;

  /// No description provided for @permitMunicipal.
  ///
  /// In tr, this message translates to:
  /// **'Belediye işletme ruhsatı'**
  String get permitMunicipal;

  /// No description provided for @permitMunicipalBody.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov tesisi olarak ruhsatlıysan'**
  String get permitMunicipalBody;

  /// No description provided for @wizPermitInfo.
  ///
  /// In tr, this message translates to:
  /// **'Belge bilgileri'**
  String get wizPermitInfo;

  /// No description provided for @permitNoLabel.
  ///
  /// In tr, this message translates to:
  /// **'İzin belge numarası'**
  String get permitNoLabel;

  /// No description provided for @permitNoHint.
  ///
  /// In tr, this message translates to:
  /// **'Bu numara ilan sayfanda “İzin belge no” olarak görünür.'**
  String get permitNoHint;

  /// No description provided for @noPermitHow.
  ///
  /// In tr, this message translates to:
  /// **'Belgem yok, nasıl alırım?'**
  String get noPermitHow;

  /// No description provided for @wizDocuments.
  ///
  /// In tr, this message translates to:
  /// **'Belgeler'**
  String get wizDocuments;

  /// No description provided for @docPermit.
  ///
  /// In tr, this message translates to:
  /// **'İzin belgesi'**
  String get docPermit;

  /// No description provided for @docPermitBody.
  ///
  /// In tr, this message translates to:
  /// **'PDF veya fotoğraf'**
  String get docPermitBody;

  /// No description provided for @docDeed.
  ///
  /// In tr, this message translates to:
  /// **'Tapu'**
  String get docDeed;

  /// No description provided for @docDeedBody.
  ///
  /// In tr, this message translates to:
  /// **'Kiracıysan kira sözleşmesi + malik izni'**
  String get docDeedBody;

  /// No description provided for @docCondo.
  ///
  /// In tr, this message translates to:
  /// **'Kat malikleri oy birliği kararı'**
  String get docCondo;

  /// No description provided for @docCondoBody.
  ///
  /// In tr, this message translates to:
  /// **'Aynı parselde birden fazla bağımsız bölüm varsa'**
  String get docCondoBody;

  /// No description provided for @docAttorney.
  ///
  /// In tr, this message translates to:
  /// **'Vekaletname'**
  String get docAttorney;

  /// No description provided for @docAttorneyBody.
  ///
  /// In tr, this message translates to:
  /// **'Başvuruyu malik adına yapıyorsan'**
  String get docAttorneyBody;

  /// No description provided for @docPlate.
  ///
  /// In tr, this message translates to:
  /// **'Plaka girişte asılı'**
  String get docPlate;

  /// No description provided for @docPlateBody.
  ///
  /// In tr, this message translates to:
  /// **'Bakanlığın verdiği plakanın giriş kapısında görünür olduğunu gösteren bir fotoğraf ekle.'**
  String get docPlateBody;

  /// No description provided for @docUpload.
  ///
  /// In tr, this message translates to:
  /// **'Yükle'**
  String get docUpload;

  /// No description provided for @docReplace.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden yükle'**
  String get docReplace;

  /// No description provided for @docUploaded.
  ///
  /// In tr, this message translates to:
  /// **'Belge yüklendi'**
  String get docUploaded;

  /// No description provided for @docUploadedShort.
  ///
  /// In tr, this message translates to:
  /// **'Yüklendi'**
  String get docUploadedShort;

  /// No description provided for @errorDocUpload.
  ///
  /// In tr, this message translates to:
  /// **'Belge yüklenemedi. Bağlantını kontrol edip tekrar dene.'**
  String get errorDocUpload;

  /// No description provided for @ifNeeded.
  ///
  /// In tr, this message translates to:
  /// **'Gerekirse'**
  String get ifNeeded;

  /// No description provided for @wizEntrancePlate.
  ///
  /// In tr, this message translates to:
  /// **'Bina girişi plakası'**
  String get wizEntrancePlate;

  /// No description provided for @wizResponsibilities.
  ///
  /// In tr, this message translates to:
  /// **'Sorumluluklarım'**
  String get wizResponsibilities;

  /// No description provided for @declKbs.
  ///
  /// In tr, this message translates to:
  /// **'Misafir kimliklerini Kimlik Bildirim Sistemi’ne bildireceğim'**
  String get declKbs;

  /// No description provided for @declKbsBody.
  ///
  /// In tr, this message translates to:
  /// **'1774 sayılı Kanun gereği bildirim yükümlülüğü izin belgesi sahibindedir'**
  String get declKbsBody;

  /// No description provided for @declPermitHolder.
  ///
  /// In tr, this message translates to:
  /// **'Kiralamayı izin belgesi sahibi olarak ben yapıyorum'**
  String get declPermitHolder;

  /// No description provided for @declPermitHolderBody.
  ///
  /// In tr, this message translates to:
  /// **'Belge devredilemez, konut başkasına alt kiraya verilemez'**
  String get declPermitHolderBody;

  /// No description provided for @declUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Belge bilgilerim değişirse 30 gün içinde güncelleyeceğim'**
  String get declUpdate;

  /// No description provided for @wizTaxInfo.
  ///
  /// In tr, this message translates to:
  /// **'Vergi bilgileri'**
  String get wizTaxInfo;

  /// No description provided for @taxIndividual.
  ///
  /// In tr, this message translates to:
  /// **'Şahıs'**
  String get taxIndividual;

  /// No description provided for @taxCompany.
  ///
  /// In tr, this message translates to:
  /// **'Şirket'**
  String get taxCompany;

  /// No description provided for @tcknLabel.
  ///
  /// In tr, this message translates to:
  /// **'T.C. kimlik no'**
  String get tcknLabel;

  /// No description provided for @taxNoLabel.
  ///
  /// In tr, this message translates to:
  /// **'Vergi numarası'**
  String get taxNoLabel;

  /// No description provided for @taxOffice.
  ///
  /// In tr, this message translates to:
  /// **'Vergi dairesi'**
  String get taxOffice;

  /// No description provided for @taxNote.
  ///
  /// In tr, this message translates to:
  /// **'Kira gelirin ticari kazanç olarak vergilendirilebilir. Doğru beyan için mali müşavirine danışmanı öneririz.'**
  String get taxNote;

  /// No description provided for @wizIdentityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kimliğini doğrula, ödeme bilgini ekle'**
  String get wizIdentityTitle;

  /// No description provided for @wizIdentitySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kazancın yalnızca doğrulanmış ve kendi adına olan hesaba gönderilir.'**
  String get wizIdentitySubtitle;

  /// No description provided for @wizIdentity.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik doğrulama'**
  String get wizIdentity;

  /// No description provided for @idFront.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik kartı ön yüz'**
  String get idFront;

  /// No description provided for @idFrontBody.
  ///
  /// In tr, this message translates to:
  /// **'Çipli T.C. kimlik kartı'**
  String get idFrontBody;

  /// No description provided for @idBack.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik kartı arka yüz'**
  String get idBack;

  /// No description provided for @idBackBody.
  ///
  /// In tr, this message translates to:
  /// **'Işık yansımasın'**
  String get idBackBody;

  /// No description provided for @idSelfie.
  ///
  /// In tr, this message translates to:
  /// **'Selfie'**
  String get idSelfie;

  /// No description provided for @idSelfieBody.
  ///
  /// In tr, this message translates to:
  /// **'Yüzün kimlikle eşleşmeli'**
  String get idSelfieBody;

  /// No description provided for @errorIdentity.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafı doğrulayamadık. İyi ışıkta, net bir fotoğrafla tekrar dene.'**
  String get errorIdentity;

  /// No description provided for @wizPayout.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme alma'**
  String get wizPayout;

  /// No description provided for @accountHolder.
  ///
  /// In tr, this message translates to:
  /// **'Hesap sahibi'**
  String get accountHolder;

  /// No description provided for @ibanLabel.
  ///
  /// In tr, this message translates to:
  /// **'IBAN'**
  String get ibanLabel;

  /// No description provided for @ibanHint.
  ///
  /// In tr, this message translates to:
  /// **'TR00 0000 0000 0000 0000 0000 00'**
  String get ibanHint;

  /// No description provided for @ibanNote.
  ///
  /// In tr, this message translates to:
  /// **'IBAN senin adına olmalı. Ödemeler misafirin girişinden 24 saat sonra aktarılır.'**
  String get ibanNote;

  /// No description provided for @errorIban.
  ///
  /// In tr, this message translates to:
  /// **'Bu IBAN geçerli görünmüyor. Rakamları kontrol et.'**
  String get errorIban;

  /// No description provided for @errorIbanHolder.
  ///
  /// In tr, this message translates to:
  /// **'Hesap sahibi, doğrulanan kimliğindeki adla aynı olmalı.'**
  String get errorIbanHolder;

  /// No description provided for @identityRejected.
  ///
  /// In tr, this message translates to:
  /// **'Kimliğini doğrulayamadık. Üç fotoğrafı iyi ışıkta yeniden çek.'**
  String get identityRejected;

  /// No description provided for @errorListingIncomplete.
  ///
  /// In tr, this message translates to:
  /// **'Bazı adımlarda eksik bilgi var. Önizlemedeki işaretli bölümleri tamamla.'**
  String get errorListingIncomplete;

  /// No description provided for @errorConsents.
  ///
  /// In tr, this message translates to:
  /// **'Göndermeden önce üç onayı da işaretle.'**
  String get errorConsents;

  /// No description provided for @errorListingInReview.
  ///
  /// In tr, this message translates to:
  /// **'İlanın incelemede. İnceleme bitince düzenleyebilirsin.'**
  String get errorListingInReview;

  /// No description provided for @errorTaxId.
  ///
  /// In tr, this message translates to:
  /// **'Vergi bilgisini kontrol et; numara geçerli görünmüyor.'**
  String get errorTaxId;

  /// No description provided for @errorUnpublishBookings.
  ///
  /// In tr, this message translates to:
  /// **'Yaklaşan rezervasyonların var. Önce onları tamamla ya da iptal et.'**
  String get errorUnpublishBookings;

  /// No description provided for @errorSessionExpired.
  ///
  /// In tr, this message translates to:
  /// **'Oturumun sona ermiş. Tekrar giriş yapıp dene.'**
  String get errorSessionExpired;

  /// No description provided for @errorAddressNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Adresi haritada bulamadık. İl ve ilçe adını kontrol edip tekrar dene.'**
  String get errorAddressNotFound;

  /// No description provided for @errorIbanRequired.
  ///
  /// In tr, this message translates to:
  /// **'Hesap sahibini değiştirmek için IBAN\'ı da yeniden gir.'**
  String get errorIbanRequired;

  /// No description provided for @wizBillingContact.
  ///
  /// In tr, this message translates to:
  /// **'Fatura ve iletişim'**
  String get wizBillingContact;

  /// No description provided for @billingAddress.
  ///
  /// In tr, this message translates to:
  /// **'Fatura adresi'**
  String get billingAddress;

  /// No description provided for @emergencyPhone.
  ///
  /// In tr, this message translates to:
  /// **'Acil durum telefonu'**
  String get emergencyPhone;

  /// No description provided for @reachableTitle.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama sırasında misafir beni arayabilir'**
  String get reachableTitle;

  /// No description provided for @reachableBody.
  ///
  /// In tr, this message translates to:
  /// **'Ulaşılabilir ev sahipleri daha iyi puan alır'**
  String get reachableBody;

  /// No description provided for @kvkkNote.
  ///
  /// In tr, this message translates to:
  /// **'Bilgilerin KVKK kapsamında şifrelenerek saklanır ve yalnızca doğrulama ile ödeme için kullanılır.'**
  String get kvkkNote;

  /// No description provided for @goToPreview.
  ///
  /// In tr, this message translates to:
  /// **'Önizlemeye geç'**
  String get goToPreview;

  /// No description provided for @previewTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son bir kontrol'**
  String get previewTitle;

  /// No description provided for @previewSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafirler ilanını tam olarak böyle görecek.'**
  String get previewSubtitle;

  /// No description provided for @badgeNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni'**
  String get badgeNew;

  /// No description provided for @completedSteps.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlanan adımlar'**
  String get completedSteps;

  /// No description provided for @allDone.
  ///
  /// In tr, this message translates to:
  /// **'Hepsi tamam'**
  String get allDone;

  /// No description provided for @consents.
  ///
  /// In tr, this message translates to:
  /// **'Onaylar'**
  String get consents;

  /// No description provided for @consentAccuracy.
  ///
  /// In tr, this message translates to:
  /// **'Verdiğim bilgilerin doğru ve güncel olduğunu onaylıyorum'**
  String get consentAccuracy;

  /// No description provided for @consentAgreement.
  ///
  /// In tr, this message translates to:
  /// **'Ev Sahibi Sözleşmesi’ni ve ayrımcılık karşıtı politikayı kabul ediyorum'**
  String get consentAgreement;

  /// No description provided for @consentMinistry.
  ///
  /// In tr, this message translates to:
  /// **'Bakanlık uyarısı gelirse ilanımın yayından kaldırılabileceğini biliyorum'**
  String get consentMinistry;

  /// No description provided for @submitForReview.
  ///
  /// In tr, this message translates to:
  /// **'İncelemeye gönder'**
  String get submitForReview;

  /// No description provided for @inReviewTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlanın incelemede'**
  String get inReviewTitle;

  /// No description provided for @inReviewBody.
  ///
  /// In tr, this message translates to:
  /// **'Belgelerini ve ilan bilgilerini kontrol ediyoruz. Genellikle 1–2 iş günü sürer; sonucu bildirim ve e-posta ile ileteceğiz.'**
  String get inReviewBody;

  /// No description provided for @reviewSent.
  ///
  /// In tr, this message translates to:
  /// **'İlan gönderildi'**
  String get reviewSent;

  /// No description provided for @reviewChecking.
  ///
  /// In tr, this message translates to:
  /// **'Belgeler kontrol ediliyor'**
  String get reviewChecking;

  /// No description provided for @reviewCheckingBody.
  ///
  /// In tr, this message translates to:
  /// **'İzin belgesi, tapu ve kimlik'**
  String get reviewCheckingBody;

  /// No description provided for @reviewPublish.
  ///
  /// In tr, this message translates to:
  /// **'Yayına alınır'**
  String get reviewPublish;

  /// No description provided for @reviewPublishBody.
  ///
  /// In tr, this message translates to:
  /// **'Keşfet’te görünmeye başlar'**
  String get reviewPublishBody;

  /// No description provided for @inReviewTip.
  ///
  /// In tr, this message translates to:
  /// **'Bu sürede takvimini doldurabilir, fiyatlarını gün gün ayarlayabilirsin.'**
  String get inReviewTip;

  /// No description provided for @homePage.
  ///
  /// In tr, this message translates to:
  /// **'Ana sayfa'**
  String get homePage;

  /// No description provided for @manageListing.
  ///
  /// In tr, this message translates to:
  /// **'İlanımı yönet'**
  String get manageListing;

  /// No description provided for @statusPublished.
  ///
  /// In tr, this message translates to:
  /// **'Yayında'**
  String get statusPublished;

  /// No description provided for @statusPaused.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyona kapalı'**
  String get statusPaused;

  /// No description provided for @statusInReview.
  ///
  /// In tr, this message translates to:
  /// **'İncelemede'**
  String get statusInReview;

  /// No description provided for @statusRejected.
  ///
  /// In tr, this message translates to:
  /// **'Düzeltme gerekli'**
  String get statusRejected;

  /// No description provided for @statusDraft.
  ///
  /// In tr, this message translates to:
  /// **'Taslak'**
  String get statusDraft;

  /// No description provided for @manageTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlanını yönet'**
  String get manageTitle;

  /// No description provided for @manageSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Değişiklikler kaydedildiği an ilan sayfana yansır.'**
  String get manageSubtitle;

  /// No description provided for @openForBooking.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyona açık'**
  String get openForBooking;

  /// No description provided for @openForBookingBody.
  ///
  /// In tr, this message translates to:
  /// **'Kapatırsan yeni rezervasyon alınmaz'**
  String get openForBookingBody;

  /// No description provided for @previewListing.
  ///
  /// In tr, this message translates to:
  /// **'İlanı önizle'**
  String get previewListing;

  /// No description provided for @groupListingPage.
  ///
  /// In tr, this message translates to:
  /// **'İlan sayfası'**
  String get groupListingPage;

  /// No description provided for @groupPriceBooking.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat ve rezervasyon'**
  String get groupPriceBooking;

  /// No description provided for @groupGuestExperience.
  ///
  /// In tr, this message translates to:
  /// **'Misafir deneyimi'**
  String get groupGuestExperience;

  /// No description provided for @groupDocsAccount.
  ///
  /// In tr, this message translates to:
  /// **'Belgeler ve hesap'**
  String get groupDocsAccount;

  /// No description provided for @identityVerification.
  ///
  /// In tr, this message translates to:
  /// **'Kimlik doğrulama'**
  String get identityVerification;

  /// No description provided for @verified.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulandı'**
  String get verified;

  /// No description provided for @notVerified.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulanmadı'**
  String get notVerified;

  /// No description provided for @payout.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme alma'**
  String get payout;

  /// No description provided for @manageReviewNote.
  ///
  /// In tr, this message translates to:
  /// **'Belge, kimlik veya IBAN bilgilerini değiştirirsen bu bölüm yeniden incelemeye alınır; ilanın yayında kalır.'**
  String get manageReviewNote;

  /// No description provided for @unpublish.
  ///
  /// In tr, this message translates to:
  /// **'İlanı yayından kaldır'**
  String get unpublish;

  /// No description provided for @unpublishTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlan yayından kalksın mı?'**
  String get unpublishTitle;

  /// No description provided for @unpublishBody.
  ///
  /// In tr, this message translates to:
  /// **'İlanın Keşfet’te görünmez ve yeni rezervasyon alınmaz. Mevcut rezervasyonların geçerli kalır; dilediğinde yeniden yayına alabilirsin.'**
  String get unpublishBody;

  /// No description provided for @unpublished.
  ///
  /// In tr, this message translates to:
  /// **'İlan yayından kaldırıldı'**
  String get unpublished;

  /// No description provided for @propertyStoneHouse.
  ///
  /// In tr, this message translates to:
  /// **'Taş ev'**
  String get propertyStoneHouse;

  /// No description provided for @propertyGlampingTent.
  ///
  /// In tr, this message translates to:
  /// **'Glamping çadırı'**
  String get propertyGlampingTent;

  /// No description provided for @propertyTinyHouse.
  ///
  /// In tr, this message translates to:
  /// **'Tiny house'**
  String get propertyTinyHouse;

  /// No description provided for @settingMountainView.
  ///
  /// In tr, this message translates to:
  /// **'Dağ manzarası'**
  String get settingMountainView;

  /// No description provided for @settingNearSea.
  ///
  /// In tr, this message translates to:
  /// **'Deniz yakını'**
  String get settingNearSea;

  /// No description provided for @systemNotifOffTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler telefonunda kapalı'**
  String get systemNotifOffTitle;

  /// No description provided for @systemNotifOffBody.
  ///
  /// In tr, this message translates to:
  /// **'Seçtiğin bildirimleri alabilmen için telefonunun bildirim iznini açman gerekiyor.'**
  String get systemNotifOffBody;

  /// No description provided for @turnOnNotifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimleri aç'**
  String get turnOnNotifications;

  /// No description provided for @offlineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ormanda kaldık galiba'**
  String get offlineTitle;

  /// No description provided for @offlineBody.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantın yok gibi görünüyor. Bağlantını kontrol edip tekrar dene.'**
  String get offlineBody;

  /// No description provided for @offlineSavedLink.
  ///
  /// In tr, this message translates to:
  /// **'Kaydettiklerini çevrimdışı gör'**
  String get offlineSavedLink;

  /// No description provided for @stillOffline.
  ///
  /// In tr, this message translates to:
  /// **'Hâlâ bağlantı yok. Biraz sonra tekrar dene.'**
  String get stillOffline;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yakınındaki kaçamakları bulalım'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionBody.
  ///
  /// In tr, this message translates to:
  /// **'Konumunu yalnızca sana yakın bungalovları ve yol sürelerini göstermek için kullanırız.'**
  String get locationPermissionBody;

  /// No description provided for @allowLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konum iznini ver'**
  String get allowLocation;

  /// No description provided for @notNow.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi değil'**
  String get notNow;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Önemli anları kaçırma'**
  String get notificationPermissionTitle;

  /// No description provided for @notificationPermissionBody.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon onayı, ev sahibi mesajları ve kaydettiğin yerlerdeki fiyat düşüşleri için haber verelim.'**
  String get notificationPermissionBody;

  /// No description provided for @enableNotifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimleri aç'**
  String get enableNotifications;

  /// No description provided for @maybeLater.
  ///
  /// In tr, this message translates to:
  /// **'Belki sonra'**
  String get maybeLater;

  /// No description provided for @permissionBlockedHint.
  ///
  /// In tr, this message translates to:
  /// **'İzni telefonunun ayarlarından açabilirsin.'**
  String get permissionBlockedHint;

  /// No description provided for @sampleNotifApprovedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonun onaylandı'**
  String get sampleNotifApprovedTitle;

  /// No description provided for @sampleNotifApprovedBody.
  ///
  /// In tr, this message translates to:
  /// **'Göl Esintisi · 6–8 Kas'**
  String get sampleNotifApprovedBody;

  /// No description provided for @sampleNotifPriceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat düştü!'**
  String get sampleNotifPriceTitle;

  /// No description provided for @sampleNotifPriceBody.
  ///
  /// In tr, this message translates to:
  /// **'Çam Yamaç ₺850 daha uygun'**
  String get sampleNotifPriceBody;

  /// No description provided for @sampleNotifMessageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibinden mesaj'**
  String get sampleNotifMessageTitle;

  /// No description provided for @sampleNotifMessageBody.
  ///
  /// In tr, this message translates to:
  /// **'“Havuz hazır olacak…”'**
  String get sampleNotifMessageBody;

  /// No description provided for @couponAlreadyAdded.
  ///
  /// In tr, this message translates to:
  /// **'Bu kupon zaten hesabında.'**
  String get couponAlreadyAdded;

  /// No description provided for @walletTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cüzdan'**
  String get walletTitle;

  /// No description provided for @groupTravelPayments.
  ///
  /// In tr, this message translates to:
  /// **'Seyahat ödemeleri'**
  String get groupTravelPayments;

  /// No description provided for @paymentMethodsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme yöntemleri'**
  String get paymentMethodsTitle;

  /// No description provided for @noSavedCards.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı kart yok'**
  String get noSavedCards;

  /// No description provided for @paymentHistoryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme geçmişi'**
  String get paymentHistoryTitle;

  /// No description provided for @paymentHistorySub.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeler ve iadeler'**
  String get paymentHistorySub;

  /// No description provided for @couponsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kuponlar'**
  String get couponsTitle;

  /// No description provided for @noActiveCoupons.
  ///
  /// In tr, this message translates to:
  /// **'Aktif kupon yok'**
  String get noActiveCoupons;

  /// No description provided for @activeCouponsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} aktif kupon'**
  String activeCouponsCount(int count);

  /// No description provided for @paymentMethodsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kartını bir kez ekle, rezervasyonlarda tek dokunuşla öde.'**
  String get paymentMethodsSubtitle;

  /// No description provided for @payInAppTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeni hep uygulamadan yap'**
  String get payInAppTitle;

  /// No description provided for @payInAppBody.
  ///
  /// In tr, this message translates to:
  /// **'Böylece rezervasyonun iptal ve iade güvencemiz kapsamında kalır.'**
  String get payInAppBody;

  /// No description provided for @payInAppLink.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl korunuyorum?'**
  String get payInAppLink;

  /// No description provided for @makeDefaultCard.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan yap'**
  String get makeDefaultCard;

  /// No description provided for @removeCard.
  ///
  /// In tr, this message translates to:
  /// **'Kartı kaldır'**
  String get removeCard;

  /// No description provided for @defaultCardSet.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan kart güncellendi'**
  String get defaultCardSet;

  /// No description provided for @cardRemoved.
  ///
  /// In tr, this message translates to:
  /// **'Kart kaldırıldı'**
  String get cardRemoved;

  /// No description provided for @addCard.
  ///
  /// In tr, this message translates to:
  /// **'Kart ekle'**
  String get addCard;

  /// No description provided for @cardBrandsAccepted.
  ///
  /// In tr, this message translates to:
  /// **'Visa · Mastercard · Troy'**
  String get cardBrandsAccepted;

  /// No description provided for @addNewCard.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kart ekle'**
  String get addNewCard;

  /// No description provided for @cardAdded.
  ///
  /// In tr, this message translates to:
  /// **'Kart eklendi'**
  String get cardAdded;

  /// No description provided for @errorCardAdd.
  ///
  /// In tr, this message translates to:
  /// **'Kart eklenemedi. Bilgileri kontrol edip tekrar dene.'**
  String get errorCardAdd;

  /// No description provided for @saveCardCta.
  ///
  /// In tr, this message translates to:
  /// **'Kartı kaydet'**
  String get saveCardCta;

  /// No description provided for @cardsStoredSafely.
  ///
  /// In tr, this message translates to:
  /// **'Kart bilgilerin ödeme kuruluşunda şifreli saklanır, bizde tutulmaz.'**
  String get cardsStoredSafely;

  /// No description provided for @paymentsTab.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeler'**
  String get paymentsTab;

  /// No description provided for @refundsTab.
  ///
  /// In tr, this message translates to:
  /// **'İadeler'**
  String get refundsTab;

  /// No description provided for @noPaymentsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz ödeme yok'**
  String get noPaymentsTitle;

  /// No description provided for @noPaymentsBody.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon yaptığında ödemelerini ve iadelerini buradan takip edebilirsin.'**
  String get noPaymentsBody;

  /// No description provided for @noRefundsTitle.
  ///
  /// In tr, this message translates to:
  /// **'İade yok'**
  String get noRefundsTitle;

  /// No description provided for @noRefundsBody.
  ///
  /// In tr, this message translates to:
  /// **'İptal ettiğin rezervasyonların iadeleri burada görünür.'**
  String get noRefundsBody;

  /// No description provided for @lookingForPaymentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başka bir ödeme mi arıyorsun?'**
  String get lookingForPaymentTitle;

  /// No description provided for @lookingForPaymentBody.
  ///
  /// In tr, this message translates to:
  /// **'Bankana yansıyan bir tutarı burada göremiyorsan bize yaz.'**
  String get lookingForPaymentBody;

  /// No description provided for @lookingForPaymentLink.
  ///
  /// In tr, this message translates to:
  /// **'Yardım merkezine göz at'**
  String get lookingForPaymentLink;

  /// No description provided for @paymentLine.
  ///
  /// In tr, this message translates to:
  /// **'{date} · {card}'**
  String paymentLine(String date, String card);

  /// No description provided for @provisionLine.
  ///
  /// In tr, this message translates to:
  /// **'{date} · Provizyon, onay bekliyor'**
  String provisionLine(String date);

  /// No description provided for @refundLine.
  ///
  /// In tr, this message translates to:
  /// **'{date} · {card} kartına iade'**
  String refundLine(String date, String card);

  /// No description provided for @refundAmount.
  ///
  /// In tr, this message translates to:
  /// **'+{amount}'**
  String refundAmount(String amount);

  /// No description provided for @couponAdded.
  ///
  /// In tr, this message translates to:
  /// **'Kupon hesabına eklendi'**
  String get couponAdded;

  /// No description provided for @applyCode.
  ///
  /// In tr, this message translates to:
  /// **'Kodu uygula'**
  String get applyCode;

  /// No description provided for @couponTermsNote.
  ///
  /// In tr, this message translates to:
  /// **'Her kuponun kullanım koşulları kupon ayrıntısında yazar.'**
  String get couponTermsNote;

  /// No description provided for @yourCoupons.
  ///
  /// In tr, this message translates to:
  /// **'Kuponların'**
  String get yourCoupons;

  /// No description provided for @couponLine.
  ///
  /// In tr, this message translates to:
  /// **'{code} · {date} tarihine kadar{days, plural, =0{} other{ · {days} gün kaldı}}'**
  String couponLine(String code, String date, int days);

  /// No description provided for @couponPercentOff.
  ///
  /// In tr, this message translates to:
  /// **'%{percent} indirim'**
  String couponPercentOff(int percent);

  /// No description provided for @groupCouponFaq.
  ///
  /// In tr, this message translates to:
  /// **'Merak edilenler'**
  String get groupCouponFaq;

  /// No description provided for @couponFaq1Q.
  ///
  /// In tr, this message translates to:
  /// **'Kuponun son kullanma tarihini nereden görürüm?'**
  String get couponFaq1Q;

  /// No description provided for @couponFaq1A.
  ///
  /// In tr, this message translates to:
  /// **'Hesabına eklediğin her kuponun altında son kullanma tarihi ve kalan gün sayısı yazar.'**
  String get couponFaq1A;

  /// No description provided for @couponFaq2Q.
  ///
  /// In tr, this message translates to:
  /// **'Bir rezervasyonda birden fazla kupon kullanabilir miyim?'**
  String get couponFaq2Q;

  /// No description provided for @couponFaq2A.
  ///
  /// In tr, this message translates to:
  /// **'Hayır. Her rezervasyonda tek kupon kullanılır ve kupon ilandaki diğer indirimlerin yerine geçer.'**
  String get couponFaq2A;

  /// No description provided for @couponFaq3Q.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonu iptal edersem kuponum geri gelir mi?'**
  String get couponFaq3Q;

  /// No description provided for @couponFaq3A.
  ///
  /// In tr, this message translates to:
  /// **'Kuponun süresi dolmadıysa iptalden sonra hesabına geri yüklenir ve yeniden kullanabilirsin.'**
  String get couponFaq3A;

  /// No description provided for @helpSearchLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yardım ara'**
  String get helpSearchLabel;

  /// No description provided for @accountTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabım'**
  String get accountTitle;

  /// No description provided for @memberSince.
  ///
  /// In tr, this message translates to:
  /// **'Misafir · {year}’ten beri'**
  String memberSince(String year);

  /// No description provided for @viewProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profili gör'**
  String get viewProfile;

  /// No description provided for @statStays.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama'**
  String get statStays;

  /// No description provided for @statReviews.
  ///
  /// In tr, this message translates to:
  /// **'Yorum'**
  String get statReviews;

  /// No description provided for @statSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı'**
  String get statSaved;

  /// No description provided for @hostCtaTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovunu kirala'**
  String get hostCtaTitle;

  /// No description provided for @hostCtaBody.
  ///
  /// In tr, this message translates to:
  /// **'Boş günlerini kazanca çevir. İlanını 10 adımda oluştur.'**
  String get hostCtaBody;

  /// No description provided for @groupAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesap'**
  String get groupAccount;

  /// No description provided for @groupSupport.
  ///
  /// In tr, this message translates to:
  /// **'Destek'**
  String get groupSupport;

  /// No description provided for @rowPersonalInfo.
  ///
  /// In tr, this message translates to:
  /// **'Bilgilerim'**
  String get rowPersonalInfo;

  /// No description provided for @rowPersonalInfoSub.
  ///
  /// In tr, this message translates to:
  /// **'Ad, iletişim, adres'**
  String get rowPersonalInfoSub;

  /// No description provided for @rowSecurity.
  ///
  /// In tr, this message translates to:
  /// **'Giriş ve güvenlik'**
  String get rowSecurity;

  /// No description provided for @rowNotificationPrefs.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim tercihleri'**
  String get rowNotificationPrefs;

  /// No description provided for @rowPrivacy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik'**
  String get rowPrivacy;

  /// No description provided for @rowWallet.
  ///
  /// In tr, this message translates to:
  /// **'Cüzdan ve ödemeler'**
  String get rowWallet;

  /// No description provided for @rowWalletSub.
  ///
  /// In tr, this message translates to:
  /// **'Kartlar, geçmiş, kuponlar'**
  String get rowWalletSub;

  /// No description provided for @rowHelp.
  ///
  /// In tr, this message translates to:
  /// **'Yardım merkezi'**
  String get rowHelp;

  /// No description provided for @rowLegal.
  ///
  /// In tr, this message translates to:
  /// **'Hukuki bilgiler'**
  String get rowLegal;

  /// No description provided for @signOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yap'**
  String get signOut;

  /// No description provided for @signOutTitle.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yapmak istiyor musun?'**
  String get signOutTitle;

  /// No description provided for @signOutBody.
  ///
  /// In tr, this message translates to:
  /// **'Kaydettiklerin ve rezervasyonların hesabında kalır; tekrar giriş yaptığında hepsi burada.'**
  String get signOutBody;

  /// No description provided for @versionLine.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovum · Sürüm {version}'**
  String versionLine(String version);

  /// No description provided for @guestAccountTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hoş geldin!'**
  String get guestAccountTitle;

  /// No description provided for @guestAccountBody.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon yapmak, kaydetmek ve ev sahipleriyle yazışmak için giriş yap.'**
  String get guestAccountBody;

  /// No description provided for @personalInfoTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bilgilerim'**
  String get personalInfoTitle;

  /// No description provided for @personalInfoSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonda ev sahibiyle yalnızca gereken kadarı paylaşılır.'**
  String get personalInfoSubtitle;

  /// No description provided for @profilePhoto.
  ///
  /// In tr, this message translates to:
  /// **'Profil fotoğrafı'**
  String get profilePhoto;

  /// No description provided for @profilePhotoSub.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahipleri seni tanısın'**
  String get profilePhotoSub;

  /// No description provided for @change.
  ///
  /// In tr, this message translates to:
  /// **'Değiştir'**
  String get change;

  /// No description provided for @groupContact.
  ///
  /// In tr, this message translates to:
  /// **'İletişim'**
  String get groupContact;

  /// No description provided for @fieldDisplayName.
  ///
  /// In tr, this message translates to:
  /// **'Görünen ad'**
  String get fieldDisplayName;

  /// No description provided for @fieldEmergencyContact.
  ///
  /// In tr, this message translates to:
  /// **'Acil durum kişisi'**
  String get fieldEmergencyContact;

  /// No description provided for @fieldEmergencyName.
  ///
  /// In tr, this message translates to:
  /// **'Kişinin adı'**
  String get fieldEmergencyName;

  /// No description provided for @fieldEmergencyPhone.
  ///
  /// In tr, this message translates to:
  /// **'Kişinin telefonu'**
  String get fieldEmergencyPhone;

  /// No description provided for @notAdded.
  ///
  /// In tr, this message translates to:
  /// **'Eklenmedi'**
  String get notAdded;

  /// No description provided for @phoneNotAdded.
  ///
  /// In tr, this message translates to:
  /// **'Numara eklenmedi'**
  String get phoneNotAdded;

  /// No description provided for @verifyNote.
  ///
  /// In tr, this message translates to:
  /// **'Değişiklikten sonra yeni {item} için doğrulama kodu göndereceğiz.'**
  String verifyNote(String item);

  /// No description provided for @saved.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedildi'**
  String get saved;

  /// No description provided for @emergencyLine.
  ///
  /// In tr, this message translates to:
  /// **'{name} · {phone}'**
  String emergencyLine(String name, String phone);

  /// No description provided for @securityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Giriş ve güvenlik'**
  String get securityTitle;

  /// No description provided for @groupSignInMethods.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yöntemleri'**
  String get groupSignInMethods;

  /// No description provided for @biometricTitle.
  ///
  /// In tr, this message translates to:
  /// **'Biyometrik giriş'**
  String get biometricTitle;

  /// No description provided for @biometricBody.
  ///
  /// In tr, this message translates to:
  /// **'Parmak izi veya yüz tanıma'**
  String get biometricBody;

  /// No description provided for @passwordRow.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get passwordRow;

  /// No description provided for @passwordUpdatedAgo.
  ///
  /// In tr, this message translates to:
  /// **'{ago} güncellendi'**
  String passwordUpdatedAgo(String ago);

  /// No description provided for @update.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get update;

  /// No description provided for @groupDevices.
  ///
  /// In tr, this message translates to:
  /// **'Cihazların'**
  String get groupDevices;

  /// No description provided for @thisDevice.
  ///
  /// In tr, this message translates to:
  /// **'Bu cihaz'**
  String get thisDevice;

  /// No description provided for @deviceLine.
  ///
  /// In tr, this message translates to:
  /// **'{city} · {time}'**
  String deviceLine(String city, String time);

  /// No description provided for @signOutDevice.
  ///
  /// In tr, this message translates to:
  /// **'Oturumu kapat'**
  String get signOutDevice;

  /// No description provided for @deviceSignedOut.
  ///
  /// In tr, this message translates to:
  /// **'Cihazdaki oturum kapatıldı'**
  String get deviceSignedOut;

  /// No description provided for @groupDanger.
  ///
  /// In tr, this message translates to:
  /// **'Tehlikeli bölge'**
  String get groupDanger;

  /// No description provided for @closeAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabı kapat'**
  String get closeAccount;

  /// No description provided for @closeAccountSub.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz'**
  String get closeAccountSub;

  /// No description provided for @changePasswordTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şifreni güncelle'**
  String get changePasswordTitle;

  /// No description provided for @fieldCurrentPassword.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut şifre'**
  String get fieldCurrentPassword;

  /// No description provided for @errorWrongPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifre doğru değil. Tekrar dene ya da şifreni sıfırla.'**
  String get errorWrongPassword;

  /// No description provided for @passwordUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Şifren güncellendi'**
  String get passwordUpdated;

  /// No description provided for @closeAccountTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabını kapatmak üzeresin'**
  String get closeAccountTitle;

  /// No description provided for @closeAccountSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Devam etmeden önce neler olacağını bil.'**
  String get closeAccountSubtitle;

  /// No description provided for @closeUpcomingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yaklaşan rezervasyonun var'**
  String get closeUpcomingTitle;

  /// No description provided for @closeUpcomingBody.
  ///
  /// In tr, this message translates to:
  /// **'{booking}. Hesabı kapatmadan önce iptal etmen gerekir.'**
  String closeUpcomingBody(String booking);

  /// No description provided for @closeListsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı listelerin silinir'**
  String get closeListsTitle;

  /// No description provided for @closeListsBody.
  ///
  /// In tr, this message translates to:
  /// **'{lists} liste ve {saved} bungalov kalıcı olarak silinir.'**
  String closeListsBody(int lists, int saved);

  /// No description provided for @closeReviewsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yorumların anonimleşir'**
  String get closeReviewsTitle;

  /// No description provided for @closeReviewsBody.
  ///
  /// In tr, this message translates to:
  /// **'Yazdığın değerlendirmeler isimsiz olarak kalır.'**
  String get closeReviewsBody;

  /// No description provided for @closeLegalTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yasal kayıtlar'**
  String get closeLegalTitle;

  /// No description provided for @closeLegalBody.
  ///
  /// In tr, this message translates to:
  /// **'Fatura ve ödeme kayıtları mevzuatın öngördüğü süre boyunca saklanır.'**
  String get closeLegalBody;

  /// No description provided for @confirmWithPassword.
  ///
  /// In tr, this message translates to:
  /// **'Onaylamak için şifreni gir'**
  String get confirmWithPassword;

  /// No description provided for @goToTrips.
  ///
  /// In tr, this message translates to:
  /// **'Seyahatlerime git'**
  String get goToTrips;

  /// No description provided for @accountClosed.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın kapatıldı. Seni özleyeceğiz.'**
  String get accountClosed;

  /// No description provided for @notifPrefsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim tercihleri'**
  String get notifPrefsTitle;

  /// No description provided for @notifPrefsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Neyi, ne zaman ve nereden duyacağını sen seç.'**
  String get notifPrefsSubtitle;

  /// No description provided for @groupForYou.
  ///
  /// In tr, this message translates to:
  /// **'Senin için'**
  String get groupForYou;

  /// No description provided for @groupFromBungalovum.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovum’dan'**
  String get groupFromBungalovum;

  /// No description provided for @topicPromotions.
  ///
  /// In tr, this message translates to:
  /// **'Kampanya ve indirimler'**
  String get topicPromotions;

  /// No description provided for @topicStayReminders.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama hatırlatmaları'**
  String get topicStayReminders;

  /// No description provided for @topicNews.
  ///
  /// In tr, this message translates to:
  /// **'Yenilikler'**
  String get topicNews;

  /// No description provided for @topicSurveys.
  ///
  /// In tr, this message translates to:
  /// **'Anket ve geri bildirim'**
  String get topicSurveys;

  /// No description provided for @topicRuleUpdates.
  ///
  /// In tr, this message translates to:
  /// **'Kural güncellemeleri'**
  String get topicRuleUpdates;

  /// No description provided for @channelPush.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim'**
  String get channelPush;

  /// No description provided for @channelEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get channelEmail;

  /// No description provided for @channelSms.
  ///
  /// In tr, this message translates to:
  /// **'SMS'**
  String get channelSms;

  /// No description provided for @off.
  ///
  /// In tr, this message translates to:
  /// **'Kapalı'**
  String get off;

  /// No description provided for @disableMarketing.
  ///
  /// In tr, this message translates to:
  /// **'Tüm pazarlama bildirimlerini kapat'**
  String get disableMarketing;

  /// No description provided for @marketingDisabled.
  ///
  /// In tr, this message translates to:
  /// **'Pazarlama bildirimleri kapatıldı'**
  String get marketingDisabled;

  /// No description provided for @privacyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik'**
  String get privacyTitle;

  /// No description provided for @privacySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Verilerinin nasıl kullanıldığını sen yönet.'**
  String get privacySubtitle;

  /// No description provided for @groupVisibility.
  ///
  /// In tr, this message translates to:
  /// **'Görünürlük'**
  String get groupVisibility;

  /// No description provided for @showProfileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profilimi ev sahiplerine göster'**
  String get showProfileTitle;

  /// No description provided for @showProfileBody.
  ///
  /// In tr, this message translates to:
  /// **'Ad, fotoğraf ve doğrulama durumu'**
  String get showProfileBody;

  /// No description provided for @showNameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yorumlarımda adım görünsün'**
  String get showNameTitle;

  /// No description provided for @showNameBody.
  ///
  /// In tr, this message translates to:
  /// **'Kapalıysa yalnızca baş harfin görünür'**
  String get showNameBody;

  /// No description provided for @groupDataPermissions.
  ///
  /// In tr, this message translates to:
  /// **'Veri ve izinler'**
  String get groupDataPermissions;

  /// No description provided for @locationTitle.
  ///
  /// In tr, this message translates to:
  /// **'Konum erişimi'**
  String get locationTitle;

  /// No description provided for @locationBody.
  ///
  /// In tr, this message translates to:
  /// **'Yakındaki bungalovları önermek için'**
  String get locationBody;

  /// No description provided for @personalizedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kişiselleştirilmiş öneriler'**
  String get personalizedTitle;

  /// No description provided for @personalizedBody.
  ///
  /// In tr, this message translates to:
  /// **'Gezinme geçmişine göre'**
  String get personalizedBody;

  /// No description provided for @groupYourData.
  ///
  /// In tr, this message translates to:
  /// **'Verilerin'**
  String get groupYourData;

  /// No description provided for @downloadData.
  ///
  /// In tr, this message translates to:
  /// **'Verilerimi indir'**
  String get downloadData;

  /// No description provided for @downloadDataSub.
  ///
  /// In tr, this message translates to:
  /// **'KVKK kapsamında bir kopyasını iste'**
  String get downloadDataSub;

  /// No description provided for @privacyNoticeRow.
  ///
  /// In tr, this message translates to:
  /// **'Aydınlatma metni'**
  String get privacyNoticeRow;

  /// No description provided for @deleteAccountData.
  ///
  /// In tr, this message translates to:
  /// **'Hesabımı ve verilerimi sil'**
  String get deleteAccountData;

  /// No description provided for @dataExportRequested.
  ///
  /// In tr, this message translates to:
  /// **'Talebin alındı. Verilerinin kopyası 30 gün içinde e-postana gönderilecek.'**
  String get dataExportRequested;

  /// No description provided for @helpTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl yardımcı olabiliriz?'**
  String get helpTitle;

  /// No description provided for @helpSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Bir konu ara…'**
  String get helpSearchHint;

  /// No description provided for @helpCenter.
  ///
  /// In tr, this message translates to:
  /// **'Yardım merkezi'**
  String get helpCenter;

  /// No description provided for @helpCenterSub.
  ///
  /// In tr, this message translates to:
  /// **'Rehber ve cevaplar'**
  String get helpCenterSub;

  /// No description provided for @safetySupport.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik desteği'**
  String get safetySupport;

  /// No description provided for @safetySupportSub.
  ///
  /// In tr, this message translates to:
  /// **'Acil durumda bize ulaş'**
  String get safetySupportSub;

  /// No description provided for @reportProblem.
  ///
  /// In tr, this message translates to:
  /// **'Sorun bildir'**
  String get reportProblem;

  /// No description provided for @reportProblemSub.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama ya da bölge'**
  String get reportProblemSub;

  /// No description provided for @feedback.
  ///
  /// In tr, this message translates to:
  /// **'Geri bildirim'**
  String get feedback;

  /// No description provided for @feedbackSub.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamayı geliştir'**
  String get feedbackSub;

  /// No description provided for @faqTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sık sorulanlar'**
  String get faqTitle;

  /// No description provided for @faqNoMatch.
  ///
  /// In tr, this message translates to:
  /// **'Aramana uyan soru bulamadık. Destek ekibimize yazabilirsin.'**
  String get faqNoMatch;

  /// No description provided for @feedbackTitle.
  ///
  /// In tr, this message translates to:
  /// **'Geri bildirim gönder'**
  String get feedbackTitle;

  /// No description provided for @feedbackLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ne düşünüyorsun?'**
  String get feedbackLabel;

  /// No description provided for @feedbackHint.
  ///
  /// In tr, this message translates to:
  /// **'Neyi sevdin, neyi geliştirelim?'**
  String get feedbackHint;

  /// No description provided for @feedbackSent.
  ///
  /// In tr, this message translates to:
  /// **'Teşekkürler! Geri bildirimin ekibimize ulaştı.'**
  String get feedbackSent;

  /// No description provided for @send.
  ///
  /// In tr, this message translates to:
  /// **'Gönder'**
  String get send;

  /// No description provided for @legalTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hukuki bilgiler'**
  String get legalTitle;

  /// No description provided for @docTerms.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get docTerms;

  /// No description provided for @docKvkk.
  ///
  /// In tr, this message translates to:
  /// **'KVKK Aydınlatma Metni'**
  String get docKvkk;

  /// No description provided for @docPrivacy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get docPrivacy;

  /// No description provided for @docCookies.
  ///
  /// In tr, this message translates to:
  /// **'Çerez Politikası'**
  String get docCookies;

  /// No description provided for @docDistanceSales.
  ///
  /// In tr, this message translates to:
  /// **'Mesafeli Satış Sözleşmesi'**
  String get docDistanceSales;

  /// No description provided for @docCancellation.
  ///
  /// In tr, this message translates to:
  /// **'İptal ve İade Koşulları'**
  String get docCancellation;

  /// No description provided for @legalFooter.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm {version} · Son güncelleme: {date}'**
  String legalFooter(String version, String date);

  /// No description provided for @updatedOn.
  ///
  /// In tr, this message translates to:
  /// **'Son güncelleme: {date}'**
  String updatedOn(String date);

  /// No description provided for @chatsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sohbetler'**
  String get chatsTitle;

  /// No description provided for @chatFilterAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get chatFilterAll;

  /// No description provided for @chatFilterStay.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama'**
  String get chatFilterStay;

  /// No description provided for @chatFilterSupport.
  ///
  /// In tr, this message translates to:
  /// **'Destek'**
  String get chatFilterSupport;

  /// No description provided for @searchChats.
  ///
  /// In tr, this message translates to:
  /// **'Sohbetlerde ara'**
  String get searchChats;

  /// No description provided for @searchChatsHint.
  ///
  /// In tr, this message translates to:
  /// **'Kişi ya da bungalov ara'**
  String get searchChatsHint;

  /// No description provided for @chatsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz sohbetin yok'**
  String get chatsEmptyTitle;

  /// No description provided for @chatsEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Bir ev sahibine yazdığında ya da rezervasyon yaptığında konuşmaların burada görünür.'**
  String get chatsEmptyBody;

  /// No description provided for @chatsNoMatch.
  ///
  /// In tr, this message translates to:
  /// **'Aramana uyan sohbet yok.'**
  String get chatsNoMatch;

  /// No description provided for @chatContextRequest.
  ///
  /// In tr, this message translates to:
  /// **'{listing} · Talep'**
  String chatContextRequest(String listing);

  /// No description provided for @supportTicket.
  ///
  /// In tr, this message translates to:
  /// **'Destek talebi #{no}'**
  String supportTicket(String no);

  /// No description provided for @youPrefix.
  ///
  /// In tr, this message translates to:
  /// **'Sen: {text}'**
  String youPrefix(String text);

  /// No description provided for @photoMessage.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf'**
  String get photoMessage;

  /// No description provided for @unreadCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} okunmamış mesaj'**
  String unreadCount(int count);

  /// No description provided for @online.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimiçi'**
  String get online;

  /// No description provided for @typeMessage.
  ///
  /// In tr, this message translates to:
  /// **'Mesaj yaz…'**
  String get typeMessage;

  /// No description provided for @sendMessageAction.
  ///
  /// In tr, this message translates to:
  /// **'Gönder'**
  String get sendMessageAction;

  /// No description provided for @attachPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf ekle'**
  String get attachPhoto;

  /// No description provided for @details.
  ///
  /// In tr, this message translates to:
  /// **'Detay'**
  String get details;

  /// No description provided for @messageFailed.
  ///
  /// In tr, this message translates to:
  /// **'Gönderilemedi · Tekrar dene'**
  String get messageFailed;

  /// No description provided for @messageSending.
  ///
  /// In tr, this message translates to:
  /// **'Gönderiliyor'**
  String get messageSending;

  /// No description provided for @messageRead.
  ///
  /// In tr, this message translates to:
  /// **'Okundu'**
  String get messageRead;

  /// No description provided for @messageSent.
  ///
  /// In tr, this message translates to:
  /// **'Gönderildi'**
  String get messageSent;

  /// No description provided for @chatStartHint.
  ///
  /// In tr, this message translates to:
  /// **'Merhaba de! Ev sahibin genelde {time} yanıt verir.'**
  String chatStartHint(String time);

  /// No description provided for @chatSafetyNote.
  ///
  /// In tr, this message translates to:
  /// **'Güvenliğin için ödemeleri yalnızca Bungalovum üzerinden yap.'**
  String get chatSafetyNote;

  /// No description provided for @notificationsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get notificationsTitle;

  /// No description provided for @markAllRead.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü okundu say'**
  String get markAllRead;

  /// No description provided for @sectionToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün'**
  String get sectionToday;

  /// No description provided for @sectionThisWeek.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta'**
  String get sectionThisWeek;

  /// No description provided for @sectionEarlier.
  ///
  /// In tr, this message translates to:
  /// **'Daha önce'**
  String get sectionEarlier;

  /// No description provided for @hoursAgo.
  ///
  /// In tr, this message translates to:
  /// **'{count} saat önce'**
  String hoursAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In tr, this message translates to:
  /// **'{count} dakika önce'**
  String minutesAgo(int count);

  /// No description provided for @justNow.
  ///
  /// In tr, this message translates to:
  /// **'Az önce'**
  String get justNow;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni bildirimin yok'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon, mesaj ve fırsatlar burada görünür.'**
  String get notificationsEmptyBody;

  /// No description provided for @unread.
  ///
  /// In tr, this message translates to:
  /// **'Okunmadı'**
  String get unread;

  /// No description provided for @savedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaydettiklerim'**
  String get savedTitle;

  /// No description provided for @savedSummary.
  ///
  /// In tr, this message translates to:
  /// **'{lists} liste · {count} bungalov'**
  String savedSummary(int lists, int count);

  /// No description provided for @newListTile.
  ///
  /// In tr, this message translates to:
  /// **'Yeni liste'**
  String get newListTile;

  /// No description provided for @createListTitle.
  ///
  /// In tr, this message translates to:
  /// **'Liste oluştur'**
  String get createListTitle;

  /// No description provided for @groupYourTrips.
  ///
  /// In tr, this message translates to:
  /// **'Kaçamaklarını grupla'**
  String get groupYourTrips;

  /// No description provided for @recentlyViewedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son baktıkların'**
  String get recentlyViewedTitle;

  /// No description provided for @yesterday.
  ///
  /// In tr, this message translates to:
  /// **'Dün'**
  String get yesterday;

  /// No description provided for @recentTileSub.
  ///
  /// In tr, this message translates to:
  /// **'{when} · {count} bungalov'**
  String recentTileSub(String when, int count);

  /// No description provided for @savedTip.
  ///
  /// In tr, this message translates to:
  /// **'İpucu: Bir bungalovun kalbine dokun, istediğin listeye ekle.'**
  String get savedTip;

  /// No description provided for @savedEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz bir şey kaydetmedin'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiğin bungalovların kalbine dokun; hafta sonu, yaz tatili gibi listelerde topla.'**
  String get savedEmptyBody;

  /// No description provided for @startExploring.
  ///
  /// In tr, this message translates to:
  /// **'Keşfetmeye başla'**
  String get startExploring;

  /// No description provided for @listSubtitleDates.
  ///
  /// In tr, this message translates to:
  /// **'{count} bungalov · {dates} için fiyatlar'**
  String listSubtitleDates(int count, String dates);

  /// No description provided for @listSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{count} bungalov · gecelik fiyatlar'**
  String listSubtitle(int count);

  /// No description provided for @addDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarih ekle'**
  String get addDates;

  /// No description provided for @unavailableForDates.
  ///
  /// In tr, this message translates to:
  /// **'Bu tarihlerde dolu'**
  String get unavailableForDates;

  /// No description provided for @perNightShort.
  ///
  /// In tr, this message translates to:
  /// **'· gece'**
  String get perNightShort;

  /// No description provided for @noteChip.
  ///
  /// In tr, this message translates to:
  /// **'Not: {note}'**
  String noteChip(String note);

  /// No description provided for @addNote.
  ///
  /// In tr, this message translates to:
  /// **'Not ekle'**
  String get addNote;

  /// No description provided for @noteLabel.
  ///
  /// In tr, this message translates to:
  /// **'Notun'**
  String get noteLabel;

  /// No description provided for @noteHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn. Annemlerle gidebiliriz'**
  String get noteHint;

  /// No description provided for @removeNote.
  ///
  /// In tr, this message translates to:
  /// **'Notu sil'**
  String get removeNote;

  /// No description provided for @editList.
  ///
  /// In tr, this message translates to:
  /// **'Listeyi düzenle'**
  String get editList;

  /// No description provided for @shareList.
  ///
  /// In tr, this message translates to:
  /// **'Listeyi paylaş'**
  String get shareList;

  /// No description provided for @listLinkCopied.
  ///
  /// In tr, this message translates to:
  /// **'Liste bağlantısı kopyalandı'**
  String get listLinkCopied;

  /// No description provided for @listNotShareable.
  ///
  /// In tr, this message translates to:
  /// **'Önce listeyi bağlantıyla paylaşılabilir yap.'**
  String get listNotShareable;

  /// No description provided for @listEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu liste henüz boş'**
  String get listEmptyTitle;

  /// No description provided for @listEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiğin bungalovların kalbine dokunup bu listeye ekleyebilirsin.'**
  String get listEmptyBody;

  /// No description provided for @shareableTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantıyla paylaşılabilsin'**
  String get shareableTitle;

  /// No description provided for @shareableBody.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantıya sahip olanlar listeyi görebilir'**
  String get shareableBody;

  /// No description provided for @deleteList.
  ///
  /// In tr, this message translates to:
  /// **'Listeyi sil'**
  String get deleteList;

  /// No description provided for @deleteListTitle.
  ///
  /// In tr, this message translates to:
  /// **'Listeyi silmek istiyor musun?'**
  String get deleteListTitle;

  /// No description provided for @deleteListBody.
  ///
  /// In tr, this message translates to:
  /// **'“{name}” ve içindeki {count} kayıt silinir. Bungalovlar diğer listelerinde kalır.'**
  String deleteListBody(String name, int count);

  /// No description provided for @deleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Evet, sil'**
  String get deleteConfirm;

  /// No description provided for @listDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Liste silindi'**
  String get listDeleted;

  /// No description provided for @listSaved.
  ///
  /// In tr, this message translates to:
  /// **'Liste güncellendi'**
  String get listSaved;

  /// No description provided for @recentSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Son {days} günde incelediğin bungalovlar.'**
  String recentSubtitle(int days);

  /// No description provided for @clearRecentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son baktıkların temizlensin mi?'**
  String get clearRecentTitle;

  /// No description provided for @clearRecentBody.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş tüm cihazlarında temizlenir. Kaydettiğin listeler etkilenmez.'**
  String get clearRecentBody;

  /// No description provided for @placesCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} yer'**
  String placesCount(int count);

  /// No description provided for @bedsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} yatak'**
  String bedsCount(int count);

  /// No description provided for @recentEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son baktığın bungalov yok'**
  String get recentEmptyTitle;

  /// No description provided for @recentEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'İncelediğin bungalovlar 30 gün boyunca burada durur.'**
  String get recentEmptyBody;

  /// No description provided for @checkInLabel.
  ///
  /// In tr, this message translates to:
  /// **'Giriş'**
  String get checkInLabel;

  /// No description provided for @checkOutLabel.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış'**
  String get checkOutLabel;

  /// No description provided for @fromTime.
  ///
  /// In tr, this message translates to:
  /// **'{time} itibarıyla'**
  String fromTime(String time);

  /// No description provided for @untilTime.
  ///
  /// In tr, this message translates to:
  /// **'{time} kadar'**
  String untilTime(String time);

  /// No description provided for @addressLabel.
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get addressLabel;

  /// No description provided for @getDirections.
  ///
  /// In tr, this message translates to:
  /// **'Yol tarifi al'**
  String get getDirections;

  /// No description provided for @copyAddress.
  ///
  /// In tr, this message translates to:
  /// **'Adresi kopyala'**
  String get copyAddress;

  /// No description provided for @addressCopied.
  ///
  /// In tr, this message translates to:
  /// **'Adres kopyalandı'**
  String get addressCopied;

  /// No description provided for @addressLocked.
  ///
  /// In tr, this message translates to:
  /// **'Tam adres {date} açılır. Şimdilik yaklaşık konumu görüyorsun.'**
  String addressLocked(String date);

  /// No description provided for @guideAndAccess.
  ///
  /// In tr, this message translates to:
  /// **'Ev kılavuzu ve giriş bilgileri'**
  String get guideAndAccess;

  /// No description provided for @guideLockedNote.
  ///
  /// In tr, this message translates to:
  /// **'Anahtar kutusu şifresi ve Wi-Fi {date} açılır.'**
  String guideLockedNote(String date);

  /// No description provided for @guideOpenNote.
  ///
  /// In tr, this message translates to:
  /// **'Anahtar kutusu şifresi ve Wi-Fi bilgileri hazır.'**
  String get guideOpenNote;

  /// No description provided for @fastResponder.
  ///
  /// In tr, this message translates to:
  /// **'Hızlı yanıt verir'**
  String get fastResponder;

  /// No description provided for @respondsWithin.
  ///
  /// In tr, this message translates to:
  /// **'Genelde {time} yanıt verir'**
  String respondsWithin(String time);

  /// No description provided for @callHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibini ara'**
  String get callHost;

  /// No description provided for @messageHostShort.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibine mesaj gönder'**
  String get messageHostShort;

  /// No description provided for @manageBooking.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonu yönet'**
  String get manageBooking;

  /// No description provided for @reportStayIssue.
  ///
  /// In tr, this message translates to:
  /// **'Konaklamada sorun bildir'**
  String get reportStayIssue;

  /// No description provided for @askHostChange.
  ///
  /// In tr, this message translates to:
  /// **'Değişiklik için ev sahibine yaz'**
  String get askHostChange;

  /// No description provided for @askHostChangeNote.
  ///
  /// In tr, this message translates to:
  /// **'Tarih veya kişi sayısı değişikliği'**
  String get askHostChangeNote;

  /// No description provided for @receiptAndInvoice.
  ///
  /// In tr, this message translates to:
  /// **'Makbuz ve fatura'**
  String get receiptAndInvoice;

  /// No description provided for @cancelBooking.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonu iptal et'**
  String get cancelBooking;

  /// No description provided for @codeCopied.
  ///
  /// In tr, this message translates to:
  /// **'Kod kopyalandı'**
  String get codeCopied;

  /// No description provided for @cannotOpenLink.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama açılamadı. Daha sonra tekrar dene.'**
  String get cannotOpenLink;

  /// No description provided for @atDateTime.
  ///
  /// In tr, this message translates to:
  /// **'{date} {time}'**
  String atDateTime(String date, String time);

  /// No description provided for @houseGuideTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ev kılavuzu'**
  String get houseGuideTitle;

  /// No description provided for @lockboxCode.
  ///
  /// In tr, this message translates to:
  /// **'Anahtar kutusu şifresi'**
  String get lockboxCode;

  /// No description provided for @lockboxHintLine.
  ///
  /// In tr, this message translates to:
  /// **'{hint} · Giriş {time} itibarıyla'**
  String lockboxHintLine(String hint, String time);

  /// No description provided for @lockboxLocked.
  ///
  /// In tr, this message translates to:
  /// **'Şifre {date} burada görünecek.'**
  String lockboxLocked(String date);

  /// No description provided for @wifiPasswordLine.
  ///
  /// In tr, this message translates to:
  /// **'Şifre: {password}'**
  String wifiPasswordLine(String password);

  /// No description provided for @wifiLocked.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi bilgileri girişten 1 gün önce açılır.'**
  String get wifiLocked;

  /// No description provided for @wifiLabel.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi'**
  String get wifiLabel;

  /// No description provided for @checkoutAt.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış · {date}, {time}'**
  String checkoutAt(String date, String time);

  /// No description provided for @reportIssueShort.
  ///
  /// In tr, this message translates to:
  /// **'Sorun bildir'**
  String get reportIssueShort;

  /// No description provided for @issueTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ne oldu?'**
  String get issueTitle;

  /// No description provided for @issueSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimin ev sahibine ve destek ekibimize aynı anda iletilir.'**
  String get issueSubtitle;

  /// No description provided for @issuePool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz / jakuzi'**
  String get issuePool;

  /// No description provided for @issueHotWater.
  ///
  /// In tr, this message translates to:
  /// **'Sıcak su'**
  String get issueHotWater;

  /// No description provided for @issueCleaning.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik'**
  String get issueCleaning;

  /// No description provided for @issueWifi.
  ///
  /// In tr, this message translates to:
  /// **'Wi-Fi'**
  String get issueWifi;

  /// No description provided for @issueClimate.
  ///
  /// In tr, this message translates to:
  /// **'Klima / ısıtma'**
  String get issueClimate;

  /// No description provided for @issueOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get issueOther;

  /// No description provided for @issueUrgencyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ne kadar acil?'**
  String get issueUrgencyTitle;

  /// No description provided for @urgencyLow.
  ///
  /// In tr, this message translates to:
  /// **'Acil değil'**
  String get urgencyLow;

  /// No description provided for @urgencyToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün çözülmeli'**
  String get urgencyToday;

  /// No description provided for @urgencyHigh.
  ///
  /// In tr, this message translates to:
  /// **'Acil'**
  String get urgencyHigh;

  /// No description provided for @issueDescribe.
  ///
  /// In tr, this message translates to:
  /// **'Kısaca anlat'**
  String get issueDescribe;

  /// No description provided for @issueDescribeHint.
  ///
  /// In tr, this message translates to:
  /// **'Ne oldu, ne zamandan beri?'**
  String get issueDescribeHint;

  /// No description provided for @issuePhotos.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf ekle (isteğe bağlı)'**
  String get issuePhotos;

  /// No description provided for @photoAdd.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get photoAdd;

  /// No description provided for @photoRemove.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafı kaldır'**
  String get photoRemove;

  /// No description provided for @issueResponseNote.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi genelde {time} yanıtlar. Yanıt gelmezse destek ekibimiz devreye girer.'**
  String issueResponseNote(String time);

  /// No description provided for @issueSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Sorunu bildir'**
  String get issueSubmit;

  /// No description provided for @issueSent.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimin iletildi. Ev sahibin kısa sürede dönecek.'**
  String get issueSent;

  /// No description provided for @errorIssueShort.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibinin anlayabilmesi için en az {min} karakter yaz.'**
  String errorIssueShort(int min);

  /// No description provided for @urgentCallNote.
  ///
  /// In tr, this message translates to:
  /// **'Can güvenliğini tehdit eden bir durum varsa önce 112’yi ara.'**
  String get urgentCallNote;

  /// No description provided for @receiptTitle.
  ///
  /// In tr, this message translates to:
  /// **'Makbuz'**
  String get receiptTitle;

  /// No description provided for @paidChip.
  ///
  /// In tr, this message translates to:
  /// **'Ödendi'**
  String get paidChip;

  /// No description provided for @refundedChip.
  ///
  /// In tr, this message translates to:
  /// **'İade edildi'**
  String get refundedChip;

  /// No description provided for @rowStay.
  ///
  /// In tr, this message translates to:
  /// **'Konaklama'**
  String get rowStay;

  /// No description provided for @totalLabel.
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get totalLabel;

  /// No description provided for @paymentLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme'**
  String get paymentLabel;

  /// No description provided for @taxesLabel.
  ///
  /// In tr, this message translates to:
  /// **'Vergiler'**
  String get taxesLabel;

  /// No description provided for @vatIncluded.
  ///
  /// In tr, this message translates to:
  /// **'KDV dahil'**
  String get vatIncluded;

  /// No description provided for @billingInfo.
  ///
  /// In tr, this message translates to:
  /// **'Fatura bilgileri'**
  String get billingInfo;

  /// No description provided for @billingIndividualLine.
  ///
  /// In tr, this message translates to:
  /// **'Bireysel · {name}'**
  String billingIndividualLine(String name);

  /// No description provided for @billingCorporateLine.
  ///
  /// In tr, this message translates to:
  /// **'Kurumsal · {name}'**
  String billingCorporateLine(String name);

  /// No description provided for @emailReceipt.
  ///
  /// In tr, this message translates to:
  /// **'E-postama gönder'**
  String get emailReceipt;

  /// No description provided for @downloadPdf.
  ///
  /// In tr, this message translates to:
  /// **'PDF indir'**
  String get downloadPdf;

  /// No description provided for @receiptEmailed.
  ///
  /// In tr, this message translates to:
  /// **'Makbuz {email} adresine gönderildi.'**
  String receiptEmailed(String email);

  /// No description provided for @receiptLinkCopied.
  ///
  /// In tr, this message translates to:
  /// **'Makbuz bağlantısı kopyalandı'**
  String get receiptLinkCopied;

  /// No description provided for @datesWithYear.
  ///
  /// In tr, this message translates to:
  /// **'{dates} {year} · {nights} gece'**
  String datesWithYear(String dates, int year, int nights);

  /// No description provided for @billingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fatura bilgileri'**
  String get billingTitle;

  /// No description provided for @billingSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Faturan bu bilgilerle e-posta adresine gönderilir.'**
  String get billingSubtitle;

  /// No description provided for @billingIndividual.
  ///
  /// In tr, this message translates to:
  /// **'Bireysel'**
  String get billingIndividual;

  /// No description provided for @billingCorporate.
  ///
  /// In tr, this message translates to:
  /// **'Kurumsal'**
  String get billingCorporate;

  /// No description provided for @fieldTcknOptional.
  ///
  /// In tr, this message translates to:
  /// **'T.C. kimlik no (isteğe bağlı)'**
  String get fieldTcknOptional;

  /// No description provided for @fieldAddress.
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get fieldAddress;

  /// No description provided for @fieldBillingEmail.
  ///
  /// In tr, this message translates to:
  /// **'Fatura e-postası'**
  String get fieldBillingEmail;

  /// No description provided for @fieldCompanyName.
  ///
  /// In tr, this message translates to:
  /// **'Şirket unvanı'**
  String get fieldCompanyName;

  /// No description provided for @fieldTaxOffice.
  ///
  /// In tr, this message translates to:
  /// **'Vergi dairesi'**
  String get fieldTaxOffice;

  /// No description provided for @fieldTaxNumber.
  ///
  /// In tr, this message translates to:
  /// **'Vergi numarası'**
  String get fieldTaxNumber;

  /// No description provided for @hintTaxNumber.
  ///
  /// In tr, this message translates to:
  /// **'10 haneli numara'**
  String get hintTaxNumber;

  /// No description provided for @errorTaxNumber.
  ///
  /// In tr, this message translates to:
  /// **'Vergi numarası 10 haneli olmalı'**
  String get errorTaxNumber;

  /// No description provided for @billingCorporateNote.
  ///
  /// In tr, this message translates to:
  /// **'Kurumsal fatura için şirket unvanı, vergi dairesi ve vergi numarası istenir.'**
  String get billingCorporateNote;

  /// No description provided for @billingSaved.
  ///
  /// In tr, this message translates to:
  /// **'Fatura bilgilerin kaydedildi'**
  String get billingSaved;

  /// No description provided for @cancelTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonu iptal et'**
  String get cancelTitle;

  /// No description provided for @refundAmountLabel.
  ///
  /// In tr, this message translates to:
  /// **'İade tutarın'**
  String get refundAmountLabel;

  /// No description provided for @fullRefundChip.
  ///
  /// In tr, this message translates to:
  /// **'Tam iade'**
  String get fullRefundChip;

  /// No description provided for @partialRefundChip.
  ///
  /// In tr, this message translates to:
  /// **'Kısmi iade'**
  String get partialRefundChip;

  /// No description provided for @noRefundChip.
  ///
  /// In tr, this message translates to:
  /// **'İade yok'**
  String get noRefundChip;

  /// No description provided for @fullRefundNote.
  ///
  /// In tr, this message translates to:
  /// **'{date} önce iptal ettiğin için ücretin tamamı iade edilir.'**
  String fullRefundNote(String date);

  /// No description provided for @partialRefundNote.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz iptal süresi {date} doldu; konaklama bedelinin bir kısmı kesilir.'**
  String partialRefundNote(String date);

  /// No description provided for @deductionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kesinti'**
  String get deductionLabel;

  /// No description provided for @refundLabel.
  ///
  /// In tr, this message translates to:
  /// **'İade'**
  String get refundLabel;

  /// No description provided for @refundTimingNote.
  ///
  /// In tr, this message translates to:
  /// **'İade, bankana bağlı olarak 5–10 iş günü içinde kartına yansır.'**
  String get refundTimingNote;

  /// No description provided for @cancelReasonTitle.
  ///
  /// In tr, this message translates to:
  /// **'İptal sebebin'**
  String get cancelReasonTitle;

  /// No description provided for @reasonPlansChanged.
  ///
  /// In tr, this message translates to:
  /// **'Planlarım değişti'**
  String get reasonPlansChanged;

  /// No description provided for @reasonFoundOther.
  ///
  /// In tr, this message translates to:
  /// **'Başka bir yer buldum'**
  String get reasonFoundOther;

  /// No description provided for @reasonHostAsked.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi iptal etmemi istedi'**
  String get reasonHostAsked;

  /// No description provided for @reasonOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get reasonOther;

  /// No description provided for @irreversible.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz.'**
  String get irreversible;

  /// No description provided for @keepBooking.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get keepBooking;

  /// No description provided for @confirmCancel.
  ///
  /// In tr, this message translates to:
  /// **'İptali onayla'**
  String get confirmCancel;

  /// No description provided for @bookingCancelled.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonun iptal edildi. İade süreci başladı.'**
  String get bookingCancelled;

  /// No description provided for @reviewTitle.
  ///
  /// In tr, this message translates to:
  /// **'Konaklaman nasıldı?'**
  String get reviewTitle;

  /// No description provided for @overallRating.
  ///
  /// In tr, this message translates to:
  /// **'Genel puanın'**
  String get overallRating;

  /// No description provided for @rating1.
  ///
  /// In tr, this message translates to:
  /// **'Kötü'**
  String get rating1;

  /// No description provided for @rating2.
  ///
  /// In tr, this message translates to:
  /// **'Vasat'**
  String get rating2;

  /// No description provided for @rating3.
  ///
  /// In tr, this message translates to:
  /// **'İyi'**
  String get rating3;

  /// No description provided for @rating4.
  ///
  /// In tr, this message translates to:
  /// **'Çok iyi'**
  String get rating4;

  /// No description provided for @rating5.
  ///
  /// In tr, this message translates to:
  /// **'Mükemmel'**
  String get rating5;

  /// No description provided for @starsOf.
  ///
  /// In tr, this message translates to:
  /// **'{stars} / 5 yıldız'**
  String starsOf(int stars);

  /// No description provided for @rateStars.
  ///
  /// In tr, this message translates to:
  /// **'{item}: {stars} yıldız ver'**
  String rateStars(String item, int stars);

  /// No description provided for @detailedRating.
  ///
  /// In tr, this message translates to:
  /// **'Ayrıntılı puan'**
  String get detailedRating;

  /// No description provided for @reviewCleanliness.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik'**
  String get reviewCleanliness;

  /// No description provided for @reviewAccuracy.
  ///
  /// In tr, this message translates to:
  /// **'Doğruluk'**
  String get reviewAccuracy;

  /// No description provided for @reviewCommunication.
  ///
  /// In tr, this message translates to:
  /// **'İletişim'**
  String get reviewCommunication;

  /// No description provided for @reviewLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konum'**
  String get reviewLocation;

  /// No description provided for @reviewValue.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat / performans'**
  String get reviewValue;

  /// No description provided for @whatYouLiked.
  ///
  /// In tr, this message translates to:
  /// **'En çok neyi sevdin?'**
  String get whatYouLiked;

  /// No description provided for @likePool.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get likePool;

  /// No description provided for @likeView.
  ///
  /// In tr, this message translates to:
  /// **'Manzara'**
  String get likeView;

  /// No description provided for @likeQuiet.
  ///
  /// In tr, this message translates to:
  /// **'Sessizlik'**
  String get likeQuiet;

  /// No description provided for @likeCleanliness.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik'**
  String get likeCleanliness;

  /// No description provided for @likeHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi'**
  String get likeHost;

  /// No description provided for @likeLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konum'**
  String get likeLocation;

  /// No description provided for @yourReview.
  ///
  /// In tr, this message translates to:
  /// **'Yorumun'**
  String get yourReview;

  /// No description provided for @reviewHint.
  ///
  /// In tr, this message translates to:
  /// **'Konaklamanı diğer misafirler için anlat…'**
  String get reviewHint;

  /// No description provided for @addPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf ekle'**
  String get addPhoto;

  /// No description provided for @charCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} / {max}'**
  String charCount(int count, int max);

  /// No description provided for @submitReview.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirmeyi gönder'**
  String get submitReview;

  /// No description provided for @reviewThanksTitle.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirmen için teşekkürler!'**
  String get reviewThanksTitle;

  /// No description provided for @reviewThanksBody.
  ///
  /// In tr, this message translates to:
  /// **'Yorumun incelendikten sonra yayınlanacak.'**
  String get reviewThanksBody;

  /// No description provided for @errorReviewShort.
  ///
  /// In tr, this message translates to:
  /// **'Yorumun en az {min} karakter olmalı.'**
  String errorReviewShort(int min);

  /// No description provided for @errorRateAll.
  ///
  /// In tr, this message translates to:
  /// **'Genel puanı ve tüm kategorileri puanla.'**
  String get errorRateAll;

  /// No description provided for @tripsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Seyahatler'**
  String get tripsTitle;

  /// No description provided for @tabUpcoming.
  ///
  /// In tr, this message translates to:
  /// **'Yaklaşan'**
  String get tabUpcoming;

  /// No description provided for @tabPast.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş'**
  String get tabPast;

  /// No description provided for @tabCancelled.
  ///
  /// In tr, this message translates to:
  /// **'İptal edilen'**
  String get tabCancelled;

  /// No description provided for @tripsPendingCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} onay bekliyor'**
  String tripsPendingCount(int count);

  /// No description provided for @tripsUpcomingCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} yaklaşan'**
  String tripsUpcomingCount(int count);

  /// No description provided for @tripsPastCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} geçmiş'**
  String tripsPastCount(int count);

  /// No description provided for @tripsPastStays.
  ///
  /// In tr, this message translates to:
  /// **'{count} geçmiş konaklama'**
  String tripsPastStays(int count);

  /// No description provided for @tripsCancelledCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} iptal edilen rezervasyon'**
  String tripsCancelledCount(int count);

  /// No description provided for @daysLeft.
  ///
  /// In tr, this message translates to:
  /// **'{days, plural, =0{Bugün} =1{Yarın} other{{days} gün kaldı}}'**
  String daysLeft(int days);

  /// No description provided for @statusConfirmed.
  ///
  /// In tr, this message translates to:
  /// **'Onaylandı'**
  String get statusConfirmed;

  /// No description provided for @statusPending.
  ///
  /// In tr, this message translates to:
  /// **'Onay bekleniyor'**
  String get statusPending;

  /// No description provided for @statusCancelled.
  ///
  /// In tr, this message translates to:
  /// **'İptal edildi'**
  String get statusCancelled;

  /// No description provided for @statusDeclined.
  ///
  /// In tr, this message translates to:
  /// **'Reddedildi'**
  String get statusDeclined;

  /// No description provided for @dotJoin2.
  ///
  /// In tr, this message translates to:
  /// **'{a} · {b}'**
  String dotJoin2(String a, String b);

  /// No description provided for @dotJoin3.
  ///
  /// In tr, this message translates to:
  /// **'{a} · {b} · {c}'**
  String dotJoin3(String a, String b, String c);

  /// No description provided for @actionDirections.
  ///
  /// In tr, this message translates to:
  /// **'Yol tarifi'**
  String get actionDirections;

  /// No description provided for @actionMessage.
  ///
  /// In tr, this message translates to:
  /// **'Mesaj'**
  String get actionMessage;

  /// No description provided for @actionCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş bilgisi'**
  String get actionCheckIn;

  /// No description provided for @hostResponseHoursLeft.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibinin yanıtı için {hours} saat kaldı'**
  String hostResponseHoursLeft(int hours);

  /// No description provided for @hostResponseMinutesLeft.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibinin yanıtı için {minutes} dakika kaldı'**
  String hostResponseMinutesLeft(int minutes);

  /// No description provided for @sendMessage.
  ///
  /// In tr, this message translates to:
  /// **'Mesaj gönder'**
  String get sendMessage;

  /// No description provided for @withdrawRequest.
  ///
  /// In tr, this message translates to:
  /// **'Talebi geri çek'**
  String get withdrawRequest;

  /// No description provided for @withdrawTitle.
  ///
  /// In tr, this message translates to:
  /// **'Talebi geri çekmek istiyor musun?'**
  String get withdrawTitle;

  /// No description provided for @withdrawBody.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibine bildirilir ve kartındaki {amount} provizyon kaldırılır.'**
  String withdrawBody(String amount);

  /// No description provided for @withdrawConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Evet, geri çek'**
  String get withdrawConfirm;

  /// No description provided for @keepRequest.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get keepRequest;

  /// No description provided for @withdrawn.
  ///
  /// In tr, this message translates to:
  /// **'Talebin geri çekildi'**
  String get withdrawn;

  /// No description provided for @confirmedSection.
  ///
  /// In tr, this message translates to:
  /// **'Onaylanmış'**
  String get confirmedSection;

  /// No description provided for @previousStays.
  ///
  /// In tr, this message translates to:
  /// **'Önceki konaklamalar'**
  String get previousStays;

  /// No description provided for @nightsCount.
  ///
  /// In tr, this message translates to:
  /// **'{nights} gece'**
  String nightsCount(int nights);

  /// No description provided for @writeReview.
  ///
  /// In tr, this message translates to:
  /// **'Yorum yaz'**
  String get writeReview;

  /// No description provided for @rateStay.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendir'**
  String get rateStay;

  /// No description provided for @youRated.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirdin · {rating}'**
  String youRated(String rating);

  /// No description provided for @receipt.
  ///
  /// In tr, this message translates to:
  /// **'Makbuz'**
  String get receipt;

  /// No description provided for @bookAgain.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar rezerve et'**
  String get bookAgain;

  /// No description provided for @cancelledByYou.
  ///
  /// In tr, this message translates to:
  /// **'Sen iptal ettin · {date}'**
  String cancelledByYou(String date);

  /// No description provided for @cancelledByHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi iptal etti · {date}'**
  String cancelledByHost(String date);

  /// No description provided for @declinedByHost.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi kabul etmedi'**
  String get declinedByHost;

  /// No description provided for @refundedTo.
  ///
  /// In tr, this message translates to:
  /// **'{amount} iade edildi · {card}'**
  String refundedTo(String amount, String card);

  /// No description provided for @provisionReleased.
  ///
  /// In tr, this message translates to:
  /// **'Provizyon kaldırıldı · {card}'**
  String provisionReleased(String card);

  /// No description provided for @refundNote.
  ///
  /// In tr, this message translates to:
  /// **'İadeler bankana bağlı olarak 5–10 iş günü içinde kartına yansır.'**
  String get refundNote;

  /// No description provided for @emptyUpcomingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz bir seyahatin yok'**
  String get emptyUpcomingTitle;

  /// No description provided for @emptyUpcomingBody.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon yaptığında yaklaşan konaklamaların, adresin ve giriş bilgilerin burada olacak.'**
  String get emptyUpcomingBody;

  /// No description provided for @exploreBungalows.
  ///
  /// In tr, this message translates to:
  /// **'Bungalovları keşfet'**
  String get exploreBungalows;

  /// No description provided for @emptyPastTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz tamamlanmış bir konaklaman yok'**
  String get emptyPastTitle;

  /// No description provided for @emptyPastBody.
  ///
  /// In tr, this message translates to:
  /// **'Konaklamaların bittikçe burada görünür; değerlendirmeyi de buradan yaparsın.'**
  String get emptyPastBody;

  /// No description provided for @emptyCancelledTitle.
  ///
  /// In tr, this message translates to:
  /// **'İptal edilen rezervasyonun yok'**
  String get emptyCancelledTitle;

  /// No description provided for @emptyCancelledBody.
  ///
  /// In tr, this message translates to:
  /// **'İptal ettiğin ya da kabul edilmeyen talepler burada görünür.'**
  String get emptyCancelledBody;

  /// No description provided for @loadErrorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bilgiler yüklenemedi'**
  String get loadErrorTitle;

  /// No description provided for @requestTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon talebi gönder'**
  String get requestTitle;

  /// No description provided for @hostApprovalChip.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi onayı gerekir'**
  String get hostApprovalChip;

  /// No description provided for @howItWorks.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl işliyor?'**
  String get howItWorks;

  /// No description provided for @requestStep1Title.
  ///
  /// In tr, this message translates to:
  /// **'Talebini gönder'**
  String get requestStep1Title;

  /// No description provided for @requestStep1Body.
  ///
  /// In tr, this message translates to:
  /// **'Kartında yalnızca provizyon tutulur, ücret çekilmez.'**
  String get requestStep1Body;

  /// No description provided for @requestStep2Title.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi {hours} saat içinde yanıtlar'**
  String requestStep2Title(int hours);

  /// No description provided for @requestStep2Body.
  ///
  /// In tr, this message translates to:
  /// **'Yanıt gelmezse talep kendiliğinden düşer.'**
  String get requestStep2Body;

  /// No description provided for @requestStep3Title.
  ///
  /// In tr, this message translates to:
  /// **'Onaylanırsa ödeme alınır'**
  String get requestStep3Title;

  /// No description provided for @requestStep3Body.
  ///
  /// In tr, this message translates to:
  /// **'Reddedilirse provizyon kartından kaldırılır.'**
  String get requestStep3Body;

  /// No description provided for @introduceYourself.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibine kendini tanıt (zorunlu)'**
  String get introduceYourself;

  /// No description provided for @introduceHint.
  ///
  /// In tr, this message translates to:
  /// **'Merhaba {host}, kimlerle ve ne için geldiğini kısaca anlat…'**
  String introduceHint(String host);

  /// No description provided for @errorIntroShort.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibinin seni tanıyabilmesi için en az {min} karakter yaz.'**
  String errorIntroShort(int min);

  /// No description provided for @notChargedNow.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi çekilmez'**
  String get notChargedNow;

  /// No description provided for @sendRequest.
  ///
  /// In tr, this message translates to:
  /// **'Talep gönder'**
  String get sendRequest;

  /// No description provided for @provisionNote.
  ///
  /// In tr, this message translates to:
  /// **'Kartından {amount} provizyon tutulur; ev sahibi onaylarsa çekilir, reddederse kaldırılır.'**
  String provisionNote(String amount);

  /// No description provided for @requestSentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Talebin ev sahibine iletildi'**
  String get requestSentTitle;

  /// No description provided for @requestSentBody.
  ///
  /// In tr, this message translates to:
  /// **'{host} genelde {time} yanıt veriyor. Gelişmeleri bildirimle haber vereceğiz.'**
  String requestSentBody(String host, String time);

  /// No description provided for @responseTimeLeft.
  ///
  /// In tr, this message translates to:
  /// **'Yanıt için kalan süre'**
  String get responseTimeLeft;

  /// No description provided for @hoursMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{hours} sa {minutes} dk'**
  String hoursMinutes(int hours, int minutes);

  /// No description provided for @responseTimeOver.
  ///
  /// In tr, this message translates to:
  /// **'Yanıt süresi doldu; provizyon kartından kaldırılacak.'**
  String get responseTimeOver;

  /// No description provided for @rowListing.
  ///
  /// In tr, this message translates to:
  /// **'Bungalov'**
  String get rowListing;

  /// No description provided for @rowProvision.
  ///
  /// In tr, this message translates to:
  /// **'Provizyon'**
  String get rowProvision;

  /// No description provided for @amountWithCard.
  ///
  /// In tr, this message translates to:
  /// **'{amount} · {card}'**
  String amountWithCard(String amount, String card);

  /// No description provided for @myTrips.
  ///
  /// In tr, this message translates to:
  /// **'Seyahatlerim'**
  String get myTrips;

  /// No description provided for @requestApprovedTitle.
  ///
  /// In tr, this message translates to:
  /// **'{host} talebini onayladı!'**
  String requestApprovedTitle(String host);

  /// No description provided for @requestApprovedBody.
  ///
  /// In tr, this message translates to:
  /// **'Ödemen alındı ve rezervasyonun kesinleşti. {listing} seni {date} bekliyor.'**
  String requestApprovedBody(String listing, String date);

  /// No description provided for @requestDeclinedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu sefer olmadı'**
  String get requestDeclinedTitle;

  /// No description provided for @requestDeclinedBody.
  ///
  /// In tr, this message translates to:
  /// **'Ev sahibi bu tarihler için talebini kabul edemedi. {amount} provizyon kartından kaldırıldı.'**
  String requestDeclinedBody(String amount);

  /// No description provided for @similarTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aynı tarihlerde boş, benzer yerler'**
  String get similarTitle;

  /// No description provided for @seeAllSimilar.
  ///
  /// In tr, this message translates to:
  /// **'Tüm benzerleri gör'**
  String get seeAllSimilar;

  /// No description provided for @priceForNights.
  ///
  /// In tr, this message translates to:
  /// **'{price} · {nights} gece'**
  String priceForNights(String price, int nights);

  /// No description provided for @couponSheetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kupon kodu ekle'**
  String get couponSheetTitle;

  /// No description provided for @fieldCouponCode.
  ///
  /// In tr, this message translates to:
  /// **'Kupon kodu'**
  String get fieldCouponCode;

  /// No description provided for @hintCouponCode.
  ///
  /// In tr, this message translates to:
  /// **'Kodu buraya yaz'**
  String get hintCouponCode;

  /// No description provided for @couponApply.
  ///
  /// In tr, this message translates to:
  /// **'Uygula'**
  String get couponApply;

  /// No description provided for @couponApplied.
  ///
  /// In tr, this message translates to:
  /// **'{code} uygulandı'**
  String couponApplied(String code);

  /// No description provided for @couponSaving.
  ///
  /// In tr, this message translates to:
  /// **'{amount} indirim'**
  String couponSaving(String amount);

  /// No description provided for @couponRemove.
  ///
  /// In tr, this message translates to:
  /// **'Kaldır'**
  String get couponRemove;

  /// No description provided for @couponNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Bu kodu bulamadık. Harfleri kontrol edip tekrar dene.'**
  String get couponNotFound;

  /// No description provided for @couponExpired.
  ///
  /// In tr, this message translates to:
  /// **'Bu kuponun süresi dolmuş.'**
  String get couponExpired;

  /// No description provided for @couponNotApplicable.
  ///
  /// In tr, this message translates to:
  /// **'Bu kupon bu rezervasyonda geçerli değil.'**
  String get couponNotApplicable;

  /// No description provided for @couponNote.
  ///
  /// In tr, this message translates to:
  /// **'Kupon ilandaki diğer indirimlerin yerine geçer; aynı anda tek kupon kullanılır.'**
  String get couponNote;

  /// No description provided for @bookingConfirmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonu onayla'**
  String get bookingConfirmTitle;

  /// No description provided for @instantBookChip.
  ///
  /// In tr, this message translates to:
  /// **'Anında onay'**
  String get instantBookChip;

  /// No description provided for @ratingWithCount.
  ///
  /// In tr, this message translates to:
  /// **'{rating} · {count} değerlendirme'**
  String ratingWithCount(String rating, int count);

  /// No description provided for @listingTypeRegion.
  ///
  /// In tr, this message translates to:
  /// **'{type} · {region}'**
  String listingTypeRegion(String type, String region);

  /// No description provided for @yourTrip.
  ///
  /// In tr, this message translates to:
  /// **'Seyahatin'**
  String get yourTrip;

  /// No description provided for @tripDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarihler'**
  String get tripDates;

  /// No description provided for @tripGuests.
  ///
  /// In tr, this message translates to:
  /// **'Misafirler'**
  String get tripGuests;

  /// No description provided for @edit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get edit;

  /// No description provided for @editItem.
  ///
  /// In tr, this message translates to:
  /// **'{item} düzenle'**
  String editItem(String item);

  /// No description provided for @guestsAdultsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} yetişkin'**
  String guestsAdultsCount(int count);

  /// No description provided for @guestsChildrenCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} çocuk'**
  String guestsChildrenCount(int count);

  /// No description provided for @guestsInfantsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} bebek'**
  String guestsInfantsCount(int count);

  /// No description provided for @guestsPetsCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} evcil hayvan'**
  String guestsPetsCount(int count);

  /// No description provided for @priceDetails.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat ayrıntısı'**
  String get priceDetails;

  /// No description provided for @priceNightsLine.
  ///
  /// In tr, this message translates to:
  /// **'{price} × {nights} gece'**
  String priceNightsLine(String price, int nights);

  /// No description provided for @priceCleaning.
  ///
  /// In tr, this message translates to:
  /// **'Temizlik ücreti'**
  String get priceCleaning;

  /// No description provided for @priceService.
  ///
  /// In tr, this message translates to:
  /// **'Hizmet bedeli'**
  String get priceService;

  /// No description provided for @discountEarlyBooking.
  ///
  /// In tr, this message translates to:
  /// **'Erken rezervasyon indirimi'**
  String get discountEarlyBooking;

  /// No description provided for @discountLastMinute.
  ///
  /// In tr, this message translates to:
  /// **'Son dakika indirimi'**
  String get discountLastMinute;

  /// No description provided for @discountLongStay.
  ///
  /// In tr, this message translates to:
  /// **'Uzun konaklama indirimi'**
  String get discountLongStay;

  /// No description provided for @discountCoupon.
  ///
  /// In tr, this message translates to:
  /// **'Kupon indirimi'**
  String get discountCoupon;

  /// No description provided for @discountSpecial.
  ///
  /// In tr, this message translates to:
  /// **'Özel indirim'**
  String get discountSpecial;

  /// No description provided for @minusAmount.
  ///
  /// In tr, this message translates to:
  /// **'–{amount}'**
  String minusAmount(String amount);

  /// No description provided for @priceTotalTry.
  ///
  /// In tr, this message translates to:
  /// **'Toplam (TRY)'**
  String get priceTotalTry;

  /// No description provided for @freeCancelUntil.
  ///
  /// In tr, this message translates to:
  /// **'{date} kadar ücretsiz iptal'**
  String freeCancelUntil(String date);

  /// No description provided for @noRefundAfter.
  ///
  /// In tr, this message translates to:
  /// **'Sonrasında iade yapılmaz.'**
  String get noRefundAfter;

  /// No description provided for @acceptRulesLink.
  ///
  /// In tr, this message translates to:
  /// **'Ev kurallarını'**
  String get acceptRulesLink;

  /// No description provided for @acceptMiddle.
  ///
  /// In tr, this message translates to:
  /// **' ve '**
  String get acceptMiddle;

  /// No description provided for @acceptPolicyLink.
  ///
  /// In tr, this message translates to:
  /// **'iptal politikasını'**
  String get acceptPolicyLink;

  /// No description provided for @acceptEnd.
  ///
  /// In tr, this message translates to:
  /// **' okudum, kabul ediyorum.'**
  String get acceptEnd;

  /// No description provided for @acceptSemantics.
  ///
  /// In tr, this message translates to:
  /// **'Ev kurallarını ve iptal politikasını okudum, kabul ediyorum.'**
  String get acceptSemantics;

  /// No description provided for @goToPayment.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeye geç'**
  String get goToPayment;

  /// No description provided for @paymentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme'**
  String get paymentTitle;

  /// No description provided for @savedCards.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı kartların'**
  String get savedCards;

  /// No description provided for @cardMasked.
  ///
  /// In tr, this message translates to:
  /// **'{brand} •••• {last4}'**
  String cardMasked(String brand, String last4);

  /// No description provided for @cardLast4.
  ///
  /// In tr, this message translates to:
  /// **'•••• {last4}'**
  String cardLast4(String last4);

  /// No description provided for @cardBrandVisa.
  ///
  /// In tr, this message translates to:
  /// **'Visa'**
  String get cardBrandVisa;

  /// No description provided for @cardBrandMastercard.
  ///
  /// In tr, this message translates to:
  /// **'Mastercard'**
  String get cardBrandMastercard;

  /// No description provided for @cardBrandTroy.
  ///
  /// In tr, this message translates to:
  /// **'Troy'**
  String get cardBrandTroy;

  /// No description provided for @cardBrandAmex.
  ///
  /// In tr, this message translates to:
  /// **'American Express'**
  String get cardBrandAmex;

  /// No description provided for @cardBrandUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Kart'**
  String get cardBrandUnknown;

  /// No description provided for @cardExpiryShort.
  ///
  /// In tr, this message translates to:
  /// **'SKT {expiry}'**
  String cardExpiryShort(String expiry);

  /// No description provided for @cardDefaultExpiry.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan · SKT {expiry}'**
  String cardDefaultExpiry(String expiry);

  /// No description provided for @payWithNewCard.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kartla öde'**
  String get payWithNewCard;

  /// No description provided for @installmentsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Taksit seçenekleri'**
  String get installmentsTitle;

  /// No description provided for @installmentSingle.
  ///
  /// In tr, this message translates to:
  /// **'Tek çekim'**
  String get installmentSingle;

  /// No description provided for @installmentCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} taksit'**
  String installmentCount(int count);

  /// No description provided for @installmentsNote.
  ///
  /// In tr, this message translates to:
  /// **'Taksit seçenekleri kartına ve bankana göre değişir.'**
  String get installmentsNote;

  /// No description provided for @couponTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kupon kodun var mı?'**
  String get couponTitle;

  /// No description provided for @couponSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'İndirimi toplam tutara uygula'**
  String get couponSubtitle;

  /// No description provided for @add.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get add;

  /// No description provided for @paymentSecure.
  ///
  /// In tr, this message translates to:
  /// **'Ödemen 3D Secure ile korunur. Kart bilgilerin bizde saklanmaz.'**
  String get paymentSecure;

  /// No description provided for @payAmount.
  ///
  /// In tr, this message translates to:
  /// **'{amount} öde'**
  String payAmount(String amount);

  /// No description provided for @totalAmount.
  ///
  /// In tr, this message translates to:
  /// **'Toplam {amount}'**
  String totalAmount(String amount);

  /// No description provided for @fieldCardHolder.
  ///
  /// In tr, this message translates to:
  /// **'Kart üzerindeki isim'**
  String get fieldCardHolder;

  /// No description provided for @fieldCardNumber.
  ///
  /// In tr, this message translates to:
  /// **'Kart numarası'**
  String get fieldCardNumber;

  /// No description provided for @fieldCardExpiry.
  ///
  /// In tr, this message translates to:
  /// **'Son kullanma'**
  String get fieldCardExpiry;

  /// No description provided for @hintCardExpiry.
  ///
  /// In tr, this message translates to:
  /// **'AA / YY'**
  String get hintCardExpiry;

  /// No description provided for @fieldCardCvc.
  ///
  /// In tr, this message translates to:
  /// **'CVC'**
  String get fieldCardCvc;

  /// No description provided for @hintCardCvc.
  ///
  /// In tr, this message translates to:
  /// **'•••'**
  String get hintCardCvc;

  /// No description provided for @saveCardForLater.
  ///
  /// In tr, this message translates to:
  /// **'Kartımı sonraki ödemeler için kaydet'**
  String get saveCardForLater;

  /// No description provided for @errorCardNumber.
  ///
  /// In tr, this message translates to:
  /// **'Kart numarasını kontrol et'**
  String get errorCardNumber;

  /// No description provided for @errorCardExpiry.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir tarih gir (AA / YY)'**
  String get errorCardExpiry;

  /// No description provided for @errorCardCvc.
  ///
  /// In tr, this message translates to:
  /// **'Kartın arkasındaki güvenlik kodunu gir'**
  String get errorCardCvc;

  /// No description provided for @errorPaymentStart.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme başlatılamadı. Bağlantını kontrol edip tekrar dene.'**
  String get errorPaymentStart;

  /// No description provided for @tdsVerifying.
  ///
  /// In tr, this message translates to:
  /// **'Bankan doğruluyor'**
  String get tdsVerifying;

  /// No description provided for @tdsRedirect.
  ///
  /// In tr, this message translates to:
  /// **'Bankanın onay ekranına yönlendiriliyorsun. Bu sayfayı kapatma.'**
  String get tdsRedirect;

  /// No description provided for @tdsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Banka doğrulaması'**
  String get tdsTitle;

  /// No description provided for @tdsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'3D Secure · Güvenli ödeme'**
  String get tdsSubtitle;

  /// No description provided for @tdsMerchant.
  ///
  /// In tr, this message translates to:
  /// **'İşyeri'**
  String get tdsMerchant;

  /// No description provided for @tdsAmount.
  ///
  /// In tr, this message translates to:
  /// **'Tutar'**
  String get tdsAmount;

  /// No description provided for @tdsCard.
  ///
  /// In tr, this message translates to:
  /// **'Kart'**
  String get tdsCard;

  /// No description provided for @tdsCodePrompt.
  ///
  /// In tr, this message translates to:
  /// **'Telefonuna gelen {length} haneli SMS şifresini gir.'**
  String tdsCodePrompt(int length);

  /// No description provided for @tdsCodeLabel.
  ///
  /// In tr, this message translates to:
  /// **'SMS şifresi'**
  String get tdsCodeLabel;

  /// No description provided for @tdsTimeLeft.
  ///
  /// In tr, this message translates to:
  /// **'Kalan süre {time}'**
  String tdsTimeLeft(String time);

  /// No description provided for @tdsExpired.
  ///
  /// In tr, this message translates to:
  /// **'Süre doldu, yeni şifre iste.'**
  String get tdsExpired;

  /// No description provided for @resend.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar gönder'**
  String get resend;

  /// No description provided for @confirm.
  ///
  /// In tr, this message translates to:
  /// **'Onayla'**
  String get confirm;

  /// No description provided for @payFailedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme tamamlanamadı'**
  String get payFailedTitle;

  /// No description provided for @payFailedBody.
  ///
  /// In tr, this message translates to:
  /// **'Bankan işlemi onaylamadı. Kartından herhangi bir ücret çekilmedi.'**
  String get payFailedBody;

  /// No description provided for @payFailedReasons.
  ///
  /// In tr, this message translates to:
  /// **'Olası sebepler'**
  String get payFailedReasons;

  /// No description provided for @payFailedLimit.
  ///
  /// In tr, this message translates to:
  /// **'Kart limiti yetersiz olabilir'**
  String get payFailedLimit;

  /// No description provided for @payFailedCode.
  ///
  /// In tr, this message translates to:
  /// **'3D Secure şifresi hatalı ya da süresi dolmuş olabilir'**
  String get payFailedCode;

  /// No description provided for @payFailedOnline.
  ///
  /// In tr, this message translates to:
  /// **'Kartın internet alışverişine kapalı olabilir'**
  String get payFailedOnline;

  /// No description provided for @payFailedHold.
  ///
  /// In tr, this message translates to:
  /// **'{dates} tarihleri {time} dakika daha senin için tutuluyor.'**
  String payFailedHold(String dates, String time);

  /// No description provided for @payFailedHoldOver.
  ///
  /// In tr, this message translates to:
  /// **'{dates} tarihleri artık tutulmuyor; hâlâ müsaitse ödemeyi tamamlayabilirsin.'**
  String payFailedHoldOver(String dates);

  /// No description provided for @payOtherCard.
  ///
  /// In tr, this message translates to:
  /// **'Başka bir kartla öde'**
  String get payOtherCard;

  /// No description provided for @payRetrySame.
  ///
  /// In tr, this message translates to:
  /// **'Aynı kartla tekrar dene'**
  String get payRetrySame;

  /// No description provided for @bookingDoneTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyonun tamam!'**
  String get bookingDoneTitle;

  /// No description provided for @bookingDoneBody.
  ///
  /// In tr, this message translates to:
  /// **'{listing} seni {date} bekliyor. Onay e-postanı da gönderdik.'**
  String bookingDoneBody(String listing, String date);

  /// No description provided for @amountPaid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenen'**
  String get amountPaid;

  /// No description provided for @bookingCode.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon kodu'**
  String get bookingCode;

  /// No description provided for @copy.
  ///
  /// In tr, this message translates to:
  /// **'Kopyala'**
  String get copy;

  /// No description provided for @bookingCodeCopied.
  ///
  /// In tr, this message translates to:
  /// **'Rezervasyon kodu kopyalandı'**
  String get bookingCodeCopied;

  /// No description provided for @bookingDoneAddress.
  ///
  /// In tr, this message translates to:
  /// **'Tam adres ve giriş talimatları Seyahatler sekmende seni bekliyor.'**
  String get bookingDoneAddress;

  /// No description provided for @goToTrip.
  ///
  /// In tr, this message translates to:
  /// **'Seyahate git'**
  String get goToTrip;

  /// No description provided for @guestInfoTitle.
  ///
  /// In tr, this message translates to:
  /// **'Misafir bilgileri'**
  String get guestInfoTitle;

  /// No description provided for @guestInfoSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Yasal bildirim için tüm misafirlerin bilgileri girişten önce tamamlanmalı.'**
  String get guestInfoSubtitle;

  /// No description provided for @guestInfoProgress.
  ///
  /// In tr, this message translates to:
  /// **'{done} / {total} tamam'**
  String guestInfoProgress(int done, int total);

  /// No description provided for @guestYou.
  ///
  /// In tr, this message translates to:
  /// **'{name} · Sen'**
  String guestYou(String name);

  /// No description provided for @idMaskedTr.
  ///
  /// In tr, this message translates to:
  /// **'T.C. ••••••••• {last2}'**
  String idMaskedTr(String last2);

  /// No description provided for @idMaskedPassport.
  ///
  /// In tr, this message translates to:
  /// **'Pasaport ••••• {last2}'**
  String idMaskedPassport(String last2);

  /// No description provided for @guestNumber.
  ///
  /// In tr, this message translates to:
  /// **'Misafir {number}'**
  String guestNumber(int number);

  /// No description provided for @requiredField.
  ///
  /// In tr, this message translates to:
  /// **'Zorunlu'**
  String get requiredField;

  /// No description provided for @nationalityTurkish.
  ///
  /// In tr, this message translates to:
  /// **'T.C. vatandaşı'**
  String get nationalityTurkish;

  /// No description provided for @nationalityForeign.
  ///
  /// In tr, this message translates to:
  /// **'Yabancı uyruklu'**
  String get nationalityForeign;

  /// No description provided for @fieldFullName.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad'**
  String get fieldFullName;

  /// No description provided for @fieldTckn.
  ///
  /// In tr, this message translates to:
  /// **'T.C. kimlik no'**
  String get fieldTckn;

  /// No description provided for @hintTckn.
  ///
  /// In tr, this message translates to:
  /// **'11 haneli numara'**
  String get hintTckn;

  /// No description provided for @fieldPassport.
  ///
  /// In tr, this message translates to:
  /// **'Pasaport no'**
  String get fieldPassport;

  /// No description provided for @hintPassport.
  ///
  /// In tr, this message translates to:
  /// **'Pasaporttaki numara'**
  String get hintPassport;

  /// No description provided for @errorTckn.
  ///
  /// In tr, this message translates to:
  /// **'T.C. kimlik numarasını kontrol et'**
  String get errorTckn;

  /// No description provided for @errorPassport.
  ///
  /// In tr, this message translates to:
  /// **'Pasaport numarasını kontrol et'**
  String get errorPassport;

  /// No description provided for @guestInfoKvkk.
  ///
  /// In tr, this message translates to:
  /// **'Bu bilgiler yalnızca yasal kimlik bildirimi için kullanılır ve ev sahibiyle paylaşılır. '**
  String get guestInfoKvkk;

  /// No description provided for @privacyNoticeLink.
  ///
  /// In tr, this message translates to:
  /// **'Aydınlatma metni'**
  String get privacyNoticeLink;

  /// No description provided for @guestInfoComplete.
  ///
  /// In tr, this message translates to:
  /// **'Tüm misafirlerin bilgileri tamam. Girişte görüşmek üzere!'**
  String get guestInfoComplete;

  /// No description provided for @daysToCheckIn.
  ///
  /// In tr, this message translates to:
  /// **'{days, plural, =0{Giriş bugün} other{Girişe {days} gün kaldı}}'**
  String daysToCheckIn(int days);

  /// No description provided for @completeLater.
  ///
  /// In tr, this message translates to:
  /// **'Sonra da tamamlayabilirsin'**
  String get completeLater;

  /// No description provided for @guestSaved.
  ///
  /// In tr, this message translates to:
  /// **'Misafir bilgileri kaydedildi'**
  String get guestSaved;

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
