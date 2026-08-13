import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_tab.dart';
import '../bloc/document_list_bloc.dart';
import 'signica_logo.dart';

class DocumentHomeHeader extends StatelessWidget {
  final DocumentListState state;
  final VoidCallback onMenuPressed;
  final VoidCallback onCloseSelect;
  final VoidCallback onSelectAll;
  final GlobalKey menuButtonKey;

  const DocumentHomeHeader({
    super.key,
    required this.state,
    required this.onMenuPressed,
    required this.onCloseSelect,
    required this.onSelectAll,
    required this.menuButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(left: 18.w, top: topInset, right: 18.w),
      child: SizedBox(
        height: 66.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (state.isSelectMode == false)
              const SignicaLogo()
            else
              GlassButton.custom(
                onTap: onSelectAll,
                height: 44.h,
                shape: LiquidRoundedRectangle(borderRadius: 15.2.r),
                useOwnLayer: true,
                interactionScale: 1.04,
                glowColor: AppColors.white.withValues(alpha: 0.1),
                glowRadius: 1.2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  child: Text(
                    state.isAllVisibleSelected
                        ? AppLocaleKeys.actionsDeselectAll.tr(
                            namedArgs: {
                              'count': state.selectedIds.length.toString(),
                            },
                          )
                        : AppLocaleKeys.actionsSelectAll.tr(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            if (state.isSelectMode)
              GlassButton.custom(
                onTap: onCloseSelect,
                height: 38.h,
                width: 38.w,
                shape: LiquidRoundedRectangle(borderRadius: 15.2.r),
                useOwnLayer: true,
                interactionScale: 1.04,
                glowColor: AppColors.white.withValues(alpha: 0.1),
                glowRadius: 1.2,
                child: Center(
                  child: SvgPicture.asset(AppImages.closeWhite, width: 12.w),
                ),
              )
            else
              Row(
                children: [
                  if (state.tab == DocumentTab.signed)
                    GlassButton.custom(
                      onTap: () {},
                      height: 38.h,
                      width: 38.w,
                      shape: LiquidRoundedRectangle(borderRadius: 15.2.r),
                      useOwnLayer: true,
                      interactionScale: 1.04,
                      glowColor: AppColors.white.withValues(alpha: 0.1),
                      glowRadius: 1.2,
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.settings,
                          width: 18.w,
                        ),
                      ),
                    ),
                  if (state.tab == DocumentTab.signed) SizedBox(width: 12.w),
                  Semantics(
                    label: AppLocaleKeys.actionsMenu.tr(),
                    button: true,
                    child: GlassButton.custom(
                      key: menuButtonKey,
                      onTap: onMenuPressed,
                      height: 38.h,
                      width: 38.w,
                      shape: LiquidRoundedRectangle(borderRadius: 15.2.r),
                      useOwnLayer: true,
                      interactionScale: 1.04,
                      glowColor: AppColors.white.withValues(alpha: 0.1),
                      glowRadius: 1.2,
                      child: Center(
                        child: SvgPicture.asset(AppImages.menu, width: 18.w),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
