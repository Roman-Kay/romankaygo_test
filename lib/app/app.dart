import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'localization/app_locale_keys.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class SignicaApp extends StatefulWidget {
  const SignicaApp({super.key});

  @override
  State<SignicaApp> createState() => _SignicaAppState();
}

class _SignicaAppState extends State<SignicaApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppLocaleKeys.appTitle.tr(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.dark,
      routerConfig: _router.config(),
    );
  }
}
