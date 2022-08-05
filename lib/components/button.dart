import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  final String theme;
  final String? radius;
  final double elevation;
  final double? padding;
  const Button({
    Key? key,
    required this.child,
    this.onPressed,
    this.theme = 'primary',
    this.radius,
    this.elevation = 0,
    this.padding,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  ButtonStyle? get style {
    double radius = widget.radius == 'circle'
        ? 100
        : widget.radius == 'round'
            ? 30
            : widget.radius == 'square'
                ? 0
                : 5;

    var shape = MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    var style = Theme.of(context).textButtonTheme.style!.copyWith(
          shape: shape,
          elevation: MaterialStateProperty.all(widget.elevation),
          padding: widget.padding != null
              ? MaterialStateProperty.all(EdgeInsets.zero)
              : null,
        );

    if (widget.theme == 'dark') {
      style = style.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorDark,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorLight.withOpacity(.15),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorLight,
        ),
      );
    } else if (widget.theme == 'light') {
      style = style.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorLight,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorDark.withOpacity(.15),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColorDark,
        ),
      );
    }

    return style;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: style,
      child: widget.child,
    );
  }
}
