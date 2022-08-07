import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolofbat/theme/button.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/theme/input.dart';

var theme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  primaryColor: primaryColor,
  primaryColorLight: lightColor,
  primaryColorDark: darkColor,
  scaffoldBackgroundColor: lightColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: primaryColor,
    onSurface: darkColor,
    brightness: Brightness.dark,
  ),

  iconTheme: IconThemeData(color: darkColor, size: 28),
  inputDecorationTheme: inputDecorationTheme,
  textButtonTheme: textButtonTheme,

  // text theme
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: darkColor,
    selectionColor: primaryColor,
    selectionHandleColor: primaryColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: darkColor, fontSize: 16),
    bodyText2: TextStyle(color: darkColor, fontSize: 16),
    caption: TextStyle(color: darkColor, fontSize: 12),
    overline: TextStyle(color: darkColor, fontSize: 10),
    subtitle1: TextStyle(color: darkColor, fontSize: 16),
    subtitle2: TextStyle(color: darkColor, fontSize: 14),
    headline1: TextStyle(color: darkColor, fontSize: 96),
    headline2: TextStyle(color: darkColor, fontSize: 60),
    headline3: TextStyle(color: darkColor, fontSize: 48),
    headline4: TextStyle(color: darkColor, fontSize: 34),
    headline5: TextStyle(color: darkColor, fontSize: 24),
    headline6: TextStyle(color: darkColor, fontSize: 20),
  ),

  // appbar
  appBarTheme: AppBarTheme(
    elevation: 0,
    shadowColor: const Color.fromARGB(102, 0, 0, 0),
    backgroundColor: darken(lightColor, .1),
    iconTheme: IconThemeData(color: darkColor),
    toolbarHeight: 50,
    titleTextStyle: TextStyle(fontSize: 20, color: darkColor),
    titleSpacing: 35,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  primaryColor: primaryColor,
  primaryColorLight: darkColor,
  primaryColorDark: lightColor,
  scaffoldBackgroundColor: darkColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: primaryColor,
    onSurface: lightColor,
    brightness: Brightness.light,
  ),

  iconTheme: IconThemeData(color: lightColor, size: 28),
  inputDecorationTheme: inputDecorationThemeDark,
  textButtonTheme: textButtonTheme,

  // text theme
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lightColor,
    selectionColor: primaryColor,
    selectionHandleColor: primaryColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: lightColor, fontSize: 16),
    bodyText2: TextStyle(color: lightColor, fontSize: 16),
    caption: TextStyle(color: lightColor, fontSize: 12),
    overline: TextStyle(color: lightColor, fontSize: 10),
    subtitle1: TextStyle(color: lightColor, fontSize: 16),
    subtitle2: TextStyle(color: lightColor, fontSize: 14),
    headline1: TextStyle(color: lightColor, fontSize: 96),
    headline2: TextStyle(color: lightColor, fontSize: 60),
    headline3: TextStyle(color: lightColor, fontSize: 48),
    headline4: TextStyle(color: lightColor, fontSize: 34),
    headline5: TextStyle(color: lightColor, fontSize: 24),
    headline6: TextStyle(color: lightColor, fontSize: 20),
  ),

  // appbar
  appBarTheme: AppBarTheme(
    elevation: 0,
    shadowColor: const Color.fromARGB(102, 0, 0, 0),
    backgroundColor: darken(darkColor, .05),
    iconTheme: IconThemeData(color: lightColor),
    toolbarHeight: 50,
    titleTextStyle: TextStyle(fontSize: 20, color: lightColor),
    titleSpacing: 35,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  ),
);
