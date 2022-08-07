import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/theme/color.dart';

class Avatar extends StatelessWidget {
  final double size;
  const Avatar({
    Key? key,
    this.size = 42,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Button(
        padding: 0,
        radius: 'circle',
        theme: 'light',
        onPressed: () {
          Navigator.of(context).pushNamed('login');
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              children: [
                Container(
                  color: darken(Theme.of(context).primaryColorLight, .02),
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/svgs/avatar.svg',
                    width: size * .6,
                    color: darken(Theme.of(context).primaryColorLight, .08),
                  ),
                ),
                // const Positioned.fill(
                //   child: Image(
                //     image: AssetImage('assets/images/pict.jpg'),
                //     width: size,
                //     height: size,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}
