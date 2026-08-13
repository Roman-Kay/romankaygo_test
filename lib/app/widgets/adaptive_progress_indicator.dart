import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const AdaptiveProgressIndicator({super.key, this.size = 28, this.strokeWidth = 3, this.color = AppColors.accent});

  @override
  Widget build(BuildContext context) {
    final scaledSize = size.r;

    if (Platform.isIOS || Platform.isMacOS) {
      return SizedBox.square(
        dimension: scaledSize,
        child: CupertinoActivityIndicator(radius: scaledSize / 2, color: AppColors.black),
      );
    }

    return SizedBox.square(
      dimension: scaledSize,
      child: CircularProgressIndicator(strokeWidth: strokeWidth.r, valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
  }
}
