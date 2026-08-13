import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/document_list_bloc.dart';
import 'document_card.dart';

class DocumentGrid extends StatelessWidget {
  static const double _horizontalInset = 28;
  static const double _topInset = 32;
  static const double _bottomInset = 126;
  static const double _mainAxisSpacing = 40;
  static const double _crossAxisSpacing = 19;

  final DocumentListState state;
  final void Function(String documentId, BuildContext anchorContext)
  onContextMenuRequested;

  const DocumentGrid({
    super.key,
    required this.state,
    required this.onContextMenuRequested,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentListBloc>();
    return GridView.builder(
      padding: EdgeInsets.only(
        left: _horizontalInset.w,
        top: _topInset.h,
        right: _horizontalInset.w,
        bottom: _bottomInset.h,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _mainAxisSpacing.h,
        crossAxisSpacing: _crossAxisSpacing.w,
        mainAxisExtent: DocumentCard.gridExtent,
      ),
      itemCount: state.visibleDocuments.length,
      itemBuilder: (context, index) {
        final document = state.visibleDocuments[index];
        final shouldDim =
            state.overlay == DocumentsOverlay.documentContext &&
            state.contextDocumentId != document.id;
        return Builder(
          builder: (cardContext) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              opacity: shouldDim ? 0.18 : 1,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: shouldDim ? 7 : 0,
                  sigmaY: shouldDim ? 7 : 0,
                ),
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
                    onContextMenuRequested(document.id, cardContext);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
