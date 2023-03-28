import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/config/theme.dart' as custom_theme;
import 'package:my_first_app/src/constants/asset.dart';
import 'package:my_first_app/src/pages/login/widgets/header.dart';
import 'package:my_first_app/src/pages/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration:
                const BoxDecoration(gradient: custom_theme.Theme.gradient),
          ),
          Column(
            children: [
              const Header(),
              LoginForm(),
              Text("forgot password"),
              Text("SSO"),
              Text("register"),
            ],
          ),
        ],
      ),
    );
  }
}
