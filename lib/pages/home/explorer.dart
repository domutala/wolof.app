import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/theme/input.dart';
import 'package:wolofbat/widgets/avatar.dart';

class Explorer extends StatefulWidget {
  const Explorer({
    Key? key,
  }) : super(key: key);

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer>
    with AutomaticKeepAliveClientMixin<Explorer> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    mUser.addListener(onUser);
  }

  onUser() {
    setState(() {});
  }

  Widget get header {
    return Container(
      color: Theme.of(context).primaryColorDark.withOpacity(.05),
      child: Column(
        children: [
          Container(height: statusBarHeight.value),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Baatukay',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  width: 42,
                  height: 42,
                  child: Button(
                    padding: 0,
                    radius: 'circle',
                    theme: 'light',
                    onPressed: () {
                      if (mUser.value == null) {
                        Navigator.of(context).pushNamed('login');
                      } else {
                        Navigator.of(context).pushNamed('user:show',
                            arguments: {'id': mUser.value!.id});
                      }
                    },
                    child: Avatar(
                      size: 42,
                      user: mUser.value,
                      key: Key(mUser.value.toString()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get body {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('search');
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Seetal ci baatukay wi...',
                        fillColor:
                            Theme.of(context).primaryColorDark.withOpacity(.1),
                        disabledBorder: inputBorder.copyWith(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        header,
        body,
        SizedBox(
          height: 120,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Button(
                  theme: 'light',
                  child: Text('Baatu bës bi'),
                ),
                Button(
                  theme: 'light',
                  child: Text('Li gënë fës ci ay baat'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
