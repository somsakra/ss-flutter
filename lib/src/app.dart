import 'package:flutter/material.dart';
import 'package:my_first_app/src/config/route.dart' as custom_route;
import 'package:my_first_app/src/pages/home/home_page.dart';
import 'package:my_first_app/src/pages/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getRoute(),
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: const LoginPage(),
    );
  }
}