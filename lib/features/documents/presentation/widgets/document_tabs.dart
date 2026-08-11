import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

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
    return SizedBox(
      height: 36,
      child: GlassSegmentedControl(
        useOwnLayer: true,
        height: 36,
        borderRadius: 100,
        indicatorBorderRadius: 20,
        padding: const EdgeInsets.all(4),
        selectedIndex: _indexOf(selectedTab),
        onSegmentSelected: (index) => onChanged(_tabAt(index)),
        backgroundColor: const Color(0x1F767680),
        indicatorColor: CupertinoColors.white.withValues(alpha: 0.78),
        settings: const LiquidGlassSettings(
          blur: 10,
          thickness: 28,
          refractiveIndex: 1.42,
        ),
        indicatorSettings: const LiquidGlassSettings(
          blur: 14,
          thickness: 38,
          refractiveIndex: 1.5,
        ),
        selectedTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: 0,
        ),
        unselectedTextStyle: TextStyle(
          color: AppColors.textPrimary.withValues(alpha: 0.62),
          fontSize: 14,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: 0,
        ),
        dividerSettings: DividerSettings(
          thickness: 1,
          indent: 7,
          endIndent: 7,
          decoration: BoxDecoration(
            color: const Color(0xFF8E8E93).withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(0.5),
          ),
        ),
        segments: const [
          GlassSegment(label: 'All'),
          GlassSegment(label: 'Signed'),
          GlassSegment(label: 'Unsigned'),
        ],
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
