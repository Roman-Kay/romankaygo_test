import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/document_repository.dart';

class DeleteDocumentsParams extends Equatable {
  final Set<String> ids;

  const DeleteDocumentsParams(this.ids);

  @override
  List<Object?> get props => [ids];
}

@injectable
class DeleteDocuments {
  final DocumentRepository repository;

  const DeleteDocuments(this.repository);

  Future<void> call(DeleteDocumentsParams params) {
    return repository.deleteDocuments(params.ids);
  }
}
