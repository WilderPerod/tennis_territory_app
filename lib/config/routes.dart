import 'package:flutter/material.dart';
import 'package:tennis_territory_app/ui/add_reserve_page.dart';
import 'package:tennis_territory_app/ui/home_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String addAppointment = '/addAppointment';

  static final routes = <RouteOption>[
    RouteOption(route: home, screen: const HomePage()),
    RouteOption(route: addAppointment, screen: AddReservePage()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final element in routes) {
      appRoutes.addAll(
          {element.route: (BuildContext buildContext) => element.screen});
    }

    return appRoutes;
  }
}

class RouteOption {
  final String route;
  final Widget screen;

  RouteOption({required this.route, required this.screen});
}
