# CareerAI 🚀 

CareerAI, yapay zeka destekli, kişiselleştirilmiş bir kariyer ve mülakat simülasyon asistanıdır. Bir adayın PDF formatındaki özgeçmişini ve hedeflediği iş ilanını analiz etmek için RAG (Retrieval-Augmented Generation) mimarisini kullanır ve o role özel, dinamik, gerçek zamanlı mülakat soruları üretir.

## 🎯 Proje Vizyonu ve MVP Kapsamı
* **Problem:** Adayların kişiselleştirilmiş, teknik derinliği olan mülakat pratik ortamlarından yoksun olması.
* **Çözüm:** Belirli CV'leri ve iş ilanlarını okuyarak gerçek dünyadaki teknik ve davranışsal mülakatları simüle eden dinamik bir sohbet arayüzü.
* *Not: MVP şu anda yalnızca "Aday" modülüne odaklanmaktadır.*

## 🏗️ Sistem Mimarisi ve Mühendislik Prensipleri
Ölçeklenebilirlik, sürdürülebilirlik ve test edilebilirlik sağlamak için bu proje **SOLID prensiplerine** sıkı sıkıya bağlıdır ve şunları kullanır:
* **Özellik Odaklı Temiz Mimari (Feature-First Clean Architecture):** Sorumlulukların Domain, Data ve Presentation katmanları arasında ayrıştırılması.
* **Durum Yönetimi (State Management):** Derleme zamanı güvenli (compile-safe) ve sağlam reaktif durum yönetimi için Riverpod.
* **Önce Arka Plan Geliştirme (Backend-First Development):** Arayüz (UI) uygulamasından önce çekirdek iş kuralları (business logic) ve RAG entegrasyonunun inşa edilip test edilmesi.

## 🛠️ Teknoloji Yığını (Tech Stack)
* **Framework:** Flutter
*
