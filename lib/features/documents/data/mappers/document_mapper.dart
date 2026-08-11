import 'package:drift/drift.dart';

import '../../domain/entities/document.dart';
import '../../domain/entities/document_preview.dart';
import '../../domain/entities/document_status.dart';
import '../database/app_database.dart';

extension DocumentTableMapper on DocumentsTableData {
  Document toDomain() {
    return Document(
      id: id,
      title: title,
      filePath: filePath,
      preview: DocumentPreview(
        firstPageImagePath: firstPagePreviewPath,
        lastPageImagePath: lastPagePreviewPath,
        pageCount: pageCount,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: DocumentStatus.values.byName(status),
    );
  }
}

extension DocumentDomainMapper on Document {
  DocumentsTableCompanion toCompanion() {
    return DocumentsTableCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(filePath),
      firstPagePreviewPath: Value(preview.firstPageImagePath),
      lastPagePreviewPath: Value(preview.lastPageImagePath),
      pageCount: Value(preview.pageCount),
      status: Value(status.name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
