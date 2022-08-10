import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/widgets/loader.dart';
import 'package:wolofbat/widgets/word.dart';
import 'package:wolofbat/widgets/word_search_list.dart';
import 'package:wolofbat/service/word.dart' as service_word;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with AutomaticKeepAliveClientMixin<Add> {
  bool _loading = false;
  int _length = 0;
  Key _key = Key(const Uuid().v1());

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

  Widget get list {
    return WordSearchList(
      key: _key,
      params: {'user': mUser.value?.id},
      onSearchFinish: (ids) {
        setState(() => _length = ids.length);
      },
      // onLoading: ((loading) => setState(() => _loading = loading)),
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
            Navigator.of(context).pushNamed('create');
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        Column(
          children: [
            Container(height: statusBarHeight.value),
            Container(
              child: _loading
                  ? const Loader(width: double.infinity, height: 5)
                  : null,
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
                      future: service_word.filter({"user": mUser.value?.id}),
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
                    )
                    //
                    // Column(
                    //     // children: [empty, list],
                    //     ),
                    ),
              ),
            ),
          ],
        ),
        adder,
      ],
    );
  }

  Widget build2(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        Column(
          children: [
            Container(height: statusBarHeight.value),
            Container(
              child: _loading
                  ? const Loader(width: double.infinity, height: 5)
                  : null,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _key = Key(const Uuid().v1());
                  });
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [empty, list],
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
