import 'package:auto_route/auto_route.dart';

import '../../features/documents/presentation/pages/document_home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: DocumentHomeRoute.page, initial: true),
  ];
}
