import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:wolofbat/theme/color.dart';

class Loader extends StatefulWidget {
  final Color? color;
  final double radius;

  const Loader({Key? key, this.radius = 10, this.color}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  Color _color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(const Duration(microseconds: 100));

    // ignore: use_build_context_synchronously
    _color = widget.color ?? Theme.of(context).primaryColor.withOpacity(.15);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(widget.radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            darken(_color, .0),
            darken(_color, .2),
          ],
        ),
      ),
    );
  }

  // Widget build0(BuildContext context) {
  //   return Shimmer.fromColors(
  //     baseColor: Theme.of(context).primaryColor, //darken(_color, .02),
  //     highlightColor: Theme.of(context).primaryColor, // darken(_color, .15),
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         color: _color,
  //         borderRadius: BorderRadius.circular(widget.radius),
  //       ),
  //     ),
  //   );
  // }
}
