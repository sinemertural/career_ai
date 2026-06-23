class CvEntity {
  final String fileName;
  final String filePath;
  final String extractedText;
  final int fileSizeInBytes;

  CvEntity({
    required this.fileName,
    required this.filePath,
    required this.extractedText,
    required this.fileSizeInBytes,
  });

  get fileSizeInMb => null;

  // Entity'ler her zaman immutable olmalıdır. Bu nedenle, bir entity'nin değerlerini değiştirmek yerine, yeni bir entity oluşturmak için copyWith yöntemi kullanılır.

  CvEntity copyWith({
    String? fileName,
    String? filePath,
    String? extractedText,
    int? fileSizeInBytes,
  }) {
    return CvEntity(
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      extractedText: extractedText ?? this.extractedText,
      fileSizeInBytes: fileSizeInBytes ?? this.fileSizeInBytes,
    );
  }
}
