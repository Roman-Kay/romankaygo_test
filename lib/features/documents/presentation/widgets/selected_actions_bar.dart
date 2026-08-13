import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import 'circle_icon_button.dart';

class SelectedActionsBar extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final bool hasSelection;
  const SelectedActionsBar({
    super.key,
    required this.onDelete,
    required this.onShare,
    required this.hasSelection,
  });

  @override
  Widget build(BuildContext context) {
    final deleteColor = hasSelection
        ? AppColors.destructive
        : AppColors.destructive.withValues(alpha: 0.5);
    final shareColor = hasSelection
        ? AppColors.textPrimary
        : AppColors.textPrimary.withValues(alpha: 0.5);

    return Positioned(
      left: 18,
      right: 18,
      bottom: 34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AnimatedActionButton(
            assetPath: 'assets/figma/trash.svg',
            onPressed: hasSelection ? onDelete : null,
            foregroundColor: deleteColor,
            semanticLabel: 'Delete',
          ),
          _AnimatedActionButton(
            assetPath: 'assets/figma/share.svg',
            onPressed: hasSelection ? onShare : null,
            foregroundColor: shareColor,
            semanticLabel: 'Share',
          ),
        ],
      ),
    );
  }
}

class _AnimatedActionButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onPressed;
  final Color foregroundColor;
  final String semanticLabel;

  const _AnimatedActionButton({
    required this.assetPath,
    required this.onPressed,
    required this.foregroundColor,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: foregroundColor),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      builder: (context, color, child) {
        return CircleIconButton(
          assetPath: assetPath,
          onPressed: onPressed,
          foregroundColor: color ?? foregroundColor,
          size: 62,
          iconSize: 22,
          semanticLabel: semanticLabel,
        );
      },
    );
  }
}
