import 'package:careerai/features/cv_upload/domain/entities/cv_entity.dart';
import 'package:careerai/features/cv_upload/domain/repositories/cv_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CvRepositoryImp implements CvRepository {
  @override
  Future<CvEntity?> pickAndExtractCv() async {
    // 1. DOSYA SEÇİMİ VE MAC SANDBOX BYPASS
    // withData: true ile dosyayı doğrudan byte (RAM) olarak alıyoruz.
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    // 2. KONTROL AŞAMASI (Artık path değil bytes kontrol ediyoruz)
    if (result != null && result.files.single.bytes != null) {
      PlatformFile file = result.files.single;

      // Boyut Kontrolü (PRD AC 2)
      final fileSizeInBytes = file.size;
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMB > 5) {
        throw Exception('Dosya boyutu 5MB\'yi geçemez.');
      }

      String extractedText = '';

      try {
        // 3. DOĞRUDAN BELLEKTEN OKUMA (dart:io File kullanmıyoruz!)
        final bytes = file.bytes!;

        final PdfDocument document = PdfDocument(inputBytes: bytes);
        final PdfTextExtractor extractor = PdfTextExtractor(document);
        extractedText = extractor.extractText();

        // Memory leak önleme
        document.dispose();

        // 4. İÇERİK KONTROLÜ
        if (extractedText.trim().isEmpty) {
          throw Exception(
            'Özgeçmişinizdeki metinler okunamadı, lütfen metin tabanlı bir PDF yükleyin.',
          );
        }
      } catch (e) {
        // GERÇEK HATAYI GÖREBİLMEK İÇİN 'e' DEĞİŞKENİNİ EKRANA BASIYORUZ
        throw Exception('Sistemsel bir hata oluştu: $e');
      }

      // 5. BAŞARILI ENTITY
      return CvEntity(
        fileName: file.name,
        filePath:
            file.path ??
            '', // Web platformunda path null dönebilir, güvenli hale getirdik.
        extractedText: extractedText,
        fileSizeInBytes: fileSizeInBytes, // Senin kendi Entity yapına uygun
      );
    } else {
      return null;
    }
  }
}
