import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:wolofbat/theme/color.dart';

class Loader extends StatefulWidget {
  final Color? color;

  const Loader({Key? key, this.color}) : super(key: key);

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
    log(width.toString());
    anime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: _color,
      width: double.infinity,
      height: double.infinity,
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
    );
  }
}
