import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final IconData? icon;
  final String? assetPath;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  final double? borderRadius;
  final double? iconSize;
  final String? semanticLabel;

  const CircleIconButton({
    super.key,
    required IconData this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.textPrimary,
    this.size = 52,
    this.borderRadius,
    this.iconSize,
    this.semanticLabel,
  }) : assetPath = null;

  const CircleIconButton.asset({
    super.key,
    required String this.assetPath,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.textPrimary,
    this.size = 52,
    this.borderRadius,
    this.iconSize,
    this.semanticLabel,
  }) : icon = null;

  static LiquidGlassSettings iosGlassSettings({Color? glassColor}) {
    final color = glassColor ?? AppColors.white;

    return LiquidGlassSettings(
      thickness: 45,
      glassColor: color.withValues(alpha: 0.2),
      backerColor: AppColors.white.withValues(alpha: 0.56),
      whitenStrength: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size / 2;
    final resolvedIconSize = iconSize ?? size * 0.44;

    return GlassButton.custom(
      onTap: onPressed,
      width: size,
      height: size,
      shape: LiquidRoundedRectangle(borderRadius: radius),
      useOwnLayer: true,
      interactionScale: 0.94,
      glowColor: AppColors.white.withValues(alpha: 0.34),
      glowRadius: 20,
      settings: iosGlassSettings(glassColor: backgroundColor),
      child: Semantics(
        label: semanticLabel,
        button: true,
        child: _CircleIconButtonContent(
          icon: icon,
          assetPath: assetPath,
          color: foregroundColor,
          size: resolvedIconSize,
        ),
      ),
    );
  }
}

class _CircleIconButtonContent extends StatelessWidget {
  final IconData? icon;
  final String? assetPath;
  final Color color;
  final double size;

  const _CircleIconButtonContent({
    required this.icon,
    required this.assetPath,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final path = assetPath;
    if (path != null) {
      return SvgPicture.asset(
        path,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    return Icon(icon, color: color, size: size);
  }
}
