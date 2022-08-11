import 'package:flutter/material.dart';
import 'package:wolofbat/service/word.dart' as service_word;
import 'package:wolofbat/widgets/word/list_one.dart';

class WordSearchList extends StatefulWidget {
  final Function(bool loading)? onLoading;
  final Function(List<String> list)? onSearchFinish;
  final Map<String, dynamic> params;
  const WordSearchList({
    Key? key,
    this.params = const {},
    this.onSearchFinish,
    this.onLoading,
  }) : super(key: key);

  @override
  State<WordSearchList> createState() => _WordSearchListState();
}

class _WordSearchListState extends State<WordSearchList> {
  int _mark = 0;
  List<String> _ids = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    filter();
  }

  filter() async {
    var mymark = _mark + 1;
    setState(() => _mark = mymark);

    if (widget.params.isEmpty) {
      setState(() => _ids = []);

      if (widget.onLoading != null) widget.onLoading!(false);
      if (widget.onSearchFinish != null) widget.onSearchFinish!(_ids);

      return;
    }

    if (widget.onLoading != null) widget.onLoading!(true);

    var ids = await service_word.filter(widget.params);
    if (_mark != mymark) return;

    setState(() => _ids = ids ?? []);

    if (widget.onLoading != null) widget.onLoading!(false);
    if (widget.onSearchFinish != null) widget.onSearchFinish!(_ids);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var id in _ids) WordListOne(id: id, key: Key(id)),
      ],
    );
  }
}
