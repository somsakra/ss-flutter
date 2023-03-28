import 'package:flutter/material.dart';
import 'package:my_first_app/src/pages/home/home_page.dart';
import 'package:my_first_app/src/pages/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: const LoginPage(),
    );
  }
}