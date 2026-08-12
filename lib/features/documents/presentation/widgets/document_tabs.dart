import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_tab.dart';

class DocumentTabs extends StatelessWidget {
  final DocumentTab selectedTab;
  final ValueChanged<DocumentTab> onChanged;

  const DocumentTabs({super.key, required this.selectedTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16, right: 12),
      child: GlassSegmentedControl(
        height: 36,
        padding: const EdgeInsets.all(4),
        selectedIndex: _indexOf(selectedTab),
        onSegmentSelected: (index) => onChanged(_tabAt(index)),
        backgroundColor: AppColors.tabBackground,
        indicatorColor: AppColors.white,
        selectedTextStyle: const TextStyle(color: AppColors.tabSelected, fontSize: 14, fontWeight: FontWeight.w700),
        unselectedTextStyle: TextStyle(color: AppColors.tabSelected.withValues(alpha: 0.4), fontSize: 13, fontWeight: FontWeight.w700),
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
