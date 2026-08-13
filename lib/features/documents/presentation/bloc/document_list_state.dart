part of 'document_list_bloc.dart';

enum DocumentsOverlay { none, addSource, actions, documentContext }

class DocumentListState extends Equatable {
  final List<Document> documents;
  final List<Document> visibleDocuments;
  final DocumentTab tab;
  final Set<String> selectedIds;
  final String searchQuery;
  final bool isLoading;
  final bool isImporting;
  final bool isSearchActive;
  final bool isSelectMode;
  final DocumentsOverlay overlay;
  final String? contextDocumentId;
  final String? errorKey;
  final String? loadErrorKey;

  const DocumentListState({
    this.documents = const [],
    this.visibleDocuments = const [],
    this.tab = DocumentTab.all,
    this.selectedIds = const {},
    this.searchQuery = '',
    this.isLoading = false,
    this.isImporting = false,
    this.isSearchActive = false,
    this.isSelectMode = false,
    this.overlay = DocumentsOverlay.none,
    this.contextDocumentId,
    this.errorKey,
    this.loadErrorKey,
  });

  bool get isEmpty => documents.isEmpty;

  bool get hasSelection => selectedIds.isNotEmpty;

  bool get isAllVisibleSelected {
    return visibleDocuments.isNotEmpty &&
        visibleDocuments.every((document) => selectedIds.contains(document.id));
  }

  DocumentListState copyWith({
    List<Document>? documents,
    List<Document>? visibleDocuments,
    DocumentTab? tab,
    Set<String>? selectedIds,
    String? searchQuery,
    bool? isLoading,
    bool? isImporting,
    bool? isSearchActive,
    bool? isSelectMode,
    DocumentsOverlay? overlay,
    String? contextDocumentId,
    bool clearContextDocument = false,
    String? errorKey,
    bool clearError = false,
    String? loadErrorKey,
    bool clearLoadError = false,
  }) {
    return DocumentListState(
      documents: documents ?? this.documents,
      visibleDocuments: visibleDocuments ?? this.visibleDocuments,
      tab: tab ?? this.tab,
      selectedIds: selectedIds ?? this.selectedIds,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isImporting: isImporting ?? this.isImporting,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      isSelectMode: isSelectMode ?? this.isSelectMode,
      overlay: overlay ?? this.overlay,
      contextDocumentId: clearContextDocument
          ? null
          : contextDocumentId ?? this.contextDocumentId,
      errorKey: clearError ? null : errorKey ?? this.errorKey,
      loadErrorKey: clearLoadError ? null : loadErrorKey ?? this.loadErrorKey,
    );
  }

  @override
  List<Object?> get props => [
    documents,
    visibleDocuments,
    tab,
    selectedIds,
    searchQuery,
    isLoading,
    isImporting,
    isSearchActive,
    isSelectMode,
    overlay,
    contextDocumentId,
    errorKey,
    loadErrorKey,
  ];
}
