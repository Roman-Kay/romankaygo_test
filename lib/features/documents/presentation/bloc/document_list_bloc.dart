import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/localization/app_locale_keys.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_source.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/entities/document_tab.dart';
import '../../domain/services/document_import_service.dart';
import '../../domain/use_cases/add_document.dart';
import '../../domain/use_cases/delete_documents.dart';
import '../../domain/use_cases/get_documents.dart';
import '../../domain/use_cases/print_document.dart';
import '../../domain/use_cases/search_documents.dart';
import '../../domain/use_cases/share_documents.dart';
import '../../domain/use_cases/toggle_document_status.dart';
part 'document_list_event.dart';
part 'document_list_state.dart';

@injectable
class DocumentListBloc extends Bloc<DocumentListEvent, DocumentListState> {
  final GetDocuments _getDocuments;
  final AddDocument _addDocument;
  final DeleteDocuments _deleteDocuments;
  final SearchDocuments _searchDocuments;
  final ToggleDocumentStatus _toggleDocumentStatus;
  final ShareDocuments _shareDocuments;
  final PrintDocument _printDocument;

  DocumentListBloc({
    required GetDocuments getDocuments,
    required AddDocument addDocument,
    required DeleteDocuments deleteDocuments,
    required SearchDocuments searchDocuments,
    required ToggleDocumentStatus toggleDocumentStatus,
    required ShareDocuments shareDocuments,
    required PrintDocument printDocument,
  }) : _getDocuments = getDocuments,
       _addDocument = addDocument,
       _deleteDocuments = deleteDocuments,
       _searchDocuments = searchDocuments,
       _toggleDocumentStatus = toggleDocumentStatus,
       _shareDocuments = shareDocuments,
       _printDocument = printDocument,
       super(const DocumentListState()) {
    on<DocumentsStarted>(_onStarted);
    on<DocumentTabChanged>(_onTabChanged);
    on<AddDocumentPressed>(_onAddPressed);
    on<ActionsMenuToggled>(_onActionsMenuToggled);
    on<ActionsMenuDismissed>(_onActionsMenuDismissed);
    on<DocumentContextMenuOpened>(_onDocumentContextMenuOpened);
    on<DocumentContextMenuDismissed>(_onDocumentContextMenuDismissed);
    on<ContextDocumentDeletePressed>(_onContextDocumentDeletePressed);
    on<ContextDocumentPrintPressed>(_onContextDocumentPrintPressed);
    on<ContextDocumentSharePressed>(_onContextDocumentSharePressed);
    on<AddDocumentCancelled>(_onOverlayCancelled);
    on<AddDocumentSourceSelected>(_onAddSourceSelected);
    on<ErrorMessageShown>(_onErrorMessageShown);
    on<SearchPressed>(_onSearchPressed);
    on<SearchCancelled>(_onSearchCancelled);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SelectModeEntered>(_onSelectModeEntered);
    on<SelectModeExited>(_onSelectModeExited);
    on<DocumentSelectionToggled>(_onSelectionToggled);
    on<DocumentTapped>(_onDocumentTapped);
    on<SelectAllPressed>(_onSelectAllPressed);
    on<DeleteSelectedPressed>(_onDeleteSelectedPressed);
    on<ShareSelectedPressed>(_onShareSelectedPressed);
  }

  Future<void> _onStarted(
    DocumentsStarted event,
    Emitter<DocumentListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final documents = await _getDocuments();
    emit(
      _derive(
        state.copyWith(
          documents: documents,
          isLoading: false,
          clearError: true,
        ),
      ),
    );
  }

  void _onTabChanged(
    DocumentTabChanged event,
    Emitter<DocumentListState> emit,
  ) {
    emit(_derive(state.copyWith(tab: event.tab)));
  }

  void _onAddPressed(
    AddDocumentPressed event,
    Emitter<DocumentListState> emit,
  ) {
    emit(state.copyWith(overlay: DocumentsOverlay.addSource));
  }

  void _onActionsMenuToggled(
    ActionsMenuToggled event,
    Emitter<DocumentListState> emit,
  ) {
    emit(
      state.copyWith(
        overlay: state.overlay == DocumentsOverlay.actions
            ? DocumentsOverlay.none
            : DocumentsOverlay.actions,
      ),
    );
  }

  void _onActionsMenuDismissed(
    ActionsMenuDismissed event,
    Emitter<DocumentListState> emit,
  ) {
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.none,
        clearContextDocument: true,
      ),
    );
  }

  void _onDocumentContextMenuOpened(
    DocumentContextMenuOpened event,
    Emitter<DocumentListState> emit,
  ) {
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.documentContext,
        contextDocumentId: event.documentId,
      ),
    );
  }

  void _onDocumentContextMenuDismissed(
    DocumentContextMenuDismissed event,
    Emitter<DocumentListState> emit,
  ) {
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.none,
        clearContextDocument: true,
      ),
    );
  }

  Future<void> _onContextDocumentDeletePressed(
    ContextDocumentDeletePressed event,
    Emitter<DocumentListState> emit,
  ) async {
    final documentId = state.contextDocumentId;
    if (documentId == null) return;
    await _deleteDocuments(DeleteDocumentsParams({documentId}));
    final documents = await _getDocuments();
    emit(
      _derive(
        state.copyWith(
          documents: documents,
          overlay: DocumentsOverlay.none,
          clearContextDocument: true,
        ),
      ),
    );
  }

  Future<void> _onContextDocumentPrintPressed(
    ContextDocumentPrintPressed event,
    Emitter<DocumentListState> emit,
  ) async {
    final document = _contextDocument();
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.none,
        clearContextDocument: true,
      ),
    );
    if (document == null) return;
    try {
      await _printDocument(PrintDocumentParams(document));
    } catch (_) {
      emit(state.copyWith(errorKey: AppLocaleKeys.errorsPrintFailed));
    }
  }

  Future<void> _onContextDocumentSharePressed(
    ContextDocumentSharePressed event,
    Emitter<DocumentListState> emit,
  ) async {
    final document = _contextDocument();
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.none,
        clearContextDocument: true,
      ),
    );
    if (document == null) return;
    try {
      await _shareDocuments(ShareDocumentsParams([document]));
    } catch (_) {
      emit(state.copyWith(errorKey: AppLocaleKeys.errorsShareFailed));
    }
  }

  void _onOverlayCancelled(
    DocumentListEvent event,
    Emitter<DocumentListState> emit,
  ) {
    emit(
      state.copyWith(
        overlay: DocumentsOverlay.none,
        clearContextDocument: true,
      ),
    );
  }

  Future<void> _onAddSourceSelected(
    AddDocumentSourceSelected event,
    Emitter<DocumentListState> emit,
  ) async {
    emit(
      state.copyWith(
        isImporting: true,
        overlay: DocumentsOverlay.none,
        clearError: true,
      ),
    );

    try {
      await _addDocument(
        AddDocumentParams(
          source: event.source,
          photoTitle: event.photoTitle,
          scannedTitle: event.scannedTitle,
        ),
      );
    } on DocumentImportCancelledException {
      emit(state.copyWith(isImporting: false));
      return;
    } on DocumentImportException catch (error) {
      emit(
        state.copyWith(
          isImporting: false,
          errorKey: _importErrorKey(error.code),
        ),
      );
      return;
    } catch (_) {
      emit(
        state.copyWith(
          isImporting: false,
          errorKey: AppLocaleKeys.errorsImportFailed,
        ),
      );
      return;
    }

    final documents = await _getDocuments();
    emit(
      _derive(
        state.copyWith(
          documents: documents,
          isImporting: false,
          overlay: DocumentsOverlay.none,
          clearError: true,
        ),
      ),
    );
  }

  void _onErrorMessageShown(
    ErrorMessageShown event,
    Emitter<DocumentListState> emit,
  ) {
    emit(state.copyWith(clearError: true));
  }

  void _onSearchPressed(SearchPressed event, Emitter<DocumentListState> emit) {
    emit(state.copyWith(isSearchActive: true));
  }

  void _onSearchCancelled(
    SearchCancelled event,
    Emitter<DocumentListState> emit,
  ) {
    emit(_derive(state.copyWith(isSearchActive: false, searchQuery: '')));
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<DocumentListState> emit,
  ) async {
    final documents = await _searchDocuments(
      SearchDocumentsParams(event.query),
    );
    emit(
      _derive(state.copyWith(documents: documents, searchQuery: event.query)),
    );
  }

  void _onSelectModeEntered(
    SelectModeEntered event,
    Emitter<DocumentListState> emit,
  ) {
    emit(state.copyWith(isSelectMode: true, overlay: DocumentsOverlay.none));
  }

  void _onSelectModeExited(
    SelectModeExited event,
    Emitter<DocumentListState> emit,
  ) {
    emit(state.copyWith(isSelectMode: false, selectedIds: const {}));
  }

  void _onSelectionToggled(
    DocumentSelectionToggled event,
    Emitter<DocumentListState> emit,
  ) {
    final selectedIds = Set<String>.from(state.selectedIds);
    if (selectedIds.contains(event.documentId)) {
      selectedIds.remove(event.documentId);
    } else {
      selectedIds.add(event.documentId);
    }
    emit(state.copyWith(selectedIds: selectedIds));
  }

  Future<void> _onDocumentTapped(
    DocumentTapped event,
    Emitter<DocumentListState> emit,
  ) async {
    await _toggleDocumentStatus(event.documentId);
    final documents = await _getDocuments();
    emit(_derive(state.copyWith(documents: documents)));
  }

  void _onSelectAllPressed(
    SelectAllPressed event,
    Emitter<DocumentListState> emit,
  ) {
    final selectedIds = state.isAllVisibleSelected
        ? <String>{}
        : state.visibleDocuments.map((document) => document.id).toSet();
    emit(state.copyWith(selectedIds: selectedIds));
  }

  Future<void> _onDeleteSelectedPressed(
    DeleteSelectedPressed event,
    Emitter<DocumentListState> emit,
  ) async {
    if (state.selectedIds.isEmpty) return;
    await _deleteDocuments(DeleteDocumentsParams(state.selectedIds));
    final documents = await _getDocuments();
    emit(
      _derive(
        state.copyWith(
          documents: documents,
          selectedIds: const {},
          isSelectMode: false,
        ),
      ),
    );
  }

  Future<void> _onShareSelectedPressed(
    ShareSelectedPressed event,
    Emitter<DocumentListState> emit,
  ) async {
    final documents = state.documents
        .where((document) => state.selectedIds.contains(document.id))
        .toList(growable: false);
    if (documents.isEmpty) return;
    try {
      await _shareDocuments(ShareDocumentsParams(documents));
    } catch (_) {
      emit(state.copyWith(errorKey: AppLocaleKeys.errorsShareManyFailed));
    }
  }

  Document? _contextDocument() {
    final documentId = state.contextDocumentId;
    if (documentId == null) return null;
    for (final document in state.documents) {
      if (document.id == documentId) {
        return document;
      }
    }
    return null;
  }

  String _importErrorKey(DocumentImportErrorCode code) {
    return switch (code) {
      DocumentImportErrorCode.filePickerUnavailable =>
        AppLocaleKeys.errorsFilePickerUnavailable,
      DocumentImportErrorCode.unsupportedFile =>
        AppLocaleKeys.errorsUnsupportedFile,
      DocumentImportErrorCode.fileSaveFailed =>
        AppLocaleKeys.errorsFileSaveFailed,
      DocumentImportErrorCode.photoPickerUnavailable =>
        AppLocaleKeys.errorsPhotoPickerUnavailable,
      DocumentImportErrorCode.scannerUnavailable =>
        AppLocaleKeys.errorsScannerUnavailable,
      DocumentImportErrorCode.permissionDenied =>
        AppLocaleKeys.errorsPermissionDenied,
      DocumentImportErrorCode.pdfBuildFailed =>
        AppLocaleKeys.errorsPdfBuildFailed,
      DocumentImportErrorCode.previewRenderFailed =>
        AppLocaleKeys.errorsPreviewRenderFailed,
      DocumentImportErrorCode.unknown => AppLocaleKeys.errorsImportFailed,
    };
  }

  DocumentListState _derive(DocumentListState input) {
    final visibleDocuments = input.documents
        .where((document) {
          final matchesTab = switch (input.tab) {
            DocumentTab.all => true,
            DocumentTab.signed => document.status == DocumentStatus.signed,
            DocumentTab.unsigned => document.status == DocumentStatus.unsigned,
          };
          final matchesQuery =
              input.searchQuery.trim().isEmpty ||
              document.title.toLowerCase().contains(
                input.searchQuery.trim().toLowerCase(),
              );
          return matchesTab && matchesQuery;
        })
        .toList(growable: false);

    return input.copyWith(visibleDocuments: visibleDocuments);
  }
}
