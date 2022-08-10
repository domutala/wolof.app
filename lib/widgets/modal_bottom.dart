import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/index.dart';

showModalBottom({
  required Widget child,
  double marginTop = 0,
  bool enableDrag = true,
  AnimationController? animationController,
}) {
  var isDarkMode = OneContext().oneTheme.isDark;

  OneContext().showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: enableDrag,
    barrierColor:
        isDarkMode ? lightColor.withOpacity(.07) : darkColor.withOpacity(.3),
    backgroundColor: OneContext().theme.primaryColorLight,
    transitionAnimationController: animationController,
    elevation: 0,
    builder: (context) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: OneContext().mediaQuery.size.height - marginTop,
        ),
        decoration: BoxDecoration(
          color: OneContext().theme.primaryColorLight,
          boxShadow: [
            BoxShadow(
              color: darken(darkColor, .25).withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 3),
            )
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: OneContext().mediaQuery.viewInsets,
          child: child,
        ),
      );
    },
  );
}
