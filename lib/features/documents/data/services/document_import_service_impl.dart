import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/document.dart';
import '../../domain/entities/document_preview.dart';
import '../../domain/entities/document_source.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/repositories/document_repository.dart';
import '../../domain/services/document_import_service.dart';
import '../../domain/services/document_title_resolver.dart';
import 'pdf_builder_service.dart';
import 'pdf_preview_service.dart';

const _photoPickerLimit = 20;

@LazySingleton(as: DocumentImportService)
class DocumentImportServiceImpl implements DocumentImportService {
  final DocumentRepository repository;
  final PdfBuilderService pdfBuilderService;
  final PdfPreviewService pdfPreviewService;
  final DocumentTitleResolver titleResolver;
  final ImagePicker imagePicker;
  final Uuid uuid;

  const DocumentImportServiceImpl(
    this.repository,
    this.pdfBuilderService,
    this.pdfPreviewService,
    this.titleResolver,
    this.imagePicker,
    this.uuid,
  );

  @override
  Future<List<Document>> importDocuments({
    required DocumentSource source,
    required String photoTitle,
    required String scannedTitle,
  }) async {
    try {
      final root = await getApplicationDocumentsDirectory();
      final documentsDirectory = Directory(p.join(root.path, 'documents'));
      final previewsDirectory = Directory(p.join(root.path, 'previews'));
      await documentsDirectory.create(recursive: true);
      await previewsDirectory.create(recursive: true);

      final importedPdfs = switch (source) {
        DocumentSource.files => await _pickPdf(
          documentsDirectoryPath: documentsDirectory.path,
        ),
        DocumentSource.photos => await _pickPhotos(
          documentsDirectoryPath: documentsDirectory.path,
          title: photoTitle,
        ),
        DocumentSource.scanner => await _scanDocument(
          documentsDirectoryPath: documentsDirectory.path,
          title: scannedTitle,
        ),
      };

      if (importedPdfs.isEmpty) {
        return const [];
      }

      final existingTitles = (await repository.getDocuments())
          .map((document) => document.title)
          .toSet();
      final documents = <Document>[];
      for (final imported in importedPdfs) {
        final preview = await _createPreview(
          pdfPath: imported.path,
          previewDirectoryPath: previewsDirectory.path,
          documentId: imported.id,
        );

        final now = DateTime.now();
        final title = titleResolver.resolve(imported.title, existingTitles);
        existingTitles.add(title);
        final document = Document(
          id: imported.id,
          title: title,
          filePath: imported.path,
          preview: preview,
          createdAt: now,
          updatedAt: now,
          status: DocumentStatus.unsigned,
        );

        await repository.saveDocument(document);
        documents.add(document);
      }

      return documents;
    } on DocumentImportException {
      rethrow;
    } on PlatformException catch (error) {
      throw DocumentImportException(_mapPlatformException(error, source));
    } on FileSystemException {
      throw const DocumentImportException(
        DocumentImportErrorCode.fileSaveFailed,
      );
    } catch (_) {
      throw const DocumentImportException(DocumentImportErrorCode.unknown);
    }
  }

  Future<List<ImportedPdf>> _pickPdf({
    required String documentsDirectoryPath,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    final sourcePath = result?.files.single.path;
    if (sourcePath == null) {
      return const [];
    }
    if (p.extension(sourcePath).toLowerCase() != '.pdf') {
      throw const DocumentImportException(
        DocumentImportErrorCode.unsupportedFile,
      );
    }

    final id = uuid.v4();
    final source = File(sourcePath);
    final title = p.basenameWithoutExtension(source.path);
    final outputPath = p.join(documentsDirectoryPath, '$id.pdf');
    final output = await source.copy(outputPath);
    return [ImportedPdf(id: id, path: output.path, title: title)];
  }

  Future<List<ImportedPdf>> _pickPhotos({
    required String documentsDirectoryPath,
    required String title,
  }) async {
    final images = await imagePicker.pickMultiImage(limit: _photoPickerLimit);
    if (images.isEmpty) {
      return const [];
    }

    final id = uuid.v4();
    final imported = await _buildPdfFromImages(
      id: id,
      title: title,
      imagePaths: images.map((image) => image.path).toList(growable: false),
      documentsDirectoryPath: documentsDirectoryPath,
    );
    return [imported];
  }

  Future<List<ImportedPdf>> _scanDocument({
    required String documentsDirectoryPath,
    required String title,
  }) async {
    final images = await CunningDocumentScanner.getPictures(noOfPages: 10);
    if (images == null || images.isEmpty) {
      return const [];
    }
    final id = uuid.v4();
    final imported = await _buildPdfFromImages(
      id: id,
      title: title,
      imagePaths: images,
      documentsDirectoryPath: documentsDirectoryPath,
    );
    return [imported];
  }

  Future<ImportedPdf> _buildPdfFromImages({
    required String id,
    required String title,
    required List<String> imagePaths,
    required String documentsDirectoryPath,
  }) async {
    final outputPath = p.join(documentsDirectoryPath, '$id.pdf');
    try {
      final output = await pdfBuilderService.buildFromImages(
        imagePaths: imagePaths,
        outputPath: outputPath,
      );
      return ImportedPdf(id: id, path: output.path, title: title);
    } catch (_) {
      throw const DocumentImportException(
        DocumentImportErrorCode.pdfBuildFailed,
      );
    }
  }

  Future<DocumentPreview> _createPreview({
    required String pdfPath,
    required String previewDirectoryPath,
    required String documentId,
  }) async {
    try {
      return await pdfPreviewService.createPreview(
        pdfPath: pdfPath,
        previewDirectoryPath: previewDirectoryPath,
        documentId: documentId,
      );
    } catch (_) {
      throw const DocumentImportException(
        DocumentImportErrorCode.previewRenderFailed,
      );
    }
  }

  DocumentImportErrorCode _mapPlatformException(
    PlatformException error,
    DocumentSource source,
  ) {
    final code = error.code.toLowerCase();
    final message = (error.message ?? '').toLowerCase();
    final details = error.details.toString().toLowerCase();
    final text = '$code $message $details';

    if (text.contains('permission') ||
        text.contains('denied') ||
        text.contains('unauthor')) {
      return DocumentImportErrorCode.permissionDenied;
    }

    return switch (source) {
      DocumentSource.files => DocumentImportErrorCode.filePickerUnavailable,
      DocumentSource.photos => DocumentImportErrorCode.photoPickerUnavailable,
      DocumentSource.scanner => DocumentImportErrorCode.scannerUnavailable,
    };
  }
}

class ImportedPdf {
  final String id;
  final String path;
  final String title;

  const ImportedPdf({
    required this.id,
    required this.path,
    required this.title,
  });
}
