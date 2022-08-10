import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/components/image.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/theme/color.dart';

class Avatar extends StatefulWidget {
  final double size;
  final MUser? user;
  final Color? color;
  const Avatar({
    Key? key,
    this.size = 42,
    this.user,
    this.color,
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Color _color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    setState(() {
      _color =
          widget.color ?? OneContext().theme.primaryColorDark.withOpacity(.1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              Container(
                color: _color,
                width: widget.size,
                height: widget.size,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svgs/avatar.svg',
                  width: widget.size * .6,
                  color: darken(_color, .1),
                ),
              ),
              Center(
                child: Container(
                  child:
                      widget.user != null && widget.user!.params.avatar != null
                          ? MyImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              token: widget.user!.params.avatar!,
                            )
                          : null,
                ),
              )
            ],
          )),
    );
  }
}
