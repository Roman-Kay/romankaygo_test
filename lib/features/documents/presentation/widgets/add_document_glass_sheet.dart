import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
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
            right: 28.w,
            bottom: 12.r + 63.r + 12.r + MediaQuery.paddingOf(context).bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _FanTransition(
                  animation: _interval(0.22, 1),
                  beginOffset: Offset(92.r, 138.r),
                  child: SourcePill.sheet(assetPath: AppImages.sourceFiles, label: AppLocaleKeys.sourcesFiles.tr(), onTap: () => widget.onSourceSelected(DocumentSource.files)),
                ),
                SizedBox(height: 12.r),
                _FanTransition(
                  animation: _interval(0.12, 0.9),
                  beginOffset: Offset(78.r, 74.r),
                  child: SourcePill.sheet(assetPath: AppImages.sourcePhotos, label: AppLocaleKeys.sourcesPhotos.tr(), onTap: () => widget.onSourceSelected(DocumentSource.photos)),
                ),
                SizedBox(height: 12.r),
                _FanTransition(
                  animation: _interval(0, 0.78),
                  beginOffset: Offset(56.r, 28.r),
                  child: SourcePill.sheet(assetPath: AppImages.sourceScanner, label: AppLocaleKeys.sourcesScanner.tr(), onTap: () => widget.onSourceSelected(DocumentSource.scanner)),
                ),
              ],
            ),
          ),

          Positioned(
            right: 20.r,
            bottom: 12.r + MediaQuery.paddingOf(context).bottom,
            child: ScaleTransition(
              scale: _interval(0, 0.65),
              child: CircleIconButton(assetPath: AppImages.close, onPressed: _close, size: 63.r, iconSize: 18, semanticLabel: AppLocaleKeys.actionsClose.tr()),
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
