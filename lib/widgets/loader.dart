import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:wolofbat/theme/color.dart';

class Loader extends StatefulWidget {
  final Color? color;
  final double? width;
  final double? height;
  final double radius;

  const Loader({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.radius = 0,
  }) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  Color _color = Colors.transparent;
  var key = GlobalKey();
  double width = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(const Duration(microseconds: 100));
    width = key.currentContext!.size!.width;

    // ignore: use_build_context_synchronously
    _color = widget.color ?? Theme.of(context).primaryColorDark.withOpacity(.1);

    setState(() {});
    // anime();
  }

  anime() async {
    await Future.delayed(const Duration(milliseconds: 100));
    anime();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(
        key: key,
        color: _color,
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _color.withOpacity(0),
                    darken(_color, .5),
                    _color.withOpacity(0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double randomLoaderSize() {
  var max = OneContext().mediaQuery.size.width - 60;
  var w = 120 + Random().nextDouble() * max;
  w = max < w ? max - (Random().nextDouble() * 80) : w;
  return w;
}
