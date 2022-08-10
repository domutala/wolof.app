import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/word.dart';
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
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mBookmark.addListener(updateState);
  }

  updateState() {
    setState(() {});
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
        for (var id in mBookmark.value) WordListOne(id: id, key: Key(id)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(height: statusBarHeight.value),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: mBookmark.value.isEmpty ? empty : list,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    mBookmark.removeListener(updateState);
  }
}
