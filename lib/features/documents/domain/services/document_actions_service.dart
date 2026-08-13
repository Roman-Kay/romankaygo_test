import '../entities/document.dart';

abstract interface class DocumentActionsService {
  Future<void> shareDocuments(List<Document> documents);

  Future<void> printDocument(Document document);
}
