import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import 'circle_icon_button.dart';

class SelectedActionsBar extends StatelessWidget {
  final VoidCallback onDelete;

  const SelectedActionsBar({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 18,
      right: 18,
      bottom: 34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(assetPath: 'assets/figma/trash.svg', onPressed: onDelete, foregroundColor: AppColors.destructive, size: 62, iconSize: 22, semanticLabel: 'Delete'),
          CircleIconButton(assetPath: 'assets/figma/share.svg', onPressed: () {}, foregroundColor: AppColors.textPrimary, size: 62, iconSize: 22, semanticLabel: 'Share'),
        ],
      ),
    );
  }
}
