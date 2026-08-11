import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../repositories/document_repository.dart';

@injectable
class GetDocuments {
  final DocumentRepository repository;

  const GetDocuments(this.repository);

  Future<List<Document>> call() {
    return repository.getDocuments();
  }
}
