import 'package:flutter/material.dart';
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
        Navigator.of(context).pop();
      },
    );
  }
}
