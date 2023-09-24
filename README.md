# GoBi Co. - CASE STUDY

## Kodlama ve Tasarım
* Sizden bir ToDo List uygulaması kodlamanız beklenmektedir.
* Bu uygulamada veritabanı olarak Firebase (Authentication, Storage, Firestore) kullanmanız istenmektedir. Realtime Database kullanmayınız.
* Uygulamanın başlangıcında kullanıcı kayıt ve girişi Firebase Authentication ile yapılmalıdır. Kullanıcı kaydında kullanıcı adı, ad-soyad, eposta adresi olmalı ve telefon doğrulaması yapılmalıdır.
* Kullanıcı, kaydolup telefon doğrulamasını geçip girişini başarıyla tamamladıktan sonra kullanıcının ToDo List’e veri ekleyebilmesi için eposta doğrulaması da yapılması istenmelidir.
* Eposta doğrulaması da tamamlanan kullanıcı not ekleme sayfasında ekleyeceği her not için not başlığı, not içeriği, tarih (başlangıç - bitiş), konum ve yer bilgisi yer almalıdır. Ek olarak bazı notlara görsel eklemesi de yapabilirsiniz (Firebase Storage).
* Eklenen her not sonrasında ekranın üst kısmında aktif toplam not sayısı ve arşivlenen/tamamlanan not sayısı yer almalıdır.
* Arşivlenen/tamamlanan notlar kullanıcı tarafından silinebilir olmalıdır.
* Aktif notlarda ise notta yer alan konum ve yer bilgisi not açıldığı anda kullanıcının şu anki konumundan ne kadar sürede ve hangi yoldan gideceğini belirten bir harita da bulunmalıdır.
* Yaklaşan tarihli not için fiziksel cihaz veya emulatörde push bildirimi de etkinleştirilmelidir.
* Eklenen her not her bir kullanıcın şahsi notu olacağı için uygulama çalışırken Firebase UID’ye bağlı olarak kodlama yapılması gerektiği unutulmamalıdır.

## Yapılacaklar
* İlk kodlamaya başladığınızda "first commit" yapınız.
* Kodlamaya başladığınız andan itibaren tüm yaptığınız önemli değişiklikler için reponuza kodlarınızı commit ederek push'lamalısınız. Yapılan tüm değişikliklerin görüntülenmesi istenmektedir. 
* Kodlamanızı tamamlayıp sonra uygulamanızı çalıştırdığınız andan itibaren tüm ekran görüntülerini adım adım bu README.md dosyasının altına ekleyin. 
* Uygulamanın başından sonuna kadarki kısmının ekran kaydını "Emülator, Firebase ve kodlama yaptığınız ide görüntüleri de kayıtta olacak şekilde" size tahsis edilen [Google Drive](https://drive.google.com/drive/folders/1AzFyO3QFLhdHFoG9Xh0xq-9plTXvGjZ7?usp=drive_link) klasöründe veya oraya ekleyemiyorsanız internet üzerinden bir sağlayıcıya yükleme yaparak linki buradan paylaşınız.
* Kodlarınızı en geç 24 Eylül 00:00'a kadar bu repoya ekleyin.

## Değerlendirme
* Temiz Kod Mimarisi ve Tasarım Düzeni kullanımı
* Ekran görüntüleri
* Uygulamanın çalışır haldeki ekran kaydı
* Uygulama çalışırken eş zamanlı olarak firebase arayüzündeki değişikliklerin görüntüleniyor olması
* Material Design kullanımı ve diğer kozmetik arayüz tasarımları
* Tek seferde yapılan toplu commmitler kabul edilmeyecektir. Lütfen yaptığınız her değişiklikte kodlarınızı açıklamalarıyla commit etmeyi UNUTMAYINIZ!!!

### Başarılar dilerim.

# EKRAN GÖRÜNTÜLERİ

<table>
  <tr>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/1fe6038e-0d68-4a0a-a1bd-6589c70be8a0" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/5f85b4cb-3082-490f-89cb-60bcf0ed93d4" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/1a8d64b1-93bb-4f44-9500-018832dfe8ba" ></td>
  </tr>
  <tr>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/6a95d8c2-b56c-44e0-84a7-fd89b3285727" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/4f0972bc-18dd-4428-9f20-a32e367525cb" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/366b4534-78fe-4496-8115-0013f28490ea" ></td>
  </tr>
  <tr>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/a6fdeeec-128f-468c-9446-4e1e9540b2d5" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/300f2b37-cd64-4fb4-aeec-c111a2a667bc" ></td>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/ae3881fa-4177-442c-af37-fd5e9ff9f0ae" ></td>
  </tr>
  <tr>
    <td><img src="https://github.com/ygtsmt/images/assets/107814778/d722db5a-800d-4a81-926c-c6a935a7d7bc" ></td>
  </tr>
  
</table>
* Todo eklemek için e-mail doğrulaması ve yaklaşan todolar için bildirim gösterme olayı eksik. Ekran kaydını Google Drive üzerinden benimle paylaştığınız klasöre ekledim.