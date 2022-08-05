import 'dart:math';
import 'package:flutter/material.dart';

Color randomColor({double alpha = 1}) {
  var r = Random().nextInt(250);
  var g = Random().nextInt(250);
  var b = Random().nextInt(250);

  return Color.fromRGBO(r, g, b, alpha);
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
