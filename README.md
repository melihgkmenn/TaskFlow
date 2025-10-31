# 📋 TaskFlow

TaskFlow, iOS platformu için geliştirilmiş modern bir görev yönetim uygulamasıdır. Kullanıcıların görevlerini organize etmelerine, takip etmelerine ve raporlamalarına olanak sağlar.

test kullanıcısı testuser@test.com şifre: Melih.1234


### 🔐 Kullanıcı Yönetimi
- Güvenli kullanıcı girişi ve kayıt sistemi
- Firebase Authentication entegrasyonu
- Kullanıcı profil yönetimi

### ✅ Görev Yönetimi
- Görev oluşturma, düzenleme ve silme
- Detaylı görev açıklamaları
- Checklist (kontrol listesi) desteği
- Görev durumu takibi

### 📱 Offline Destek
- İnternet bağlantısı olmadan çalışabilme
- Offline görev oluşturma ve düzenleme
- Otomatik senkronizasyon

### 📊 Raporlama
- PDF rapor oluşturma
- Görev istatistikleri
- Detaylı raporlama ekranları

### ✍️ İmza Özelliği
- Dijital imza desteği
- Görevler için imza onayı
- İmza görüntüleme ve kaydetme

### 🔔 Bildirimler
- Görev hatırlatıcıları
- Push notification desteği
- Özelleştirilebilir bildirim ayarları

## 🛠️ Teknolojiler

- **Platform**: iOS (Swift & SwiftUI)
- **Backend**: Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Cloud Messaging (FCM)
- **Mimari**: MVVM (Model-View-ViewModel)
- **UI Framework**: SwiftUI

## 📁 Proje Yapısı

```
TaskFlow/
├── Models/              # Veri modelleri
│   ├── AppUser.swift
│   ├── TaskModel.swift
│   ├── ChecklistItem.swift
│   └── OfflineTask.swift
├── Moduls/
│   ├── ViewModels/      # ViewModel katmanı
│   ├── Views/           # UI bileşenleri
│   ├── Reports/         # Raporlama modülü
│   └── Settings/        # Ayarlar modülü
├── Services/            # İş mantığı servisleri
│   ├── AuthService.swift
│   ├── TaskService.swift
│   ├── SyncService.swift
│   ├── NotificationService.swift
│   └── PDFService.swift
└── Assets.xcassets/     # Görseller ve renkler
```

## 🚀 Kurulum

### Gereksinimler
- Xcode 14.0 veya üzeri
- iOS 15.0 veya üzeri
- Firebase projesi

### Adımlar

1. **Projeyi klonlayın**
   ```bash
   git clone https://github.com/username/TaskFlow.git
   cd TaskFlow
   ```

2. **Firebase Yapılandırması**
   - [Firebase Console](https://console.firebase.google.com/) üzerinden yeni bir proje oluşturun
   - iOS uygulaması ekleyin
   - `GoogleService-Info.plist` dosyasını indirin
   - İndirdiğiniz dosyayı `TaskFlow/` klasörüne ekleyin

3. **Projeyi Açın**
   ```bash
   open TaskFlow.xcodeproj
   ```

4. **Bağımlılıkları Yükleyin**
   - Xcode, Swift Package Manager üzerinden otomatik olarak bağımlılıkları yükleyecektir

5. **Çalıştırın**
   - Xcode'da bir simulator veya fiziksel cihaz seçin
   - `Cmd + R` ile uygulamayı çalıştırın

## 🔑 Yapılandırma

### Firebase
Firebase servisleri için `GoogleService-Info.plist` dosyası gereklidir. Bu dosya hassas bilgiler içerdiğinden `.gitignore` ile repository dışında tutulur.

### Bildirimler
Push notification kullanmak için:
1. Apple Developer hesabınızda Push Notifications'ı etkinleştirin
2. Firebase Console'da APNs sertifikası yükleyin
3. Xcode'da Signing & Capabilities bölümünden Push Notifications ekleyin

## 📝 Kullanım

1. **Giriş Yapın**: Uygulamayı açtığınızda giriş ekranı karşınıza gelecektir
2. **Görev Oluşturun**: Ana ekranda "+" butonuna basarak yeni görev ekleyin
3. **Görevlerinizi Yönetin**: Görevlerinizi görüntüleyin, düzenleyin veya silin
4. **Rapor Alın**: Raporlar sekmesinden görev raporlarınızı PDF olarak oluşturun
5. **Ayarlarınızı Düzenleyin**: Ayarlar sekmesinden uygulama tercihlerinizi yapılandırın

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen şu adımları izleyin:

1. Projeyi fork edin
2. Feature branch oluşturun (`git checkout -b feature/AmazingFeature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Branch'inizi push edin (`git push origin feature/AmazingFeature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 📧 İletişim

Proje Sahibi - [@username](https://github.com/username)

Proje Linki: [https://github.com/username/TaskFlow](https://github.com/username/TaskFlow)

## 🙏 Teşekkürler

- Firebase ekibine harika backend servisleri için
- Swift ve SwiftUI topluluğuna sürekli destek için
- Tüm katkıda bulunanlara

---

**Not**: Bu uygulama aktif geliştirme aşamasındadır. Hatalar veya öneriler için lütfen issue açın.

