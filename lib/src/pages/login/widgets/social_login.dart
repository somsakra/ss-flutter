import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/view-models/social_login_view_model.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        const SizedBox(height: 12),
        _buildSocialLoginButton()
      ],
    );
  }
}

Row _buildDivider() {
  const gradientColor = [Colors.white10, Colors.white];

  Container line(List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0, 1]),
      ),
      width: 80,
      height: 1,
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      line(gradientColor),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'or',
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      ),
      line(gradientColor.reversed.toList())
    ],
  );
}

Padding _buildSocialLoginButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: SocialLoginViewModel()
          .items
          .map(
            (item) => FloatingActionButton(
              heroTag: item.icon.toString(),
              onPressed: item.onPress,
              backgroundColor: item.backgroundColor,
              child: FaIcon(
                item.icon,
                color: Colors.white,
              ),
            ),
          )
          .toList(),
    ),
  );
}
