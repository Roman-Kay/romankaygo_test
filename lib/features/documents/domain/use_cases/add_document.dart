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

  Future<Document> call(AddDocumentParams params) async {
    final document = await importService.importDocument(params.source);
    if (document == null) {
      throw const DocumentImportCancelledException();
    }
    return document;
  }
}

class DocumentImportCancelledException implements Exception {
  const DocumentImportCancelledException();
}
