import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import 'glass_tap_target.dart';

class SelectedActionsBar extends StatelessWidget {
  final VoidCallback onDelete;

  const SelectedActionsBar({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 18,
      right: 18,
      bottom: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FloatingAction(
            icon: Icons.delete_outline,
            color: AppColors.destructive,
            onTap: onDelete,
          ),
          _FloatingAction(
            icon: Icons.ios_share,
            color: AppColors.textPrimary,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _FloatingAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FloatingAction({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTapTarget(
      onTap: onTap,
      child: GlassIconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
        size: 58,
        iconSize: 30,
        useOwnLayer: true,
        interactionScale: 0.94,
        glowColor: AppColors.glassWhite.withValues(alpha: 0.42),
        glowRadius: 20,
        settings: LiquidGlassSettings(
          blur: 18,
          thickness: 22,
          refractiveIndex: 1.32,
          glassColor: AppColors.glassWhite.withValues(alpha: 0.18),
        ),
      ),
    );
  }
}
