import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
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
      left: 18.w,
      right: 18.w,
      bottom: 34.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AnimatedActionButton(
            assetPath: AppImages.trash,
            onPressed: hasSelection ? onDelete : null,
            foregroundColor: deleteColor,
            semanticLabel: AppLocaleKeys.actionsDelete.tr(),
          ),
          _AnimatedActionButton(
            assetPath: AppImages.share,
            onPressed: hasSelection ? onShare : null,
            foregroundColor: shareColor,
            semanticLabel: AppLocaleKeys.actionsShare.tr(),
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
