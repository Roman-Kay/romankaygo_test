import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';

class ImportProgressOverlay extends StatelessWidget {
  const ImportProgressOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withValues(alpha: 0.18),
        alignment: Alignment.center,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.12),
                blurRadius: 24.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              top: 20.h,
              right: 24.w,
              bottom: 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 28.r,
                  height: 28.r,
                  child: CircularProgressIndicator(strokeWidth: 3.r),
                ),
                SizedBox(height: 14.h),
                Text(
                  AppLocaleKeys.documentsImportingPreview.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
