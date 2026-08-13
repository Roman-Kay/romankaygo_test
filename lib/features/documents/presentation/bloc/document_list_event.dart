part of 'document_list_bloc.dart';

sealed class DocumentListEvent extends Equatable {
  const DocumentListEvent();

  @override
  List<Object?> get props => [];
}

class DocumentsStarted extends DocumentListEvent {
  const DocumentsStarted();
}

class DocumentTabChanged extends DocumentListEvent {
  final DocumentTab tab;

  const DocumentTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

class AddDocumentPressed extends DocumentListEvent {
  const AddDocumentPressed();
}

class ActionsMenuToggled extends DocumentListEvent {
  const ActionsMenuToggled();
}

class ActionsMenuDismissed extends DocumentListEvent {
  const ActionsMenuDismissed();
}

class DocumentContextMenuOpened extends DocumentListEvent {
  final String documentId;

  const DocumentContextMenuOpened(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class DocumentContextMenuDismissed extends DocumentListEvent {
  const DocumentContextMenuDismissed();
}

class ContextDocumentDeletePressed extends DocumentListEvent {
  const ContextDocumentDeletePressed();
}

class ContextDocumentPrintPressed extends DocumentListEvent {
  const ContextDocumentPrintPressed();
}

class ContextDocumentSharePressed extends DocumentListEvent {
  const ContextDocumentSharePressed();
}

class AddDocumentCancelled extends DocumentListEvent {
  const AddDocumentCancelled();
}

class AddDocumentSourceSelected extends DocumentListEvent {
  final DocumentSource source;

  const AddDocumentSourceSelected(this.source);

  @override
  List<Object?> get props => [source];
}

class SearchPressed extends DocumentListEvent {
  const SearchPressed();
}

class SearchCancelled extends DocumentListEvent {
  const SearchCancelled();
}

class SearchQueryChanged extends DocumentListEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectModeEntered extends DocumentListEvent {
  const SelectModeEntered();
}

class SelectModeExited extends DocumentListEvent {
  const SelectModeExited();
}

class DocumentSelectionToggled extends DocumentListEvent {
  final String documentId;

  const DocumentSelectionToggled(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class DocumentTapped extends DocumentListEvent {
  final String documentId;

  const DocumentTapped(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class SelectAllPressed extends DocumentListEvent {
  const SelectAllPressed();
}

class DeleteSelectedPressed extends DocumentListEvent {
  const DeleteSelectedPressed();
}

class ShareSelectedPressed extends DocumentListEvent {
  const ShareSelectedPressed();
}
