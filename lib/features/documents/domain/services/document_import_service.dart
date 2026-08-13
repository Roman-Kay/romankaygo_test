import '../entities/document.dart';
import '../entities/document_source.dart';

abstract interface class DocumentImportService {
  Future<List<Document>> importDocuments(DocumentSource source);
}
