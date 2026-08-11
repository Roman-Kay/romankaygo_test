import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/documents_table.dart';

part 'document_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [DocumentsTable])
class DocumentDao extends DatabaseAccessor<AppDatabase>
    with _$DocumentDaoMixin {
  DocumentDao(super.db);

  Future<List<DocumentsTableData>> getAll() {
    return (select(
      documentsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();
  }

  Future<void> upsertDocument(DocumentsTableCompanion document) {
    return into(documentsTable).insertOnConflictUpdate(document);
  }

  Future<void> deleteByIds(Set<String> ids) {
    return (delete(documentsTable)..where((table) => table.id.isIn(ids))).go();
  }
}
