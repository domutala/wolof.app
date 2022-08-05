import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolofbat/routes/index.dart';
import 'package:wolofbat/theme/settings.dart';

final statusBarHeight = ValueNotifier<double>(0);

void main() {
  return runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        routes: routes,
        initialRoute: 'start',
        // home: const HomePage(),
      ),
    );
  }
}
