import 'package:flutter_test/flutter_test.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_preview.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_source.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_status.dart';
import 'package:test_romankaygo/features/documents/domain/services/document_import_service.dart';
import 'package:test_romankaygo/features/documents/domain/use_cases/add_document.dart';

void main() {
  group('AddDocument', () {
    test('returns imported documents and forwards generated titles', () async {
      final document = _document();
      final service = _FakeDocumentImportService([document]);
      final useCase = AddDocument(service);

      final result = await useCase(
        const AddDocumentParams(
          source: DocumentSource.photos,
          photoTitle: 'New Document',
          scannedTitle: 'New Document',
        ),
      );

      expect(result, [document]);
      expect(service.source, DocumentSource.photos);
      expect(service.photoTitle, 'New Document');
      expect(service.scannedTitle, 'New Document');
    });

    test(
      'throws cancel exception when import service returns no documents',
      () async {
        final service = _FakeDocumentImportService(const []);
        final useCase = AddDocument(service);

        expect(
          () => useCase(
            const AddDocumentParams(
              source: DocumentSource.files,
              photoTitle: 'New Document',
              scannedTitle: 'New Document',
            ),
          ),
          throwsA(isA<DocumentImportCancelledException>()),
        );
      },
    );

    test('keeps typed import exception from import service', () async {
      final service = _FakeDocumentImportService(
        const [],
        error: const DocumentImportException(
          DocumentImportErrorCode.permissionDenied,
        ),
      );
      final useCase = AddDocument(service);

      expect(
        () => useCase(
          const AddDocumentParams(
            source: DocumentSource.photos,
            photoTitle: 'New Document',
            scannedTitle: 'New Document',
          ),
        ),
        throwsA(
          isA<DocumentImportException>().having(
            (error) => error.code,
            'code',
            DocumentImportErrorCode.permissionDenied,
          ),
        ),
      );
    });
  });
}

Document _document() {
  final createdAt = DateTime(2026, 8, 13);
  return Document(
    id: '1',
    title: 'New Document',
    filePath: '1.pdf',
    preview: const DocumentPreview(
      firstPageImagePath: '1_first.jpg',
      lastPageImagePath: null,
      pageCount: 1,
    ),
    createdAt: createdAt,
    updatedAt: createdAt,
    status: DocumentStatus.unsigned,
  );
}

class _FakeDocumentImportService implements DocumentImportService {
  final List<Document> documents;
  final DocumentImportException? error;
  DocumentSource? source;
  String? photoTitle;
  String? scannedTitle;

  _FakeDocumentImportService(this.documents, {this.error});

  @override
  Future<List<Document>> importDocuments({
    required DocumentSource source,
    required String photoTitle,
    required String scannedTitle,
  }) async {
    this.source = source;
    this.photoTitle = photoTitle;
    this.scannedTitle = scannedTitle;
    final error = this.error;
    if (error != null) {
      throw error;
    }
    return documents;
  }
}
