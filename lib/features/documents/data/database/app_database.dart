import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

import 'daos/document_dao.dart';
import 'tables/documents_table.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [DocumentsTable], daos: [DocumentDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'signica_documents',
    native: DriftNativeOptions(
      tempDirectoryPath: () async => Directory.systemTemp.path,
    ),
  );
}
