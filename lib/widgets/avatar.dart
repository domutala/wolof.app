import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/image.dart';
import 'package:wolofbat/models/user.dart';

class Avatar extends StatefulWidget {
  final double size;
  final MUser? user;
  const Avatar({
    Key? key,
    this.size = 42,
    this.user,
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  void initState() {
    super.initState();
  }

  init() {}

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
                color: Theme.of(context).primaryColorDark.withOpacity(.05),
                width: widget.size,
                height: widget.size,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svgs/avatar.svg',
                  width: widget.size * .6,
                  color: Theme.of(context).primaryColorDark.withOpacity(.1),
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
