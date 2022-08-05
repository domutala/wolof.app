import 'package:flutter/material.dart';
import 'package:wolofbat/pages/home.dart';
import 'package:wolofbat/pages/start.dart';

Widget rt(Widget page, [String? name]) {
  return page;
}

Map<String, Widget Function(BuildContext)> routes = {
  "start": (_) => rt(const StartPage(), "start"),
  "home": (_) => rt(const HomePage(), "home"),
};
