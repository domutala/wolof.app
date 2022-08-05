import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/input.dart';
import 'package:wolofbat/theme/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        home: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Text(
                        'Bat u wolof',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Rechercher un mot',
                          fillColor:
                              darken(Theme.of(context).primaryColorLight, .05),
                          enabledBorder: inputBorder.copyWith(
                            borderRadius: BorderRadius.circular(200),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: theme.toggleMode,
            child: Icon(
              theme.getMode() == 'light'
                  ? Icons.sunny
                  : theme.getMode() == 'dark'
                      ? Icons.dark_mode
                      : Icons.computer,
            ),
          ),
        ),
      ),
    );
  }
}
