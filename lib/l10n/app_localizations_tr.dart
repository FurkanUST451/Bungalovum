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
  String get welcomeBrand => 'kozalak';

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
  String get hostSuperhost => 'Altın Kozalak Ev Sahibi';

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
    return '$date’e kadar';
  }

  @override
  String cancelAfter(String date) {
    return '$date’ten sonra';
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
  String lakeName(String region) {
    return '$region Gölü';
  }
}
