import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/document.dart';
import '../services/document_actions_service.dart';

class ShareDocumentsParams extends Equatable {
  final List<Document> documents;

  const ShareDocumentsParams(this.documents);

  @override
  List<Object?> get props => [documents];
}

@injectable
class ShareDocuments {
  final DocumentActionsService actionsService;

  const ShareDocuments(this.actionsService);

  Future<void> call(ShareDocumentsParams params) {
    return actionsService.shareDocuments(params.documents);
  }
}
