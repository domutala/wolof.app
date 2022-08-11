import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_context/one_context.dart';
import 'package:uuid/uuid.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/theme/input.dart';
import 'package:wolofbat/widgets/word/list_one.dart';
import 'package:wolofbat/service/word.dart' as service_word;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with AutomaticKeepAliveClientMixin<Add> {
  Key _key = Key(const Uuid().v1());
  String _value = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mUser.addListener(updateState);
  }

  updateState() {
    setState(() {});
  }

  Widget get empty {
    return Column(
      children: [
        const SizedBox(height: 150),
        SvgPicture.asset(
          'assets/svgs/folder.svg',
          width: 92,
          color: Theme.of(context).primaryColorDark.withOpacity(.1),
        ),
        SizedBox(
          width: 120,
          child: Text(
            "Ba légi duggëlë go bénn baat !",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Widget get adder {
    return Positioned(
      bottom: 40,
      right: 30,
      child: SizedBox(
        width: 54,
        height: 54,
        child: Button(
          radius: 'circle',
          elevation: 10,
          onPressed: () {
            if (mUser.value == null) {
              OneContext().pushNamed('login');
            } else {
              OneContext().pushNamed('create');
            }
          },
          child: SvgPicture.asset(
            'assets/svgs/plus.svg',
            color: lightColor,
            width: 20,
          ),
        ),
      ),
    );
  }

  Widget get body {
    return Stack(
      children: [
        Column(
          children: [
            Container(height: statusBarHeight.value),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColorDark.withOpacity(.1),
                  ),
                ),
              ),
              height: 120,
              child: Center(
                child: Text(
                  "Baat yi ya leen dugël",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Column(
              children: [
                TextField(
                  textInputAction: TextInputAction.search,
                  // controller: _controler,
                  onChanged: (text) {
                    setState(() => _value = text);
                  },
                  // onSubmitted: (value) => filter(),
                  decoration: InputDecoration(
                    hintText: 'Bindël baat bi nga soxla...',
                    focusedBorder: inputBorder.copyWith(
                      borderSide: const BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: inputBorder.copyWith(
                      borderSide: const BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ),
                    prefixIcon: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/loupe.svg',
                            width: 20,
                            color: darken(
                              Theme.of(context).primaryColorLight,
                              .5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColorDark.withOpacity(.1),
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _key = Key(const Uuid().v1());
                  });
                },
                child: SingleChildScrollView(
                    key: _key,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: FutureBuilder<List<String>?>(
                      future: service_word.filter({
                        "user": mUser.value?.id,
                        "value": _value,
                      }),
                      builder: (ctx, list) {
                        if (list.connectionState == ConnectionState.waiting) {
                          return Column(
                            children: const [
                              SizedBox(height: 50),
                              CircularProgressIndicator(),
                            ],
                          );
                        }

                        if (list.hasData) {
                          if (list.data!.isEmpty) return empty;

                          return Column(
                            children: [
                              for (var id in list.data!)
                                WordListOne(id: id, key: Key(id)),
                            ],
                          );
                        }

                        return empty;
                      },
                    )),
              ),
            ),
          ],
        ),
        adder,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return mUser.value != null
        ? body
        : Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    width: 150,
                    child: Text(
                      'Duggël ngir nga mana yokk ay baat',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Button(
                    radius: 'circle',
                    elevation: 10,
                    onPressed: () {
                      OneContext().pushNamed('login');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/login.svg',
                          color: lightColor,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text('Dugg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    mUser.removeListener(updateState);
  }
}
