import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../app/assets/app_images.dart';
import '../../../../app/localization/app_locale_keys.dart';
import '../../../../app/theme/app_colors.dart';
import 'circle_icon_button.dart';

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
            height: 54,
            shape: const LiquidRoundedRectangle(borderRadius: 100),
            settings: LiquidGlassSettings(
              thickness: 45,
              glassColor: AppColors.white.withValues(alpha: 0.2),
              backerColor: AppColors.white.withValues(alpha: 0.56),
              whitenStrength: 0.5,
            ),
            padding: EdgeInsets.zero,
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
              placeholder: AppLocaleKeys.documentsSearchPlaceholder.tr(),
              placeholderStyle: const TextStyle(
                color: AppColors.searchColor,
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
        const SizedBox(width: 10),
        CircleIconButton(
          assetPath: AppImages.close,
          onPressed: widget.onClose,
          size: 54,
          iconSize: 18,
          semanticLabel: AppLocaleKeys.actionsClose.tr(),
        ),
      ],
    );
  }
}
