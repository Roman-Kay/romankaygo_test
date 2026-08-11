import 'package:injectable/injectable.dart';

import '../repositories/document_repository.dart';

@injectable
class ToggleDocumentStatus {
  final DocumentRepository repository;

  const ToggleDocumentStatus(this.repository);

  Future<void> call(String id) {
    return repository.toggleDocumentStatus(id);
  }
}
