import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:pdf/widgets.dart' as pw;

@lazySingleton
class PdfBuilderService {
  Future<File> buildFromImages({
    required List<String> imagePaths,
    required String outputPath,
  }) async {
    final document = pw.Document();

    for (final imagePath in imagePaths) {
      final imageBytes = await File(imagePath).readAsBytes();
      final image = pw.MemoryImage(imageBytes);
      document.addPage(
        pw.Page(
          build: (_) =>
              pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain)),
        ),
      );
    }

    final output = File(outputPath);
    await output.create(recursive: true);
    await output.writeAsBytes(await document.save());
    return output;
  }
}
