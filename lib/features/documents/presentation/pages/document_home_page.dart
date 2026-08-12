import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import '../../domain/entities/document_tab.dart';
import '../bloc/document_list_bloc.dart';
import '../widgets/add_document_glass_sheet.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/document_card.dart';
import '../widgets/document_context_menu.dart';
import '../widgets/document_overflow_menu.dart';
import '../widgets/document_tabs.dart';
import '../widgets/empty_documents_view.dart';
import '../widgets/glass_tap_target.dart';
import '../widgets/search_documents_bar.dart';
import '../widgets/selected_actions_bar.dart';
import '../widgets/signica_logo.dart';

@RoutePage()
class DocumentHomePage extends StatelessWidget {
  const DocumentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<DocumentListBloc>()..add(const DocumentsStarted()), child: const _DocumentHomeView());
  }
}

class _DocumentHomeView extends StatelessWidget {
  const _DocumentHomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentListBloc, DocumentListState>(
      builder: (context, state) {
        final bloc = context.read<DocumentListBloc>();

        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _Header(
                        state: state,
                        onMenuPressed: () {
                          bloc.add(const ActionsMenuToggled());
                        },
                        onCloseSelect: () {
                          bloc.add(const SelectModeExited());
                        },
                        onSelectAll: () {
                          bloc.add(const SelectAllPressed());
                        },
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.paper,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
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
                                child: state.isEmpty
                                    ? EmptyDocumentsView(
                                        onSourceSelected: (DocumentSource source) {
                                          bloc.add(AddDocumentSourceSelected(source));
                                        },
                                      )
                                    : _DocumentGrid(state: state),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!state.isSelectMode)
                    Positioned(
                      left: 18,
                      right: 18,
                      bottom: 36,
                      child: _BottomDocumentControls(
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
                    ),
                  if (state.isSelectMode)
                    SelectedActionsBar(
                      onDelete: () {
                        bloc.add(const DeleteSelectedPressed());
                      },
                    ),
                  if (state.overlay == DocumentsOverlay.documentContext)
                    _DocumentContextDismissLayer(
                      onDismiss: () {
                        bloc.add(const DocumentContextMenuDismissed());
                      },
                    ),
                  if (state.overlay == DocumentsOverlay.documentContext)
                    DocumentContextMenu(
                      onPrint: () {
                        bloc.add(const DocumentContextMenuDismissed());
                      },
                      onShare: () {
                        bloc.add(const DocumentContextMenuDismissed());
                      },
                      onDelete: () {
                        bloc.add(const ContextDocumentDeletePressed());
                      },
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
                      onSelect: () {
                        bloc.add(const SelectModeEntered());
                      },
                      onAddDocument: () {
                        bloc.add(const AddDocumentPressed());
                      },
                    ),
                  if (state.isImporting)
                    Positioned.fill(
                      child: Container(color: Colors.black.withValues(alpha: 0.16), alignment: Alignment.center, child: const CircularProgressIndicator()),
                    ),
                  if (state.overlay == DocumentsOverlay.addSource)
                    AddDocumentGlassSheet(
                      onSourceSelected: (source) {
                        bloc.add(AddDocumentSourceSelected(source));
                      },
                      onClose: () {
                        bloc.add(const AddDocumentCancelled());
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BottomDocumentControls extends StatelessWidget {
  final DocumentListState state;
  final VoidCallback onSearchPressed;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchClosed;
  final VoidCallback onAddPressed;

  const _BottomDocumentControls({required this.state, required this.onSearchPressed, required this.onSearchChanged, required this.onSearchClosed, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 360),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack, reverseCurve: Curves.easeInCubic);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(curved),
            child: ScaleTransition(scale: Tween<double>(begin: 0.96, end: 1).animate(curved), child: child),
          ),
        );
      },
      child: state.isSearchActive
          ? SearchDocumentsBar(key: const ValueKey('search'), query: state.searchQuery, onChanged: onSearchChanged, onClose: onSearchClosed)
          : Row(
              key: const ValueKey('actions'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundGlassActionButton(icon: Icons.search, onPressed: onSearchPressed),
                _AddDocumentGlassButton(onPressed: onAddPressed),
              ],
            ),
    );
  }
}

class _RoundGlassActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _RoundGlassActionButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GlassTapTarget(
      onTap: onPressed,
      child: GlassIconButton(
        icon: Icon(icon, color: const Color(0xFF2F2F2F)),
        onPressed: () {},
        size: 70,
        iconSize: 34,
        useOwnLayer: true,
        interactionScale: 0.96,
        glowColor: Colors.white.withValues(alpha: 0.55),
        glowRadius: 26,
        semanticLabel: 'Search',
        settings: LiquidGlassSettings(
          blur: 14,
          thickness: 32,
          refractiveIndex: 1.44,
          chromaticAberration: 0.014,
          lightIntensity: 0.72,
          ambientStrength: 0.16,
          ambientRim: 0.42,
          fresnelStrength: 0.88,
          saturation: 1.16,
          glowIntensity: 0.48,
          whitenStrength: 0.22,
          glassColor: Colors.white.withValues(alpha: 0.24),
          backerColor: Colors.white.withValues(alpha: 0.20),
        ),
      ),
    );
  }
}

class _AddDocumentGlassButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddDocumentGlassButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GlassTapTarget(
      onTap: onPressed,
      child: GlassButton.custom(
        onTap: () {},
        width: 206,
        height: 62,
        shape: const LiquidRoundedRectangle(borderRadius: 31),
        useOwnLayer: true,
        style: GlassButtonStyle.prominent,
        interactionScale: 1.05,
        glowColor: AppColors.accent.withValues(alpha: 0.36),
        glowRadius: 1.1,
        settings: LiquidGlassSettings(blur: 16, thickness: 24, refractiveIndex: 1.34, glassColor: AppColors.accent.withValues(alpha: 0.48)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle, color: AppColors.ink, size: 24),
                SizedBox(width: 8),
                Text(
                  'Add Document',
                  style: TextStyle(color: AppColors.ink, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DocumentListState state;
  final VoidCallback onMenuPressed;
  final VoidCallback onCloseSelect;
  final VoidCallback onSelectAll;

  const _Header({required this.state, required this.onMenuPressed, required this.onCloseSelect, required this.onSelectAll});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(left: 18, top: topInset + 12, right: 18, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (state.isSelectMode == false)
            const SignicaLogo()
          else
            GlassButton.custom(
              onTap: onSelectAll,
              height: 44,
              shape: const LiquidRoundedRectangle(borderRadius: 15.2),
              useOwnLayer: true,
              interactionScale: 1.04,
              glowColor: AppColors.white.withValues(alpha: 0.1),
              glowRadius: 1.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  state.isAllVisibleSelected ? 'Deselect All (${state.selectedIds.length})' : 'Select All',
                  style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          if (state.isSelectMode)
            CircleIconButton(icon: Icons.close, size: 52, onPressed: onCloseSelect)
          else
            Row(
              children: [
                if (state.tab == DocumentTab.signed) CircleIconButton(icon: Icons.settings, size: 38, borderRadius: 15.2, onPressed: () {}),
                if (state.tab == DocumentTab.signed) const SizedBox(width: 8),
                CircleIconButton(icon: Icons.more_horiz, size: 38, borderRadius: 15.2, onPressed: onMenuPressed),
              ],
            ),
        ],
      ),
    );
  }
}

class _DocumentGrid extends StatelessWidget {
  final DocumentListState state;

  const _DocumentGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentListBloc>();
    return GridView.builder(
      padding: const EdgeInsets.only(left: 28, top: 36, right: 28, bottom: 126),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 38, crossAxisSpacing: 19, childAspectRatio: 150 / 227),
      itemCount: state.visibleDocuments.length,
      itemBuilder: (context, index) {
        final document = state.visibleDocuments[index];
        final shouldDim = state.overlay == DocumentsOverlay.documentContext && state.contextDocumentId != document.id;
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          opacity: shouldDim ? 0.18 : 1,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: shouldDim ? 7 : 0, sigmaY: shouldDim ? 7 : 0),
            child: DocumentCard(
              document: document,
              isSelected: state.selectedIds.contains(document.id),
              isSelectMode: state.isSelectMode,
              onTap: () {
                if (state.overlay == DocumentsOverlay.documentContext) {
                  bloc.add(const DocumentContextMenuDismissed());
                  return;
                }
                if (state.isSelectMode) {
                  bloc.add(DocumentSelectionToggled(document.id));
                  return;
                }
                bloc.add(DocumentTapped(document.id));
              },
              onLongPress: () {
                bloc.add(DocumentContextMenuOpened(document.id));
              },
            ),
          ),
        );
      },
    );
  }
}

class _DocumentContextDismissLayer extends StatelessWidget {
  final VoidCallback onDismiss;

  const _DocumentContextDismissLayer({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Positioned(
      left: 0,
      right: 0,
      top: topInset + 66,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onDismiss,
          child: ColoredBox(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
    );
  }
}
