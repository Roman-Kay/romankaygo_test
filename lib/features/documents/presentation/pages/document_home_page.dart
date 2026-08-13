import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/di/injection.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import '../bloc/document_list_bloc.dart';
import '../widgets/add_document_glass_sheet.dart';
import '../widgets/document_bottom_controls.dart';
import '../widgets/document_card.dart';
import '../widgets/document_context_dismiss_layer.dart';
import '../widgets/document_context_menu.dart';
import '../widgets/document_grid.dart';
import '../widgets/document_home_header.dart';
import '../widgets/document_load_state_view.dart';
import '../widgets/document_overflow_menu.dart';
import '../widgets/document_tabs.dart';
import '../widgets/empty_documents_view.dart';
import '../widgets/import_progress_overlay.dart';
import '../widgets/selected_actions_bar.dart';

@RoutePage()
class DocumentHomePage extends StatelessWidget {
  const DocumentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DocumentListBloc>()..add(const DocumentsStarted()),
      child: const _DocumentHomeView(),
    );
  }
}

class _DocumentHomeView extends StatefulWidget {
  const _DocumentHomeView();

  @override
  State<_DocumentHomeView> createState() => _DocumentHomeViewState();
}

class _DocumentHomeViewState extends State<_DocumentHomeView> {
  final _menuButtonKey = GlobalKey();
  Rect? _menuAnchorRect;
  Rect? _contextMenuAnchorRect;

  void _toggleActionsMenu(DocumentListBloc bloc) {
    final context = _menuButtonKey.currentContext;
    final renderBox = context?.findRenderObject() as RenderBox?;
    final topLeft = renderBox?.localToGlobal(Offset.zero);

    if (renderBox != null && topLeft != null) {
      _menuAnchorRect = topLeft & renderBox.size;
    }

    bloc.add(const ActionsMenuToggled());
  }

  void _openDocumentContextMenu(
    DocumentListBloc bloc,
    String documentId,
    BuildContext anchorContext,
  ) {
    final renderBox = anchorContext.findRenderObject() as RenderBox?;
    final topLeft = renderBox?.localToGlobal(Offset.zero);

    if (renderBox != null && topLeft != null) {
      final titleTop =
          topLeft.dy +
          DocumentCard.previewStackHeight.h +
          DocumentCard.titleTopGap.h;

      _contextMenuAnchorRect = Rect.fromLTWH(
        topLeft.dx,
        titleTop,
        renderBox.size.width,
        1,
      );
    }

    bloc.add(DocumentContextMenuOpened(documentId));
  }

  void _addSourceSelected(DocumentListBloc bloc, DocumentSource source) {
    bloc.add(
      AddDocumentSourceSelected(
        source: source,
        photoTitle: AppLocaleKeys.documentsPhotoTitle.tr(),
        scannedTitle: AppLocaleKeys.documentsScannedTitle.tr(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentListBloc, DocumentListState>(
      listenWhen: (previous, current) => previous.errorKey != current.errorKey,
      listener: (context, state) {
        final errorKey = state.errorKey;
        if (errorKey == null) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(errorKey.tr()),
              behavior: SnackBarBehavior.floating,
            ),
          );
        context.read<DocumentListBloc>().add(const ErrorMessageShown());
      },
      child: BlocBuilder<DocumentListBloc, DocumentListState>(
        builder: (context, state) {
          final bloc = context.read<DocumentListBloc>();

          return Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      DocumentHomeHeader(
                        state: state,
                        onMenuPressed: () {
                          _toggleActionsMenu(bloc);
                        },
                        onCloseSelect: () {
                          bloc.add(const SelectModeExited());
                        },
                        onSelectAll: () {
                          bloc.add(const SelectAllPressed());
                        },
                        menuButtonKey: _menuButtonKey,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.paper,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(36.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  DocumentTabs(
                                    selectedTab: state.tab,
                                    onChanged: (tab) {
                                      bloc.add(DocumentTabChanged(tab));
                                    },
                                  ),
                                  Expanded(
                                    child: state.loadErrorKey != null
                                        ? DocumentLoadStateView.error(
                                            onRetry: () {
                                              bloc.add(
                                                const DocumentsReloadPressed(),
                                              );
                                            },
                                          )
                                        : state.isLoading
                                        ? const DocumentLoadStateView.loading()
                                        : state.isEmpty
                                        ? EmptyDocumentsView(
                                            onSourceSelected:
                                                (DocumentSource source) {
                                                  _addSourceSelected(
                                                    bloc,
                                                    source,
                                                  );
                                                },
                                          )
                                        : DocumentGrid(
                                            state: state,
                                            onContextMenuRequested:
                                                (documentId, anchorContext) {
                                                  _openDocumentContextMenu(
                                                    bloc,
                                                    documentId,
                                                    anchorContext,
                                                  );
                                                },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            if (!state.isSelectMode &&
                                state.overlay != DocumentsOverlay.addSource)
                              DocumentBottomControls(
                                state: state,
                                onSearchPressed: () {
                                  bloc.add(const SearchPressed());
                                },
                                onSearchChanged: (query) {
                                  bloc.add(SearchQueryChanged(query));
                                },
                                onSearchClosed: () {
                                  bloc.add(const SearchCancelled());
                                },
                                onAddPressed: () {
                                  bloc.add(const AddDocumentPressed());
                                },
                              ),
                            if (state.isSelectMode)
                              SelectedActionsBar(
                                hasSelection: state.selectedIds.isNotEmpty,
                                onDelete: () {
                                  bloc.add(const DeleteSelectedPressed());
                                },
                                onShare: () {
                                  bloc.add(const ShareSelectedPressed());
                                },
                              ),
                            if (state.isImporting)
                              const ImportProgressOverlay(),
                            if (state.overlay == DocumentsOverlay.addSource)
                              AddDocumentGlassSheet(
                                onSourceSelected: (source) {
                                  _addSourceSelected(bloc, source);
                                },
                                onClose: () {
                                  bloc.add(const AddDocumentCancelled());
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.overlay == DocumentsOverlay.actions)
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          bloc.add(const ActionsMenuDismissed());
                        },
                      ),
                    ),
                  if (state.overlay == DocumentsOverlay.actions)
                    DocumentOverflowMenu(
                      anchorRect: _menuAnchorRect ?? Rect.zero,
                      onSelect: () {
                        bloc.add(const SelectModeEntered());
                      },
                      onAddDocument: () {
                        bloc.add(const AddDocumentPressed());
                      },
                    ),
                  if (state.overlay == DocumentsOverlay.documentContext)
                    DocumentContextDismissLayer(
                      onDismiss: () {
                        bloc.add(const DocumentContextMenuDismissed());
                      },
                    ),
                  if (state.overlay == DocumentsOverlay.documentContext)
                    DocumentContextMenu(
                      anchorRect: _contextMenuAnchorRect ?? Rect.zero,
                      onPrint: () {
                        bloc.add(const ContextDocumentPrintPressed());
                      },
                      onShare: () {
                        bloc.add(const ContextDocumentSharePressed());
                      },
                      onDelete: () {
                        bloc.add(const ContextDocumentDeletePressed());
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
