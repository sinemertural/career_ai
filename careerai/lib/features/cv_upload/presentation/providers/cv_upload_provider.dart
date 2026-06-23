import 'package:careerai/features/cv_upload/data/repositories/cv_repository_imp.dart';
import 'package:careerai/features/cv_upload/domain/entities/cv_entity.dart';
import 'package:careerai/features/cv_upload/domain/usecases/extract_cv_text_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final extractCvTextUseCaseProvider = Provider<ExtractCvTextUseCase>((ref) {
  final repository =
      CvRepositoryImp(); // CvRepositoryImp sınıfının bir örneğini oluşturuyoruz
  return ExtractCvTextUseCase(repository: repository);
});

// StateNotifier (Durum Yöneticisi)
class CvUploadNotifier extends StateNotifier<AsyncValue<CvEntity?>> {
  final ExtractCvTextUseCase _useCase;

  CvUploadNotifier(this._useCase) : super(const AsyncValue.data(null));

  Future<void> pickAndExtractCv() async {
    state = const AsyncValue.loading();
    try {
      final result = await _useCase.execute();
      state = AsyncValue.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final cvUploadProvider =
    StateNotifierProvider<CvUploadNotifier, AsyncValue<CvEntity?>>((ref) {
      final useCase = ref.watch(extractCvTextUseCaseProvider);
      return CvUploadNotifier(useCase);
    });
