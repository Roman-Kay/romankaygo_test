import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../services/document_actions_service.dart';

class PrintDocumentParams extends Equatable {
  final Document document;

  const PrintDocumentParams(this.document);

  @override
  List<Object?> get props => [document];
}

@injectable
class PrintDocument {
  final DocumentActionsService actionsService;

  const PrintDocument(this.actionsService);

  Future<void> call(PrintDocumentParams params) {
    return actionsService.printDocument(params.document);
  }
}
