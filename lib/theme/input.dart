import 'package:flutter/material.dart';
import 'package:wolofbat/theme/index.dart';

var inputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: darkColor.withOpacity(.1), width: 3),
  borderRadius: BorderRadius.circular(10),
);

var inputBorderDark = OutlineInputBorder(
  borderSide: BorderSide(color: lightColor.withOpacity(.1), width: 3),
  borderRadius: BorderRadius.circular(10),
);

var inputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(color: darkColor.withOpacity(.5)),
  labelStyle: TextStyle(color: darkColor.withOpacity(.5)),
  floatingLabelStyle: TextStyle(color: darkColor),
  errorStyle: TextStyle(color: dangerColor),
  border: inputBorder,
  enabledBorder: inputBorder,
  disabledBorder: inputBorder.copyWith(
    borderSide: BorderSide(
      color: darkColor.withOpacity(.05),
      width: 3,
    ),
  ),
  errorBorder: inputBorder.copyWith(
    borderSide: BorderSide(color: dangerColor, width: 3),
  ),
  focusedErrorBorder: inputBorder.copyWith(
    borderSide: BorderSide(color: dangerColor, width: 3),
  ),
  focusedBorder: inputBorder.copyWith(
    borderSide: BorderSide(color: darkColor.withOpacity(.5), width: 3),
  ),
  filled: false,
  fillColor: lightColor,
);

var inputDecorationThemeDark = inputDecorationTheme.copyWith(
  hintStyle: TextStyle(color: lightColor.withOpacity(.5)),
  labelStyle: TextStyle(color: lightColor.withOpacity(.5)),
  floatingLabelStyle: TextStyle(color: lightColor),
  border: inputBorderDark,
  enabledBorder: inputBorderDark,
  disabledBorder: inputBorderDark.copyWith(
    borderSide: BorderSide(color: lightColor.withOpacity(.05), width: 3),
  ),
  errorBorder: inputBorderDark.copyWith(
    borderSide: BorderSide(color: dangerColor, width: 3),
  ),
  focusedErrorBorder: inputBorderDark.copyWith(
    borderSide: BorderSide(color: dangerColor, width: 3),
  ),
  focusedBorder: inputBorderDark.copyWith(
    borderSide: BorderSide(color: lightColor.withOpacity(.5), width: 3),
  ),
  fillColor: darkColor,
);
