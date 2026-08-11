import '../entities/document.dart';
import '../entities/document_source.dart';

abstract interface class DocumentImportService {
  Future<Document?> importDocument(DocumentSource source);
}
