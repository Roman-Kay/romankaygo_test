import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  static const double defaultIconSize = 18;

  final String assetPath;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  final double? borderRadius;
  final double? iconSize;
  final String? semanticLabel;

  const CircleIconButton({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.textPrimary,
    this.size = 52,
    this.borderRadius,
    this.iconSize,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size / 2;
    final resolvedIconSize = iconSize ?? defaultIconSize;
    return IgnorePointer(
      ignoring: onPressed == null,
      child: GlassButton.custom(
        onTap: onPressed ?? () {},
        width: size,
        height: size,
        shape: LiquidRoundedRectangle(borderRadius: radius),
        useOwnLayer: true,
        glowColor: AppColors.white.withValues(alpha: 0.34),
        glowRadius: 20,
        settings: LiquidGlassSettings(
          thickness: 45,
          glassColor: backgroundColor.withValues(alpha: 0.2),
          backerColor: AppColors.white.withValues(alpha: 0.56),
          whitenStrength: 0.5,
        ),
        child: Semantics(
          label: semanticLabel,
          button: true,
          child: SvgPicture.asset(
            assetPath,
            height: resolvedIconSize,
            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
