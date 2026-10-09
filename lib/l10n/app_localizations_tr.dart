// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get tabExplore => 'Keşfet';

  @override
  String get tabSaved => 'Kayıtlı';

  @override
  String get tabTrips => 'Seyahatler';

  @override
  String get tabChats => 'Sohbetler';

  @override
  String get tabAccount => 'Hesabım';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get seeAll => 'Tümünü gör';

  @override
  String get exploreGreeting => 'Bu hafta sonu\nnereye kaçıyoruz?';

  @override
  String get exploreNotifications => 'Bildirimler';

  @override
  String get exploreNotificationsUnread =>
      'Bildirimler, okunmamış bildirim var';

  @override
  String get exploreSearchTitle => 'Nereye gidiyorsun?';

  @override
  String get exploreSearchSubtitle => 'Tarih seç · Misafir ekle';

  @override
  String get exploreFilters => 'Filtreler';

  @override
  String get categoryAll => 'Tümü';

  @override
  String get categoryPool => 'Havuzlu';

  @override
  String get categoryLakeView => 'Göl manzaralı';

  @override
  String get categoryForest => 'Orman içi';

  @override
  String get categoryJacuzzi => 'Jakuzili';

  @override
  String get categoryFireplace => 'Şömineli';

  @override
  String get categoryAFrame => 'A-frame';

  @override
  String explorePopularTitle(String region) {
    return '$region en sevilenler';
  }

  @override
  String get explorePopularSubtitle => 'Gecelik fiyat · tüm ücretler dahil';

  @override
  String get exploreWeekendTitle => 'Bu hafta sonu boş olanlar';

  @override
  String exploreWeekendSubtitle(String dates, int nights) {
    return '$dates · $nights gecelik toplam, ücretler dahil';
  }

  @override
  String get exploreEmptyTitle => 'Bu kategoride şimdilik bungalov yok';

  @override
  String get exploreEmptyBody =>
      'Başka bir kategoriye göz at, yenileri sürekli ekleniyor.';

  @override
  String get exploreErrorTitle => 'Bungalovlar yüklenemedi';

  @override
  String get exploreErrorBody => 'Bağlantını kontrol edip tekrar dene.';

  @override
  String weatherTemperature(int degrees) {
    return '$degrees°';
  }

  @override
  String weatherDayCondition(String weekday, String condition) {
    return '$weekday · $condition';
  }

  @override
  String get weatherSunny => 'Güneşli';

  @override
  String get weatherPartlyCloudy => 'Parçalı bulutlu';

  @override
  String get weatherCloudy => 'Bulutlu';

  @override
  String get weatherRainy => 'Yağmurlu';

  @override
  String get weatherSnowy => 'Karlı';

  @override
  String weatherPoolDay(int count) {
    return 'Havuz keyfi için ideal hafta sonu — $count bungalov müsait.';
  }

  @override
  String weatherAvailable(int count) {
    return 'Bu hafta sonu $count bungalov müsait.';
  }

  @override
  String get badgeGuestFavorite => 'Misafirlerin gözdesi';

  @override
  String badgeNightsLeft(int count) {
    return 'Son $count gece!';
  }

  @override
  String photoCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String photoOf(int current, int total) {
    return 'Fotoğraf $current / $total';
  }

  @override
  String get listingSave => 'Kaydet';

  @override
  String get listingUnsave => 'Kayıtlılardan çıkar';

  @override
  String get listingPerNight => '/ gece';

  @override
  String listingNightsTotal(int nights) {
    return '· $nights gece toplam';
  }

  @override
  String listingRating(String rating) {
    return 'Puan $rating';
  }

  @override
  String listingNightlySemantics(String price) {
    return 'Gecelik $price';
  }

  @override
  String listingTotalSemantics(int nights, String price) {
    return '$nights gece toplam $price';
  }

  @override
  String listingDiscountSemantics(int nights, String price, String original) {
    return '$nights gece toplam $price, indirimsiz $original';
  }

  @override
  String listingGuests(int count) {
    return '$count misafir';
  }

  @override
  String get propertyBungalow => 'Bungalov';

  @override
  String get propertyTreeHouse => 'Ağaç ev';

  @override
  String get propertyAFrame => 'A-frame';

  @override
  String get propertyCabin => 'Kulübe';

  @override
  String get settingLakeView => 'Göl manzaralı';

  @override
  String get settingLakeside => 'Göl kıyısı';

  @override
  String get settingForest => 'Orman içi';

  @override
  String get amenityPool => 'Havuz';

  @override
  String get amenityHeatedPool => 'Isıtmalı havuz';

  @override
  String get amenityJacuzzi => 'Jakuzi';

  @override
  String get amenityFireplace => 'Şömine';

  @override
  String get back => 'Geri';

  @override
  String get close => 'Kapat';

  @override
  String get or => 'veya';

  @override
  String get continueLabel => 'Devam et';

  @override
  String get showPassword => 'Şifreyi göster';

  @override
  String get hidePassword => 'Şifreyi gizle';

  @override
  String get fieldEmail => 'E-posta';

  @override
  String get fieldPassword => 'Şifre';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldPhoneNumber => 'Telefon numarası';

  @override
  String get fieldFirstName => 'Ad';

  @override
  String get fieldLastName => 'Soyad';

  @override
  String get fieldBirthDate => 'Doğum tarihi';

  @override
  String get fieldNewPassword => 'Yeni şifre';

  @override
  String get fieldNewPasswordRepeat => 'Yeni şifre (tekrar)';

  @override
  String get hintPhone => '5XX XXX XX XX';

  @override
  String get hintBirthDate => 'GG / AA / YYYY';

  @override
  String get countryCodeTr => '+90';

  @override
  String get verificationCode => 'Doğrulama kodu';

  @override
  String get welcomeBrand => 'bungalovum';

  @override
  String get welcomeStats => '4,9 · 1.200+ bungalov';

  @override
  String get welcomeTitle => 'Doğaya en yakın\nkaçamak burada.';

  @override
  String get welcomeBody =>
      'Havuzlu, göl manzaralı, orman içi bungalovları keşfet; birkaç dokunuşla rezervasyonunu yap.';

  @override
  String get welcomeCreateAccount => 'Hesap oluştur';

  @override
  String get welcomeSignIn => 'Giriş yap';

  @override
  String get welcomeBrowse => 'Şimdilik göz at';

  @override
  String get signInTitle => 'Tekrar hoş geldin';

  @override
  String get signInSubtitle => 'Kaçamaklarına kaldığın yerden devam et.';

  @override
  String get signInRememberMe => 'Beni hatırla';

  @override
  String get signInForgot => 'Şifremi unuttum';

  @override
  String get signInSubmit => 'Giriş yap';

  @override
  String get signInGoogle => 'Google ile devam et';

  @override
  String get signInApple => 'Apple ile devam et';

  @override
  String get signInGoogleBadge => 'G';

  @override
  String get signInNoAccount => 'Hesabın yok mu?';

  @override
  String get signInRegister => 'Kayıt ol';

  @override
  String get signInPhoneNote =>
      'Numarana 6 haneli bir doğrulama kodu göndereceğiz.';

  @override
  String get signInSendSms => 'SMS kodu gönder';

  @override
  String signInInvalidCredentials(int count) {
    return 'E-posta veya şifre hatalı. $count deneme hakkın kaldı.';
  }

  @override
  String get signInLocked =>
      'Deneme hakkın doldu. Şifreni sıfırlayarak devam edebilirsin.';

  @override
  String get errorEmail => 'Geçerli bir e-posta adresi gir';

  @override
  String get errorPasswordShort => 'Şifren en az 8 karakter olmalı';

  @override
  String get errorPhone => 'Geçerli bir cep telefonu numarası gir';

  @override
  String get errorName => 'Bu alanı doldur';

  @override
  String get errorBirthDate => 'Geçerli bir tarih gir';

  @override
  String get errorUnderage => 'Kayıt için 18 yaşından büyük olmalısın.';

  @override
  String get errorPasswordRule => 'En az 8 karakter ve 1 rakam kullan';

  @override
  String get errorPasswordMismatch => 'Şifreler aynı değil';

  @override
  String get errorInvalidCode => 'Kod hatalı. Kontrol edip tekrar dene.';

  @override
  String get errorEmailInUse =>
      'Bu e-posta ile zaten bir hesap var. Giriş yapmayı dene.';

  @override
  String get errorNetwork =>
      'Bağlantı kurulamadı. İnternetini kontrol edip tekrar dene.';

  @override
  String get smsTitle => 'SMS kodunu gir';

  @override
  String smsBody(String phone) {
    return '$phone numarasına 6 haneli bir kod gönderdik.';
  }

  @override
  String get smsChangeNumber => 'Numarayı değiştir';

  @override
  String get resendCode => 'Kodu tekrar gönder';

  @override
  String get resendCodeIn => 'Kodu tekrar gönder · ';

  @override
  String get registerTitle => 'Hesabını oluştur';

  @override
  String get registerSubtitle =>
      'Bir dakikada kaydol, ilk kaçamağını planlamaya başla.';

  @override
  String get registerAgeNote => 'Kayıt için 18 yaşından büyük olmalısın.';

  @override
  String get registerPasswordHint => 'En az 8 karakter, 1 rakam';

  @override
  String get passwordWeak => 'Zayıf';

  @override
  String get passwordMedium => 'Orta güçte';

  @override
  String get passwordStrong => 'Güçlü';

  @override
  String get registerTermsLink => 'Kullanım Koşulları';

  @override
  String get registerTermsMiddle => '’nı ve ';

  @override
  String get registerKvkkLink => 'KVKK Aydınlatma Metni';

  @override
  String get registerTermsEnd => '’ni okudum, kabul ediyorum.';

  @override
  String get registerTermsSemantics =>
      'Kullanım Koşulları’nı ve KVKK Aydınlatma Metni’ni okudum, kabul ediyorum.';

  @override
  String get registerMarketing =>
      'Kampanya ve fırsatlardan e-posta/SMS ile haberdar olmak istiyorum. (İsteğe bağlı)';

  @override
  String get registerHaveAccount => 'Zaten hesabın var mı?';

  @override
  String get registerSignIn => 'Giriş yap';

  @override
  String get verifyEmailTitle => 'E-postanı doğrula';

  @override
  String verifyEmailBody(String email) {
    return '$email adresine 6 haneli bir kod gönderdik. Kodu aşağıya yaz.';
  }

  @override
  String get verifyEmailSubmit => 'Doğrula';

  @override
  String get verifyEmailChange => 'E-posta adresini değiştir';

  @override
  String get forgotTitle => 'Şifreni mi unuttun?';

  @override
  String get forgotBody =>
      'Dert etme. Hesabına bağlı e-postanı yaz, sana bir sıfırlama kodu gönderelim.';

  @override
  String get forgotSubmit => 'Kod gönder';

  @override
  String get forgotRemembered => 'Şifreni hatırladın mı?';

  @override
  String get forgotSignIn => 'Giriş yap';

  @override
  String get resetCodeTitle => 'Kodu gir';

  @override
  String resetCodeBody(String email) {
    return '$email adresine gönderdiğimiz 6 haneli kodu yaz.';
  }

  @override
  String get resetCodeTip =>
      'Kod gelmediyse spam/gereksiz klasörünü kontrol et.';

  @override
  String get newPasswordTitle => 'Yeni şifreni belirle';

  @override
  String get newPasswordBody =>
      'Daha önce kullanmadığın, tahmin edilmesi zor bir şifre seç.';

  @override
  String get newPasswordRulesTitle => 'Şifren şunları içermeli';

  @override
  String get ruleMinLength => 'En az 8 karakter';

  @override
  String get ruleUppercase => 'En az bir büyük harf';

  @override
  String get ruleDigit => 'En az bir rakam';

  @override
  String get ruleSpecial => 'En az bir özel karakter (!, ?, #)';

  @override
  String get newPasswordSubmit => 'Şifreyi güncelle';

  @override
  String get passwordUpdatedTitle => 'Şifren güncellendi!';

  @override
  String get passwordUpdatedBody =>
      'Artık yeni şifrenle giriş yapabilirsin. Güvenliğin için diğer cihazlardaki oturumlarını kapattık.';

  @override
  String get passwordUpdatedSubmit => 'Giriş yap';

  @override
  String get loginRequiredTitle => 'Kaydetmek için giriş yap';

  @override
  String get loginRequiredBody =>
      'Beğendiğin bungalovları listelere eklemek ve rezervasyon yapmak için bir hesaba ihtiyacın var.';

  @override
  String get loginRequiredEmail => 'E-posta ile devam et';

  @override
  String get amenityAirConditioning => 'Klima';

  @override
  String get amenityWifi => 'Wi-Fi';

  @override
  String get amenityParking => 'Otopark';

  @override
  String get badgeRareFind => 'Nadir fırsat';

  @override
  String get featureLakeView => 'Göl manzarası';

  @override
  String get clearAll => 'Tümünü temizle';

  @override
  String get clear => 'Temizle';

  @override
  String get reset => 'Sıfırla';

  @override
  String get save => 'Kaydet';

  @override
  String get searchTabListings => 'Bungalovlar';

  @override
  String get searchTabMap => 'Haritada ara';

  @override
  String get searchWhereTitle => 'Nereye?';

  @override
  String get searchLocationLabel => 'Konum';

  @override
  String get searchLocationHint => 'Bölge ya da bungalov ara';

  @override
  String get searchRecent => 'Son aramalar';

  @override
  String get searchPopularRoutes => 'Popüler rotalar';

  @override
  String get searchWhen => 'Ne zaman?';

  @override
  String get searchWho => 'Kim?';

  @override
  String get searchAnyDate => 'Esnek tarih';

  @override
  String get searchAddDates => 'Tarih ekle';

  @override
  String get searchSubmit => 'Bungalov ara';

  @override
  String searchSummary(String dates, String guests) {
    return '$dates · $guests';
  }

  @override
  String get searchAnywhere => 'Her yer';

  @override
  String get filtersTitle => 'Filtreler';

  @override
  String get filtersPrice => 'Gecelik fiyat';

  @override
  String get filtersPriceNote => 'Vergiler ve ücretler dahil';

  @override
  String get filtersMin => 'En az';

  @override
  String get filtersMax => 'En çok';

  @override
  String get filtersFeatures => 'Bungalov özellikleri';

  @override
  String get filtersBedrooms => 'Yatak odası';

  @override
  String get filtersAnyBedrooms => 'Farketmez';

  @override
  String filtersBedroomsPlus(int count) {
    return '$count+';
  }

  @override
  String get filtersBooking => 'Rezervasyon tercihleri';

  @override
  String get filtersInstant => 'Anında onay';

  @override
  String get filtersInstantNote => 'Ev sahibi onayı beklemeden rezervasyon';

  @override
  String get filtersFreeCancel => 'Ücretsiz iptal';

  @override
  String get filtersFreeCancelNote => 'Girişten 24 saat öncesine kadar';

  @override
  String get filtersPets => 'Evcil hayvan kabul eden';

  @override
  String get filtersPetsNote => 'Patili dostunla gel';

  @override
  String get filtersAccessible => 'Engelsiz erişim';

  @override
  String get filtersAccessibleNote => 'Basamaksız giriş, geniş kapılar';

  @override
  String filtersShow(int count) {
    return '$count bungalovu göster';
  }

  @override
  String filtersPriceChip(String min, String max) {
    return '₺$min–$max';
  }

  @override
  String filtersActive(int count) {
    return '$count filtre etkin';
  }

  @override
  String removeFilter(String name) {
    return '$name filtresini kaldır';
  }

  @override
  String resultsCount(int count) {
    return '$count bungalov';
  }

  @override
  String get sortRecommended => 'Önerilen';

  @override
  String get sortPriceLow => 'Fiyat (artan)';

  @override
  String get sortPriceHigh => 'Fiyat (azalan)';

  @override
  String get sortRating => 'En yüksek puan';

  @override
  String get sortTitle => 'Sırala';

  @override
  String get resultsMap => 'Harita';

  @override
  String get resultsList => 'Liste';

  @override
  String mapPriceNote(int nights) {
    return '$nights gecelik toplam fiyatlar · ücretler dahil';
  }

  @override
  String get mapMyLocation => 'Konumuma git';

  @override
  String mapListingLine(String rating, String setting) {
    return '$rating · $setting';
  }

  @override
  String nightsTotalShort(int nights) {
    return '$nights gece toplam';
  }

  @override
  String get noResultsTitle => 'Bu kriterlere uygun\nbungalov bulamadık';

  @override
  String get noResultsBody =>
      'Birkaç filtreyi gevşetmeyi dene. Şu öneriler işine yarayabilir:';

  @override
  String get relaxDates => 'Tarihleri ±2 gün esnet';

  @override
  String get relaxHeatedPool => 'Isıtmalı havuzu kaldır';

  @override
  String get relaxPrice => 'Fiyat aralığını genişlet';

  @override
  String relaxExtra(int count) {
    return '$count bungalov daha çıkıyor';
  }

  @override
  String get clearAllFilters => 'Tüm filtreleri temizle';

  @override
  String get datesTitle => 'Ne zaman geliyorsun?';

  @override
  String get datesSubtitle =>
      'Fiyatlar gece başına. Yeşil noktalı günler daha uygun.';

  @override
  String get datesPrevMonth => 'Önceki ay';

  @override
  String get datesNextMonth => 'Sonraki ay';

  @override
  String get datesLegendSelected => 'Seçili';

  @override
  String get datesLegendStay => 'Konaklama';

  @override
  String get datesLegendDeal => 'Uygun fiyat';

  @override
  String get datesLegendBooked => 'Dolu';

  @override
  String datesSummary(String dates, int nights) {
    return '$dates · $nights gece';
  }

  @override
  String get datesPickCheckIn => 'Giriş tarihini seç';

  @override
  String get datesPickCheckOut => 'Çıkış tarihini seç';

  @override
  String get datesClear => 'Tarihleri temizle';

  @override
  String dayPriceShort(String price) {
    return '${price}b';
  }

  @override
  String dayUnavailable(String day) {
    return '$day, dolu';
  }

  @override
  String get guestsTitle => 'Kimler geliyor?';

  @override
  String get guestsSubtitle =>
      'Misafir sayısı fiyatı ve kuralları etkileyebilir.';

  @override
  String get guestsAdults => 'Yetişkin';

  @override
  String get guestsAdultsNote => '13 yaş ve üzeri';

  @override
  String get guestsChildren => 'Çocuk';

  @override
  String get guestsChildrenNote => '2–12 yaş';

  @override
  String get guestsInfants => 'Bebek';

  @override
  String get guestsInfantsNote => '2 yaş altı · kapasiteye sayılmaz';

  @override
  String get guestsPets => 'Evcil hayvan';

  @override
  String get guestsPetsNote => 'Patili dostlar';

  @override
  String get guestsPetsNotAllowed => 'Bu bungalov evcil hayvan kabul etmiyor';

  @override
  String guestsCapacity(int count) {
    return 'Bu bungalov en fazla $count misafir kabul ediyor.';
  }

  @override
  String counterDecrease(String name) {
    return '$name azalt';
  }

  @override
  String counterIncrease(String name) {
    return '$name artır';
  }

  @override
  String get weekdaysShort => 'Pt,Sa,Ça,Pe,Cu,Ct,Pz';

  @override
  String get share => 'Paylaş';

  @override
  String get photoTour => 'Fotoğraf turu';

  @override
  String photoTourSubtitle(String title, int count) {
    return '$title · $count fotoğraf';
  }

  @override
  String photoCountShort(int count) {
    return '$count fotoğraf';
  }

  @override
  String get pinchToZoom => 'İki parmakla yakınlaştır';

  @override
  String get roomLiving => 'Oturma odası';

  @override
  String get roomBedroom => 'Yatak odası';

  @override
  String get roomBathroom => 'Banyo';

  @override
  String get roomOutdoor => 'Dış alan';

  @override
  String get roomPool => 'Havuz';

  @override
  String photoProgress(int current, int total) {
    return '$current / $total fotoğraf';
  }

  @override
  String get propertyBadgeBungalow => 'Ahşap bungalov';

  @override
  String statGuests(int count) {
    return '$count misafir';
  }

  @override
  String statRooms(int count) {
    return '$count oda';
  }

  @override
  String statBeds(int count) {
    return '$count yatak';
  }

  @override
  String statBaths(int count) {
    return '$count banyo';
  }

  @override
  String get guestFavoriteTwoLine => 'Misafirlerin\ngözdesi';

  @override
  String topPercent(int percent) {
    return 'En iyi %$percent';
  }

  @override
  String get reviewsLabel => 'Değerlendirme';

  @override
  String hostLine(String name) {
    return 'Ev sahibi: $name';
  }

  @override
  String get hostSuperhost => 'Altın Bungalovum Ev Sahibi';

  @override
  String get hostStandard => 'Ev sahibi';

  @override
  String hostYears(int years) {
    return '$years yıl';
  }

  @override
  String hostSubline(String level, String years) {
    return '$level · $years';
  }

  @override
  String get messageHost => 'Ev sahibine yaz';

  @override
  String get poolTitle => 'Havuz';

  @override
  String get poolPrivate => 'Sana özel · paylaşımsız';

  @override
  String get poolShared => 'Ortak kullanım';

  @override
  String get poolTemperature => 'Sıcaklık';

  @override
  String get poolSize => 'Boyut';

  @override
  String get poolDepth => 'Derinlik';

  @override
  String get poolSeason => 'Açık olduğu';

  @override
  String poolHeated(int temp) {
    return '$temp°C · Isıtmalı';
  }

  @override
  String get poolUnheated => 'Isıtmasız';

  @override
  String poolSizeValue(String w, String l) {
    return '$w × $l m';
  }

  @override
  String poolDepthValue(String min, String max) {
    return '$min – $max m';
  }

  @override
  String get readMore => 'Devamını oku';

  @override
  String get guestsLoved => 'Misafirler bunu sevdi';

  @override
  String get topicPool => 'Havuz';

  @override
  String get topicCleanliness => 'Temizlik';

  @override
  String get topicHost => 'Ev sahibi';

  @override
  String topicCount(String topic, int count) {
    return '$topic · $count';
  }

  @override
  String allReviews(int count) {
    return '$count değerlendirmenin tümü';
  }

  @override
  String get whatOffers => 'Bu mekân neler sunuyor?';

  @override
  String allAmenities(int count) {
    return '$count olanağın tümü';
  }

  @override
  String amenityCount(int count) {
    return '$count olanak';
  }

  @override
  String get whereYouWillBe => 'Nerede olacaksın?';

  @override
  String get locationAfterBooking =>
      'Tam konum rezervasyondan sonra paylaşılır.';

  @override
  String get addressAfterBooking =>
      'Tam adres rezervasyondan sonra paylaşılır.';

  @override
  String nearbyMinutes(String name, int minutes) {
    return '$name · $minutes dk';
  }

  @override
  String get expandMap => 'Haritayı büyüt';

  @override
  String get availability => 'Uygunluk';

  @override
  String get changeDates => 'Tarihleri değiştir';

  @override
  String get thingsToKnow => 'Bilinmesi gerekenler';

  @override
  String get cancellationPolicy => 'İptal politikası';

  @override
  String cancellationSummary(int hours) {
    return '$hours saat ücretsiz iptal, sonrasında iade yok.';
  }

  @override
  String get houseRules => 'Ev kuralları';

  @override
  String houseRulesSummary(String checkIn, String checkOut, int guests) {
    return 'Giriş $checkIn · Çıkış $checkOut · En fazla $guests misafir';
  }

  @override
  String get safetyTitle => 'Güvenlik ve mekân';

  @override
  String get reportListing => 'Bu ilanı bildir';

  @override
  String get nearbyListings => 'Yakındaki diğer bungalovlar';

  @override
  String get rareFindBanner => 'Nadir fırsat! Bu yer genelde dolu';

  @override
  String get bookNow => 'Rezerve et';

  @override
  String get requestToBook => 'Talep gönder';

  @override
  String nightsAndDates(int nights, String dates) {
    return '$nights gece · $dates';
  }

  @override
  String get addDatesForPrice => 'Fiyat için tarih ekle';

  @override
  String perNightPrice(String price) {
    return '$price / gece';
  }

  @override
  String get aboutListing => 'Bu bungalov hakkında';

  @override
  String get descSpace => 'Mekân';

  @override
  String get descGuestAccess => 'Misafir erişimi';

  @override
  String get descOther => 'Bilinmesi gerekenler';

  @override
  String listingNumbers(String listingNo, String permitNo) {
    return 'İlan no: $listingNo  ·  İzin belge no: $permitNo';
  }

  @override
  String get reviewsTitle => 'Değerlendirmeler';

  @override
  String reviewsCount(int count) {
    return '$count değerlendirme';
  }

  @override
  String get ratingCleanliness => 'Temizlik';

  @override
  String get ratingAccuracy => 'Doğruluk';

  @override
  String get ratingCommunication => 'İletişim';

  @override
  String get ratingLocation => 'Konum';

  @override
  String get all => 'Tümü';

  @override
  String daysAgo(int count) {
    return '$count gün önce';
  }

  @override
  String weeksAgo(int count) {
    return '$count hafta önce';
  }

  @override
  String monthsAgo(int count) {
    return '$count ay önce';
  }

  @override
  String get today => 'Bugün';

  @override
  String starsLabel(int count) {
    return '$count yıldız';
  }

  @override
  String get groupOutdoor => 'Dış alan';

  @override
  String get groupIndoor => 'İç mekân';

  @override
  String get groupNotIncluded => 'Dahil olmayanlar';

  @override
  String get amenPrivatePool => 'Özel havuz';

  @override
  String get amenJacuzzi => 'Jakuzi';

  @override
  String get amenBarbecue => 'Mangal alanı';

  @override
  String get amenParking => 'Ücretsiz otopark';

  @override
  String get amenKitchen => 'Tam donanımlı mutfak';

  @override
  String get amenWifi => 'Hızlı Wi-Fi';

  @override
  String get amenAirConditioning => 'Klima';

  @override
  String get amenOrthopedicBed => 'Ortopedik yatak';

  @override
  String get amenFireplace => 'Şömine';

  @override
  String get amenPets => 'Evcil hayvan';

  @override
  String get amenStepFree => 'Engelsiz giriş';

  @override
  String get rulesTabHouse => 'Ev kuralları';

  @override
  String get rulesTabCancel => 'İptal';

  @override
  String get rulesTabSafety => 'Güvenlik';

  @override
  String get rulesCheckInOut => 'Giriş ve çıkış';

  @override
  String get rulesDuringStay => 'Konaklama sırasında';

  @override
  String get rulesCancelPreview => 'İptal politikası (önizleme)';

  @override
  String ruleCheckIn(String from, String to) {
    return 'Giriş $from – $to';
  }

  @override
  String ruleCheckOut(String time) {
    return 'Çıkış $time’e kadar';
  }

  @override
  String get ruleKeybox => 'Anahtar kutusu ile kendin giriş yap';

  @override
  String get ruleSmartLock => 'Akıllı kilit ile kendin giriş yap';

  @override
  String get ruleHostCheckIn => 'Ev sahibi seni karşılar';

  @override
  String ruleMaxGuests(int count) {
    return 'En fazla $count misafir';
  }

  @override
  String get rulePetsNo => 'Evcil hayvan kabul edilmez';

  @override
  String get rulePetsYes => 'Evcil hayvan kabul edilir';

  @override
  String ruleQuiet(String from, String to) {
    return 'Sessiz saatler $from – $to';
  }

  @override
  String get ruleNoSmoking => 'Kapalı alanda sigara içilmez';

  @override
  String cancelUntil(String date) {
    return '$date kadar';
  }

  @override
  String cancelAfter(String date) {
    return '$date sonra';
  }

  @override
  String get cancelFullRefund => 'Ücretin tamamı iade edilir';

  @override
  String get cancelNoRefund => 'İade yapılmaz';

  @override
  String get cancelPickDates =>
      'Tarih seçtiğinde iptal tarihleri burada görünür.';

  @override
  String get safetyCo => 'Karbonmonoksit alarmı';

  @override
  String get safetySmoke => 'Duman dedektörü';

  @override
  String get safetyFirstAid => 'İlk yardım çantası';

  @override
  String get safetyExtinguisher => 'Yangın söndürücü';

  @override
  String get safetyCamera => 'Dış mekân kamerası';

  @override
  String approxLocation(String area) {
    return '$area · yaklaşık konum';
  }

  @override
  String get whatsNearby => 'Yakında neler var?';

  @override
  String distanceWalk(String distance, int minutes) {
    return '$distance · $minutes dk yürüme';
  }

  @override
  String distanceDrive(String distance, int minutes) {
    return '$distance · $minutes dk';
  }

  @override
  String meters(String value) {
    return '$value m';
  }

  @override
  String kilometers(String value) {
    return '$value km';
  }

  @override
  String get yourHost => 'Ev sahibin';

  @override
  String get hostResponseRate => 'Yanıt oranı';

  @override
  String get hostResponseTime => 'Yanıt süresi';

  @override
  String get hostLanguages => 'Konuştuğu diller';

  @override
  String get hostIdentity => 'Kimlik';

  @override
  String get hostVerified => 'Doğrulandı';

  @override
  String get hostNotVerified => 'Doğrulanmadı';

  @override
  String get withinHour => '1 saat içinde';

  @override
  String withinHours(int hours) {
    return '$hours saat içinde';
  }

  @override
  String percentValue(int value) {
    return '%$value';
  }

  @override
  String get about => 'Hakkında';

  @override
  String hostListings(String name) {
    return '$name’ın bungalovları';
  }

  @override
  String get ratingLabel => 'Puan';

  @override
  String get copyLink => 'Bağlantıyı kopyala';

  @override
  String get linkCopied => 'Bağlantı kopyalandı';

  @override
  String get shareWhatsapp => 'WhatsApp';

  @override
  String get shareMessages => 'Mesajlar';

  @override
  String get shareEmail => 'E-posta';

  @override
  String get shareOther => 'Diğer';

  @override
  String ratingAndRegion(String rating, String region) {
    return '$rating · $region';
  }

  @override
  String get reportTitle => 'Bu ilanı neden bildiriyorsun?';

  @override
  String get reportSubtitle =>
      'Bildirimin ev sahibiyle paylaşılmaz. Ekibimiz 24 saat içinde inceler.';

  @override
  String get reportInaccurate =>
      'Fotoğraflar ya da bilgiler gerçeği yansıtmıyor';

  @override
  String get reportFraud => 'Dolandırıcılık şüphesi';

  @override
  String get reportOffPlatform => 'Uygulama dışında ödeme istendi';

  @override
  String get reportSafety => 'Güvenlik sorunu';

  @override
  String get reportOther => 'Diğer';

  @override
  String get reportDetails => 'Ayrıntı ekle (isteğe bağlı)';

  @override
  String get reportDetailsHint => 'Ne gördüğünü kısaca anlat…';

  @override
  String get reportEmergency =>
      'Acil bir güvenlik durumu varsa önce 112’yi ara.';

  @override
  String get reportSubmit => 'Bildirimi gönder';

  @override
  String get reportSent => 'Bildirimin alındı. Teşekkürler!';

  @override
  String get saveToList => 'Listeye kaydet';

  @override
  String get newList => 'Yeni liste oluştur';

  @override
  String listItems(int count) {
    return '$count kayıt';
  }

  @override
  String get emptyList => 'Boş liste';

  @override
  String get listName => 'Liste adı';

  @override
  String get listNameHint => 'Örn. Yaz tatili';

  @override
  String get create => 'Oluştur';

  @override
  String get wizardContinue => 'Devam';

  @override
  String get wizPoolPrivate => 'Özel havuz';

  @override
  String get wizPoolShared => 'Ortak havuz';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get show => 'Göster';

  @override
  String get hide => 'Gizle';

  @override
  String get start => 'Başla';

  @override
  String get done => 'Tamam';

  @override
  String get increase => 'Artır';

  @override
  String get decrease => 'Azalt';

  @override
  String get tapToSet => 'Belirle';

  @override
  String get draftSaved =>
      'Taslağın kaydedildi. Kaldığın yerden devam edebilirsin.';

  @override
  String get saveAndExit => 'Kaydet ve çık';

  @override
  String get sectionSentToReview =>
      'Kaydedildi. Bu bölüm yeniden incelemeye alındı; ilanın yayında kalır.';

  @override
  String get sectionInReview => 'Yeniden inceleniyor';

  @override
  String get monthFrom => 'Başlangıç';

  @override
  String get monthTo => 'Bitiş';

  @override
  String wizardStepOf(int step, int total) {
    return 'Adım $step / $total';
  }

  @override
  String countOf(int count, int total) {
    return '$count / $total';
  }

  @override
  String selectedCount(int count) {
    return '$count seçildi';
  }

  @override
  String rangeValue(String from, String to) {
    return '$from – $to';
  }

  @override
  String sizeValue(String width, String length) {
    return '$width × $length';
  }

  @override
  String metersValue(String value) {
    return '$value m';
  }

  @override
  String celsius(int value) {
    return '$value°C';
  }

  @override
  String squareMeters(int value) {
    return '$value m²';
  }

  @override
  String bedroomsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yatak odası',
      zero: 'Yatak odası yok',
    );
    return '$_temp0';
  }

  @override
  String amenitiesCount(int count) {
    return '$count olanak';
  }

  @override
  String photoCount(int count) {
    return '$count fotoğraf';
  }

  @override
  String photosSummary(int count, int rooms) {
    return '$count fotoğraf · $rooms alan';
  }

  @override
  String photoIndex(int index, int total) {
    return '$index / $total';
  }

  @override
  String safetySummary(int count, String checkIn, String checkOut) {
    return '$count donanım · Giriş $checkIn · Çıkış $checkOut';
  }

  @override
  String permitNoShort(String no) {
    return 'İzin no $no';
  }

  @override
  String ibanShort(String masked) {
    return 'IBAN $masked';
  }

  @override
  String nightsTimesPrice(int nights, String price) {
    return '$nights gece × $price';
  }

  @override
  String similarRange(String min, String max) {
    return 'Benzer bungalovlar: $min – $max';
  }

  @override
  String missingSteps(int count) {
    return '$count adım eksik';
  }

  @override
  String todayAt(String time) {
    return 'Bugün $time';
  }

  @override
  String addPhotoTo(String room) {
    return '$room için fotoğraf ekle';
  }

  @override
  String removeItem(String item) {
    return '$item maddesini sil';
  }

  @override
  String bedDouble(int count) {
    return '$count çift kişilik';
  }

  @override
  String bedSingle(int count) {
    return '$count tek kişilik';
  }

  @override
  String bedSofa(int count) {
    return '$count tek kişilik kanepe';
  }

  @override
  String bedBunk(int count) {
    return '$count ranza';
  }

  @override
  String wizHighlights(int count) {
    return 'Öne çıkan $count özellik';
  }

  @override
  String wizHighlightsFull(int count) {
    return 'En fazla $count özellik seçebilirsin. Önce birini kaldır.';
  }

  @override
  String wizPhotosRule(int min, int recommended) {
    return 'En az $min · Önerilen $recommended+';
  }

  @override
  String get hostProgram => 'Ev sahibi programı';

  @override
  String get hostHeroTitle => 'Bungalovun boş kalmasın';

  @override
  String get hostHeroBody =>
      'Doğa kaçamağı arayan misafirlerle buluş. Takvimini, fiyatını ve kurallarını sen belirle.';

  @override
  String get hostStep1 => 'Bungalovunu anlat';

  @override
  String get hostStep1Body => 'Fotoğraflar, havuz, olanaklar ve kurallar';

  @override
  String get hostStep2 => 'Belgelerini ekle';

  @override
  String get hostStep2Body => 'İzin belgesi, kimlik ve ödeme bilgileri';

  @override
  String get hostStep3 => 'İncelemeden sonra yayına al';

  @override
  String get hostStep3Body => 'Ekibimiz 1–2 iş günü içinde kontrol eder';

  @override
  String get hostPrepTitle => 'Başlamadan hazırla';

  @override
  String get hostPrep1 =>
      'Turizm amaçlı kiralama izin belgesi (veya işletme belgesi)';

  @override
  String get hostPrep2 => 'Tapu ya da malik izin yazısı';

  @override
  String get hostPrep3 => 'Kimlik kartın ve kendi adına IBAN';

  @override
  String get hostPrep4 => 'En az 8 net fotoğraf';

  @override
  String get letsStart => 'Hadi başlayalım';

  @override
  String get continueWhereLeft => 'Kaldığın yerden devam et';

  @override
  String get stepTypeLocation => 'Tür, konum ve kapasite';

  @override
  String get stepBasics => 'Temel bilgiler';

  @override
  String get stepPoolAmenities => 'Havuz ve olanaklar';

  @override
  String get stepPhotos => 'Fotoğraflar';

  @override
  String get stepTitleDescription => 'Başlık ve açıklama';

  @override
  String get stepSafetyRules => 'Güvenlik ve kurallar';

  @override
  String get stepPricing => 'Fiyat ve rezervasyon';

  @override
  String get stepCheckIn => 'Giriş ve ev kılavuzu';

  @override
  String get stepLegal => 'Yasal belgeler';

  @override
  String get stepIdentityPayout => 'Kimlik ve ödeme';

  @override
  String get wizTypeTitle => 'Bungalovun nasıl bir yer?';

  @override
  String get wizTypeSubtitle =>
      'Misafirlerin aramada seni doğru kategoride bulsun.';

  @override
  String get wizTypeSection => 'Bungalov türü';

  @override
  String get wizSettingSection => 'Çevresi';

  @override
  String get wizAddressSection => 'Adres';

  @override
  String get wizAddressLabel => 'Açık adres';

  @override
  String get wizCity => 'İl';

  @override
  String get wizDistrict => 'İlçe';

  @override
  String get wizCitySearch => 'İl ara';

  @override
  String get wizDistrictSearch => 'İlçe ara';

  @override
  String get wizCityFirst => 'Önce ili seç';

  @override
  String get pickerNoMatch => 'Eşleşen sonuç yok. Yazımı kontrol et.';

  @override
  String get wizPinHint => 'Pini sürükleyerek konumu düzelt';

  @override
  String get wizAddressPrivacy =>
      'Tam adres yalnızca rezervasyonu onaylanan misafirle paylaşılır.';

  @override
  String get wizBasicsTitle => 'Kaç kişi ağırlayabilirsin?';

  @override
  String get wizBasicsSubtitle =>
      'Bu bilgiler ilan detayındaki özellik kutucuklarında görünür.';

  @override
  String get wizGuests => 'Misafir';

  @override
  String get wizGuestsHint => 'En fazla kaç kişi kalabilir?';

  @override
  String get wizBedrooms => 'Yatak odası';

  @override
  String get wizBeds => 'Yatak';

  @override
  String get wizBathrooms => 'Banyo';

  @override
  String get wizBedTypes => 'Yatak tipleri';

  @override
  String get wizAddBed => 'Yatak ekle';

  @override
  String get wizSize => 'Bungalov büyüklüğü';

  @override
  String get wizIndoorM2 => 'Kapalı alan (m²)';

  @override
  String get wizGardenM2 => 'Bahçe (m²)';

  @override
  String get wizWholePlace => 'Bungalovun tamamı mı?';

  @override
  String get wizWholePlaceYes => 'Tamamı misafire ait';

  @override
  String get wizSharedGarden => 'Ortak bahçe';

  @override
  String get wizPoolTitle => 'Havuzunu ve olanaklarını anlat';

  @override
  String get wizPoolSubtitle =>
      'Havuz bilgisi, misafirlerin ilan detayında ilk baktığı yerlerden biri.';

  @override
  String get wizHasPool => 'Havuz var';

  @override
  String get wizHeated => 'Isıtmalı';

  @override
  String get wizPoolTemp => 'Sıcaklık';

  @override
  String get wizPoolDepth => 'Derinlik';

  @override
  String get wizPoolSize => 'Boyut';

  @override
  String get wizPoolSeason => 'Açık olduğu aylar';

  @override
  String get wizMin => 'En az (m)';

  @override
  String get wizMax => 'En çok (m)';

  @override
  String get wizWidth => 'En (m)';

  @override
  String get wizLength => 'Boy (m)';

  @override
  String get wizAmenities => 'Olanaklar';

  @override
  String get wheelHint => 'Kaydır ya da ortadaki değere dokunup yaz';

  @override
  String minCharsHint(int count, int min) {
    return 'Devam etmek için en az $min karakter yaz · $count / $min';
  }

  @override
  String get wheelUnitCelsius => '°C';

  @override
  String get wheelUnitPercent => '%';

  @override
  String get wheelUnitNights => 'gece';

  @override
  String get poolHeatedShort => 'Isıtmalı';

  @override
  String get wizPhotosTitle => 'Fotoğraflarını ekle';

  @override
  String get wizPhotosSubtitle =>
      'Odalara göre yükle; misafirler fotoğraf turunda aynı sırayla görür.';

  @override
  String get coverPhoto => 'Kapak fotoğrafı';

  @override
  String get photoActions => 'Fotoğraf seçenekleri';

  @override
  String get makeCover => 'Kapak fotoğrafı yap';

  @override
  String get moveEarlier => 'Öne al';

  @override
  String get moveLater => 'Sona al';

  @override
  String get deletePhoto => 'Fotoğrafı sil';

  @override
  String get errorPhotoUpload =>
      'Fotoğraf yüklenemedi. Bağlantını kontrol edip tekrar dene.';

  @override
  String get wizPhotosTip =>
      'Gün ışığında, yatay çekilmiş fotoğraflar daha çok tıklanır. Havuzun akşam aydınlatmalı halini de ekle.';

  @override
  String get wizTitleTitle => 'Bungalovunu anlat';

  @override
  String get wizTitleSubtitle =>
      'Bu metinler ilan detayında ve açıklama panelinde görünür.';

  @override
  String get wizListingTitle => 'İlan başlığı';

  @override
  String get wizTitleLabel => 'Başlık';

  @override
  String get wizTitleHint =>
      'Kısa ve akılda kalıcı olsun; konumu ve en güçlü özelliği vurgula.';

  @override
  String get wizDescription => 'Açıklama';

  @override
  String get wizSpace => 'Mekân';

  @override
  String get wizGuestAccess => 'Misafir erişimi';

  @override
  String get wizOtherNotes => 'Bilinmesi gerekenler';

  @override
  String get tagLakeView => 'Göl manzarası';

  @override
  String get tagHeatedPool => 'Isıtmalı havuz';

  @override
  String get tagSelfCheckIn => 'Kendi kendine giriş';

  @override
  String get tagInForest => 'Orman içinde';

  @override
  String get tagSunsetTerrace => 'Gün batımı terası';

  @override
  String get tagQuietArea => 'Sessiz bölge';

  @override
  String get wizSafetyTitle => 'Güvenlik ve ev kuralları';

  @override
  String get wizSafetySubtitle =>
      'Misafirler bunları rezervasyondan önce “Bilinmesi gerekenler” bölümünde görür.';

  @override
  String get wizSafetyGear => 'Güvenlik donanımı';

  @override
  String get wizCoNote =>
      'Şömine, soba veya gazlı ısıtıcı varsa şiddetle önerilir';

  @override
  String get wizPoolFenceNote => 'Çocuklu misafirler için önemli';

  @override
  String get wizCameraNote =>
      'Varsa yerini belirtmelisin. İç mekânda kameraya izin verilmez.';

  @override
  String get safetyPoolFence => 'Havuz çiti veya güvenlik kapağı';

  @override
  String get wizCameraLocation => 'Kameranın yeri';

  @override
  String get wizCameraLocationRequired =>
      'Dış kameranın yerini yazman gerekiyor.';

  @override
  String get wizPoolSafety => 'Havuz güvenliği';

  @override
  String get wizNoLifeguard =>
      'Havuzda cankurtaran olmadığını misafire bildiriyorum';

  @override
  String get wizDepthMarked => 'Havuz derinliği havuz başında yazılı';

  @override
  String get wizHouseRules => 'Ev kuralları';

  @override
  String get checkInTime => 'Giriş saati';

  @override
  String get checkOutTime => 'Çıkış saati';

  @override
  String get wizPets => 'Evcil hayvan kabul edilir';

  @override
  String get wizSmoking => 'Kapalı alanda sigara içilebilir';

  @override
  String get wizEvents => 'Etkinlik ve parti';

  @override
  String get wizQuietHours => 'Sessiz saatler';

  @override
  String get wizPriceTitle => 'Fiyatını ve rezervasyon tercihini belirle';

  @override
  String get wizPriceSubtitle =>
      'Fiyatı istediğin zaman takvimden gün gün değiştirebilirsin.';

  @override
  String get nightlyPrice => 'Gecelik fiyat';

  @override
  String get weekendPrice => 'Hafta sonu';

  @override
  String get cleaningFee => 'Temizlik ücreti';

  @override
  String get weeklyDiscount => 'Haftalık indirim';

  @override
  String get minNights => 'En az konaklama';

  @override
  String get earningsTitle => 'Misafir ne öder, sana ne kalır?';

  @override
  String get serviceFeeExample => 'Hizmet bedeli (örnek oran)';

  @override
  String get youEarn => 'Sana kalan (tahmini)';

  @override
  String get earningsNote =>
      'Komisyon oranı ve vergiler netleşince burada gerçek değer görünecek.';

  @override
  String get wizBookingType => 'Rezervasyon tipi';

  @override
  String get instantBook => 'Anında onay';

  @override
  String get instantBookBody =>
      'Misafir müsait günlerde doğrudan rezervasyon yapar. Aramada daha üstte çıkarsın.';

  @override
  String get requestBook => 'Benim onayımla';

  @override
  String get requestBookBody =>
      'Her talebi 24 saat içinde onaylar ya da reddedersin.';

  @override
  String get instantBookShort => 'Anında onay';

  @override
  String get requestBookShort => 'Onaylı talep';

  @override
  String get policyFlexible => 'Esnek';

  @override
  String get policyFlexibleBody => 'Girişten 24 saat öncesine kadar tam iade';

  @override
  String get policyModerate => 'Orta';

  @override
  String get policyModerateBody => 'Girişten 5 gün öncesine kadar tam iade';

  @override
  String get policyStrict => 'Katı';

  @override
  String get policyStrictBody => '7 gün öncesine kadar %50 iade';

  @override
  String get availabilityCalendar => 'Müsaitlik takvimi';

  @override
  String get availabilityCalendarSub =>
      'Dolu günleri ve özel fiyatları işaretle';

  @override
  String get calendar => 'Takvim';

  @override
  String get calendarSoon => 'Takvim yönetimi çok yakında burada olacak.';

  @override
  String get wizCheckInTitle => 'Misafirin içeri nasıl girecek?';

  @override
  String get wizCheckInSubtitle =>
      'Bu bilgiler yalnızca onaylı misafire, girişten bir gün önce görünür.';

  @override
  String get wizCheckInMethod => 'Giriş yöntemi';

  @override
  String get checkInKeybox => 'Anahtar kutusu';

  @override
  String get checkInSmartLock => 'Akıllı kilit';

  @override
  String get checkInInPerson => 'Ben karşılarım';

  @override
  String get wizCheckInInfo => 'Giriş bilgileri';

  @override
  String get smartLockCode => 'Akıllı kilit kodu';

  @override
  String get lockboxPlace => 'Kutunun yeri';

  @override
  String get wifiName => 'Wi-Fi adı';

  @override
  String get wifiPassword => 'Wi-Fi şifresi';

  @override
  String get wifiShort => 'Wi-Fi';

  @override
  String get checkoutListShort => 'çıkış listesi';

  @override
  String get wizInstructions => 'Kullanım talimatları';

  @override
  String get wizPoolInstructions => 'Havuz ve jakuzi';

  @override
  String get wizHouseInstructions => 'Ev düzeni';

  @override
  String get wizCheckoutList => 'Çıkış listesi';

  @override
  String get wizCheckoutItem => 'Madde';

  @override
  String get addItem => 'Madde ekle';

  @override
  String get wizLegalTitle => 'Yasal belgelerini ekle';

  @override
  String get wizLegalSubtitle =>
      'Belgeler yalnızca ekibimiz tarafından incelenir, misafirlerle paylaşılmaz.';

  @override
  String get wizLegalLaw =>
      '7464 sayılı Kanun gereği konutunu turizm amaçlı kiralamak için Kültür ve Turizm Bakanlığı’ndan izin belgesi alman gerekir. Belgesiz ilanlar yayına alınmaz.';

  @override
  String get wizPermitType => 'Belge türü';

  @override
  String get permitTourismRental => 'Turizm amaçlı kiralama izin belgesi';

  @override
  String get permitTourismRentalBody => 'e-Devlet üzerinden Bakanlıktan alınır';

  @override
  String get permitTourismOperation => 'Turizm işletme belgesi';

  @override
  String get permitTourismOperationBody => 'Bakanlık belgeli tesisler için';

  @override
  String get permitMunicipal => 'Belediye işletme ruhsatı';

  @override
  String get permitMunicipalBody => 'Bungalov tesisi olarak ruhsatlıysan';

  @override
  String get wizPermitInfo => 'Belge bilgileri';

  @override
  String get permitNoLabel => 'İzin belge numarası';

  @override
  String get permitNoHint =>
      'Bu numara ilan sayfanda “İzin belge no” olarak görünür.';

  @override
  String get noPermitHow => 'Belgem yok, nasıl alırım?';

  @override
  String get wizDocuments => 'Belgeler';

  @override
  String get docPermit => 'İzin belgesi';

  @override
  String get docPermitBody => 'PDF veya fotoğraf';

  @override
  String get docDeed => 'Tapu';

  @override
  String get docDeedBody => 'Kiracıysan kira sözleşmesi + malik izni';

  @override
  String get docCondo => 'Kat malikleri oy birliği kararı';

  @override
  String get docCondoBody => 'Aynı parselde birden fazla bağımsız bölüm varsa';

  @override
  String get docAttorney => 'Vekaletname';

  @override
  String get docAttorneyBody => 'Başvuruyu malik adına yapıyorsan';

  @override
  String get docPlate => 'Plaka girişte asılı';

  @override
  String get docPlateBody =>
      'Bakanlığın verdiği plakanın giriş kapısında görünür olduğunu gösteren bir fotoğraf ekle.';

  @override
  String get docUpload => 'Yükle';

  @override
  String get docReplace => 'Yeniden yükle';

  @override
  String get docUploaded => 'Belge yüklendi';

  @override
  String get docUploadedShort => 'Yüklendi';

  @override
  String get errorDocUpload =>
      'Belge yüklenemedi. Bağlantını kontrol edip tekrar dene.';

  @override
  String get ifNeeded => 'Gerekirse';

  @override
  String get wizEntrancePlate => 'Bina girişi plakası';

  @override
  String get wizResponsibilities => 'Sorumluluklarım';

  @override
  String get declKbs =>
      'Misafir kimliklerini Kimlik Bildirim Sistemi’ne bildireceğim';

  @override
  String get declKbsBody =>
      '1774 sayılı Kanun gereği bildirim yükümlülüğü izin belgesi sahibindedir';

  @override
  String get declPermitHolder =>
      'Kiralamayı izin belgesi sahibi olarak ben yapıyorum';

  @override
  String get declPermitHolderBody =>
      'Belge devredilemez, konut başkasına alt kiraya verilemez';

  @override
  String get declUpdate =>
      'Belge bilgilerim değişirse 30 gün içinde güncelleyeceğim';

  @override
  String get wizTaxInfo => 'Vergi bilgileri';

  @override
  String get taxIndividual => 'Şahıs';

  @override
  String get taxCompany => 'Şirket';

  @override
  String get tcknLabel => 'T.C. kimlik no';

  @override
  String get taxNoLabel => 'Vergi numarası';

  @override
  String get taxOffice => 'Vergi dairesi';

  @override
  String get taxNote =>
      'Kira gelirin ticari kazanç olarak vergilendirilebilir. Doğru beyan için mali müşavirine danışmanı öneririz.';

  @override
  String get wizIdentityTitle => 'Kimliğini doğrula, ödeme bilgini ekle';

  @override
  String get wizIdentitySubtitle =>
      'Kazancın yalnızca doğrulanmış ve kendi adına olan hesaba gönderilir.';

  @override
  String get wizIdentity => 'Kimlik doğrulama';

  @override
  String get idFront => 'Kimlik kartı ön yüz';

  @override
  String get idFrontBody => 'Çipli T.C. kimlik kartı';

  @override
  String get idBack => 'Kimlik kartı arka yüz';

  @override
  String get idBackBody => 'Işık yansımasın';

  @override
  String get idSelfie => 'Selfie';

  @override
  String get idSelfieBody => 'Yüzün kimlikle eşleşmeli';

  @override
  String get errorIdentity =>
      'Fotoğrafı doğrulayamadık. İyi ışıkta, net bir fotoğrafla tekrar dene.';

  @override
  String get wizPayout => 'Ödeme alma';

  @override
  String get accountHolder => 'Hesap sahibi';

  @override
  String get ibanLabel => 'IBAN';

  @override
  String get ibanHint => 'TR00 0000 0000 0000 0000 0000 00';

  @override
  String get ibanNote =>
      'IBAN senin adına olmalı. Ödemeler misafirin girişinden 24 saat sonra aktarılır.';

  @override
  String get errorIban => 'Bu IBAN geçerli görünmüyor. Rakamları kontrol et.';

  @override
  String get errorIbanHolder =>
      'Hesap sahibi, doğrulanan kimliğindeki adla aynı olmalı.';

  @override
  String get identityRejected =>
      'Kimliğini doğrulayamadık. Üç fotoğrafı iyi ışıkta yeniden çek.';

  @override
  String get errorListingIncomplete =>
      'Bazı adımlarda eksik bilgi var. Önizlemedeki işaretli bölümleri tamamla.';

  @override
  String errorListingIncompleteSteps(String steps) {
    return 'Şu adımlarda eksik bilgi var: $steps. Tamamlayıp tekrar gönder.';
  }

  @override
  String get errorConsents => 'Göndermeden önce üç onayı da işaretle.';

  @override
  String get errorListingInReview =>
      'İlanın incelemede. İnceleme bitince düzenleyebilirsin.';

  @override
  String get errorTaxId =>
      'Vergi bilgisini kontrol et; numara geçerli görünmüyor.';

  @override
  String get errorUnpublishBookings =>
      'Yaklaşan rezervasyonların var. Önce onları tamamla ya da iptal et.';

  @override
  String get errorSessionExpired =>
      'Oturumun sona ermiş. Tekrar giriş yapıp dene.';

  @override
  String get errorAddressNotFound =>
      'Adresi haritada bulamadık. İl ve ilçe adını kontrol edip tekrar dene.';

  @override
  String get errorIbanRequired =>
      'Hesap sahibini değiştirmek için IBAN\'ı da yeniden gir.';

  @override
  String get wizBillingContact => 'Fatura ve iletişim';

  @override
  String get billingAddress => 'Fatura adresi';

  @override
  String get emergencyPhone => 'Acil durum telefonu';

  @override
  String get reachableTitle => 'Konaklama sırasında misafir beni arayabilir';

  @override
  String get reachableBody => 'Ulaşılabilir ev sahipleri daha iyi puan alır';

  @override
  String get kvkkNote =>
      'Bilgilerin KVKK kapsamında şifrelenerek saklanır ve yalnızca doğrulama ile ödeme için kullanılır.';

  @override
  String get goToPreview => 'Önizlemeye geç';

  @override
  String get previewTitle => 'Son bir kontrol';

  @override
  String get previewSubtitle => 'Misafirler ilanını tam olarak böyle görecek.';

  @override
  String get badgeNew => 'Yeni';

  @override
  String get completedSteps => 'Tamamlanan adımlar';

  @override
  String get allDone => 'Hepsi tamam';

  @override
  String get consents => 'Onaylar';

  @override
  String get consentAccuracy =>
      'Verdiğim bilgilerin doğru ve güncel olduğunu onaylıyorum';

  @override
  String get consentAgreement =>
      'Ev Sahibi Sözleşmesi’ni ve ayrımcılık karşıtı politikayı kabul ediyorum';

  @override
  String get consentMinistry =>
      'Bakanlık uyarısı gelirse ilanımın yayından kaldırılabileceğini biliyorum';

  @override
  String get submitForReview => 'İncelemeye gönder';

  @override
  String get inReviewTitle => 'İlanın incelemede';

  @override
  String get inReviewBody =>
      'Belgelerini ve ilan bilgilerini kontrol ediyoruz. Genellikle 1–2 iş günü sürer; sonucu bildirim ve e-posta ile ileteceğiz.';

  @override
  String get reviewSent => 'İlan gönderildi';

  @override
  String get reviewChecking => 'Belgeler kontrol ediliyor';

  @override
  String get reviewCheckingBody => 'İzin belgesi, tapu ve kimlik';

  @override
  String get reviewPublish => 'Yayına alınır';

  @override
  String get reviewPublishBody => 'Keşfet’te görünmeye başlar';

  @override
  String get inReviewTip =>
      'Bu sürede takvimini doldurabilir, fiyatlarını gün gün ayarlayabilirsin.';

  @override
  String get homePage => 'Ana sayfa';

  @override
  String get manageListing => 'İlanımı yönet';

  @override
  String get statusPublished => 'Yayında';

  @override
  String get statusPaused => 'Rezervasyona kapalı';

  @override
  String get statusInReview => 'İncelemede';

  @override
  String get statusRejected => 'Düzeltme gerekli';

  @override
  String get statusDraft => 'Taslak';

  @override
  String get manageTitle => 'İlanını yönet';

  @override
  String get manageSubtitle =>
      'Değişiklikler kaydedildiği an ilan sayfana yansır.';

  @override
  String get openForBooking => 'Rezervasyona açık';

  @override
  String get openForBookingBody => 'Kapatırsan yeni rezervasyon alınmaz';

  @override
  String get previewListing => 'İlanı önizle';

  @override
  String get groupListingPage => 'İlan sayfası';

  @override
  String get groupPriceBooking => 'Fiyat ve rezervasyon';

  @override
  String get groupGuestExperience => 'Misafir deneyimi';

  @override
  String get groupDocsAccount => 'Belgeler ve hesap';

  @override
  String get identityVerification => 'Kimlik doğrulama';

  @override
  String get verified => 'Doğrulandı';

  @override
  String get notVerified => 'Doğrulanmadı';

  @override
  String get payout => 'Ödeme alma';

  @override
  String get manageReviewNote =>
      'Belge, kimlik veya IBAN bilgilerini değiştirirsen bu bölüm yeniden incelemeye alınır; ilanın yayında kalır.';

  @override
  String get unpublish => 'İlanı yayından kaldır';

  @override
  String get unpublishTitle => 'İlan yayından kalksın mı?';

  @override
  String get unpublishBody =>
      'İlanın Keşfet’te görünmez ve yeni rezervasyon alınmaz. Mevcut rezervasyonların geçerli kalır; dilediğinde yeniden yayına alabilirsin.';

  @override
  String get unpublished => 'İlan yayından kaldırıldı';

  @override
  String get propertyStoneHouse => 'Taş ev';

  @override
  String get propertyGlampingTent => 'Glamping çadırı';

  @override
  String get propertyTinyHouse => 'Tiny house';

  @override
  String get settingMountainView => 'Dağ manzarası';

  @override
  String get settingNearSea => 'Deniz yakını';

  @override
  String get systemNotifOffTitle => 'Bildirimler telefonunda kapalı';

  @override
  String get systemNotifOffBody =>
      'Seçtiğin bildirimleri alabilmen için telefonunun bildirim iznini açman gerekiyor.';

  @override
  String get turnOnNotifications => 'Bildirimleri aç';

  @override
  String get offlineTitle => 'Ormanda kaldık galiba';

  @override
  String get offlineBody =>
      'İnternet bağlantın yok gibi görünüyor. Bağlantını kontrol edip tekrar dene.';

  @override
  String get offlineSavedLink => 'Kaydettiklerini çevrimdışı gör';

  @override
  String get stillOffline => 'Hâlâ bağlantı yok. Biraz sonra tekrar dene.';

  @override
  String get locationPermissionTitle => 'Yakınındaki kaçamakları bulalım';

  @override
  String get locationPermissionBody =>
      'Konumunu yalnızca sana yakın bungalovları ve yol sürelerini göstermek için kullanırız.';

  @override
  String get allowLocation => 'Konum iznini ver';

  @override
  String get notNow => 'Şimdi değil';

  @override
  String get notificationPermissionTitle => 'Önemli anları kaçırma';

  @override
  String get notificationPermissionBody =>
      'Rezervasyon onayı, ev sahibi mesajları ve kaydettiğin yerlerdeki fiyat düşüşleri için haber verelim.';

  @override
  String get enableNotifications => 'Bildirimleri aç';

  @override
  String get maybeLater => 'Belki sonra';

  @override
  String get permissionBlockedHint =>
      'İzni telefonunun ayarlarından açabilirsin.';

  @override
  String get sampleNotifApprovedTitle => 'Rezervasyonun onaylandı';

  @override
  String get sampleNotifApprovedBody => 'Göl Esintisi · 6–8 Kas';

  @override
  String get sampleNotifPriceTitle => 'Fiyat düştü!';

  @override
  String get sampleNotifPriceBody => 'Çam Yamaç ₺850 daha uygun';

  @override
  String get sampleNotifMessageTitle => 'Ev sahibinden mesaj';

  @override
  String get sampleNotifMessageBody => '“Havuz hazır olacak…”';

  @override
  String get couponAlreadyAdded => 'Bu kupon zaten hesabında.';

  @override
  String get walletTitle => 'Cüzdan';

  @override
  String get groupTravelPayments => 'Seyahat ödemeleri';

  @override
  String get paymentMethodsTitle => 'Ödeme yöntemleri';

  @override
  String get noSavedCards => 'Kayıtlı kart yok';

  @override
  String get paymentHistoryTitle => 'Ödeme geçmişi';

  @override
  String get paymentHistorySub => 'Ödemeler ve iadeler';

  @override
  String get couponsTitle => 'Kuponlar';

  @override
  String get noActiveCoupons => 'Aktif kupon yok';

  @override
  String activeCouponsCount(int count) {
    return '$count aktif kupon';
  }

  @override
  String get paymentMethodsSubtitle =>
      'Kartını bir kez ekle, rezervasyonlarda tek dokunuşla öde.';

  @override
  String get payInAppTitle => 'Ödemeni hep uygulamadan yap';

  @override
  String get payInAppBody =>
      'Böylece rezervasyonun iptal ve iade güvencemiz kapsamında kalır.';

  @override
  String get payInAppLink => 'Nasıl korunuyorum?';

  @override
  String get makeDefaultCard => 'Varsayılan yap';

  @override
  String get removeCard => 'Kartı kaldır';

  @override
  String get defaultCardSet => 'Varsayılan kart güncellendi';

  @override
  String get cardRemoved => 'Kart kaldırıldı';

  @override
  String get addCard => 'Kart ekle';

  @override
  String get cardBrandsAccepted => 'Visa · Mastercard · Troy';

  @override
  String get addNewCard => 'Yeni kart ekle';

  @override
  String get cardAdded => 'Kart eklendi';

  @override
  String get errorCardAdd =>
      'Kart eklenemedi. Bilgileri kontrol edip tekrar dene.';

  @override
  String get saveCardCta => 'Kartı kaydet';

  @override
  String get cardsStoredSafely =>
      'Kart bilgilerin ödeme kuruluşunda şifreli saklanır, bizde tutulmaz.';

  @override
  String get paymentsTab => 'Ödemeler';

  @override
  String get refundsTab => 'İadeler';

  @override
  String get noPaymentsTitle => 'Henüz ödeme yok';

  @override
  String get noPaymentsBody =>
      'Rezervasyon yaptığında ödemelerini ve iadelerini buradan takip edebilirsin.';

  @override
  String get noRefundsTitle => 'İade yok';

  @override
  String get noRefundsBody =>
      'İptal ettiğin rezervasyonların iadeleri burada görünür.';

  @override
  String get lookingForPaymentTitle => 'Başka bir ödeme mi arıyorsun?';

  @override
  String get lookingForPaymentBody =>
      'Bankana yansıyan bir tutarı burada göremiyorsan bize yaz.';

  @override
  String get lookingForPaymentLink => 'Yardım merkezine göz at';

  @override
  String paymentLine(String date, String card) {
    return '$date · $card';
  }

  @override
  String provisionLine(String date) {
    return '$date · Provizyon, onay bekliyor';
  }

  @override
  String refundLine(String date, String card) {
    return '$date · $card kartına iade';
  }

  @override
  String refundAmount(String amount) {
    return '+$amount';
  }

  @override
  String get couponAdded => 'Kupon hesabına eklendi';

  @override
  String get applyCode => 'Kodu uygula';

  @override
  String get couponTermsNote =>
      'Her kuponun kullanım koşulları kupon ayrıntısında yazar.';

  @override
  String get yourCoupons => 'Kuponların';

  @override
  String couponLine(String code, String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: ' · $days gün kaldı',
      zero: '',
    );
    return '$code · $date tarihine kadar$_temp0';
  }

  @override
  String couponPercentOff(int percent) {
    return '%$percent indirim';
  }

  @override
  String get groupCouponFaq => 'Merak edilenler';

  @override
  String get couponFaq1Q => 'Kuponun son kullanma tarihini nereden görürüm?';

  @override
  String get couponFaq1A =>
      'Hesabına eklediğin her kuponun altında son kullanma tarihi ve kalan gün sayısı yazar.';

  @override
  String get couponFaq2Q =>
      'Bir rezervasyonda birden fazla kupon kullanabilir miyim?';

  @override
  String get couponFaq2A =>
      'Hayır. Her rezervasyonda tek kupon kullanılır ve kupon ilandaki diğer indirimlerin yerine geçer.';

  @override
  String get couponFaq3Q => 'Rezervasyonu iptal edersem kuponum geri gelir mi?';

  @override
  String get couponFaq3A =>
      'Kuponun süresi dolmadıysa iptalden sonra hesabına geri yüklenir ve yeniden kullanabilirsin.';

  @override
  String get helpSearchLabel => 'Yardım ara';

  @override
  String get accountTitle => 'Hesabım';

  @override
  String memberSince(String year) {
    return 'Misafir · $year’ten beri';
  }

  @override
  String get viewProfile => 'Profili gör';

  @override
  String get statStays => 'Konaklama';

  @override
  String get statReviews => 'Yorum';

  @override
  String get statSaved => 'Kayıtlı';

  @override
  String get hostCtaTitle => 'Bungalovunu kirala';

  @override
  String get hostCtaBody =>
      'Boş günlerini kazanca çevir. İlanını 10 adımda oluştur.';

  @override
  String get groupAccount => 'Hesap';

  @override
  String get groupSupport => 'Destek';

  @override
  String get rowPersonalInfo => 'Bilgilerim';

  @override
  String get rowPersonalInfoSub => 'Ad, iletişim, adres';

  @override
  String get rowSecurity => 'Giriş ve güvenlik';

  @override
  String get rowNotificationPrefs => 'Bildirim tercihleri';

  @override
  String get rowPrivacy => 'Gizlilik';

  @override
  String get rowWallet => 'Cüzdan ve ödemeler';

  @override
  String get rowWalletSub => 'Kartlar, geçmiş, kuponlar';

  @override
  String get rowHelp => 'Yardım merkezi';

  @override
  String get rowLegal => 'Hukuki bilgiler';

  @override
  String get signOut => 'Çıkış yap';

  @override
  String get signOutTitle => 'Çıkış yapmak istiyor musun?';

  @override
  String get signOutBody =>
      'Kaydettiklerin ve rezervasyonların hesabında kalır; tekrar giriş yaptığında hepsi burada.';

  @override
  String versionLine(String version) {
    return 'Bungalovum · Sürüm $version';
  }

  @override
  String get guestAccountTitle => 'Hoş geldin!';

  @override
  String get guestAccountBody =>
      'Rezervasyon yapmak, kaydetmek ve ev sahipleriyle yazışmak için giriş yap.';

  @override
  String get personalInfoTitle => 'Bilgilerim';

  @override
  String get personalInfoSubtitle =>
      'Rezervasyonda ev sahibiyle yalnızca gereken kadarı paylaşılır.';

  @override
  String get profilePhoto => 'Profil fotoğrafı';

  @override
  String get profilePhotoSub => 'Ev sahipleri seni tanısın';

  @override
  String get change => 'Değiştir';

  @override
  String get groupContact => 'İletişim';

  @override
  String get fieldDisplayName => 'Görünen ad';

  @override
  String get fieldEmergencyContact => 'Acil durum kişisi';

  @override
  String get fieldEmergencyName => 'Kişinin adı';

  @override
  String get fieldEmergencyPhone => 'Kişinin telefonu';

  @override
  String get notAdded => 'Eklenmedi';

  @override
  String get phoneNotAdded => 'Numara eklenmedi';

  @override
  String verifyNote(String item) {
    return 'Değişiklikten sonra yeni $item için doğrulama kodu göndereceğiz.';
  }

  @override
  String get saved => 'Kaydedildi';

  @override
  String emergencyLine(String name, String phone) {
    return '$name · $phone';
  }

  @override
  String get securityTitle => 'Giriş ve güvenlik';

  @override
  String get groupSignInMethods => 'Giriş yöntemleri';

  @override
  String get biometricTitle => 'Biyometrik giriş';

  @override
  String get biometricBody => 'Parmak izi veya yüz tanıma';

  @override
  String get passwordRow => 'Şifre';

  @override
  String passwordUpdatedAgo(String ago) {
    return '$ago güncellendi';
  }

  @override
  String get update => 'Güncelle';

  @override
  String get groupDevices => 'Cihazların';

  @override
  String get thisDevice => 'Bu cihaz';

  @override
  String deviceLine(String city, String time) {
    return '$city · $time';
  }

  @override
  String get signOutDevice => 'Oturumu kapat';

  @override
  String get deviceSignedOut => 'Cihazdaki oturum kapatıldı';

  @override
  String get groupDanger => 'Tehlikeli bölge';

  @override
  String get closeAccount => 'Hesabı kapat';

  @override
  String get closeAccountSub => 'Bu işlem geri alınamaz';

  @override
  String get changePasswordTitle => 'Şifreni güncelle';

  @override
  String get fieldCurrentPassword => 'Mevcut şifre';

  @override
  String get errorWrongPassword =>
      'Şifre doğru değil. Tekrar dene ya da şifreni sıfırla.';

  @override
  String get passwordUpdated => 'Şifren güncellendi';

  @override
  String get closeAccountTitle => 'Hesabını kapatmak üzeresin';

  @override
  String get closeAccountSubtitle => 'Devam etmeden önce neler olacağını bil.';

  @override
  String get closeUpcomingTitle => 'Yaklaşan rezervasyonun var';

  @override
  String closeUpcomingBody(String booking) {
    return '$booking. Hesabı kapatmadan önce iptal etmen gerekir.';
  }

  @override
  String get closeListsTitle => 'Kayıtlı listelerin silinir';

  @override
  String closeListsBody(int lists, int saved) {
    return '$lists liste ve $saved bungalov kalıcı olarak silinir.';
  }

  @override
  String get closeReviewsTitle => 'Yorumların anonimleşir';

  @override
  String get closeReviewsBody =>
      'Yazdığın değerlendirmeler isimsiz olarak kalır.';

  @override
  String get closeLegalTitle => 'Yasal kayıtlar';

  @override
  String get closeLegalBody =>
      'Fatura ve ödeme kayıtları mevzuatın öngördüğü süre boyunca saklanır.';

  @override
  String get confirmWithPassword => 'Onaylamak için şifreni gir';

  @override
  String get goToTrips => 'Seyahatlerime git';

  @override
  String get accountClosed => 'Hesabın kapatıldı. Seni özleyeceğiz.';

  @override
  String get notifPrefsTitle => 'Bildirim tercihleri';

  @override
  String get notifPrefsSubtitle =>
      'Neyi, ne zaman ve nereden duyacağını sen seç.';

  @override
  String get groupForYou => 'Senin için';

  @override
  String get groupFromBungalovum => 'Bungalovum’dan';

  @override
  String get topicPromotions => 'Kampanya ve indirimler';

  @override
  String get topicStayReminders => 'Konaklama hatırlatmaları';

  @override
  String get topicNews => 'Yenilikler';

  @override
  String get topicSurveys => 'Anket ve geri bildirim';

  @override
  String get topicRuleUpdates => 'Kural güncellemeleri';

  @override
  String get channelPush => 'Bildirim';

  @override
  String get channelEmail => 'E-posta';

  @override
  String get channelSms => 'SMS';

  @override
  String get off => 'Kapalı';

  @override
  String get disableMarketing => 'Tüm pazarlama bildirimlerini kapat';

  @override
  String get marketingDisabled => 'Pazarlama bildirimleri kapatıldı';

  @override
  String get privacyTitle => 'Gizlilik';

  @override
  String get privacySubtitle => 'Verilerinin nasıl kullanıldığını sen yönet.';

  @override
  String get groupVisibility => 'Görünürlük';

  @override
  String get showProfileTitle => 'Profilimi ev sahiplerine göster';

  @override
  String get showProfileBody => 'Ad, fotoğraf ve doğrulama durumu';

  @override
  String get showNameTitle => 'Yorumlarımda adım görünsün';

  @override
  String get showNameBody => 'Kapalıysa yalnızca baş harfin görünür';

  @override
  String get groupDataPermissions => 'Veri ve izinler';

  @override
  String get locationTitle => 'Konum erişimi';

  @override
  String get locationBody => 'Yakındaki bungalovları önermek için';

  @override
  String get personalizedTitle => 'Kişiselleştirilmiş öneriler';

  @override
  String get personalizedBody => 'Gezinme geçmişine göre';

  @override
  String get groupYourData => 'Verilerin';

  @override
  String get downloadData => 'Verilerimi indir';

  @override
  String get downloadDataSub => 'KVKK kapsamında bir kopyasını iste';

  @override
  String get privacyNoticeRow => 'Aydınlatma metni';

  @override
  String get deleteAccountData => 'Hesabımı ve verilerimi sil';

  @override
  String get dataExportRequested =>
      'Talebin alındı. Verilerinin kopyası 30 gün içinde e-postana gönderilecek.';

  @override
  String get helpTitle => 'Nasıl yardımcı olabiliriz?';

  @override
  String get helpSearchHint => 'Bir konu ara…';

  @override
  String get helpCenter => 'Yardım merkezi';

  @override
  String get helpCenterSub => 'Rehber ve cevaplar';

  @override
  String get safetySupport => 'Güvenlik desteği';

  @override
  String get safetySupportSub => 'Acil durumda bize ulaş';

  @override
  String get reportProblem => 'Sorun bildir';

  @override
  String get reportProblemSub => 'Konaklama ya da bölge';

  @override
  String get feedback => 'Geri bildirim';

  @override
  String get feedbackSub => 'Uygulamayı geliştir';

  @override
  String get faqTitle => 'Sık sorulanlar';

  @override
  String get faqNoMatch =>
      'Aramana uyan soru bulamadık. Destek ekibimize yazabilirsin.';

  @override
  String get feedbackTitle => 'Geri bildirim gönder';

  @override
  String get feedbackLabel => 'Ne düşünüyorsun?';

  @override
  String get feedbackHint => 'Neyi sevdin, neyi geliştirelim?';

  @override
  String get feedbackSent => 'Teşekkürler! Geri bildirimin ekibimize ulaştı.';

  @override
  String get send => 'Gönder';

  @override
  String get legalTitle => 'Hukuki bilgiler';

  @override
  String get docTerms => 'Kullanım Koşulları';

  @override
  String get docKvkk => 'KVKK Aydınlatma Metni';

  @override
  String get docPrivacy => 'Gizlilik Politikası';

  @override
  String get docCookies => 'Çerez Politikası';

  @override
  String get docDistanceSales => 'Mesafeli Satış Sözleşmesi';

  @override
  String get docCancellation => 'İptal ve İade Koşulları';

  @override
  String legalFooter(String version, String date) {
    return 'Sürüm $version · Son güncelleme: $date';
  }

  @override
  String updatedOn(String date) {
    return 'Son güncelleme: $date';
  }

  @override
  String get chatsTitle => 'Sohbetler';

  @override
  String get chatFilterAll => 'Tümü';

  @override
  String get chatFilterStay => 'Konaklama';

  @override
  String get chatFilterSupport => 'Destek';

  @override
  String get searchChats => 'Sohbetlerde ara';

  @override
  String get searchChatsHint => 'Kişi ya da bungalov ara';

  @override
  String get chatsEmptyTitle => 'Henüz sohbetin yok';

  @override
  String get chatsEmptyBody =>
      'Bir ev sahibine yazdığında ya da rezervasyon yaptığında konuşmaların burada görünür.';

  @override
  String get chatsNoMatch => 'Aramana uyan sohbet yok.';

  @override
  String chatContextRequest(String listing) {
    return '$listing · Talep';
  }

  @override
  String supportTicket(String no) {
    return 'Destek talebi #$no';
  }

  @override
  String youPrefix(String text) {
    return 'Sen: $text';
  }

  @override
  String get photoMessage => 'Fotoğraf';

  @override
  String unreadCount(int count) {
    return '$count okunmamış mesaj';
  }

  @override
  String get online => 'Çevrimiçi';

  @override
  String get typeMessage => 'Mesaj yaz…';

  @override
  String get sendMessageAction => 'Gönder';

  @override
  String get attachPhoto => 'Fotoğraf ekle';

  @override
  String get details => 'Detay';

  @override
  String get messageFailed => 'Gönderilemedi · Tekrar dene';

  @override
  String get messageSending => 'Gönderiliyor';

  @override
  String get messageRead => 'Okundu';

  @override
  String get messageSent => 'Gönderildi';

  @override
  String chatStartHint(String time) {
    return 'Merhaba de! Ev sahibin genelde $time yanıt verir.';
  }

  @override
  String get chatSafetyNote =>
      'Güvenliğin için ödemeleri yalnızca Bungalovum üzerinden yap.';

  @override
  String get notificationsTitle => 'Bildirimler';

  @override
  String get markAllRead => 'Tümünü okundu say';

  @override
  String get sectionToday => 'Bugün';

  @override
  String get sectionThisWeek => 'Bu hafta';

  @override
  String get sectionEarlier => 'Daha önce';

  @override
  String hoursAgo(int count) {
    return '$count saat önce';
  }

  @override
  String minutesAgo(int count) {
    return '$count dakika önce';
  }

  @override
  String get justNow => 'Az önce';

  @override
  String get notificationsEmptyTitle => 'Yeni bildirimin yok';

  @override
  String get notificationsEmptyBody =>
      'Rezervasyon, mesaj ve fırsatlar burada görünür.';

  @override
  String get unread => 'Okunmadı';

  @override
  String get savedTitle => 'Kaydettiklerim';

  @override
  String savedSummary(int lists, int count) {
    return '$lists liste · $count bungalov';
  }

  @override
  String get newListTile => 'Yeni liste';

  @override
  String get createListTitle => 'Liste oluştur';

  @override
  String get groupYourTrips => 'Kaçamaklarını grupla';

  @override
  String get recentlyViewedTitle => 'Son baktıkların';

  @override
  String get yesterday => 'Dün';

  @override
  String recentTileSub(String when, int count) {
    return '$when · $count bungalov';
  }

  @override
  String get savedTip =>
      'İpucu: Bir bungalovun kalbine dokun, istediğin listeye ekle.';

  @override
  String get savedEmptyTitle => 'Henüz bir şey kaydetmedin';

  @override
  String get savedEmptyBody =>
      'Beğendiğin bungalovların kalbine dokun; hafta sonu, yaz tatili gibi listelerde topla.';

  @override
  String get startExploring => 'Keşfetmeye başla';

  @override
  String listSubtitleDates(int count, String dates) {
    return '$count bungalov · $dates için fiyatlar';
  }

  @override
  String listSubtitle(int count) {
    return '$count bungalov · gecelik fiyatlar';
  }

  @override
  String get addDates => 'Tarih ekle';

  @override
  String get unavailableForDates => 'Bu tarihlerde dolu';

  @override
  String get perNightShort => '· gece';

  @override
  String noteChip(String note) {
    return 'Not: $note';
  }

  @override
  String get addNote => 'Not ekle';

  @override
  String get noteLabel => 'Notun';

  @override
  String get noteHint => 'Örn. Annemlerle gidebiliriz';

  @override
  String get removeNote => 'Notu sil';

  @override
  String get editList => 'Listeyi düzenle';

  @override
  String get shareList => 'Listeyi paylaş';

  @override
  String get listLinkCopied => 'Liste bağlantısı kopyalandı';

  @override
  String get listNotShareable => 'Önce listeyi bağlantıyla paylaşılabilir yap.';

  @override
  String get listEmptyTitle => 'Bu liste henüz boş';

  @override
  String get listEmptyBody =>
      'Beğendiğin bungalovların kalbine dokunup bu listeye ekleyebilirsin.';

  @override
  String get shareableTitle => 'Bağlantıyla paylaşılabilsin';

  @override
  String get shareableBody => 'Bağlantıya sahip olanlar listeyi görebilir';

  @override
  String get deleteList => 'Listeyi sil';

  @override
  String get deleteListTitle => 'Listeyi silmek istiyor musun?';

  @override
  String deleteListBody(String name, int count) {
    return '“$name” ve içindeki $count kayıt silinir. Bungalovlar diğer listelerinde kalır.';
  }

  @override
  String get deleteConfirm => 'Evet, sil';

  @override
  String get listDeleted => 'Liste silindi';

  @override
  String get listSaved => 'Liste güncellendi';

  @override
  String recentSubtitle(int days) {
    return 'Son $days günde incelediğin bungalovlar.';
  }

  @override
  String get clearRecentTitle => 'Son baktıkların temizlensin mi?';

  @override
  String get clearRecentBody =>
      'Geçmiş tüm cihazlarında temizlenir. Kaydettiğin listeler etkilenmez.';

  @override
  String placesCount(int count) {
    return '$count yer';
  }

  @override
  String bedsCount(int count) {
    return '$count yatak';
  }

  @override
  String get recentEmptyTitle => 'Son baktığın bungalov yok';

  @override
  String get recentEmptyBody =>
      'İncelediğin bungalovlar 30 gün boyunca burada durur.';

  @override
  String get checkInLabel => 'Giriş';

  @override
  String get checkOutLabel => 'Çıkış';

  @override
  String fromTime(String time) {
    return '$time itibarıyla';
  }

  @override
  String untilTime(String time) {
    return '$time kadar';
  }

  @override
  String get addressLabel => 'Adres';

  @override
  String get getDirections => 'Yol tarifi al';

  @override
  String get copyAddress => 'Adresi kopyala';

  @override
  String get addressCopied => 'Adres kopyalandı';

  @override
  String addressLocked(String date) {
    return 'Tam adres $date açılır. Şimdilik yaklaşık konumu görüyorsun.';
  }

  @override
  String get guideAndAccess => 'Ev kılavuzu ve giriş bilgileri';

  @override
  String guideLockedNote(String date) {
    return 'Anahtar kutusu şifresi ve Wi-Fi $date açılır.';
  }

  @override
  String get guideOpenNote =>
      'Anahtar kutusu şifresi ve Wi-Fi bilgileri hazır.';

  @override
  String get fastResponder => 'Hızlı yanıt verir';

  @override
  String respondsWithin(String time) {
    return 'Genelde $time yanıt verir';
  }

  @override
  String get callHost => 'Ev sahibini ara';

  @override
  String get messageHostShort => 'Ev sahibine mesaj gönder';

  @override
  String get manageBooking => 'Rezervasyonu yönet';

  @override
  String get reportStayIssue => 'Konaklamada sorun bildir';

  @override
  String get askHostChange => 'Değişiklik için ev sahibine yaz';

  @override
  String get askHostChangeNote => 'Tarih veya kişi sayısı değişikliği';

  @override
  String get receiptAndInvoice => 'Makbuz ve fatura';

  @override
  String get cancelBooking => 'Rezervasyonu iptal et';

  @override
  String get codeCopied => 'Kod kopyalandı';

  @override
  String get cannotOpenLink => 'Uygulama açılamadı. Daha sonra tekrar dene.';

  @override
  String atDateTime(String date, String time) {
    return '$date $time';
  }

  @override
  String get houseGuideTitle => 'Ev kılavuzu';

  @override
  String get lockboxCode => 'Anahtar kutusu şifresi';

  @override
  String lockboxHintLine(String hint, String time) {
    return '$hint · Giriş $time itibarıyla';
  }

  @override
  String lockboxLocked(String date) {
    return 'Şifre $date burada görünecek.';
  }

  @override
  String wifiPasswordLine(String password) {
    return 'Şifre: $password';
  }

  @override
  String get wifiLocked => 'Wi-Fi bilgileri girişten 1 gün önce açılır.';

  @override
  String get wifiLabel => 'Wi-Fi';

  @override
  String checkoutAt(String date, String time) {
    return 'Çıkış · $date, $time';
  }

  @override
  String get reportIssueShort => 'Sorun bildir';

  @override
  String get issueTitle => 'Ne oldu?';

  @override
  String get issueSubtitle =>
      'Bildirimin ev sahibine ve destek ekibimize aynı anda iletilir.';

  @override
  String get issuePool => 'Havuz / jakuzi';

  @override
  String get issueHotWater => 'Sıcak su';

  @override
  String get issueCleaning => 'Temizlik';

  @override
  String get issueWifi => 'Wi-Fi';

  @override
  String get issueClimate => 'Klima / ısıtma';

  @override
  String get issueOther => 'Diğer';

  @override
  String get issueUrgencyTitle => 'Ne kadar acil?';

  @override
  String get urgencyLow => 'Acil değil';

  @override
  String get urgencyToday => 'Bugün çözülmeli';

  @override
  String get urgencyHigh => 'Acil';

  @override
  String get issueDescribe => 'Kısaca anlat';

  @override
  String get issueDescribeHint => 'Ne oldu, ne zamandan beri?';

  @override
  String get issuePhotos => 'Fotoğraf ekle (isteğe bağlı)';

  @override
  String get photoAdd => 'Ekle';

  @override
  String get photoRemove => 'Fotoğrafı kaldır';

  @override
  String issueResponseNote(String time) {
    return 'Ev sahibi genelde $time yanıtlar. Yanıt gelmezse destek ekibimiz devreye girer.';
  }

  @override
  String get issueSubmit => 'Sorunu bildir';

  @override
  String get issueSent =>
      'Bildirimin iletildi. Ev sahibin kısa sürede dönecek.';

  @override
  String errorIssueShort(int min) {
    return 'Ev sahibinin anlayabilmesi için en az $min karakter yaz.';
  }

  @override
  String get urgentCallNote =>
      'Can güvenliğini tehdit eden bir durum varsa önce 112’yi ara.';

  @override
  String get receiptTitle => 'Makbuz';

  @override
  String get paidChip => 'Ödendi';

  @override
  String get refundedChip => 'İade edildi';

  @override
  String get rowStay => 'Konaklama';

  @override
  String get totalLabel => 'Toplam';

  @override
  String get paymentLabel => 'Ödeme';

  @override
  String get taxesLabel => 'Vergiler';

  @override
  String get vatIncluded => 'KDV dahil';

  @override
  String get billingInfo => 'Fatura bilgileri';

  @override
  String billingIndividualLine(String name) {
    return 'Bireysel · $name';
  }

  @override
  String billingCorporateLine(String name) {
    return 'Kurumsal · $name';
  }

  @override
  String get emailReceipt => 'E-postama gönder';

  @override
  String get downloadPdf => 'PDF indir';

  @override
  String receiptEmailed(String email) {
    return 'Makbuz $email adresine gönderildi.';
  }

  @override
  String get receiptLinkCopied => 'Makbuz bağlantısı kopyalandı';

  @override
  String datesWithYear(String dates, int year, int nights) {
    return '$dates $year · $nights gece';
  }

  @override
  String get billingTitle => 'Fatura bilgileri';

  @override
  String get billingSubtitle =>
      'Faturan bu bilgilerle e-posta adresine gönderilir.';

  @override
  String get billingIndividual => 'Bireysel';

  @override
  String get billingCorporate => 'Kurumsal';

  @override
  String get fieldTcknOptional => 'T.C. kimlik no (isteğe bağlı)';

  @override
  String get fieldAddress => 'Adres';

  @override
  String get fieldBillingEmail => 'Fatura e-postası';

  @override
  String get fieldCompanyName => 'Şirket unvanı';

  @override
  String get fieldTaxOffice => 'Vergi dairesi';

  @override
  String get fieldTaxNumber => 'Vergi numarası';

  @override
  String get hintTaxNumber => '10 haneli numara';

  @override
  String get errorTaxNumber => 'Vergi numarası 10 haneli olmalı';

  @override
  String get billingCorporateNote =>
      'Kurumsal fatura için şirket unvanı, vergi dairesi ve vergi numarası istenir.';

  @override
  String get billingSaved => 'Fatura bilgilerin kaydedildi';

  @override
  String get cancelTitle => 'Rezervasyonu iptal et';

  @override
  String get refundAmountLabel => 'İade tutarın';

  @override
  String get fullRefundChip => 'Tam iade';

  @override
  String get partialRefundChip => 'Kısmi iade';

  @override
  String get noRefundChip => 'İade yok';

  @override
  String fullRefundNote(String date) {
    return '$date önce iptal ettiğin için ücretin tamamı iade edilir.';
  }

  @override
  String partialRefundNote(String date) {
    return 'Ücretsiz iptal süresi $date doldu; konaklama bedelinin bir kısmı kesilir.';
  }

  @override
  String get deductionLabel => 'Kesinti';

  @override
  String get refundLabel => 'İade';

  @override
  String get refundTimingNote =>
      'İade, bankana bağlı olarak 5–10 iş günü içinde kartına yansır.';

  @override
  String get cancelReasonTitle => 'İptal sebebin';

  @override
  String get reasonPlansChanged => 'Planlarım değişti';

  @override
  String get reasonFoundOther => 'Başka bir yer buldum';

  @override
  String get reasonHostAsked => 'Ev sahibi iptal etmemi istedi';

  @override
  String get reasonOther => 'Diğer';

  @override
  String get irreversible => 'Bu işlem geri alınamaz.';

  @override
  String get keepBooking => 'Vazgeç';

  @override
  String get confirmCancel => 'İptali onayla';

  @override
  String get bookingCancelled =>
      'Rezervasyonun iptal edildi. İade süreci başladı.';

  @override
  String get reviewTitle => 'Konaklaman nasıldı?';

  @override
  String get overallRating => 'Genel puanın';

  @override
  String get rating1 => 'Kötü';

  @override
  String get rating2 => 'Vasat';

  @override
  String get rating3 => 'İyi';

  @override
  String get rating4 => 'Çok iyi';

  @override
  String get rating5 => 'Mükemmel';

  @override
  String starsOf(int stars) {
    return '$stars / 5 yıldız';
  }

  @override
  String rateStars(String item, int stars) {
    return '$item: $stars yıldız ver';
  }

  @override
  String get detailedRating => 'Ayrıntılı puan';

  @override
  String get reviewCleanliness => 'Temizlik';

  @override
  String get reviewAccuracy => 'Doğruluk';

  @override
  String get reviewCommunication => 'İletişim';

  @override
  String get reviewLocation => 'Konum';

  @override
  String get reviewValue => 'Fiyat / performans';

  @override
  String get whatYouLiked => 'En çok neyi sevdin?';

  @override
  String get likePool => 'Havuz';

  @override
  String get likeView => 'Manzara';

  @override
  String get likeQuiet => 'Sessizlik';

  @override
  String get likeCleanliness => 'Temizlik';

  @override
  String get likeHost => 'Ev sahibi';

  @override
  String get likeLocation => 'Konum';

  @override
  String get yourReview => 'Yorumun';

  @override
  String get reviewHint => 'Konaklamanı diğer misafirler için anlat…';

  @override
  String get addPhoto => 'Fotoğraf ekle';

  @override
  String charCount(int count, int max) {
    return '$count / $max';
  }

  @override
  String get submitReview => 'Değerlendirmeyi gönder';

  @override
  String get reviewThanksTitle => 'Değerlendirmen için teşekkürler!';

  @override
  String get reviewThanksBody => 'Yorumun incelendikten sonra yayınlanacak.';

  @override
  String errorReviewShort(int min) {
    return 'Yorumun en az $min karakter olmalı.';
  }

  @override
  String get errorRateAll => 'Genel puanı ve tüm kategorileri puanla.';

  @override
  String get tripsTitle => 'Seyahatler';

  @override
  String get tabUpcoming => 'Yaklaşan';

  @override
  String get tabPast => 'Geçmiş';

  @override
  String get tabCancelled => 'İptal edilen';

  @override
  String tripsPendingCount(int count) {
    return '$count onay bekliyor';
  }

  @override
  String tripsUpcomingCount(int count) {
    return '$count yaklaşan';
  }

  @override
  String tripsPastCount(int count) {
    return '$count geçmiş';
  }

  @override
  String tripsPastStays(int count) {
    return '$count geçmiş konaklama';
  }

  @override
  String tripsCancelledCount(int count) {
    return '$count iptal edilen rezervasyon';
  }

  @override
  String daysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün kaldı',
      one: 'Yarın',
      zero: 'Bugün',
    );
    return '$_temp0';
  }

  @override
  String get statusConfirmed => 'Onaylandı';

  @override
  String get statusPending => 'Onay bekleniyor';

  @override
  String get statusCancelled => 'İptal edildi';

  @override
  String get statusDeclined => 'Reddedildi';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get actionDirections => 'Yol tarifi';

  @override
  String get actionMessage => 'Mesaj';

  @override
  String get actionCheckIn => 'Giriş bilgisi';

  @override
  String hostResponseHoursLeft(int hours) {
    return 'Ev sahibinin yanıtı için $hours saat kaldı';
  }

  @override
  String hostResponseMinutesLeft(int minutes) {
    return 'Ev sahibinin yanıtı için $minutes dakika kaldı';
  }

  @override
  String get sendMessage => 'Mesaj gönder';

  @override
  String get withdrawRequest => 'Talebi geri çek';

  @override
  String get withdrawTitle => 'Talebi geri çekmek istiyor musun?';

  @override
  String withdrawBody(String amount) {
    return 'Ev sahibine bildirilir ve kartındaki $amount provizyon kaldırılır.';
  }

  @override
  String get withdrawConfirm => 'Evet, geri çek';

  @override
  String get keepRequest => 'Vazgeç';

  @override
  String get withdrawn => 'Talebin geri çekildi';

  @override
  String get confirmedSection => 'Onaylanmış';

  @override
  String get previousStays => 'Önceki konaklamalar';

  @override
  String nightsCount(int nights) {
    return '$nights gece';
  }

  @override
  String get writeReview => 'Yorum yaz';

  @override
  String get rateStay => 'Değerlendir';

  @override
  String youRated(String rating) {
    return 'Değerlendirdin · $rating';
  }

  @override
  String get receipt => 'Makbuz';

  @override
  String get bookAgain => 'Tekrar rezerve et';

  @override
  String cancelledByYou(String date) {
    return 'Sen iptal ettin · $date';
  }

  @override
  String cancelledByHost(String date) {
    return 'Ev sahibi iptal etti · $date';
  }

  @override
  String get declinedByHost => 'Ev sahibi kabul etmedi';

  @override
  String refundedTo(String amount, String card) {
    return '$amount iade edildi · $card';
  }

  @override
  String provisionReleased(String card) {
    return 'Provizyon kaldırıldı · $card';
  }

  @override
  String get refundNote =>
      'İadeler bankana bağlı olarak 5–10 iş günü içinde kartına yansır.';

  @override
  String get emptyUpcomingTitle => 'Henüz bir seyahatin yok';

  @override
  String get emptyUpcomingBody =>
      'Rezervasyon yaptığında yaklaşan konaklamaların, adresin ve giriş bilgilerin burada olacak.';

  @override
  String get exploreBungalows => 'Bungalovları keşfet';

  @override
  String get emptyPastTitle => 'Henüz tamamlanmış bir konaklaman yok';

  @override
  String get emptyPastBody =>
      'Konaklamaların bittikçe burada görünür; değerlendirmeyi de buradan yaparsın.';

  @override
  String get emptyCancelledTitle => 'İptal edilen rezervasyonun yok';

  @override
  String get emptyCancelledBody =>
      'İptal ettiğin ya da kabul edilmeyen talepler burada görünür.';

  @override
  String get loadErrorTitle => 'Bilgiler yüklenemedi';

  @override
  String get requestTitle => 'Rezervasyon talebi gönder';

  @override
  String get hostApprovalChip => 'Ev sahibi onayı gerekir';

  @override
  String get howItWorks => 'Nasıl işliyor?';

  @override
  String get requestStep1Title => 'Talebini gönder';

  @override
  String get requestStep1Body =>
      'Kartında yalnızca provizyon tutulur, ücret çekilmez.';

  @override
  String requestStep2Title(int hours) {
    return 'Ev sahibi $hours saat içinde yanıtlar';
  }

  @override
  String get requestStep2Body => 'Yanıt gelmezse talep kendiliğinden düşer.';

  @override
  String get requestStep3Title => 'Onaylanırsa ödeme alınır';

  @override
  String get requestStep3Body => 'Reddedilirse provizyon kartından kaldırılır.';

  @override
  String get introduceYourself => 'Ev sahibine kendini tanıt (zorunlu)';

  @override
  String introduceHint(String host) {
    return 'Merhaba $host, kimlerle ve ne için geldiğini kısaca anlat…';
  }

  @override
  String errorIntroShort(int min) {
    return 'Ev sahibinin seni tanıyabilmesi için en az $min karakter yaz.';
  }

  @override
  String get notChargedNow => 'Şimdi çekilmez';

  @override
  String get sendRequest => 'Talep gönder';

  @override
  String provisionNote(String amount) {
    return 'Kartından $amount provizyon tutulur; ev sahibi onaylarsa çekilir, reddederse kaldırılır.';
  }

  @override
  String get requestSentTitle => 'Talebin ev sahibine iletildi';

  @override
  String requestSentBody(String host, String time) {
    return '$host genelde $time yanıt veriyor. Gelişmeleri bildirimle haber vereceğiz.';
  }

  @override
  String get responseTimeLeft => 'Yanıt için kalan süre';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }

  @override
  String get responseTimeOver =>
      'Yanıt süresi doldu; provizyon kartından kaldırılacak.';

  @override
  String get rowListing => 'Bungalov';

  @override
  String get rowProvision => 'Provizyon';

  @override
  String amountWithCard(String amount, String card) {
    return '$amount · $card';
  }

  @override
  String get myTrips => 'Seyahatlerim';

  @override
  String requestApprovedTitle(String host) {
    return '$host talebini onayladı!';
  }

  @override
  String requestApprovedBody(String listing, String date) {
    return 'Ödemen alındı ve rezervasyonun kesinleşti. $listing seni $date bekliyor.';
  }

  @override
  String get requestDeclinedTitle => 'Bu sefer olmadı';

  @override
  String requestDeclinedBody(String amount) {
    return 'Ev sahibi bu tarihler için talebini kabul edemedi. $amount provizyon kartından kaldırıldı.';
  }

  @override
  String get similarTitle => 'Aynı tarihlerde boş, benzer yerler';

  @override
  String get seeAllSimilar => 'Tüm benzerleri gör';

  @override
  String priceForNights(String price, int nights) {
    return '$price · $nights gece';
  }

  @override
  String get couponSheetTitle => 'Kupon kodu ekle';

  @override
  String get fieldCouponCode => 'Kupon kodu';

  @override
  String get hintCouponCode => 'Kodu buraya yaz';

  @override
  String get couponApply => 'Uygula';

  @override
  String couponApplied(String code) {
    return '$code uygulandı';
  }

  @override
  String couponSaving(String amount) {
    return '$amount indirim';
  }

  @override
  String get couponRemove => 'Kaldır';

  @override
  String get couponNotFound =>
      'Bu kodu bulamadık. Harfleri kontrol edip tekrar dene.';

  @override
  String get couponExpired => 'Bu kuponun süresi dolmuş.';

  @override
  String get couponNotApplicable => 'Bu kupon bu rezervasyonda geçerli değil.';

  @override
  String get couponNote =>
      'Kupon ilandaki diğer indirimlerin yerine geçer; aynı anda tek kupon kullanılır.';

  @override
  String get bookingConfirmTitle => 'Rezervasyonu onayla';

  @override
  String get instantBookChip => 'Anında onay';

  @override
  String ratingWithCount(String rating, int count) {
    return '$rating · $count değerlendirme';
  }

  @override
  String listingTypeRegion(String type, String region) {
    return '$type · $region';
  }

  @override
  String get yourTrip => 'Seyahatin';

  @override
  String get tripDates => 'Tarihler';

  @override
  String get tripGuests => 'Misafirler';

  @override
  String get edit => 'Düzenle';

  @override
  String editItem(String item) {
    return '$item düzenle';
  }

  @override
  String guestsAdultsCount(int count) {
    return '$count yetişkin';
  }

  @override
  String guestsChildrenCount(int count) {
    return '$count çocuk';
  }

  @override
  String guestsInfantsCount(int count) {
    return '$count bebek';
  }

  @override
  String guestsPetsCount(int count) {
    return '$count evcil hayvan';
  }

  @override
  String get priceDetails => 'Fiyat ayrıntısı';

  @override
  String priceNightsLine(String price, int nights) {
    return '$price × $nights gece';
  }

  @override
  String get priceCleaning => 'Temizlik ücreti';

  @override
  String get priceService => 'Hizmet bedeli';

  @override
  String get discountEarlyBooking => 'Erken rezervasyon indirimi';

  @override
  String get discountLastMinute => 'Son dakika indirimi';

  @override
  String get discountLongStay => 'Uzun konaklama indirimi';

  @override
  String get discountCoupon => 'Kupon indirimi';

  @override
  String get discountSpecial => 'Özel indirim';

  @override
  String minusAmount(String amount) {
    return '–$amount';
  }

  @override
  String get priceTotalTry => 'Toplam (TRY)';

  @override
  String freeCancelUntil(String date) {
    return '$date kadar ücretsiz iptal';
  }

  @override
  String get noRefundAfter => 'Sonrasında iade yapılmaz.';

  @override
  String get acceptRulesLink => 'Ev kurallarını';

  @override
  String get acceptMiddle => ' ve ';

  @override
  String get acceptPolicyLink => 'iptal politikasını';

  @override
  String get acceptEnd => ' okudum, kabul ediyorum.';

  @override
  String get acceptSemantics =>
      'Ev kurallarını ve iptal politikasını okudum, kabul ediyorum.';

  @override
  String get goToPayment => 'Ödemeye geç';

  @override
  String get paymentTitle => 'Ödeme';

  @override
  String get savedCards => 'Kayıtlı kartların';

  @override
  String cardMasked(String brand, String last4) {
    return '$brand •••• $last4';
  }

  @override
  String cardLast4(String last4) {
    return '•••• $last4';
  }

  @override
  String get cardBrandVisa => 'Visa';

  @override
  String get cardBrandMastercard => 'Mastercard';

  @override
  String get cardBrandTroy => 'Troy';

  @override
  String get cardBrandAmex => 'American Express';

  @override
  String get cardBrandUnknown => 'Kart';

  @override
  String cardExpiryShort(String expiry) {
    return 'SKT $expiry';
  }

  @override
  String cardDefaultExpiry(String expiry) {
    return 'Varsayılan · SKT $expiry';
  }

  @override
  String get payWithNewCard => 'Yeni kartla öde';

  @override
  String get installmentsTitle => 'Taksit seçenekleri';

  @override
  String get installmentSingle => 'Tek çekim';

  @override
  String installmentCount(int count) {
    return '$count taksit';
  }

  @override
  String get installmentsNote =>
      'Taksit seçenekleri kartına ve bankana göre değişir.';

  @override
  String get couponTitle => 'Kupon kodun var mı?';

  @override
  String get couponSubtitle => 'İndirimi toplam tutara uygula';

  @override
  String get add => 'Ekle';

  @override
  String get paymentSecure =>
      'Ödemen 3D Secure ile korunur. Kart bilgilerin bizde saklanmaz.';

  @override
  String payAmount(String amount) {
    return '$amount öde';
  }

  @override
  String totalAmount(String amount) {
    return 'Toplam $amount';
  }

  @override
  String get fieldCardHolder => 'Kart üzerindeki isim';

  @override
  String get fieldCardNumber => 'Kart numarası';

  @override
  String get fieldCardExpiry => 'Son kullanma';

  @override
  String get hintCardExpiry => 'AA / YY';

  @override
  String get fieldCardCvc => 'CVC';

  @override
  String get hintCardCvc => '•••';

  @override
  String get saveCardForLater => 'Kartımı sonraki ödemeler için kaydet';

  @override
  String get errorCardNumber => 'Kart numarasını kontrol et';

  @override
  String get errorCardExpiry => 'Geçerli bir tarih gir (AA / YY)';

  @override
  String get errorCardCvc => 'Kartın arkasındaki güvenlik kodunu gir';

  @override
  String get errorPaymentStart =>
      'Ödeme başlatılamadı. Bağlantını kontrol edip tekrar dene.';

  @override
  String get tdsVerifying => 'Bankan doğruluyor';

  @override
  String get tdsRedirect =>
      'Bankanın onay ekranına yönlendiriliyorsun. Bu sayfayı kapatma.';

  @override
  String get tdsTitle => 'Banka doğrulaması';

  @override
  String get tdsSubtitle => '3D Secure · Güvenli ödeme';

  @override
  String get tdsMerchant => 'İşyeri';

  @override
  String get tdsAmount => 'Tutar';

  @override
  String get tdsCard => 'Kart';

  @override
  String tdsCodePrompt(int length) {
    return 'Telefonuna gelen $length haneli SMS şifresini gir.';
  }

  @override
  String get tdsCodeLabel => 'SMS şifresi';

  @override
  String tdsTimeLeft(String time) {
    return 'Kalan süre $time';
  }

  @override
  String get tdsExpired => 'Süre doldu, yeni şifre iste.';

  @override
  String get resend => 'Tekrar gönder';

  @override
  String get confirm => 'Onayla';

  @override
  String get payFailedTitle => 'Ödeme tamamlanamadı';

  @override
  String get payFailedBody =>
      'Bankan işlemi onaylamadı. Kartından herhangi bir ücret çekilmedi.';

  @override
  String get payFailedReasons => 'Olası sebepler';

  @override
  String get payFailedLimit => 'Kart limiti yetersiz olabilir';

  @override
  String get payFailedCode =>
      '3D Secure şifresi hatalı ya da süresi dolmuş olabilir';

  @override
  String get payFailedOnline => 'Kartın internet alışverişine kapalı olabilir';

  @override
  String payFailedHold(String dates, String time) {
    return '$dates tarihleri $time dakika daha senin için tutuluyor.';
  }

  @override
  String payFailedHoldOver(String dates) {
    return '$dates tarihleri artık tutulmuyor; hâlâ müsaitse ödemeyi tamamlayabilirsin.';
  }

  @override
  String get payOtherCard => 'Başka bir kartla öde';

  @override
  String get payRetrySame => 'Aynı kartla tekrar dene';

  @override
  String get bookingDoneTitle => 'Rezervasyonun tamam!';

  @override
  String bookingDoneBody(String listing, String date) {
    return '$listing seni $date bekliyor. Onay e-postanı da gönderdik.';
  }

  @override
  String get amountPaid => 'Ödenen';

  @override
  String get bookingCode => 'Rezervasyon kodu';

  @override
  String get copy => 'Kopyala';

  @override
  String get bookingCodeCopied => 'Rezervasyon kodu kopyalandı';

  @override
  String get bookingDoneAddress =>
      'Tam adres ve giriş talimatları Seyahatler sekmende seni bekliyor.';

  @override
  String get goToTrip => 'Seyahate git';

  @override
  String get guestInfoTitle => 'Misafir bilgileri';

  @override
  String get guestInfoSubtitle =>
      'Yasal bildirim için tüm misafirlerin bilgileri girişten önce tamamlanmalı.';

  @override
  String guestInfoProgress(int done, int total) {
    return '$done / $total tamam';
  }

  @override
  String guestYou(String name) {
    return '$name · Sen';
  }

  @override
  String idMaskedTr(String last2) {
    return 'T.C. ••••••••• $last2';
  }

  @override
  String idMaskedPassport(String last2) {
    return 'Pasaport ••••• $last2';
  }

  @override
  String guestNumber(int number) {
    return 'Misafir $number';
  }

  @override
  String get requiredField => 'Zorunlu';

  @override
  String get nationalityTurkish => 'T.C. vatandaşı';

  @override
  String get nationalityForeign => 'Yabancı uyruklu';

  @override
  String get fieldFullName => 'Ad soyad';

  @override
  String get fieldTckn => 'T.C. kimlik no';

  @override
  String get hintTckn => '11 haneli numara';

  @override
  String get fieldPassport => 'Pasaport no';

  @override
  String get hintPassport => 'Pasaporttaki numara';

  @override
  String get errorTckn => 'T.C. kimlik numarasını kontrol et';

  @override
  String get errorPassport => 'Pasaport numarasını kontrol et';

  @override
  String get guestInfoKvkk =>
      'Bu bilgiler yalnızca yasal kimlik bildirimi için kullanılır ve ev sahibiyle paylaşılır. ';

  @override
  String get privacyNoticeLink => 'Aydınlatma metni';

  @override
  String get guestInfoComplete =>
      'Tüm misafirlerin bilgileri tamam. Girişte görüşmek üzere!';

  @override
  String daysToCheckIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Girişe $days gün kaldı',
      zero: 'Giriş bugün',
    );
    return '$_temp0';
  }

  @override
  String get completeLater => 'Sonra da tamamlayabilirsin';

  @override
  String get guestSaved => 'Misafir bilgileri kaydedildi';

  @override
  String lakeName(String region) {
    return '$region Gölü';
  }
}
