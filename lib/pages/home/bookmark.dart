import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/widgets/loader.dart';
import 'package:wolofbat/widgets/word.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({
    Key? key,
  }) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark>
    with AutomaticKeepAliveClientMixin<Bookmark> {
  List<String> _ids = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    load();
  }

  load() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _ids = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12'
      ];
      _loading = false;
    });
  }

  Widget get empty {
    return Column(
      children: [
        const SizedBox(height: 150),
        SvgPicture.asset(
          'assets/svgs/bookmark.svg',
          width: 72,
          color: Theme.of(context).primaryColorDark.withOpacity(.1),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 130,
          child: Text(
            "Vous n'avez enregistrer aucun mot !",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Widget get list {
    return Column(
      children: [
        for (var id in _ids) WordListOne(id: id.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          child: _loading
              ? const SizedBox(
                  height: 3,
                  child: Loader(),
                )
              : null,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await load();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: _ids.isEmpty ? empty : list,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
