import 'package:auto_route/auto_route.dart';
import 'package:weather_app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: WeatherRoute.page, initial: true),
    ];
  }
}
