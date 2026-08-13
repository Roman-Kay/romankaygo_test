import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';

class DocumentContextDismissLayer extends StatelessWidget {
  final VoidCallback onDismiss;

  const DocumentContextDismissLayer({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Positioned(
      left: 0,
      right: 0,
      top: topInset + 66.h,
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onDismiss,
          child: ColoredBox(color: AppColors.white.withValues(alpha: 0.08)),
        ),
      ),
    );
  }
}
