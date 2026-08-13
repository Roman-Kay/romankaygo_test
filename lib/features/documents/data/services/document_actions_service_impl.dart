import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/document.dart';
import '../../domain/services/document_actions_service.dart';

@LazySingleton(as: DocumentActionsService)
class DocumentActionsServiceImpl implements DocumentActionsService {
  const DocumentActionsServiceImpl();

  @override
  Future<void> shareDocuments(List<Document> documents) async {
    if (documents.isEmpty) return;

    final files = documents
        .map(
          (document) => XFile(document.filePath, name: '${document.title}.pdf'),
        )
        .toList(growable: false);

    await SharePlus.instance.share(ShareParams(files: files));
  }

  @override
  Future<void> printDocument(Document document) async {
    final pdf = await File(document.filePath).readAsBytes();
    await Printing.layoutPdf(
      name: '${document.title}.pdf',
      onLayout: (_) async => pdf,
    );
  }
}
