import 'package:flutter_test/flutter_test.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_preview.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_status.dart';
import 'package:test_romankaygo/features/documents/domain/repositories/document_repository.dart';
import 'package:test_romankaygo/features/documents/domain/use_cases/search_documents.dart';

void main() {
  group('SearchDocuments', () {
    test('returns all documents when query is empty', () async {
      final documents = [_document('1', 'Contract'), _document('2', 'Resume')];
      final useCase = SearchDocuments(_FakeDocumentRepository(documents));

      final result = await useCase(const SearchDocumentsParams('   '));

      expect(result, documents);
    });

    test('filters documents by title case-insensitively', () async {
      final contract = _document('1', 'Important Contract');
      final resume = _document('2', 'Resume');
      final useCase = SearchDocuments(
        _FakeDocumentRepository([contract, resume]),
      );

      final result = await useCase(const SearchDocumentsParams('contract'));

      expect(result, [contract]);
    });
  });
}

Document _document(String id, String title) {
  final createdAt = DateTime(2026, 8, 13);
  return Document(
    id: id,
    title: title,
    filePath: '$id.pdf',
    preview: DocumentPreview(
      firstPageImagePath: '${id}_first.jpg',
      lastPageImagePath: null,
      pageCount: 1,
    ),
    createdAt: createdAt,
    updatedAt: createdAt,
    status: DocumentStatus.unsigned,
  );
}

class _FakeDocumentRepository implements DocumentRepository {
  final List<Document> documents;

  const _FakeDocumentRepository(this.documents);

  @override
  Future<void> deleteDocuments(Set<String> ids) async {}

  @override
  Future<List<Document>> getDocuments() async => documents;

  @override
  Future<void> saveDocument(Document document) async {}

  @override
  Future<void> toggleDocumentStatus(String id) async {}
}
