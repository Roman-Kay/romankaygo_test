import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/theme/app_colors.dart';

const _menuWidth = 262.0;
const _menuHeight = 100.0;
const _menuRadius = 34.0;
const _menuItemHeight = _menuHeight / 2;

class DocumentOverflowMenu extends StatelessWidget {
  final Rect anchorRect;
  final VoidCallback onSelect;
  final VoidCallback onAddDocument;

  const DocumentOverflowMenu({super.key, required this.anchorRect, required this.onSelect, required this.onAddDocument});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: anchorRect.right - _menuWidth,
      top: anchorRect.bottom + 12,
      height: _menuHeight,
      child: Container(
        width: _menuWidth,
        height: _menuHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_menuRadius),
          boxShadow: [BoxShadow(color: AppColors.white.withValues(alpha: 0.4), blurRadius: 32, spreadRadius: 4)],
        ),
        child: GlassContainer(
          useOwnLayer: true,
          width: _menuWidth,
          height: _menuHeight,
          clipBehavior: Clip.antiAlias,
          shape: const LiquidRoundedRectangle(borderRadius: _menuRadius),
          settings: LiquidGlassSettings(thickness: 45, glassColor: AppColors.white.withValues(alpha: 0.2), backerColor: AppColors.white.withValues(alpha: 0.56), whitenStrength: 0.5),
          child: Column(
            children: [
              _MenuItem(svgPath: 'assets/figma/checkmark.svg', label: 'Select', onTap: onSelect),
              _MenuItem(svgPath: 'assets/figma/add.svg', label: 'Add Document', onTap: onAddDocument),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.svgPath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: _menuItemHeight,
      useOwnLayer: true,
      style: GlassButtonStyle.transparent,
      shape: const LiquidRoundedRectangle(borderRadius: 18),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 184,
          child: Row(
            children: [
              SvgPicture.asset(svgPath, height: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.textDropDown, fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
