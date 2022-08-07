import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/widgets/loader.dart';

class Add extends StatefulWidget {
  const Add({
    Key? key,
  }) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with AutomaticKeepAliveClientMixin<Add> {
  Widget get empty {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/svgs/folder.svg',
          width: 92,
          color: Theme.of(context).primaryColorDark.withOpacity(.1),
        ),
        SizedBox(
          width: 120,
          child: Text(
            "Vous n'avez ajouté aucun mot !",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 3,
              child: Loader(),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        children: [
                          empty,
                          // Column(
                          //   children: [

                          //     // for (var i = 0; i < 30; i++)
                          //     //   const Text(
                          //     //       'Select other important details like Organization, your preferred Android Language and iOS Language as well. Then click on Finish to create new flutter project.'),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 40,
          right: 30,
          child: SizedBox(
            width: 54,
            height: 54,
            child: Button(
              radius: 'circle',
              elevation: 10,
              onPressed: () {
                Navigator.of(context).pushNamed('create');
              },
              child: SvgPicture.asset(
                'assets/svgs/plus.svg',
                color: lightColor,
                width: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
