import 'package:careerai/features/cv_upload/domain/entities/cv_entity.dart';
import 'package:careerai/features/cv_upload/domain/repositories/cv_repository.dart';

// bu kısımda usecase'lerimizi yazıyoruz.Usecase'ler, uygulamanın belirli bir işlevini yerine getirmek için gerekli olan adımları tanımlar ve bu adımların nasıl gerçekleştirileceğini belirler. burada kullanıcı bir CV yüklediğinde, bu CV'nin içeriğini çıkarmak için bir usecase yazıyoruz. Bu usecase, CvRepository'yi kullanarak cihazdan bir CV seçer ve içindeki verilerle birlikte bir CvEntity döndürür.

class ExtractCvTextUseCase {
  final CvRepository repository;

  ExtractCvTextUseCase({required this.repository});

  Future<CvEntity?> execute() async {
    return await repository.pickAndExtractCv();
  }
}
