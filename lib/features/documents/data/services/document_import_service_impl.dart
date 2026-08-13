import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/document.dart';
import '../../domain/entities/document_source.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/repositories/document_repository.dart';
import '../../domain/services/document_import_service.dart';
import 'pdf_builder_service.dart';
import 'pdf_preview_service.dart';

const _photoPickerLimit = 20;

@LazySingleton(as: DocumentImportService)
class DocumentImportServiceImpl implements DocumentImportService {
  final DocumentRepository repository;
  final PdfBuilderService pdfBuilderService;
  final PdfPreviewService pdfPreviewService;
  final ImagePicker imagePicker;
  final Uuid uuid;

  const DocumentImportServiceImpl(
    this.repository,
    this.pdfBuilderService,
    this.pdfPreviewService,
    this.imagePicker,
    this.uuid,
  );

  @override
  Future<List<Document>> importDocuments(DocumentSource source) async {
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
      ),
      DocumentSource.scanner => await _scanDocument(
        documentsDirectoryPath: documentsDirectory.path,
      ),
    };

    if (importedPdfs.isEmpty) {
      return const [];
    }

    final documents = <Document>[];
    for (final imported in importedPdfs) {
      final preview = await pdfPreviewService.createPreview(
        pdfPath: imported.path,
        previewDirectoryPath: previewsDirectory.path,
        documentId: imported.id,
      );

      final now = DateTime.now();
      final document = Document(
        id: imported.id,
        title: imported.title,
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

    final id = uuid.v4();
    final source = File(sourcePath);
    final title = p.basenameWithoutExtension(source.path);
    final outputPath = p.join(documentsDirectoryPath, '$id.pdf');
    final output = await source.copy(outputPath);
    return [ImportedPdf(id: id, path: output.path, title: title)];
  }

  Future<List<ImportedPdf>> _pickPhotos({
    required String documentsDirectoryPath,
  }) async {
    final images = await imagePicker.pickMultiImage(limit: _photoPickerLimit);
    if (images.isEmpty) {
      return const [];
    }

    final id = uuid.v4();
    final imported = await _buildPdfFromImages(
      id: id,
      title: 'Photo Document',
      imagePaths: images.map((image) => image.path).toList(growable: false),
      documentsDirectoryPath: documentsDirectoryPath,
    );
    return [imported];
  }

  Future<List<ImportedPdf>> _scanDocument({
    required String documentsDirectoryPath,
  }) async {
    final images = await CunningDocumentScanner.getPictures(noOfPages: 10);
    if (images == null || images.isEmpty) {
      return const [];
    }
    final id = uuid.v4();
    final imported = await _buildPdfFromImages(
      id: id,
      title: 'Scanned Document',
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
    final output = await pdfBuilderService.buildFromImages(
      imagePaths: imagePaths,
      outputPath: outputPath,
    );
    return ImportedPdf(id: id, path: output.path, title: title);
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
