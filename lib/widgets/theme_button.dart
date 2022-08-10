import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/theme/settings.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({Key? key}) : super(key: key);

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    themeMode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Button(
        padding: 0,
        radius: 'circle',
        onPressed: () {
          themeToggle.value = !themeToggle.value;
        },
        child: Icon(
          themeMode.value == 'light'
              ? Icons.sunny
              : themeMode.value == 'dark'
                  ? Icons.dark_mode
                  : Icons.computer,
        ),
      ),
    );
  }
}
