import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: statusBarHeight.value),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Baat',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Image(
                    image: AssetImage('assets/images/pict.jpg'),
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
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
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Rechercher un mot',
                            fillColor: darken(
                                Theme.of(context).primaryColorLight, .05),
                            enabledBorder: inputBorder.copyWith(
                              borderRadius: BorderRadius.circular(200),
                              borderSide: const BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).primaryColorDark.withOpacity(.1),
                ),
              ),
            ),
            child: Row(
              children: const [
                NavItem(
                  iconPath: 'assets/svgs/list.svg',
                  text: 'Explorer',
                ),
                NavItem(
                  iconPath: 'assets/svgs/pen.svg',
                  text: 'Modification',
                ),
                NavItem(
                  iconPath: 'assets/svgs/bookmark.svg',
                  text: 'Enregistré',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final void Function()? onPressed;
  final String iconPath;
  final String text;
  const NavItem({
    Key? key,
    required this.iconPath,
    this.onPressed,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: Button(
          onPressed: onPressed,
          radius: 'square',
          theme: 'light',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                color: Theme.of(context).primaryColorDark,
                width: 24,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
