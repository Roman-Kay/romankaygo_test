import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';

class SourcePill extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight fontWeight;

  const SourcePill({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.width,
    this.height = 56,
    this.horizontalPadding = 20,
    this.verticalPadding = 16,
    this.fontWeight = FontWeight.w700,
  });

  const SourcePill.sheet({super.key, required this.assetPath, required this.label, required this.onTap})
    : width = 128,
      height = 56,
      horizontalPadding = 0,
      verticalPadding = 16,
      fontWeight = FontWeight.w800;

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      width: width,
      height: height,
      shape: const LiquidRoundedRectangle(borderRadius: 100),
      useOwnLayer: true,
      settings: LiquidGlassSettings(thickness: 45, glassColor: AppColors.white.withValues(alpha: 0.2), backerColor: AppColors.white.withValues(alpha: 0.56), whitenStrength: 0.5),
      child: Padding(
        padding: EdgeInsets.only(left: horizontalPadding, top: verticalPadding, right: horizontalPadding, bottom: verticalPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
