import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';

class SourcePill extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight fontWeight;

  const SourcePill({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.width,
    this.height = 56,
    this.horizontalPadding = 20,
    this.verticalPadding = 16,
    this.fontWeight = FontWeight.w700,
  });

  const SourcePill.sheet({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
  }) : width = 128,
       height = 56,
       horizontalPadding = 0,
       verticalPadding = 16,
       fontWeight = FontWeight.w800;

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      width: width?.w,
      height: height.r,
      shape: LiquidRoundedRectangle(borderRadius: 100.r),
      useOwnLayer: true,
      settings: LiquidGlassSettings(
        thickness: 45,
        glassColor: AppColors.white.withValues(alpha: 0.2),
        backerColor: AppColors.white.withValues(alpha: 0.56),
        whitenStrength: 0.5,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          top: verticalPadding.r,
          right: horizontalPadding,
          bottom: verticalPadding.r,
        ),
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 24.r, height: 24.r),
            SizedBox(width: 8.w),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
