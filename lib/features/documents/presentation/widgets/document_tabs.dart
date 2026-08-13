import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_tab.dart';

class DocumentTabs extends StatelessWidget {
  final DocumentTab selectedTab;
  final ValueChanged<DocumentTab> onChanged;

  const DocumentTabs({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, top: 16.h, right: 12.w),
      child: SizedBox(
        height: 36.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GlassSegmentedControl(
              height: 36.h,
              padding: EdgeInsets.all(4.r),
              selectedIndex: _indexOf(selectedTab),
              onSegmentSelected: (index) => onChanged(_tabAt(index)),
              backgroundColor: AppColors.tabBackground,
              indicatorColor: AppColors.white,
              selectedTextStyle: TextStyle(
                color: AppColors.tabSelected,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.1,
                letterSpacing: 0,
              ),
              unselectedTextStyle: TextStyle(
                color: AppColors.tabSelected.withValues(alpha: 0.4),
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.1,
                letterSpacing: 0,
              ),
              segments: [
                GlassSegment(label: AppLocaleKeys.tabsAll.tr()),
                GlassSegment(label: AppLocaleKeys.tabsSigned.tr()),
                GlassSegment(label: AppLocaleKeys.tabsUnsigned.tr()),
              ],
            ),
            IgnorePointer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final segmentWidth = constraints.maxWidth / 3;
                  return Stack(
                    children: [
                      _TabDivider(
                        left: segmentWidth,
                        isVisible: selectedTab == DocumentTab.unsigned,
                      ),
                      _TabDivider(
                        left: segmentWidth * 2,
                        isVisible: selectedTab == DocumentTab.all,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _indexOf(DocumentTab tab) {
    return switch (tab) {
      DocumentTab.all => 0,
      DocumentTab.signed => 1,
      DocumentTab.unsigned => 2,
    };
  }

  DocumentTab _tabAt(int index) {
    return switch (index) {
      0 => DocumentTab.all,
      1 => DocumentTab.signed,
      _ => DocumentTab.unsigned,
    };
  }
}

class _TabDivider extends StatelessWidget {
  final double left;
  final bool isVisible;

  const _TabDivider({required this.left, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: 4.h,
      bottom: 4.h,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        child: Container(
          width: 1.5.w,
          decoration: BoxDecoration(
            color: AppColors.tabDivider.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
      ),
    );
  }
}
