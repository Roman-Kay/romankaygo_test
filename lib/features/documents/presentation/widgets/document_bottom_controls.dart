import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import '../bloc/document_list_bloc.dart';
import 'circle_icon_button.dart';
import 'search_documents_bar.dart';

class DocumentBottomControls extends StatelessWidget {
  final DocumentListState state;
  final VoidCallback onSearchPressed;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchClosed;
  final VoidCallback onAddPressed;

  const DocumentBottomControls({
    super.key,
    required this.state,
    required this.onSearchPressed,
    required this.onSearchChanged,
    required this.onSearchClosed,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Positioned(
      left: 18,
      right: 18,
      bottom: 13 + bottomInset,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: state.isSearchActive
            ? SearchDocumentsBar(
                query: state.searchQuery,
                onChanged: onSearchChanged,
                onClose: onSearchClosed,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    onPressed: onSearchPressed,
                    assetPath: AppImages.search,
                    size: 62.9,
                    semanticLabel: AppLocaleKeys.actionsSearch.tr(),
                  ),
                  _AddDocumentGlassButton(onPressed: onAddPressed),
                ],
              ),
      ),
    );
  }
}

class _AddDocumentGlassButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddDocumentGlassButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onPressed,
      height: 61,
      shape: const LiquidRoundedRectangle(borderRadius: 31),
      useOwnLayer: true,
      style: GlassButtonStyle.prominent,
      interactionScale: 1.05,
      glowColor: AppColors.accent.withValues(alpha: 0.36),
      glowRadius: 1.1,
      settings: LiquidGlassSettings(
        blur: 16,
        thickness: 24,
        refractiveIndex: 1.34,
        glassColor: AppColors.accent.withValues(alpha: 0.22),
        backerColor: AppColors.accent.withValues(alpha: 0.18),
        whitenStrength: 0.04,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(31),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: [
                AppColors.accentGradientTop,
                AppColors.accentGradientBottom,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 19),
            child: Row(
              children: [
                SvgPicture.asset(AppImages.add, height: 23),
                const SizedBox(width: 8),
                Text(
                  AppLocaleKeys.actionsAddDocument.tr(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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
