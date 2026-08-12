import 'dart:math' as math;
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_status.dart';

class DocumentCard extends StatelessWidget {
  final Document document;
  final bool isSelected;
  final bool isSelectMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DocumentCard({
    super.key,
    required this.document,
    required this.isSelected,
    required this.isSelectMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 182,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 3,
                  top: 7.5,
                  child: Transform.rotate(
                    angle: -0.03,
                    child: const _PreviewFrame(child: _FigmaDocumentUnderlay()),
                  ),
                ),
                Positioned(
                  left: 26.5,
                  top: 0,
                  child: Transform.rotate(
                    angle: 0.13,
                    child: _PreviewFrame(
                      hasShadow: true,
                      child: _PreviewImage(
                        path: document.preview.firstPageImagePath,
                        opacity: 1,
                      ),
                    ),
                  ),
                ),
                if (document.status == DocumentStatus.signed)
                  Positioned(
                    left: 54,
                    top: 140,
                    child: const _SignedMarkBadge(),
                  ),
                if (isSelectMode)
                  Positioned(
                    left: 54,
                    top: 70,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.selectedCheck
                            : AppColors.white.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.check,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.blackMuted,
                        size: 28,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 96,
            child: Text(
              document.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatDate(document.createdAt),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              height: 1.2,
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
    return Opacity(
      opacity: opacity,
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
        child: CustomPaint(
          painter: _DocumentLinesPainter(),
          size: Size.infinite,
        ),
      ),
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

class _FigmaDocumentUnderlay extends StatelessWidget {
  const _FigmaDocumentUnderlay();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/figma/empty_document.png',
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
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
      width: 123.72,
      height: 167.84,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.documentBorder.withValues(alpha: 0.59),
        ),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 11.1,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
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

    canvas.drawLine(
      Offset(size.width * 0.22, 5),
      Offset(size.width * 0.78, 5),
      titlePaint,
    );

    for (var i = 0; i < 16; i++) {
      final y = 20.0 + i * 5.8;
      final inset = i.isEven ? 0.0 : size.width * 0.08;
      canvas.drawLine(
        Offset(inset, y),
        Offset(size.width - inset - (i % 3) * 8, y),
        linePaint,
      );
    }

    final tableTop = size.height - 34;
    final tableRect = Rect.fromLTWH(0, tableTop, size.width, 26);
    canvas.drawRect(tableRect, tablePaint);
    for (var i = 1; i < 4; i++) {
      final x = size.width * i / 4;
      canvas.drawLine(
        Offset(x, tableTop),
        Offset(x, tableTop + 26),
        tablePaint,
      );
    }
    canvas.drawLine(
      Offset(0, tableTop + 13),
      Offset(size.width, tableTop + 13),
      tablePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SignatureMark extends StatelessWidget {
  const _SignatureMark();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 16,
      child: CustomPaint(
        size: const Size(40, 28),
        painter: _SignaturePainter(),
      ),
    );
  }
}

class _SignedMarkBadge extends StatelessWidget {
  const _SignedMarkBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const _SignatureMark(),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(4, 22)
      ..cubicTo(9, 6, 13, 4, 16, 17)
      ..cubicTo(20, 28, 25, 12, 29, 16)
      ..cubicTo(31, 18, 34, 20, 38, 18);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
