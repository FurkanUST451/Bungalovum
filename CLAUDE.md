# CLAUDE.md — Bungalovum · Bungalov Kiralama Uygulaması

Bu dosya, projede çalışan Claude Code için **tek doğruluk kaynağıdır**. Her oturumun başında okunur. Tasarım Figma'dadır, bu dosya Figma'nın koda nasıl aktarılacağını, hangi kurallara uyulacağını ve nelerden kaçınılacağını tanımlar.

> Kural önceliği: **Bu dosya > Figma ekranı > genel Flutter alışkanlıkları.** Figma ile bu dosya çelişirse dur ve sor.

---

## 1. Proje özeti

- Türkiye'ye özel (TR-only, tek dil: Türkçe) havuzlu bungalov kiralama uygulaması. Airbnb'den *esinlenir* ama kopyası değildir: kendi renkleri, yuvarlak ve "tatlı" widget'ları, büyük fotoğraflı Keşfet akışı vardır.
- İki taraf: **Misafir** (keşfet → ilan → rezervasyon → seyahat) ve **Ev sahibi** (ilan oluşturma sihirbazı → inceleme → ilan yönetimi).
- Rezervasyon iki modda çalışır: **Anında onay** ve **Ev sahibi onaylı talep** (24 saat içinde onay/ret).
- Hediye kartı yok. Ekstra hizmet satışı yok.
- Marka/ürün adlarında Airbnb'ye ait hiçbir ifade, ikon, renk veya metin kullanılmaz.

## 2. Teknoloji yığını

| Konu | Seçim | Not |
|---|---|---|
| Framework | Flutter (güncel stable), Dart 3 | iOS + Android; tablet desteği zorunlu |
| State | Riverpod (`flutter_riverpod` + `riverpod_annotation`) | Widget içinde iş mantığı yok |
| Routing | `go_router` | Tab'lar için `StatefulShellRoute` |
| Model | `freezed` + `json_serializable` | Tüm modeller immutable |
| Ağ | `dio` + repository katmanı | UI asla doğrudan API çağırmaz |
| Görsel | `cached_network_image` + blurhash/placeholder | Bkz. §7 |
| İkon | `flutter_svg` (Figma'daki `ikon/*` bileşenlerinden SVG export) | Material ikon **kullanma** |
| Font | Plus Jakarta Sans (asset olarak gömülü, `google_fonts` runtime indirmesi yok) | 500/600/700/800 |
| Yerelleştirme | `flutter_localizations` + `intl` ARB (`tr`) | Tek dil olsa da metinler ARB'de |
| Test | `flutter_test`, golden test (`alchemist` veya `golden_toolkit`) | Bkz. §12 |

Yeni paket eklemeden önce gerekçesini yaz ve onay iste.

## 3. Klasör yapısı

```
lib/
  app/                 # MaterialApp, router, theme bootstrap
  core/
    theme/             # tokens.dart, colors.dart, typography.dart, shadows.dart, radii.dart, spacing.dart
    responsive/        # breakpoints.dart, adaptive_layout.dart
    widgets/           # Tasarım sistemi bileşenleri (Kz önekli): KzButton, KzInput, KzChip...
    icons/             # KzIcons (SVG yolları)
    utils/
  features/
    auth/  explore/  listing/  booking/  trips/  saved/  chat/  account/  wallet/  host/
      data/  domain/  presentation/ (screens/, widgets/, controllers/)
  l10n/                # app_tr.arb
assets/
  fonts/  icons/  images/ (2.0x/, 3.0x/)
```

## 4. Figma bağlantısı (MCP)

- Dosya anahtarı: `CIvwD4G3YGjs5RU85EUbAY`
- Sayfalar: **"Misafir Uygulaması"** (tüm ekranlar, ev sahibi akışı dahil) ve **"Bileşenler"** (bileşen kütüphanesi + ikonlar).
- Ekran adları `NN · Başlık` formatındadır (01–95). Bir ekranı kodlarken:
  1. `get_metadata` ile sayfayı tara, ekranı adına göre bul, node id'sini al.
  2. `get_design_context` + `get_screenshot` ile ekranı çek.
  3. Dönen kodu **referans** olarak kullan; birebir yapıştırma. Renk/ölçü değerlerini §5 token'larına eşle.
  4. Bittiğinde ekranı emülatörde 390×844'te açıp Figma screenshot'ı ile karşılaştır.
- Figma'daki gradyan dolgulu kutular **fotoğraf yer tutucusudur**; gerçek görsellerle değiştirilir, gradyan kodlanmaz.
- Figma'daki örnek veriler (Göl Esintisi Bungalov, ₺4.900, 20–22 Kas vb.) sadece mock data içindir.

## 5. Tasarım token'ları (Figma değişkenleriyle birebir)

Figma'da `Kozalak / Renk` ve `Kozalak / Ölçü` koleksiyonları vardır. Kodda **asla** hex veya sayı literal'i kullanma; her zaman token kullan.

### 5.1 Renkler — `KzColors`

| Token | Hex | Kullanım |
|---|---|---|
| `bg` | `#FBF7F0` | Ekran arka planı (sıcak krem) |
| `surface` | `#FFFFFF` | Kart, input, alt bar |
| `sand` | `#F3ECE0` | İkincil yüzey, segment arka planı, ikon kutuları |
| `line` | `#EAE2D4` | Kenarlık, ayırıcı |
| `ink` | `#1B2420` | Ana metin |
| `ink2` | `#5E6762` | İkincil metin (AA kontrastlı — açmak yasak) |
| `forest` | `#1E4D3B` | Marka rengi, birincil buton, seçili durum |
| `forestSoft` | `#DDEBE2` | Seçili kart/chip zemini |
| `apricot` | `#F2895C` | Vurgu (rozet, kalp, uyarı ikonu) — **metin rengi olarak kullanma** |
| `apricotSoft` | `#FDE8DC` | Uyarı/bilgi kutusu zemini |
| `apricotText` | `#A84A24` | apricot tonlu metin (AA kontrastlı) |
| `pool` | `#2F9BB8` | Havuz/su vurgusu — **metin rengi olarak kullanma** |
| `poolSoft` | `#DCF0F5` | Havuz bilgi kutuları |
| `poolText` | `#1F6F85` | pool tonlu metin (AA kontrastlı) |
| `star` | `#F4B63F` | Puan yıldızı |

Kural: Yumuşak zemin (`*Soft`) üzerindeki metin her zaman ilgili `*Text` veya `forest`/`ink` olur. Karartma katmanı: `ink` %40–50 opaklık.

Karanlık tema şimdilik **yok**; `ThemeMode.light` sabit. Token yapısı ileride dark eklenebilecek şekilde `ThemeExtension` ile kurulmalı.

### 5.2 Köşe yarıçapları — `KzRadii`

Figma değişkenleri: `sm 12 · md 20 · lg 28 · xl 36 · pill 999`. Ekranlarda bunlara ek olarak aşağıdaki ara değerler yoğun kullanılıyor; hepsi token olarak tanımlanır:

| Token | Değer | Nerede |
|---|---|---|
| `xs` | 8 | Küçük rozet, mini görsel |
| `sm` | 12 | Küçük kutu |
| `icon` | 15 | 42×42 ikon kutuları (satır başı) |
| `tile` | 18 | Küçük fotoğraf, liste maddesi |
| `md` | 20 | Seçim kartı, ipucu kutusu |
| `field` | 22 | Input, textarea, seçenek satırı |
| `card` | 26 | Standart kart (`Card`, grup listeleri) |
| `lg` | 28 | Büyük kart, fotoğraf, alt bar üst köşeleri |
| `hero` | 30 | Tanıtım görselleri |
| `xl` | 36 | Tab bar, büyük hero |
| `pill` | 999 | Buton, chip, segment, yuvarlak buton |

Figma'da bu tabloda olmayan bir değer görürsen en yakın token'ı kullan; 2px'ten fazla fark varsa sor. Köşeler her zaman yumuşaktır — keskin köşe (0) yalnızca tam ekran görsellerde.

### 5.3 Boşluklar — `KzSpace`

Figma değişkenleri: `xs 4 · sm 8 · md 16 · lg 24 · xl 32`. Ekranlarda en sık kullanılan aralıklar: **2, 4, 6, 8, 10, 12, 14, 16, 20**. Hepsini token yap (`s2 … s32`).

- Ekran yatay kenar boşluğu: **20** (telefon). Tablet kuralı için §6.
- Kart iç boşluğu: **16–18**. Liste satırı: dikey 14, yatay 16.
- Bölümler arası: 16–24. Başlık ile içerik arası: 10–12.

### 5.4 Tipografi — `KzText` (Plus Jakarta Sans)

| Stil | Boyut / Ağırlık | Satır yüksekliği | Harf aralığı | Kullanım |
|---|---|---|---|---|
| `display` | 40 / 800 | 1.05 | -3% | Fiyat vurgusu |
| `h1` | 30 / 800 | 1.10 | -2.5% | Tanıtım başlıkları |
| `h2` | 28 / 800 | 1.15 | -2.5% | Ekran başlığı (Top) |
| `h3` | 26 / 800 | 1.15 | -2% | Sihirbaz adım başlığı |
| `h4` | 22 / 800 | 1.2 | -1% | Bölüm büyük başlık |
| `title` | 17 / 800 | 1.25 | 0 | Bölüm başlığı |
| `titleSm` | 15 / 800 | 1.3 | 0 | Blok başlığı, kart başlığı |
| `bodyStrong` | 15–16 / 700 | 1.4 | 0 | Satır başlığı |
| `body` | 14–15 / 500 | 1.45–1.5 | 0 | Paragraf |
| `label` | 13 / 700–800 | 1.3 | 0 | Link, chip, buton içi küçük |
| `caption` | 12 / 500–600 | 1.45 | 0 | Alt açıklama |
| `micro` | 11 / 600–700 | 1.4 | 0 | Rozet, sayaç |
| `overline` | 12 / 800 | 1.3 | +6%, BÜYÜK HARF | Grup başlıkları ("HESAP") |

- Font asset olarak gömülür (500, 600, 700, 800). Türkçe karakterler (ğ, ş, İ, ı) mutlaka test edilir; büyük harfe çevirmede `toUpperCase()` yerine Türkçe locale kullan (`i → İ`).
- Linkler: `forest` renk + alt çizgi + 800.

### 5.5 Gölgeler — `KzShadows`

Tüm gölgelerin rengi aynı yeşilimsi koyu tondur: **`Color.fromRGBO(26, 51, 38, a)`** (Figma: r0.10 g0.20 b0.15). Saf siyah gölge **yasak**. Gölgeler yumuşak, geniş ve düşük opaklıktadır; spread hep 0.

| Token | Offset Y | Blur | Opaklık | Kullanım |
|---|---|---|---|---|
| `soft` | 8 | 24 | 0.06 | Seçili segment, ince kart |
| `card` | 8 | 24 | 0.08 | Yuvarlak üst butonlar (geri/kapat), kartlar |
| `raised` | 8 | 24 | 0.12 | Görsel üstü butonlar, öne çıkan kart |
| `floating` | 8 | 24 | 0.16 | **Tab bar**, harita kartı, yüzen öğeler |
| `strong` | 10 | 28 | 0.18–0.25 | Harita pini, modal üstü öğeler |
| `bottomBar` | **-6** | 24 | 0.08 | Ekran altı sabit aksiyon barı (yukarı doğru) |

```dart
const _shadowBase = Color.fromRGBO(26, 51, 38, 1);
BoxShadow kzShadow(double y, double blur, double a) =>
    BoxShadow(color: _shadowBase.withValues(alpha: a), offset: Offset(0, y), blurRadius: blur, spreadRadius: 0);
```

- Material `elevation` kullanma; gölgeyi her zaman `BoxDecoration.boxShadow` ile ver.
- Kenarlıklı kartlarda (`line` stroke) genelde gölge yoktur — ikisini birlikte kullanma, Figma'da ne varsa o.
- Kenarlık her zaman **içeri** hizalı (Figma INSIDE) — Flutter'da `Border.all` + doğru iç padding ile boyut sabit kalmalı.

## 6. Ölçeklendirme ve tüm cihazlara uyum (zorunlu)

Figma tasarımları **390×844 (iPhone 14/15 boyutu)** referans çerçevesindedir. Bu bir *referans*, sabit tuval değil.

### 6.1 Temel ilkeler
1. **Global ölçek çarpanı yok.** `flutter_screenutil` gibi her şeyi oranla büyüten/küçülten paketler kullanılmaz. Yazı ve boşluklar mantıksal piksel (dp) olarak token'dan gelir; uyum, **layout** ile sağlanır (Expanded, Flexible, Wrap, LayoutBuilder, maxWidth).
2. **Sabit genişlik yasak.** Figma'daki `w:350` gibi değerler "ekran genişliği − 2×20 padding" demektir. Kodda `double.infinity` / `Expanded` kullan. Sabit yükseklik sadece ikon, avatar, buton (58), input (66), tab bar (72) gibi bileşenlerde.
3. **Taşma sıfır tolerans.** 320 dp genişlikte ve `textScaler` 1.3'te hiçbir ekranda overflow (sarı-siyah şerit) olmamalı. Uzun metinler `maxLines` + `ellipsis` veya satır kaydırma ile çözülür.
4. **SafeArea her yerde.** Figma'daki "Durum çubuğu" bileşeni *çizilmez*; yerini `SafeArea`/`MediaQuery.padding` alır. Alt bar ve tab bar, alt güvenli alanın (home indicator) üstüne oturur.
5. **Klavye:** form ekranlarında alt aksiyon barı klavyenin üstüne çıkar; içerik `SingleChildScrollView` + `viewInsets` ile kayar.

### 6.2 Kırılma noktaları (`KzBreakpoints`)

| Sınıf | Genişlik | Davranış |
|---|---|---|
| `compact` | < 600 | Telefon. Tek kolon, kenar boşluğu 20 (≤ 360 dp cihazlarda 16). |
| `medium` | 600–839 | Küçük tablet / yatay telefon. İçerik `maxWidth: 560` ortalanır; Keşfet ve listeler **2 kolon** grid. |
| `expanded` | ≥ 840 | Tablet. Tab bar yerine `NavigationRail` (sol), ilan detayı + rezervasyon kartı **yan yana** (master-detail), Keşfet 3 kolon, formlar `maxWidth: 600`. |

- Keşfet kart görseli: compact'ta tam genişlik ve en-boy oranı Figma'daki gibi (büyük, dikey ağırlıklı); grid'de `AspectRatio` korunur, sabit yükseklik verilmez.
- Bottom sheet'ler tablette `maxWidth: 560` ile ortalanmış diyalog gibi açılır.
- Yatay yönelim telefonlarda desteklenir ama tasarım önceliği dikeydir; overflow olmaması yeterli.

### 6.3 Erişilebilir yazı ölçeği
- Sistem yazı boyutuna saygı göster: `MediaQuery.textScalerOf(context)` kullan, **0.85–1.3** aralığına clamp et (uygulama kökünde `MediaQuery.withClampedTextScaling`).
- 1.3'te tüm ekranlar golden test ile doğrulanır.

### 6.4 Yüksek çözünürlük
- **İkonlar**: Figma'daki 83 `ikon/*` bileşeni SVG olarak export edilir (`assets/icons/`), `KzIcon(name, size, color)` ile kullanılır. Çizgi kalınlığı Figma'daki gibi (Lucide tarzı, 2px @24). PNG ikon yasak.
- **Raster görseller**: `assets/images/2.0x` ve `3.0x` varyantları zorunlu. Ağdan gelen fotoğraflar için `cached_network_image` ile `memCacheWidth = (görünür genişlik × devicePixelRatio).round()` — gereğinden büyük decode etme.
- Fotoğraf CDN'den istenirken genişlik parametresi DPR'ye göre seçilir (örn. 390dp × 3 = 1170px).
- İllüstrasyonlar (boş durum çizimleri) kodla veya SVG ile çizilir, bulanık PNG olmaz.
- Gölge/blur değerleri dp cinsindendir; DPR ile çarpma.

## 7. Bileşen kuralları (`lib/core/widgets`, `Kz` önekli)

Figma "Bileşenler" sayfasındaki her component set'in **tek** bir Flutter karşılığı olur. Ekranlarda aynı görünümü tekrar yazma; bileşeni kullan.

| Figma | Flutter | Ölçü / davranış |
|---|---|---|
| Buton (Tür = Birincil/İkincil/Koyu/Çerçeve; Etiket, Ok) | `KzButton(variant, label, trailingArrow)` | Yükseklik 58, `pill`, metin 16/800. Birincil = forest zemin + beyaz. Basılıyken scale 0.97 + hafif koyulaşma. Loading durumunda spinner, genişlik sabit kalır. Disabled: %40 opaklık. |
| Input (Durum = Varsayılan/Odak/Hata; Etiket, Değer, Göz, Simge) | `KzInput` | Yükseklik 66, `field` radius, üstte küçük etiket (12/600) + değer (16/700). Odak: 2px forest kenarlık. Hata: apricotText kenarlık + altta hata metni. Şifre için göz ikonu. |
| Anahtar (Açık/Kapalı) | `KzSwitch` | Açık: forest zemin, içinde check. Animasyon 180ms. |
| Onay kutusu (Seçili/Boş) | `KzCheckbox` | Yuvarlatılmış kare, seçili = forest. |
| Chip (Dolu/Açık/Yumuşak/Vurgu) | `KzChip` | `pill`, padding 9×13, metin 13/700. |
| Tab bar (5 sekme) | `KzTabBar` | **Yüzen** bar: kenarlardan 20 içeride, alttan 28 yukarıda (güvenli alan + 28), radius 36, `floating` gölge, yükseklik 72. Sekmeler: Keşfet, Kayıtlı, Seyahatler, Sohbetler, Hesabım. |
| Alt aksiyon barı | `KzBottomBar` | `surface` zemin, sadece üst köşeler 28, `bottomBar` gölge, padding 14/20/30(+safe)/20. |
| Yuvarlak buton (geri, kapat, paylaş, kalp) | `KzCircleButton` | 44–46 çap, `card` gölge; görsel üstündeyse %95 beyaz. |
| Seçim kartı / radyo kartı | `KzChoiceCard`, `KzRadioCard` | Seçili: forestSoft zemin + 2px forest kenarlık; değil: surface + 1px line. |
| Liste grubu (Hesabım tarzı) | `KzGroup` + `KzRow` | Overline başlık + `card` radius beyaz kart; satır: 42×42 ikon kutusu (radius 15) + başlık + alt metin + chevron. Ayırıcı ikon hizasından başlar (sol 72). |
| İpucu kutusu | `KzTip` | `md` radius, Soft zemin, ikon + 12/600 metin. |
| İlerleme çubuğu (sihirbaz) | `KzStepProgress` | 6 yükseklik, radius 3, line zemin / forest dolgu, animasyonlu. |
| Segment | `KzSegmented` | sand zemin pill, seçili parça beyaz + `soft` gölge. |
| Sayaç (+/−) | `KzCounter` | 40 çaplı butonlar; sınırda − devre dışı. |

Genel:
- Dokunma alanı en az **44×44** (görsel küçükse `hitTestBehavior` + padding ile büyüt).
- Ripple (InkWell dalgası) yerine Bungalovum stili: hafif scale/opacity geri bildirimi. Haptic: birincil aksiyonlarda `HapticFeedback.lightImpact`.
- Tüm interaktif öğelerde `Semantics` etiketi (Türkçe).

## 8. Hareket ve etkileşim

- Süreler: mikro 120–180ms, geçiş 250–300ms, sheet 350ms. Eğri: `Curves.easeOutCubic` (giriş), `easeInCubic` (çıkış).
- Sayfa geçişleri: iOS'ta Cupertino kaydırma, Android'de fade-through; ilan kartından detaya fotoğraf **Hero** animasyonu.
- Kalp (kaydet): apricot dolgu + küçük "pop" (scale 1 → 1.2 → 1).
- Skeleton/yükleniyor: Figma "Yükleniyor" ekranındaki gibi sand tonlu shimmer; spinner tek başına kullanılmaz.
- `MediaQuery.disableAnimations` açıksa animasyonları kapat.

## 9. Ekran envanteri (Figma ile birebir)

Her satır bir route/ekrandır. Varyantlar (boş, hata, yükleniyor) ayrı ekran değil, aynı ekranın **durumlarıdır**.

1. **Giriş ve kayıt (01–12):** Hoş Geldin, Giriş Yap (e-posta / telefon), SMS Doğrulama, Giriş Hatası, Kayıt Ol, Hesabı Doğrula, Şifremi Unuttum, Sıfırlama Kodu, Yeni Şifre, Şifre Güncellendi, Giriş Gerekli (misafir modunda korumalı aksiyon).
2. **Keşfet ve arama (13–18):** Keşfet, Arama, Filtreler, Arama Sonuçları, Harita Görünümü, Sonuç Yok.
3. **İlan (19–30):** İlan Detayı, İlan Açıklaması (sheet, izin belge no burada), Fotoğraf Turu, Fotoğraf Görüntüleyici, Değerlendirmeler, Olanaklar, Kurallar ve İptal, Konum, Ev Sahibi Profili, Paylaş, İlanı Bildir, Listeye Ekle.
4. **Rezervasyon · anında onay (31–39):** Tarih Seç, Misafirler, Rezervasyonu Onayla, Ödeme (kayıtlı kart / yeni kart), 3D Secure, Ödeme Başarısız, Rezervasyon Tamam, Misafir Bilgileri.
5. **Rezervasyon · ev sahibi onaylı (40–43):** Rezervasyon Talebi, Talep Gönderildi, Talep Onaylandı, Talep Reddedildi.
6. **Seyahatler (44–55):** Liste (yaklaşan / onay bekliyor / geçmiş / iptal / boş), Konaklama Detayı, Ev Kılavuzu, Sorun Bildir, Makbuz, Fatura Bilgileri, Rezervasyonu İptal Et, Değerlendirme Yaz.
7. **Kaydedilenler (56–60):** Kaydettiklerim (dolu/boş), Liste Detayı, Listeyi Düzenle, Son Baktıkların.
8. **Sohbet ve bildirimler (61–64):** Sohbetler (boş/dolu), Sohbet, Bildirim Merkezi.
9. **Hesap (65–72):** Hesabım (+ "Bungalovunu kirala" kartı), Bilgilerim, Giriş ve Güvenlik, Hesabı Kapat, Bildirim Tercihleri, Gizlilik, Yardım, Hukuki Bilgiler.
10. **Cüzdan (73–77):** Cüzdan, Ödeme Yöntemleri (boş/kayıtlı), Ödeme Geçmişi, Kuponlar.
11. **Durum ekranları (78–81):** Yükleniyor, Bağlantı Yok, Konum İzni, Bildirim İzni.
12. **Ev sahibi · İlan oluşturma (82–95):** Ev Sahibi Ol → İlan 1–10 (Tür ve Konum, Temel Bilgiler, Havuz ve Olanaklar, Fotoğraflar, Başlık ve Açıklama, Güvenlik ve Kurallar, Fiyat ve Rezervasyon, Giriş ve Ev Kılavuzu, Yasal Belgeler, Kimlik ve Ödeme) → İlan Önizleme → İlan İncelemede → İlan Yönetimi.

## 10. İş kuralları (kodda zorunlu)

**İlan veri modeli tek kaynaktır.** Misafirin İlan Detayı'nda gördüğü her alan, ev sahibi sihirbazında ve İlan Yönetimi'nde düzenlenebilir olmalı. Yeni bir alan eklenirse üç yere birden eklenir: model → sihirbaz adımı → detay ekranı.

Ev sahibi sihirbazı:
- Her adım taslak olarak kaydedilir ("Kaydet ve çık"); kullanıcı kaldığı adımdan devam eder.
- Zorunlu alanlar doldurulmadan "Devam" pasif. En az **8 fotoğraf**, 1 kapak fotoğrafı.
- İç mekânda kamera seçeneği **yok**; dış kamera varsa konumu zorunlu metin.
- **İzin belge numarası olmayan ilan yayına alınmaz.** Belge türü, belge no, izin belgesi, tapu (veya kira sözleşmesi + malik izni) zorunlu; kat malikleri kararı ve vekaletname koşullu.
- Kimlik bildirimi (KBS) sorumluluk beyanı ve doğruluk taahhütleri işaretlenmeden "İncelemeye gönder" pasif.
- IBAN sahibi adı, doğrulanmış kimlikteki adla eşleşmeli (TR IBAN formatı + mod-97 doğrulaması).
- Belge, kimlik veya IBAN değişirse yalnızca o bölüm yeniden incelemeye girer; ilan yayında kalır.
- Durumlar: `draft → in_review → published | rejected`, ayrıca `paused` (rezervasyona kapalı).

Misafir tarafı:
- Tam adres ve giriş bilgileri (anahtar kutusu şifresi, Wi-Fi) yalnızca **onaylı** rezervasyonda, girişten 1 gün önce görünür.
- Misafir bilgileri (kimlik bildirimi için) rezervasyon sonrası uygulama içinde toplanır.
- Fiyat gösterimi: gecelik × gece + temizlik + hizmet bedeli; toplam her ekranda aynı hesaplayıcıdan gelir (`PriceCalculator`), UI'da hesap yapılmaz.
- Para birimi yalnızca TRY: `₺4.900` formatı (`NumberFormat.currency(locale: 'tr_TR', symbol: '₺', decimalDigits: 0)`).
- Tarih: `20 – 22 Kas` kısa format, `tr_TR` locale.
- Komisyon oranı ve vergi kesintileri **backend'den** gelir; kodda sabit oran yazma.

Kişisel veri (KVKK): kimlik görselleri, TCKN, IBAN, belge dosyaları cihazda kalıcı saklanmaz (önbelleğe alma, log'a yazma yok). Ekranlarda maskeli gösterilir (`•••• 89 01`).

## 11. Metin ve ton

- Samimi, "sen" diliyle, kısa. Örn. "Bungalovun boş kalmasın", "Hadi başlayalım".
- Tüm metinler `app_tr.arb`'de. Kodda Türkçe string literal yok (debug hariç).
- Hata mesajları suçlayıcı değil, çözüm odaklı ("Kart onaylanmadı. Başka bir kart dene ya da bankanla görüş.").

## 12. Kalite kontrol (her ekran için "bitti" tanımı)

Bir ekran ancak şunların hepsi sağlandığında tamamdır:
- [ ] Figma screenshot'ı ile 390×844'te görsel karşılaştırma yapıldı; renk, radius, gölge, boşluk token'larla eşleşiyor.
- [ ] Golden testler: **320×568, 390×844, 430×932, 768×1024 (tablet dikey), 1024×1366** ve `textScaler 1.3`.
- [ ] Overflow yok, `flutter analyze` temiz, hex/sayı literal'i yok (token kullanımı).
- [ ] Boş, yükleniyor ve hata durumları uygulandı.
- [ ] Semantics etiketleri ve 44×44 dokunma alanları var.
- [ ] Gerçek cihazda (en az bir küçük Android + bir iPhone) kontrol edildi.

## 13. Yapma listesi

- Material varsayılan görünümü (mor/elevation/ripple) sızdırma; `ThemeData`'yı token'larla tamamen özelleştir.
- `Colors.black` gölge, `Colors.grey` metin kullanma.
- Figma'daki durum çubuğunu, gradyan yer tutucuları veya mock metni production koda taşıma.
- Ekran başına özel buton/input yazma — `Kz*` bileşenini genişlet.
- Airbnb'ye ait ad, ikon, renk (#FF385C vb.) veya metin kullanma.
- Kullanıcıya sormadan yeni ekran, akış veya paket ekleme; tasarımda olmayan bir şeyi uydurma — gerekiyorsa önce sor.

## 14. Backend (Supabase + Cloudflare R2)

- Supabase projesi (dev): `kuncwgfudkgmubdaawok`. Şema yalnızca `supabase/migrations/` ile değişir; panelden elle tablo düzenleme yok. Her değişiklik yeni bir migration dosyasıdır, eskiler düzenlenmez (canlıya gittikten sonra).
- `public` şeması: RLS'i açık tablolar ve RPC fonksiyonları. `private` şeması API'ye kapalıdır: TCKN, IBAN, kart token'ı, misafir kimlik numarası, iç fonksiyonlar.
- Durum değiştiren işlemler (rezervasyon, ödeme, iptal, ilanı incelemeye gönderme, IBAN/kimlik) yalnızca RPC ile yapılır; uygulama bu tablolara doğrudan yazmaz. Korunan kolonları trigger'lar engeller.
- RPC hataları sabit kodla döner (`dates_unavailable`, `min_nights`…); uygulama kodu ARB metnine eşler.
- Enum'lar: Dart `camelCase` ↔ veritabanı `snake_case` (`inReview` ↔ `in_review`).
- Fiyat ve iade hesabı veritabanında (`quote_booking`, `cancellation_terms`); komisyon ve süreler `platform_settings` tablosunda.
- Dosyalar: ilan/değerlendirme fotoğrafları Cloudflare R2'de (Edge Function `r2-upload-url` imzalı adres verir); kimlik, belge, sohbet eki ve sorun fotoğrafları Supabase Storage'ın gizli bucket'larında.
- Gizli anahtarlar (R2, ödeme sağlayıcısı, `service_role`) yalnızca Supabase secrets'ta; uygulamada ve repoda bulunmaz.
