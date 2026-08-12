import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';
import 'glass_tap_target.dart';

class EmptyDocumentsView extends StatelessWidget {
  final ValueChanged<DocumentSource> onSourceSelected;

  const EmptyDocumentsView({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 272,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 13,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/figma/empty_document.png',
                        width: 164,
                        height: 222,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 126,
                    top: 101,
                    child: _EmptySignatureArea(),
                  ),
                  Positioned(
                    right: 18,
                    top: 0,
                    child: Transform.rotate(
                      angle: 0.53,
                      child: Image.asset(
                        'assets/figma/pen.png',
                        width: 30,
                        height: 155,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 54,
                    right: 54,
                    bottom: 0,
                    child: Container(
                      height: 59,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.transparent, AppColors.paper],
                          stops: [0.3, 0.8],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No Documents Yet',
              style: TextStyle(
                color: AppColors.textStrong,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your can add documents from ',
              style: TextStyle(
                color: AppColors.textStrong.withValues(alpha: 0.40),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _SourcePill(
                  assetPath: 'assets/figma/source_files.png',
                  label: 'Files',
                  onTap: () => onSourceSelected(DocumentSource.files),
                ),
                _SourcePill(
                  assetPath: 'assets/figma/source_photos.png',
                  label: 'Photos',
                  onTap: () => onSourceSelected(DocumentSource.photos),
                ),
                _SourcePill(
                  assetPath: 'assets/figma/source_scanner.png',
                  label: 'Scanner',
                  onTap: () => onSourceSelected(DocumentSource.scanner),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySignatureArea extends StatelessWidget {
  const _EmptySignatureArea();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(50, 43),
      painter: _EmptySignaturePainter(),
    );
  }
}

class _EmptySignaturePainter extends CustomPainter {
  const _EmptySignaturePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final guidePaint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    const dash = 5.0;
    const gap = 4.0;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    _drawDashedLine(
      canvas,
      rect.topRight,
      rect.bottomRight,
      dash,
      gap,
      guidePaint,
    );
    _drawDashedLine(
      canvas,
      rect.bottomLeft,
      rect.bottomRight,
      dash,
      gap,
      guidePaint,
    );

    final signaturePaint = Paint()
      ..color = AppColors.textPrimary
      ..strokeWidth = 2.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(2, 31)
      ..cubicTo(8, 18, 14, 17, 17, 29)
      ..cubicTo(20, 39, 25, 11, 30, 22)
      ..cubicTo(34, 30, 39, 29, 48, 24)
      ..moveTo(7, 38)
      ..cubicTo(19, 34, 31, 32, 49, 35);
    canvas.drawPath(path, signaturePaint);
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    double dash,
    double gap,
    Paint paint,
  ) {
    final delta = end - start;
    final distance = delta.distance;
    final direction = delta / distance;
    var drawn = 0.0;
    while (drawn < distance) {
      final next = (drawn + dash).clamp(0.0, distance);
      canvas.drawLine(
        start + direction * drawn,
        start + direction * next,
        paint,
      );
      drawn += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SourcePill extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _SourcePill({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTapTarget(
      onTap: onTap,
      child: GlassButton.custom(
        onTap: () {},
        width: switch (label) {
          'Files' => 128,
          'Photos' => 142,
          _ => 156,
        },
        height: 56,
        shape: const LiquidRoundedRectangle(borderRadius: 28),
        useOwnLayer: true,
        interactionScale: 1.05,
        glowColor: AppColors.white.withValues(alpha: 0.42),
        glowRadius: 1.2,
        settings: LiquidGlassSettings(
          blur: 18,
          thickness: 28,
          refractiveIndex: 1.42,
          lightIntensity: 0.7,
          ambientStrength: 0.16,
          ambientRim: 0.38,
          fresnelStrength: 0.86,
          whitenStrength: 0.26,
          glassColor: AppColors.white.withValues(alpha: 0.42),
          backerColor: AppColors.white.withValues(alpha: 0.34),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(assetPath, width: 24, height: 24),
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
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
