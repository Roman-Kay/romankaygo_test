import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../repositories/document_repository.dart';

class SearchDocumentsParams extends Equatable {
  final String query;

  const SearchDocumentsParams(this.query);

  @override
  List<Object?> get props => [query];
}

@injectable
class SearchDocuments {
  final DocumentRepository repository;

  const SearchDocuments(this.repository);

  Future<List<Document>> call(SearchDocumentsParams params) async {
    final documents = await repository.getDocuments();
    final query = params.query.trim().toLowerCase();
    if (query.isEmpty) {
      return documents;
    }

    return documents
        .where((document) => document.title.toLowerCase().contains(query))
        .toList(growable: false);
  }
}
