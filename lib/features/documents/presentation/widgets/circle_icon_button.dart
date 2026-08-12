import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import 'glass_tap_target.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  final double? borderRadius;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.headerButtonBackground,
    this.foregroundColor = AppColors.white,
    this.size = 52,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size / 2;
    return GlassTapTarget(
      onTap: onPressed,
      child: GlassButton.custom(
        onTap: () {},
        width: size,
        height: size,
        shape: LiquidRoundedRectangle(borderRadius: radius),
        useOwnLayer: true,
        interactionScale: 0.94,
        glowColor: AppColors.white.withValues(alpha: 0.34),
        glowRadius: 20,
        settings: LiquidGlassSettings(
          blur: 18,
          thickness: 22,
          refractiveIndex: 1.34,
          glassColor: backgroundColor.withValues(alpha: 0.22),
        ),
        child: Icon(icon, color: foregroundColor, size: size * 0.44),
      ),
    );
  }
}
