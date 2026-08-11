import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import 'glass_tap_target.dart';

class AddDocumentGlassSheet extends StatefulWidget {
  final ValueChanged<DocumentSource> onSourceSelected;
  final VoidCallback onClose;

  const AddDocumentGlassSheet({
    super.key,
    required this.onSourceSelected,
    required this.onClose,
  });

  @override
  State<AddDocumentGlassSheet> createState() => _AddDocumentGlassSheetState();
}

class _AddDocumentGlassSheetState extends State<AddDocumentGlassSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().whenComplete(widget.onClose);
  }

  @override
  Widget build(BuildContext context) {
    final topBarHeight = MediaQuery.paddingOf(context).top + 88;

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _close,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            left: 0,
            top: topBarHeight,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(34),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      color: Colors.white.withValues(
                        alpha: 0.46 * _controller.value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 28,
            bottom: 121,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _FanSourceButton(
                  animation: _interval(0.22, 1),
                  beginOffset: const Offset(92, 138),
                  iconAsset: 'assets/figma/source_files.png',
                  label: 'Files',
                  onTap: () => widget.onSourceSelected(DocumentSource.files),
                ),
                const SizedBox(height: 12),
                _FanSourceButton(
                  animation: _interval(0.12, 0.9),
                  beginOffset: const Offset(78, 74),
                  iconAsset: 'assets/figma/source_photos.png',
                  label: 'Photos',
                  onTap: () => widget.onSourceSelected(DocumentSource.photos),
                ),
                const SizedBox(height: 12),
                _FanSourceButton(
                  animation: _interval(0, 0.78),
                  beginOffset: const Offset(56, 28),
                  iconAsset: 'assets/figma/source_scanner.png',
                  label: 'Scanner',
                  onTap: () => widget.onSourceSelected(DocumentSource.scanner),
                ),
              ],
            ),
          ),
          Positioned(
            left: 88,
            right: 92,
            bottom: 70,
            child: _FanTitle(animation: _interval(0, 0.72)),
          ),
          Positioned(
            right: 20,
            bottom: 45,
            child: ScaleTransition(
              scale: _interval(0, 0.65),
              child: GlassTapTarget(
                onTap: _close,
                child: GlassIconButton(
                  icon: const Icon(Icons.close, color: AppColors.textPrimary),
                  onPressed: () {},
                  size: 63,
                  iconSize: 34,
                  useOwnLayer: true,
                  interactionScale: 0.94,
                  glowColor: Colors.white.withValues(alpha: 0.42),
                  glowRadius: 22,
                  settings: LiquidGlassSettings(
                    blur: 24,
                    thickness: 22,
                    refractiveIndex: 1.32,
                    glassColor: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Animation<double> _interval(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutBack),
      reverseCurve: Interval(1 - end, 1 - begin, curve: Curves.easeInCubic),
    );
  }
}

class _FanTitle extends StatelessWidget {
  final Animation<double> animation;

  const _FanTitle({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = animation.value.clamp(0.0, 1.0);
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(72 * (1 - value), 6 * (1 - value)),
            child: Transform.scale(
              alignment: Alignment.centerRight,
              scale: 0.82 + 0.18 * value,
              child: child,
            ),
          ),
        );
      },
      child: Text(
        'Add Document From',
        textAlign: TextAlign.center,
        maxLines: 1,
        style: TextStyle(
          color: AppColors.textPrimary.withValues(alpha: 0.92),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _FanSourceButton extends StatelessWidget {
  final Animation<double> animation;
  final Offset beginOffset;
  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  const _FanSourceButton({
    required this.animation,
    required this.beginOffset,
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = animation.value;
        return Opacity(
          opacity: value.clamp(0, 1),
          child: Transform.translate(
            offset: beginOffset * (1 - value),
            child: Transform.rotate(
              angle: 0.06 * (1 - value),
              child: Transform.scale(scale: 0.82 + 0.18 * value, child: child),
            ),
          ),
        );
      },
      child: GlassTapTarget(
        onTap: onTap,
        child: GlassButton.custom(
          onTap: () {},
          width: 128,
          height: 56,
          shape: const LiquidRoundedRectangle(borderRadius: 100),
          useOwnLayer: true,
          interactionScale: 1.05,
          glowColor: Colors.white.withValues(alpha: 0.42),
          glowRadius: 1.2,
          settings: LiquidGlassSettings(
            blur: 24,
            thickness: 22,
            refractiveIndex: 1.32,
            glassColor: Colors.white.withValues(alpha: 0.18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconAsset, width: 24, height: 24),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
