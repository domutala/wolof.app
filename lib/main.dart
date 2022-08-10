import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolofbat/routes/index.dart';
import 'package:wolofbat/theme/settings.dart';
import 'firebase_options.dart';

final statusBarHeight = ValueNotifier<double>(0);
// C:\Program Files (x86)\Java\jre1.8.0_333

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
