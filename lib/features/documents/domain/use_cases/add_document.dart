import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../entities/document_source.dart';
import '../services/document_import_service.dart';

class AddDocumentParams extends Equatable {
  final DocumentSource source;

  const AddDocumentParams({required this.source});

  @override
  List<Object?> get props => [source];
}

@injectable
class AddDocument {
  final DocumentImportService importService;

  const AddDocument(this.importService);

  Future<List<Document>> call(AddDocumentParams params) async {
    final documents = await importService.importDocuments(params.source);
    if (documents.isEmpty) {
      throw const DocumentImportCancelledException();
    }
    return documents;
  }
}

class DocumentImportCancelledException implements Exception {
  const DocumentImportCancelledException();
}
