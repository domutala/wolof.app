import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/firebase_options.dart';
import 'package:wolofbat/routes/index.dart';
import 'package:wolofbat/theme/settings.dart';
import 'package:wolofbat/theme/theme.dart' as th;

final statusBarHeight = ValueNotifier<double>(0);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  OnePlatform.app = () => MyApp();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ThemeSettings.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OneNotification<List<Locale>>(
      stopBubbling: true,
      rebuildOnNull: true,
      builder: (context, dataLocale) {
        return OneNotification<OneThemeChangerEvent>(
          stopBubbling: true,
          builder: (context, data) {
            // ThemeSettings.init();

            return MaterialApp(
              navigatorObservers: [OneContext().heroController],
              debugShowCheckedModeBanner: false,
              themeMode: OneThemeController.initThemeMode(ThemeMode.light),
              theme: OneThemeController.initThemeData(th.theme),
              darkTheme: OneThemeController.initDarkThemeData(th.darkTheme),
              builder: OneContext().builder,
              navigatorKey: OneContext().key,
              routes: routes,
              initialRoute: 'start',
            );
          },
        );
      },
    );
  }
}
