import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/config/theme.dart' as custom_theme;
import 'package:my_first_app/src/constants/asset.dart';
import 'package:my_first_app/src/pages/login/widgets/header.dart';
import 'package:my_first_app/src/pages/login/widgets/login_form.dart';
import 'package:my_first_app/src/pages/login/widgets/social_login.dart';

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
          SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                const LoginForm(),
                const SizedBox(height: 30),
                _buildTextButton('Forgot Password', onPressed: () {}),
                const SocialLogin(),
                const SizedBox(height: 25),
                _buildTextButton("Don't have Account", onPressed: () {}),
                const SizedBox(height: 80)
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextButton _buildTextButton(String text,
      {required VoidCallback onPressed, double fontSize = 16}) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ));
  }
}
