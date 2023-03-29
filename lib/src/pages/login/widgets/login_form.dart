import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/config/theme.dart' as custom_theme;
import 'package:my_first_app/src/config/route.dart' as custom_route;
import 'package:my_first_app/src/constants/setting.dart';
import 'package:my_first_app/src/pages/home/home_page.dart';
import 'package:my_first_app/src/utils/RegexValidator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenArguments {
  final String name;
  final int age;

  ScreenArguments(this.name, this.age);
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  String? _errorUsername;
  String? _errorPassword;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [_buildForm(), _buildSubmitFormButton()],
    );
  }

  Container _buildSubmitFormButton() => Container(
        width: 220,
        height: 50,
        decoration: _boxDecoration(),
        child: TextButton(
          onPressed: () {
            String username = usernameController.text;
            String password = passwordController.text;
            _errorUsername = null;
            _errorPassword = null;
            if (!EmailSubmitRegexValidator().isValid(username)) {
              _errorUsername = "The Email must be valid";
            }
            if (password.length < 8) {
              _errorPassword = "Password need at least 8 characters";
            }
            if (_errorUsername == null && _errorPassword == null) {
              showLoading().show(context);
              Future.delayed(const Duration(seconds: 1)).then((value) async {
                Navigator.pop(context);
                if (username == "somsakra@live.com" && password == "12345678") {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomePage(name: 'xxx', age: 20)));
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(Setting.TOKEN_PREF, 'asdfweadsfeasdfesdfesde');
                  prefs.setString(Setting.USERNAME_PREF, username);

                  Navigator.pushReplacementNamed(
                      context, custom_route.Route.home);
                } else {
                  showAlertBar().show(context);
                  setState(() {});
                }
              });
            } else {
              setState(() {});
            }
          },
          child: const Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Flushbar<dynamic> showAlertBar() {
    return Flushbar(
      title: "Username or Password incorrect",
      message: "Please Try Again",
      icon: const Icon(
        Icons.error,
        size: 28.0,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Flushbar<dynamic> showLoading() {
    return Flushbar(
      message: "Loading....",
      icon: const Icon(
        Icons.error,
        size: 28.0,
        color: Colors.orange,
      ),
      showProgressIndicator: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    );
  }

  BoxDecoration _boxDecoration() {
    const gradientStart = custom_theme.Theme.gradientStart;
    const gradientEnd = custom_theme.Theme.gradientEnd;

    BoxShadow boxShadowItem(Color color) {
      return BoxShadow(
        color: color,
        offset: const Offset(1, 6),
        blurRadius: 20.0,
      );
    }

    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      boxShadow: [
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      gradient: const LinearGradient(
          colors: [gradientEnd, gradientStart],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0]),
    );
  }

  Card _buildForm() => Card(
        margin: const EdgeInsets.only(bottom: 22, left: 22, right: 22),
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 58, left: 28, right: 28),
          child: FormInput(
            usernameController: usernameController,
            passwordController: passwordController,
            errorUsername: _errorUsername,
            errorPassword: _errorPassword,
          ),
        ),
      );
}

class FormInput extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String? errorUsername;
  final String? errorPassword;

  const FormInput({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.errorUsername,
    required this.errorPassword,
  }) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _color = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUserName(),
        const Divider(
          height: 22,
          thickness: 1,
          indent: 13,
          endIndent: 13,
        ),
        _buildPassword(),
      ],
    );
  }

  TextStyle _textStyle() =>
      TextStyle(fontWeight: FontWeight.w500, color: _color);

  TextField _buildPassword() => TextField(
        controller: widget.passwordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Password',
          labelStyle: _textStyle(),
          icon: FaIcon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: _color,
          ),
          errorText: widget.errorPassword,
        ),
        obscureText: true,
      );

  TextField _buildUserName() => TextField(
        controller: widget.usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Email Address',
          labelStyle: _textStyle(),
          hintText: 'email@example.com',
          icon: FaIcon(
            FontAwesomeIcons.envelope,
            size: 22.0,
            color: _color,
          ),
          errorText: widget.errorUsername,
        ),
      );
}
