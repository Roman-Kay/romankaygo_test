import '../entities/document.dart';
import '../entities/document_source.dart';

abstract interface class DocumentImportService {
  Future<List<Document>> importDocuments({
    required DocumentSource source,
    required String photoTitle,
    required String scannedTitle,
  });
}
