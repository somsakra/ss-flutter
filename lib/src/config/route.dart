
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/src/pages/pages.dart';

class Route {
  static const home = '/home';
  static const login = '/login';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> getRoute() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    dashboard: (context) => const DashboardPage()
  };

}