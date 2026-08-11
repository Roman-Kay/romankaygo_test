import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:pdfx/pdfx.dart';

import '../../domain/entities/document_preview.dart';

@lazySingleton
class PdfPreviewService {
  Future<DocumentPreview> createPreview({
    required String pdfPath,
    required String previewDirectoryPath,
    required String documentId,
  }) async {
    final previewDirectory = Directory(previewDirectoryPath);
    await previewDirectory.create(recursive: true);

    final document = await PdfDocument.openFile(pdfPath);
    try {
      final pageCount = document.pagesCount;
      final firstPagePath = await _renderPage(
        document: document,
        pageNumber: 1,
        outputPath: '$previewDirectoryPath/${documentId}_first.jpg',
      );

      String? lastPagePath;
      if (pageCount > 1) {
        lastPagePath = await _renderPage(
          document: document,
          pageNumber: pageCount,
          outputPath: '$previewDirectoryPath/${documentId}_last.jpg',
        );
      }

      return DocumentPreview(
        firstPageImagePath: firstPagePath,
        lastPageImagePath: lastPagePath,
        pageCount: pageCount,
      );
    } finally {
      await document.close();
    }
  }

  Future<String> _renderPage({
    required PdfDocument document,
    required int pageNumber,
    required String outputPath,
  }) async {
    final page = await document.getPage(pageNumber);
    try {
      final scale = 420 / page.width;
      final image = await page.render(
        width: page.width * scale,
        height: page.height * scale,
        format: PdfPageImageFormat.jpeg,
        backgroundColor: '#FFFFFF',
        quality: 92,
      );
      if (image == null) {
        throw StateError('Unable to render PDF page $pageNumber');
      }
      final output = File(outputPath);
      await output.writeAsBytes(image.bytes);
      return output.path;
    } finally {
      await page.close();
    }
  }
}
