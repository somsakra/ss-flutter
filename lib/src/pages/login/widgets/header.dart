import 'package:flutter/material.dart';
import 'package:my_first_app/src/constants/asset.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 38),
      child: Image.asset(
        Asset.LOGO_IMAGE,
        height: 80,
      ),
    );
  }
}
