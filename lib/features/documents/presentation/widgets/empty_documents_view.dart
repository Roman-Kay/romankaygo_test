import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
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
        Text(
          AppLocaleKeys.documentsEmptyTitle.tr(),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocaleKeys.documentsEmptySubtitle.tr(),
          style: const TextStyle(
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
                label: AppLocaleKeys.sourcesFiles.tr(),
                onTap: () => onSourceSelected(DocumentSource.files),
              ),
              SourcePill(
                assetPath: AppImages.sourcePhotos,
                label: AppLocaleKeys.sourcesPhotos.tr(),
                onTap: () => onSourceSelected(DocumentSource.photos),
              ),
              SourcePill(
                assetPath: AppImages.sourceScanner,
                label: AppLocaleKeys.sourcesScanner.tr(),
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
