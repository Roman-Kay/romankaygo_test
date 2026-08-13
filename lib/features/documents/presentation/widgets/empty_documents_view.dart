import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Image.asset(AppImages.emptyDocument, width: 272.w, height: 160.h),
        SizedBox(height: 18.h),
        Text(
          AppLocaleKeys.documentsEmptyTitle.tr(),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          AppLocaleKeys.documentsEmptySubtitle.tr(),
          style: TextStyle(
            color: AppColors.blackEmptyHint,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 343.w,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
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
