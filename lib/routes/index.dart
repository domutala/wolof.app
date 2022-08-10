import 'package:flutter/material.dart';
import 'package:wolofbat/pages/create.dart';
import 'package:wolofbat/pages/home/index.dart';
import 'package:wolofbat/pages/login.dart';
import 'package:wolofbat/pages/one.dart';
import 'package:wolofbat/pages/search.dart';
import 'package:wolofbat/pages/start.dart';
import 'package:wolofbat/pages/user/show.dart';

Widget rt(Widget page, [String? name]) {
  return page;
}

Map<String, Widget Function(BuildContext)> routes = {
  "start": (_) => rt(const StartPage(), "start"),
  "home": (_) => rt(const HomePage(), "home"),
  "login": (_) => rt(const LoginPage(), "login"),
  "search": (_) => rt(const SearchPage(), "search"),
  "create": (_) => rt(const CreatePage(), "create"),
  "user:show": (_) => rt(UserShowPage(args: getArguments(_)), "user:show"),
  "one": (_) => rt(OnePage(args: getArguments(_)), "one"),
};

getArguments(BuildContext _) {
  dynamic args = {};
  args = ModalRoute.of(_)!.settings.arguments as dynamic;
  args ??= {};
  return args;
}
