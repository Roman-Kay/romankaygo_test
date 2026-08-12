import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import 'circle_icon_button.dart';
import 'source_pill.dart';

class AddDocumentGlassSheet extends StatefulWidget {
  final ValueChanged<DocumentSource> onSourceSelected;
  final VoidCallback onClose;

  const AddDocumentGlassSheet({super.key, required this.onSourceSelected, required this.onClose});

  @override
  State<AddDocumentGlassSheet> createState() => _AddDocumentGlassSheetState();
}

class _AddDocumentGlassSheetState extends State<AddDocumentGlassSheet> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 520))..forward();
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
    return GestureDetector(
      onTap: _close,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(color: AppColors.white.withValues(alpha: 0.46 * _controller.value));
                },
              ),
            ),
          ),
          Positioned(
            right: 28,
            bottom: 121,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _FanTransition(
                  animation: _interval(0.22, 1),
                  beginOffset: const Offset(92, 138),
                  child: SourcePill.sheet(assetPath: 'assets/figma/source_files.png', label: 'Files', onTap: () => widget.onSourceSelected(DocumentSource.files)),
                ),
                const SizedBox(height: 12),
                _FanTransition(
                  animation: _interval(0.12, 0.9),
                  beginOffset: const Offset(78, 74),
                  child: SourcePill.sheet(assetPath: 'assets/figma/source_photos.png', label: 'Photos', onTap: () => widget.onSourceSelected(DocumentSource.photos)),
                ),
                const SizedBox(height: 12),
                _FanTransition(
                  animation: _interval(0, 0.78),
                  beginOffset: const Offset(56, 28),
                  child: SourcePill.sheet(assetPath: 'assets/figma/source_scanner.png', label: 'Scanner', onTap: () => widget.onSourceSelected(DocumentSource.scanner)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20 + 63 + 12,
            bottom: 12 + MediaQuery.paddingOf(context).bottom,
            child: _FanTitle(animation: _interval(0, 0.72)),
          ),
          Positioned(
            right: 20,
            bottom: 12 + MediaQuery.paddingOf(context).bottom,
            child: ScaleTransition(
              scale: _interval(0, 0.65),
              child: GlassIconButton(
                icon: const Icon(Icons.close, color: AppColors.textPrimary),
                onPressed: _close,
                size: 63,
                iconSize: 34,
                useOwnLayer: true,
                interactionScale: 0.94,
                glowColor: AppColors.white.withValues(alpha: 0.42),
                glowRadius: 22,
                settings: CircleIconButton.iosGlassSettings(),
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
            child: Transform.scale(alignment: Alignment.centerRight, scale: 0.82 + 0.18 * value, child: child),
          ),
        );
      },
      child: SizedBox(
        height: 63,
        child: Center(
          child: Text(
            'Add Document From',
            style: TextStyle(color: AppColors.tabSelected, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class _FanTransition extends StatelessWidget {
  final Animation<double> animation;
  final Offset beginOffset;
  final Widget child;

  const _FanTransition({required this.animation, required this.beginOffset, required this.child});

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
      child: child,
    );
  }
}
