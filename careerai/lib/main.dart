import 'package:careerai/features/cv_upload/presentation/pages/cv_upload_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: CareeerAIApp()));
}

class CareeerAIApp extends StatelessWidget {
  const CareeerAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareerAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B5797)),
        useMaterial3: true,
      ),
      home:
          const CvUploadPage(), // Ana sayfa olarak CvUploadPage'i belirliyoruz
    );
  }
}
