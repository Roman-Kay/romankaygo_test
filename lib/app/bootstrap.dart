import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'app.dart';
import 'di/injection.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: LiquidGlassWidgets.wrap(child: const SignicaApp()),
    ),
  );
}
