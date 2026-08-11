import 'package:drift/drift.dart';

class DocumentsTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get filePath => text()();

  TextColumn get firstPagePreviewPath => text()();

  TextColumn get lastPagePreviewPath => text().nullable()();

  IntColumn get pageCount => integer()();

  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
