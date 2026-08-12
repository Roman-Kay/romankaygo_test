import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/theme/app_colors.dart';
import 'glass_tap_target.dart';

class AnimatedSearchPanel extends StatelessWidget {
  final bool visible;
  final Widget child;

  const AnimatedSearchPanel({
    super.key,
    required this.visible,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        opacity: visible ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutBack,
          offset: visible ? Offset.zero : const Offset(0, 0.35),
          child: child,
        ),
      ),
    );
  }
}

class SearchDocumentsBar extends StatefulWidget {
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;

  const SearchDocumentsBar({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onClose,
  });

  @override
  State<SearchDocumentsBar> createState() => _SearchDocumentsBarState();
}

class _SearchDocumentsBarState extends State<SearchDocumentsBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassContainer(
            useOwnLayer: true,
            height: 54,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: const LiquidRoundedRectangle(borderRadius: 27),
            settings: const LiquidGlassSettings(
              blur: 18,
              thickness: 24,
              refractiveIndex: 1.34,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.glassWhite.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(27),
                border: Border.all(
                  color: AppColors.tabDivider.withValues(alpha: 0.12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CupertinoSearchTextField(
                controller: _controller,
                autofocus: true,
                onChanged: widget.onChanged,
                onSuffixTap: () {
                  _controller.clear();
                  widget.onChanged('');
                },
                backgroundColor: AppColors.transparent,
                borderRadius: BorderRadius.circular(27),
                itemColor: AppColors.textPrimary,
                itemSize: 28,
                padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 10, 0),
                prefixInsets: const EdgeInsetsDirectional.only(start: 16),
                suffixInsets: const EdgeInsetsDirectional.only(end: 12),
                placeholder: 'Search Documents',
                placeholderStyle: const TextStyle(
                  color: AppColors.searchPlaceholder,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  letterSpacing: 0,
                ),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GlassTapTarget(
          onTap: widget.onClose,
          child: GlassIconButton(
            icon: const Icon(
              CupertinoIcons.xmark,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
            size: 54,
            iconSize: 28,
            useOwnLayer: true,
            interactionScale: 0.94,
            glowColor: AppColors.glassWhite.withValues(alpha: 0.42),
            glowRadius: 20,
            settings: LiquidGlassSettings(
              blur: 18,
              thickness: 20,
              refractiveIndex: 1.3,
              glassColor: AppColors.glassWhite.withValues(alpha: 0.18),
            ),
          ),
        ),
      ],
    );
  }
}
