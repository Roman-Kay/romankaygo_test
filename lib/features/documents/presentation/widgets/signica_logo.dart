import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_romankaygo/app/assets/app_images.dart';
import 'package:test_romankaygo/app/localization/app_locale_keys.dart';
import 'package:test_romankaygo/app/theme/app_colors.dart';

class SignicaLogo extends StatelessWidget {
  const SignicaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppImages.logo, width: 38.r, height: 38.r),
        SizedBox(width: 10.w),
        Text(
          AppLocaleKeys.appTitle.tr(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
