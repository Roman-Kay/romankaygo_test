import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../entities/document_source.dart';
import '../services/document_import_service.dart';

class AddDocumentParams extends Equatable {
  final DocumentSource source;
  final String photoTitle;
  final String scannedTitle;

  const AddDocumentParams({
    required this.source,
    required this.photoTitle,
    required this.scannedTitle,
  });

  @override
  List<Object?> get props => [source, photoTitle, scannedTitle];
}

@injectable
class AddDocument {
  final DocumentImportService importService;

  const AddDocument(this.importService);

  Future<List<Document>> call(AddDocumentParams params) async {
    final documents = await importService.importDocuments(
      source: params.source,
      photoTitle: params.photoTitle,
      scannedTitle: params.scannedTitle,
    );
    if (documents.isEmpty) {
      throw const DocumentImportCancelledException();
    }
    return documents;
  }
}

class DocumentImportCancelledException implements Exception {
  const DocumentImportCancelledException();
}
