import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/widgets/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Login(
      onLogged: () {
        OneContext().pushNamedAndRemoveUntil('start', (route) => false);
      },
    );
  }
}
