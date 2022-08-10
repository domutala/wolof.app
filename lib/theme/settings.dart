import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/utils/store.dart';

final themeMode = ValueNotifier<String?>(null);

class ThemeSettings {
  static init() async {
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () async {
      var mode = await StorageManager.readData('themeMode');
      setMode(mode);
    };

    var mode = await StorageManager.readData('themeMode');
    setMode(mode);
  }

  static toggle() async {
    var mode = await StorageManager.readData('themeMode');
    mode = mode == 'dark'
        ? 'light'
        : mode == 'light'
            ? null
            : 'dark';

    setMode(mode);
  }

  static setMode([String? mode]) async {
    themeMode.value = mode;
    await StorageManager.saveData('themeMode', mode);
    setTheme(mode);
  }

  static setTheme([String? mode]) async {
    String nmode;

    if (mode == null) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      nmode = isDarkMode ? "dark" : "light";
    } else {
      nmode = mode;
    }

    OneContext()
        .oneTheme
        .changeMode(nmode == 'dark' ? ThemeMode.dark : ThemeMode.light);

    setNavBarColor(nmode);
  }

  static setNavBarColor(String mode) {
    if (mode == 'light') {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: lightColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: darkColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }
}
