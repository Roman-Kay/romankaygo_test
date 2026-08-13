import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets/app_images.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_status.dart';

class DocumentCard extends StatelessWidget {
  static const double previewStackHeight = 182;
  static const double titleTopGap = 8;
  static const double titleWidth = 96;
  static const double titleFontSize = 14;
  static const double titleLineHeight = 1.2;
  static const int titleMaxLines = 2;
  static const double dateTopGap = 4;
  static const double dateFontSize = 11;
  static const double dateLineHeight = 1.2;

  static double get titleHeight => titleFontSize.sp * titleLineHeight * titleMaxLines;

  static double get dateHeight => dateFontSize.sp * dateLineHeight;

  static double get gridExtent => previewStackHeight.h + titleTopGap.h + titleHeight + dateTopGap.h + dateHeight;

  final Document document;
  final bool isSelected;
  final bool isSelectMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DocumentCard({super.key, required this.document, required this.isSelected, required this.isSelectMode, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final lastPageImagePath = document.preview.lastPageImagePath;
    final hasMultiplePages = document.preview.hasLastPage && lastPageImagePath != null;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: previewStackHeight.h,
            child: Stack(
              children: [
                if (hasMultiplePages)
                  Positioned(
                    left: 2.w,
                    top: 7.h,
                    child: Transform.rotate(
                      angle: -0.03,
                      child: _PreviewFrame(child: _PreviewImage(path: lastPageImagePath, opacity: 1)),
                    ),
                  ),
                Positioned(
                  left: hasMultiplePages ? 20.w : 13.14.w,
                  top: hasMultiplePages ? 8.h : 0,
                  child: hasMultiplePages
                      ? Transform.rotate(
                          angle: 0.13,
                          child: _PreviewFrame(hasShadow: true, child: _PreviewImage(path: document.preview.firstPageImagePath, opacity: 1)),
                        )
                      : _PreviewFrame(hasShadow: true, child: _PreviewImage(path: document.preview.firstPageImagePath, opacity: 1)),
                ),
                if (document.status == DocumentStatus.signed) Positioned(left: 54.w, top: 140.h, child: const _SignedMarkBadge()),
                if (isSelectMode)
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 30.r,
                      height: 30.r,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.selectedCheck : AppColors.transparent,

                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.white, width: 3.r),
                        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.1), blurRadius: 12.r, offset: Offset(0, 4.h))],
                      ),
                      child: Icon(Icons.check, color: isSelected ? AppColors.white : AppColors.blackMuted, size: 15.r),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: titleTopGap.h),
          SizedBox(
            width: titleWidth.w,
            height: titleHeight,
            child: Text(
              document.title,
              textAlign: TextAlign.center,
              maxLines: titleMaxLines,
              overflow: TextOverflow.ellipsis,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
              style: TextStyle(color: AppColors.textPrimary, fontSize: titleFontSize.sp, fontWeight: FontWeight.w700, height: titleLineHeight),
            ),
          ),
          SizedBox(height: dateTopGap.h),
          SizedBox(
            height: dateHeight,
            child: Text(
              _formatDate(document.createdAt),
              style: TextStyle(color: AppColors.textCardTitle, fontSize: dateFontSize.sp, fontWeight: FontWeight.w400, height: dateLineHeight),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day.$month.${value.year}';
  }
}

class _DocumentSheet extends StatelessWidget {
  final double opacity;

  const _DocumentSheet({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: CustomPaint(painter: _DocumentLinesPainter(), size: Size.infinite),
    );
  }
}

class _PreviewImage extends StatelessWidget {
  final String path;
  final double opacity;

  const _PreviewImage({required this.path, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const _DocumentSheet(opacity: 1);
        },
      ),
    );
  }
}

class _PreviewFrame extends StatelessWidget {
  final Widget child;
  final bool hasShadow;

  const _PreviewFrame({required this.child, this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 123.72.w,
      height: 167.84.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.documentBorder.withValues(alpha: 0.59)),
        boxShadow: hasShadow ? [BoxShadow(color: AppColors.black.withValues(alpha: 0.08), blurRadius: 11.1.r, offset: Offset(0, 4.h))] : null,
      ),
      child: child,
    );
  }
}

class _DocumentLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final titlePaint = Paint()
      ..color = AppColors.documentTitleLine
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    final linePaint = Paint()
      ..color = AppColors.documentBodyLine.withValues(alpha: 0.65)
      ..strokeWidth = 0.85
      ..strokeCap = StrokeCap.round;
    final tablePaint = Paint()
      ..color = AppColors.documentTableLine.withValues(alpha: 0.55)
      ..strokeWidth = 0.8;

    canvas.drawLine(Offset(size.width * 0.22, 5), Offset(size.width * 0.78, 5), titlePaint);

    for (var i = 0; i < 16; i++) {
      final y = 20.0 + i * 5.8;
      final inset = i.isEven ? 0.0 : size.width * 0.08;
      canvas.drawLine(Offset(inset, y), Offset(size.width - inset - (i % 3) * 8, y), linePaint);
    }

    final tableTop = size.height - 34;
    final tableRect = Rect.fromLTWH(0, tableTop, size.width, 26);
    canvas.drawRect(tableRect, tablePaint);
    for (var i = 1; i < 4; i++) {
      final x = size.width * i / 4;
      canvas.drawLine(Offset(x, tableTop), Offset(x, tableTop + 26), tablePaint);
    }
    canvas.drawLine(Offset(0, tableTop + 13), Offset(size.width, tableTop + 13), tablePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SignedMarkBadge extends StatelessWidget {
  const _SignedMarkBadge();

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.sign, height: 42.r, width: 42.r);
  }
}
