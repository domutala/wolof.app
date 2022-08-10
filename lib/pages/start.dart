import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/service/session.dart' as session_service;
import 'package:wolofbat/utils/rsa.dart' as rsa;

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await rsa.init();
    if (await session_service.init()) next();
  }

  next() async {
    await Future.delayed(const Duration(seconds: 2));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight.value = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: init,
              child: Center(
                child: Button(
                  onPressed: init,
                  child: const Text('start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
