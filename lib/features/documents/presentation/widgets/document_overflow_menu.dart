import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 262.0;
const _menuHeight = 100.0;
const _menuRadius = 34.0;
const _menuItemHeight = _menuHeight / 2;

class DocumentOverflowMenu extends StatelessWidget {
  final Rect anchorRect;
  final VoidCallback onSelect;
  final VoidCallback onAddDocument;

  const DocumentOverflowMenu({
    super.key,
    required this.anchorRect,
    required this.onSelect,
    required this.onAddDocument,
  });

  @override
  Widget build(BuildContext context) {
    final menuWidth = _menuWidth.w;
    final menuHeight = _menuHeight.h;
    final menuRadius = _menuRadius.r;
    return Positioned(
      left: anchorRect.right - menuWidth,
      top: anchorRect.bottom + 12.h,
      height: menuHeight,
      child: Container(
        width: menuWidth,
        height: menuHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(menuRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withValues(alpha: 0.4),
              blurRadius: 32.r,
              spreadRadius: 4.r,
            ),
          ],
        ),
        child: GlassContainer(
          useOwnLayer: true,
          width: menuWidth,
          height: menuHeight,
          clipBehavior: Clip.antiAlias,
          shape: LiquidRoundedRectangle(borderRadius: menuRadius),
          settings: LiquidGlassSettings(
            thickness: 45,
            glassColor: AppColors.white.withValues(alpha: 0.2),
            backerColor: AppColors.white.withValues(alpha: 0.56),
            whitenStrength: 0.5,
          ),
          child: Column(
            children: [
              _MenuItem(
                svgPath: AppImages.checkmark,
                label: AppLocaleKeys.actionsSelect.tr(),
                onTap: onSelect,
              ),
              _MenuItem(
                svgPath: AppImages.add,
                label: AppLocaleKeys.actionsAddDocument.tr(),
                onTap: onAddDocument,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.svgPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: _menuItemHeight.h,
      useOwnLayer: true,
      style: GlassButtonStyle.transparent,
      shape: LiquidRoundedRectangle(borderRadius: 18.r),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 184.w,
          child: Row(
            children: [
              SvgPicture.asset(svgPath, height: 18.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textDropDown,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
