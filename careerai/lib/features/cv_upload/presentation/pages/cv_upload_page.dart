import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cv_upload_provider.dart';

class CvUploadPage extends ConsumerWidget {
  const CvUploadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider'ı dinliyoruz
    final uploadState = ref.watch(cvUploadProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CareerAI - CV Yükleme')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // AsyncValue'nun sihirli "when" metodu!
          child: uploadState.when(
            // DURUM 1: İlk açılış veya İşlem Başarılı
            data: (cvData) {
              if (cvData == null) {
                return ElevatedButton(
                  onPressed: () {
                    // Butona basıldığında Provider'daki fonksiyonu tetikliyoruz
                    ref.read(cvUploadProvider.notifier).pickAndExtractCv();
                  },
                  child: const Text('PDF CV Seç ve Yükle'),
                );
              }
              // CV başarıyla okunmuşsa ekrana bas
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Başarılı! Dosya: ${cvData.fileName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Boyut: ${((cvData.fileSizeInBytes ?? 0) / (1024 * 1024)).toStringAsFixed(2)} MB',
                  ),
                  const SizedBox(height: 20),
                  const Text('Çıkarılan Metin (İlk 100 Karakter):'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey.shade200,
                    child: Text(
                      cvData.extractedText.length > 100
                          ? '${cvData.extractedText.substring(0, 100)}...'
                          : cvData.extractedText,
                    ),
                  ),
                ],
              );
            },
            // DURUM 2: Yükleniyor...
            loading: () => const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Özgeçmişiniz analiz ediliyor, lütfen bekleyin...',
                ), // PRD AC 3'teki metnimiz
              ],
            ),
            // DURUM 3: Hata Durumu
            error: (error, stack) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                Text(
                  error.toString().replaceAll('Exception: ', ''),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.read(cvUploadProvider.notifier).pickAndExtractCv();
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
