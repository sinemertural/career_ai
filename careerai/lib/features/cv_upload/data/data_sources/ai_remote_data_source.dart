import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AiRemoteDataSource {
  // DIO'ya 60 Saniyelik Timeout Ekliyoruz
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  // Ngrok URL'si, Colab'deki Flask API'sine yönlendirilmiş durumdas
  final String _apiUrl =
      "https://barometer-unscrew-backed.ngrok-free.dev/analyze_cv";

  Future<String?> sendCvToColab(String cvText) async {
    try {
      debugPrint("🚀 Uzay üssüne (Colab) veri gönderiliyor...");

      final response = await _dio.post(
        _apiUrl,
        data: {"text": cvText},
        options: Options(headers: {"ngrok-skip-browser-warning": "true"}),
      );

      debugPrint("✅ Colab'den Cevap Geldi: ${response.data}");

      if (response.data != null && response.data["status"] == "success") {
        return response.data["ai_question"] as String;
      }
      return null;
    } catch (e) {
      // Artık sonsuza kadar beklemek yerine 60 saniye sonra buraya düşecek
      debugPrint("❌ Bağlantı Hatası: $e");
      return null;
    }
  }
}
