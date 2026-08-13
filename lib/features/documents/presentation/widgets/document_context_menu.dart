import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 250.0;
const _menuHeight = 137.0;
const _menuRadius = 34.0;

class DocumentContextMenu extends StatelessWidget {
  final Rect anchorRect;
  final VoidCallback onPrint;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const DocumentContextMenu({
    super.key,
    required this.anchorRect,
    required this.onPrint,
    required this.onShare,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final menuWidth = _menuWidth.w;
    final menuHeight = _menuHeight.h;
    final menuRadius = _menuRadius.r;
    final left = (anchorRect.center.dx - menuWidth / 2).clamp(
      16.w,
      screenSize.width - menuWidth - 16.w,
    );
    final top = anchorRect.top.clamp(
      16.h,
      screenSize.height - menuHeight - 24.h,
    );

    return Positioned(
      left: left,
      top: top,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0, 1),
            child: Transform.translate(
              offset: Offset(0, 12.h * (1 - value)),
              child: Transform.scale(
                scale: 0.92 + 0.08 * value,
                alignment: Alignment.bottomCenter,
                child: child,
              ),
            ),
          );
        },
        child: SizedBox(
          width: menuWidth,
          height: menuHeight,
          child: GlassContainer(
            useOwnLayer: true,
            shape: LiquidRoundedRectangle(borderRadius: menuRadius),
            settings: LiquidGlassSettings(
              thickness: 45,
              glassColor: AppColors.white.withValues(alpha: 0.2),
              backerColor: AppColors.white.withValues(alpha: 0.56),
              whitenStrength: 0.5,
            ),
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: 66.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: _MenuAction(
                          assetPath: AppImages.print,
                          label: AppLocaleKeys.actionsPrint.tr(),
                          onTap: onPrint,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: _MenuAction(
                          assetPath: AppImages.share,
                          label: AppLocaleKeys.actionsShare.tr(),
                          onTap: onShare,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  color: AppColors.separator,
                ),
                const Spacer(),
                _DeleteAction(onTap: onDelete),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuAction extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _MenuAction({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 56.h,
      style: GlassButtonStyle.transparent,
      shape: LiquidRoundedRectangle(borderRadius: 26.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assetPath, height: 18.r),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textDropDown,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 40.h,
      style: GlassButtonStyle.transparent,
      shape: LiquidRoundedRectangle(borderRadius: 24.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          children: [
            SvgPicture.asset(AppImages.trash, height: 18.r),
            SizedBox(width: 13.w),
            Text(
              AppLocaleKeys.actionsDelete.tr(),
              style: TextStyle(
                color: AppColors.accentRed,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
