import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/theme/theme.dart';

final themeMode = ValueNotifier<String?>(null);
final themeToggle = ValueNotifier<bool>(true);

class StorageManager {
  static Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = theme;
  String? _mode;

  ThemeData getTheme() => _themeData;
  String? getMode() => _mode;

  ThemeNotifier() {
    setTheme();
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () async {
      var mode = await StorageManager.readData('themeMode');
      setMode(mode);
    };

    themeToggle.addListener(toggleMode);
  }

  void toggleMode() {
    StorageManager.readData('themeMode').then((mode) async {
      mode = mode == 'dark'
          ? 'light'
          : mode == 'light'
              ? null
              : 'dark';

      setMode(mode);
    });
  }

  void setMode([String? mode]) async {
    themeMode.value = mode;
    await StorageManager.saveData('themeMode', mode);
    setTheme(mode);
  }

  void setTheme([String? mode]) async {
    String nmode;

    if (mode == null) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      nmode = isDarkMode ? "dark" : "light";
    } else {
      nmode = mode;
    }

    _themeData = nmode == 'light' ? theme : darkTheme;
    _mode = mode;

    StorageManager.saveData('themeMode', mode);
    notifyListeners();
    setNavBarColor(nmode);
  }

  setNavBarColor(String mode) {
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
