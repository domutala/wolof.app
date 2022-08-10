import 'package:flutter/material.dart';

showModalBottom({
  required BuildContext context,
  required Widget child,
  double marginTop = 0,
  bool enableDrag = true,
  AnimationController? animationController,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    enableDrag: enableDrag,
    barrierColor: Theme.of(context).primaryColorDark.withOpacity(.2),
    backgroundColor: Theme.of(context).primaryColorLight,
    transitionAnimationController: animationController,
    elevation: 50,
    builder: (context) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - marginTop,
        ),
        width: double.infinity,
        color: Theme.of(context).primaryColorLight,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child,
        ),
      );
    },
  );
}
