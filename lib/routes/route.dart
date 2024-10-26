import 'package:flutter/material.dart';
import 'package:pos/routes/route_list.dart';
import 'package:pos/screans/login.dart';
import 'package:pos/screans/home.dart';
import 'package:pos/widgets/error_screen.dart';

class OnGenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // ignore: unused_local_variable
    final parm = routeSettings.arguments;
    switch (routeSettings.name) {
      case RouteList.home:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const HomeScrean());
      case RouteList.login:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const LoginScrean());
      default:
        return errorPage(routeSettings);
    }
  }

  static Route<dynamic> errorPage(RouteSettings routeSttings) {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
