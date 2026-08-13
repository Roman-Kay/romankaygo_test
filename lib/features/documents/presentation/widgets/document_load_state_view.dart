import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/adaptive_progress_indicator.dart';

class DocumentLoadStateView extends StatelessWidget {
  final bool isError;
  final VoidCallback? onRetry;

  const DocumentLoadStateView.loading({super.key})
    : isError = false,
      onRetry = null;

  const DocumentLoadStateView.error({
    super.key,
    required VoidCallback this.onRetry,
  }) : isError = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isError)
              Icon(
                Icons.error_outline,
                color: AppColors.textSecondary,
                size: 34.r,
              )
            else
              const AdaptiveProgressIndicator(size: 30),
            SizedBox(height: 16.h),
            Text(
              isError
                  ? AppLocaleKeys.documentsLoadFailedTitle.tr()
                  : AppLocaleKeys.documentsLoading.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (isError) ...[
              SizedBox(height: 8.h),
              Text(
                AppLocaleKeys.documentsLoadFailedSubtitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 18.h),
              TextButton(
                onPressed: onRetry,
                child: Text(AppLocaleKeys.actionsRetry.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
