import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const _maxPdfPageSide = 842.0;

@lazySingleton
class PdfBuilderService {
  Future<File> buildFromImages({
    required List<String> imagePaths,
    required String outputPath,
  }) async {
    final document = pw.Document();

    for (final imagePath in imagePaths) {
      final imageBytes = await File(imagePath).readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) {
        throw const FormatException('Unsupported image format');
      }

      final normalizedImage = img.bakeOrientation(decodedImage);
      final normalizedBytes = img.encodeJpg(normalizedImage, quality: 95);
      final image = pw.MemoryImage(normalizedBytes);
      final pageFormat = _pageFormatFor(normalizedImage);

      document.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (_) => pw.SizedBox.expand(
            child: pw.Image(
              image,
              fit: pw.BoxFit.fill,
              alignment: pw.Alignment.center,
            ),
          ),
        ),
      );
    }

    final output = File(outputPath);
    await output.create(recursive: true);
    await output.writeAsBytes(await document.save());
    return output;
  }

  PdfPageFormat _pageFormatFor(img.Image image) {
    final width = image.width.toDouble();
    final height = image.height.toDouble();
    final aspectRatio = width / height;

    if (width >= height) {
      return PdfPageFormat(
        _maxPdfPageSide,
        _maxPdfPageSide / aspectRatio,
        marginAll: 0,
      );
    }

    return PdfPageFormat(
      _maxPdfPageSide * aspectRatio,
      _maxPdfPageSide,
      marginAll: 0,
    );
  }
}
