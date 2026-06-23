import 'package:careerai/features/cv_upload/domain/entities/cv_entity.dart';

abstract class CvRepository {
  // Kural 1: Cihazdan bir CV seç ve bana içindeki verilerle birlikte bir CvEntity döndür.
  // İşlem uzun sürebileceği için (asenkron) Future kullanıyoruz.
  Future<CvEntity?> pickAndExtractCv();
}
