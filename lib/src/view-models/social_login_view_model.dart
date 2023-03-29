import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin {
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onPress;

  SocialLogin({this.icon, this.backgroundColor, this.onPress});
}

class SocialLoginViewModel {
  List<SocialLogin> get items => <SocialLogin>[
        SocialLogin(
          icon: FontAwesomeIcons.apple,
          backgroundColor: Colors.black,
          onPress: () {},
        ),
        SocialLogin(
          icon: FontAwesomeIcons.google,
          backgroundColor: Colors.redAccent,
          onPress: () {},
        ),
        SocialLogin(
          icon: FontAwesomeIcons.facebookF,
          backgroundColor: Colors.blueAccent,
          onPress: () {},
        ),
        SocialLogin(
          icon: FontAwesomeIcons.line,
          backgroundColor: Colors.greenAccent,
          onPress: () {},
        ),
      ];
}
