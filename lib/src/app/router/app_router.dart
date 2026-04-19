import 'package:auto_route/auto_route.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/presentation/pages/counter_page.dart';
import 'package:kyrgyz_kuhnya/src/features/splash/presentation/pages/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: CounterRoute.page),
      ];
}
