import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/pages/home/add.dart';
import 'package:wolofbat/pages/home/bookmark.dart';
import 'package:wolofbat/pages/home/explorer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int side = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() => setState(() {}));
  }

  Widget get navs {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).primaryColorDark.withOpacity(.1),
          ),
        ),
      ),
      child: Row(
        children: [
          NavItem(
            iconPath: 'assets/svgs/list.svg',
            text: 'Explorer',
            active: _tabController.index == 0,
            onPressed: () {
              _tabController.animateTo(0);
            },
          ),
          NavItem(
            iconPath: 'assets/svgs/pen.svg',
            text: 'Modification',
            active: _tabController.index == 1,
            onPressed: () {
              _tabController.animateTo(1);
            },
          ),
          NavItem(
            iconPath: 'assets/svgs/bookmark.svg',
            text: 'Enregistré',
            active: _tabController.index == 2,
            onPressed: () {
              _tabController.animateTo(2);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [
            Explorer(),
            Add(),
            Bookmark(),
          ],
        ),
        bottomNavigationBar: navs,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _tabController
        //       .animateTo((_tabController.index + 1) % 2), // Switch tabs
        //   child: Icon(Icons.swap_horiz),
        // ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final void Function()? onPressed;
  final String iconPath;
  final String text;
  final bool active;
  const NavItem({
    Key? key,
    required this.iconPath,
    this.onPressed,
    this.text = '',
    this.active = false,
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
                color: active
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorDark,
                width: 24,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 9,
                      color: active
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorDark,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
