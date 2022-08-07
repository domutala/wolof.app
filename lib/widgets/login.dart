import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: statusBarHeight.value),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Column(
                      children: [
                        Text(
                          'Se connecter',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 30),
                        Button(
                          // theme: 'dark',
                          padding: 12,
                          onPressed: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/google.svg',
                                width: 32,
                              ),
                              const SizedBox(width: 10),
                              const Text('Se connecter avec Google'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Button(
                          // theme: 'dark',
                          padding: 12,
                          onPressed: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/facebook.svg',
                                width: 32,
                              ),
                              const SizedBox(width: 10),
                              const Text('Se connecter avec Facebook'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}