import 'package:flutter/material.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import 'source_pill.dart';

class EmptyDocumentsView extends StatelessWidget {
  final ValueChanged<DocumentSource> onSourceSelected;

  const EmptyDocumentsView({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(flex: 66),
        Image.asset(AppImages.emptyDocument, width: 272, height: 160),
        const SizedBox(height: 18),
        const Text(
          'No Documents Yet',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Your can add documents from ',
          style: TextStyle(
            color: AppColors.blackEmptyHint,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 343,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              SourcePill(
                assetPath: AppImages.sourceFiles,
                label: 'Files',
                onTap: () => onSourceSelected(DocumentSource.files),
              ),
              SourcePill(
                assetPath: AppImages.sourcePhotos,
                label: 'Photos',
                onTap: () => onSourceSelected(DocumentSource.photos),
              ),
              SourcePill(
                assetPath: AppImages.sourceScanner,
                label: 'Scanner',
                onTap: () => onSourceSelected(DocumentSource.scanner),
              ),
            ],
          ),
        ),
        Spacer(flex: 176),
      ],
    );
  }
}
