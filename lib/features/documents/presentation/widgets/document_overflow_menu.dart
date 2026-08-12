import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 262.0;
const _menuHeight = 100.0;
const _menuRadius = 34.0;
const _menuItemHeight = _menuHeight / 2;
const _menuItemWidth = _menuWidth;

class DocumentOverflowMenu extends StatelessWidget {
  final VoidCallback onSelect;
  final VoidCallback onAddDocument;

  const DocumentOverflowMenu({super.key, required this.onSelect, required this.onAddDocument});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 118,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              alignment: Alignment.topCenter,
              scale: 0.94 + 0.06 * value,
              child: Transform.translate(offset: Offset(0, -6 * (1 - value)), child: child),
            ),
          );
        },
        child: SizedBox(
          width: _menuWidth,
          height: _menuHeight,
          child: GlassContainer(
            useOwnLayer: true,
            clipBehavior: Clip.antiAlias,
            shape: const LiquidRoundedRectangle(borderRadius: _menuRadius),
            settings: LiquidGlassSettings(
              blur: 14,
              thickness: 34,
              refractiveIndex: 1.46,
              chromaticAberration: 0.018,
              lightIntensity: 0.74,
              ambientStrength: 0.18,
              ambientRim: 0.48,
              fresnelStrength: 0.92,
              saturation: 1.28,
              glowIntensity: 0.52,
              whitenStrength: 0.14,
              glassColor: AppColors.white.withValues(alpha: 0.18),
              backerColor: AppColors.glassBacker.withValues(alpha: 0.18),
            ),
            child: Column(
              children: [
                _MenuItem(icon: Icons.check_circle_outline, label: 'Select', onTap: onSelect),
                _MenuItem(icon: Icons.add_circle, label: 'Add Document', onTap: onAddDocument),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _menuItemWidth,
      height: _menuItemHeight,
      child: GlassButton.custom(
        onTap: onTap,
        height: _menuItemHeight,
        useOwnLayer: true,
        style: GlassButtonStyle.transparent,
        shape: const LiquidRoundedRectangle(borderRadius: 22),
        interactionScale: 1.03,
        glowColor: AppColors.white.withValues(alpha: 0.26),
        glowRadius: 0.8,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 160,
            child: Row(
              children: [
                Icon(icon, color: AppColors.textPrimary, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
