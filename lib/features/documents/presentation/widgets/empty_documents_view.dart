import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/document_source.dart';

class EmptyDocumentsView extends StatelessWidget {
  final ValueChanged<DocumentSource> onSourceSelected;

  const EmptyDocumentsView({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(flex: 66),
        Image.asset('assets/figma/empty_document.png', width: 272, height: 160),
        const SizedBox(height: 18),
        const Text(
          'No Documents Yet',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700, height: 1.20),
        ),
        const SizedBox(height: 10),
        Text(
          'Your can add documents from ',
          style: TextStyle(color: AppColors.blackEmptyHint, fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 343,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _SourcePill(assetPath: 'assets/figma/source_files.png', label: 'Files', onTap: () => onSourceSelected(DocumentSource.files)),
              _SourcePill(assetPath: 'assets/figma/source_photos.png', label: 'Photos', onTap: () => onSourceSelected(DocumentSource.photos)),
              _SourcePill(assetPath: 'assets/figma/source_scanner.png', label: 'Scanner', onTap: () => onSourceSelected(DocumentSource.scanner)),
            ],
          ),
        ),
        Spacer(flex: 176),
      ],
    );
  }
}

class _SourcePill extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _SourcePill({required this.assetPath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      height: 56,
      shape: const LiquidRoundedRectangle(borderRadius: 100),
      useOwnLayer: true,
      settings: LiquidGlassSettings(thickness: 45, glassColor: AppColors.white.withValues(alpha: 0.2), backerColor: AppColors.white.withValues(alpha: 0.56), whitenStrength: 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(assetPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
