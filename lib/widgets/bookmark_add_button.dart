import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/models/word.dart';

class BookmarkAddButton extends StatefulWidget {
  final MWord word;
  const BookmarkAddButton({Key? key, required this.word}) : super(key: key);

  @override
  State<BookmarkAddButton> createState() => _BookmarkAddButtonState();
}

class _BookmarkAddButtonState extends State<BookmarkAddButton> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    mBookmark.addListener(() {
      setState(() {});
    });
  }

  bool get isInBookmark {
    return mBookmark.value.contains(widget.word.id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: TextButton(
        onPressed: () {
          mBookmark.toggle(widget.word.id);
        },
        style: Theme.of(context).textButtonTheme.style!.copyWith(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
        child: SvgPicture.asset(
          'assets/svgs/bookmark.svg',
          color: isInBookmark
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColorDark.withOpacity(.1),
          width: 26,
        ),
      ),
    );
  }
}
