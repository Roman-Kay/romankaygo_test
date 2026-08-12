import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 250.0;
const _menuHeight = 137.0;
const _menuRadius = 34.0;

class DocumentContextMenu extends StatelessWidget {
  final VoidCallback onPrint;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const DocumentContextMenu({super.key, required this.onPrint, required this.onShare, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 22,
      top: 411,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0, 1),
            child: Transform.translate(
              offset: Offset(0, 12 * (1 - value)),
              child: Transform.scale(scale: 0.92 + 0.08 * value, alignment: Alignment.bottomCenter, child: child),
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
              blur: 16,
              thickness: 36,
              refractiveIndex: 1.46,
              chromaticAberration: 0.018,
              lightIntensity: 0.74,
              ambientStrength: 0.18,
              ambientRim: 0.46,
              fresnelStrength: 0.9,
              saturation: 1.24,
              glowIntensity: 0.52,
              whitenStrength: 0.16,
              glassColor: AppColors.white.withValues(alpha: 0.19),
              backerColor: AppColors.glassBacker.withValues(alpha: 0.20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 66,
                  child: Row(
                    children: [
                      Expanded(
                        child: _MenuAction(icon: Icons.print, label: 'Print', onTap: onPrint),
                      ),
                      Expanded(
                        child: _MenuAction(icon: Icons.ios_share, label: 'Share', onTap: onShare),
                      ),
                    ],
                  ),
                ),
                Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: 24), color: AppColors.separator),
                Expanded(child: _DeleteAction(onTap: onDelete)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 56,
      style: GlassButtonStyle.transparent,
      useOwnLayer: true,
      interactionScale: 1.02,
      glowColor: AppColors.white.withValues(alpha: 0.24),
      glowRadius: 0.8,
      shape: const LiquidRoundedRectangle(borderRadius: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: AppColors.textPrimary),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600, height: 1.5, letterSpacing: 0),
          ),
        ],
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 70,
      style: GlassButtonStyle.transparent,
      useOwnLayer: true,
      interactionScale: 1.02,
      glowColor: AppColors.destructiveGlow.withValues(alpha: 0.18),
      glowRadius: 0.8,
      shape: const LiquidRoundedRectangle(borderRadius: 24),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Icon(Icons.delete_outline, size: 24, color: AppColors.destructiveIos),
            SizedBox(width: 8),
            Text(
              'Delete',
              style: TextStyle(color: AppColors.destructiveIos, fontSize: 17, fontWeight: FontWeight.w400, height: 1.18, letterSpacing: -0.43),
            ),
          ],
        ),
      ),
    );
  }
}
