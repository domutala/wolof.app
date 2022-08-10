import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/service/session.dart' as session;
import 'package:wolofbat/widgets/loading.dart';

class Login extends StatefulWidget {
  final Function? onLogged;
  const Login({Key? key, this.onLogged}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  login({String credential = "google"}) async {
    setState(() => _loading = true);
    var res = await session.login(credential: credential);
    setState(() => _loading = false);

    if (res == null) return;

    if (widget.onLogged == null) return;
    widget.onLogged!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                              'xammeeku',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(height: 30),
                            Button(
                              // theme: 'dark',
                              padding: 12,
                              onPressed: () {
                                login(credential: 'google');
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/google.svg',
                                    width: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('xammeekul ak Google'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Button(
                              // theme: 'dark',
                              padding: 12,
                              onPressed: () {
                                login(credential: 'facebook');
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/facebook.svg',
                                    width: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('xammeekul ak Facebook'),
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
          Positioned.fill(
            child: Container(
              child: _loading
                  ? const Loading(alignment: Alignment.bottomCenter)
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
