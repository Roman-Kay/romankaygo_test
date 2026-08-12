import 'package:flutter/material.dart';
import 'package:test_romankaygo/app/theme/app_colors.dart';

class SignicaLogo extends StatelessWidget {
  const SignicaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/figma/logo.png', width: 38, height: 38),
        const SizedBox(width: 10),
        const Text(
          'Signica',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
