import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 250.0;
const _menuHeight = 137.0;
const _menuRadius = 34.0;

class DocumentContextMenu extends StatelessWidget {
  final Rect anchorRect;
  final VoidCallback onPrint;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const DocumentContextMenu({
    super.key,
    required this.anchorRect,
    required this.onPrint,
    required this.onShare,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final left = (anchorRect.center.dx - _menuWidth / 2).clamp(
      16.0,
      screenSize.width - _menuWidth - 16,
    );
    final top = anchorRect.top.clamp(
      16.0,
      screenSize.height - _menuHeight - 24,
    );

    return Positioned(
      left: left,
      top: top,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0, 1),
            child: Transform.translate(
              offset: Offset(0, 12 * (1 - value)),
              child: Transform.scale(
                scale: 0.92 + 0.08 * value,
                alignment: Alignment.bottomCenter,
                child: child,
              ),
            ),
          );
        },
        child: SizedBox(
          width: _menuWidth,
          height: _menuHeight,
          child: GlassContainer(
            useOwnLayer: true,
            shape: const LiquidRoundedRectangle(borderRadius: _menuRadius),
            settings: LiquidGlassSettings(
              thickness: 45,
              glassColor: AppColors.white.withValues(alpha: 0.2),
              backerColor: AppColors.white.withValues(alpha: 0.56),
              whitenStrength: 0.5,
            ),
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  height: 66,
                  child: Row(
                    children: [
                      Expanded(
                        child: _MenuAction(
                          assetPath: AppImages.print,
                          label: 'Print',
                          onTap: onPrint,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: _MenuAction(
                          assetPath: AppImages.share,
                          label: 'Share',
                          onTap: onShare,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: AppColors.separator,
                ),
                Spacer(),
                _DeleteAction(onTap: onDelete),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuAction extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _MenuAction({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 56,
      style: GlassButtonStyle.transparent,
      shape: const LiquidRoundedRectangle(borderRadius: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assetPath, height: 18),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textDropDown,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
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
      height: 40,
      style: GlassButtonStyle.transparent,
      shape: const LiquidRoundedRectangle(borderRadius: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SvgPicture.asset(AppImages.trash, height: 18),
            const SizedBox(width: 13),
            const Text(
              'Delete',
              style: TextStyle(
                color: AppColors.accentRed,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
