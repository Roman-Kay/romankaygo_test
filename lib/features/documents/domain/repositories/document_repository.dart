import '../entities/document.dart';

abstract interface class DocumentRepository {
  Future<List<Document>> getDocuments();

  Future<void> saveDocument(Document document);

  Future<void> deleteDocuments(Set<String> ids);

  Future<void> toggleDocumentStatus(String id);
}
