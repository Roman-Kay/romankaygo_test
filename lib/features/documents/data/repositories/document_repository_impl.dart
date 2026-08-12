import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/document.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/repositories/document_repository.dart';
import '../database/daos/document_dao.dart';
import '../mappers/document_mapper.dart';

@LazySingleton(as: DocumentRepository)
class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentDao dao;

  const DocumentRepositoryImpl(this.dao);

  @override
  Future<void> deleteDocuments(Set<String> ids) {
    return dao.deleteByIds(ids);
  }

  @override
  Future<List<Document>> getDocuments() async {
    final storageRoot = await getApplicationDocumentsDirectory();
    final rows = await dao.getAll();
    return rows
        .map((row) => row.toDomain(storageRootPath: storageRoot.path))
        .toList(growable: false);
  }

  @override
  Future<void> saveDocument(Document document) async {
    final storageRoot = await getApplicationDocumentsDirectory();
    return dao.upsertDocument(
      document.toCompanion(storageRootPath: storageRoot.path),
    );
  }

  @override
  Future<void> toggleDocumentStatus(String id) async {
    final documents = await getDocuments();
    final document = documents.firstWhere((item) => item.id == id);
    final nextStatus = document.status == DocumentStatus.signed
        ? DocumentStatus.unsigned
        : DocumentStatus.signed;
    await saveDocument(
      document.copyWith(status: nextStatus, updatedAt: DateTime.now()),
    );
  }
}
