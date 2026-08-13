import '../entities/document.dart';
import '../entities/document_source.dart';

abstract interface class DocumentImportService {
  Future<List<Document>> importDocuments({
    required DocumentSource source,
    required String photoTitle,
    required String scannedTitle,
  });
}

enum DocumentImportErrorCode {
  filePickerUnavailable,
  unsupportedFile,
  fileSaveFailed,
  photoPickerUnavailable,
  scannerUnavailable,
  permissionDenied,
  pdfBuildFailed,
  previewRenderFailed,
  unknown,
}

class DocumentImportException implements Exception {
  final DocumentImportErrorCode code;

  const DocumentImportException(this.code);
}
