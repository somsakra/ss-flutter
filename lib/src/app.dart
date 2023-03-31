import 'package:flutter/material.dart';
import 'package:my_first_app/src/config/route.dart' as custom_route;
import 'package:my_first_app/src/pages/home/home_page.dart';
import 'package:my_first_app/src/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/src/constants/setting.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getRoute(),
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final token = snapshot.data?.getString(Setting.TOKEN_PREF) ?? '';
            if (token.isNotEmpty) {
              return const HomePage();
            }
            return const LoginPage();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
