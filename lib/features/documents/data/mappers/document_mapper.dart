import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../domain/entities/document.dart';
import '../../domain/entities/document_preview.dart';
import '../../domain/entities/document_status.dart';
import '../database/app_database.dart';

extension DocumentTableMapper on DocumentsTableData {
  Document toDomain({required String storageRootPath}) {
    return Document(
      id: id,
      title: title,
      filePath: _toAbsoluteStoragePath(filePath, storageRootPath),
      preview: DocumentPreview(
        firstPageImagePath: _toAbsoluteStoragePath(
          firstPagePreviewPath,
          storageRootPath,
        ),
        lastPageImagePath: lastPagePreviewPath == null
            ? null
            : _toAbsoluteStoragePath(lastPagePreviewPath!, storageRootPath),
        pageCount: pageCount,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: DocumentStatus.values.byName(status),
    );
  }
}

extension DocumentDomainMapper on Document {
  DocumentsTableCompanion toCompanion({required String storageRootPath}) {
    return DocumentsTableCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(_toRelativeStoragePath(filePath, storageRootPath)),
      firstPagePreviewPath: Value(
        _toRelativeStoragePath(preview.firstPageImagePath, storageRootPath),
      ),
      lastPagePreviewPath: Value(
        preview.lastPageImagePath == null
            ? null
            : _toRelativeStoragePath(
                preview.lastPageImagePath!,
                storageRootPath,
              ),
      ),
      pageCount: Value(preview.pageCount),
      status: Value(status.name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

String _toAbsoluteStoragePath(String value, String storageRootPath) {
  if (!p.isAbsolute(value)) {
    return p.join(storageRootPath, value);
  }
  if (File(value).existsSync()) {
    return value;
  }
  final relativePath = _extractStorageRelativePath(value);
  return relativePath == null ? value : p.join(storageRootPath, relativePath);
}

String _toRelativeStoragePath(String value, String storageRootPath) {
  if (!p.isAbsolute(value)) {
    return value;
  }
  if (p.isWithin(storageRootPath, value)) {
    return p.relative(value, from: storageRootPath);
  }
  return _extractStorageRelativePath(value) ?? value;
}

String? _extractStorageRelativePath(String value) {
  final normalized = p.normalize(value);
  for (final directory in ['documents', 'previews']) {
    final marker = '${p.separator}$directory${p.separator}';
    final index = normalized.indexOf(marker);
    if (index == -1) continue;
    return normalized.substring(index + 1);
  }
  return null;
}
