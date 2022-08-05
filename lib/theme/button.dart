import 'package:flutter/material.dart';
import 'package:wolofbat/theme/index.dart';

var textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    alignment: Alignment.center,
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    overlayColor: MaterialStateProperty.all<Color>(
      darkColor.withOpacity(.1),
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
        };

        if (states.any(interactiveStates.contains)) {
          return lightColor;
        }

        return lightColor;
      },
    ),
    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
  ),
);
