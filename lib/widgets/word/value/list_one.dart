import 'package:flutter/material.dart';
import 'package:wolofbat/models/value.dart';
import 'package:wolofbat/service/word.dart';
import 'package:wolofbat/widgets/loader.dart';

class WordValueListOne extends StatefulWidget {
  final int? index;
  final String id;

  const WordValueListOne({
    Key? key,
    this.index,
    required this.id,
  }) : super(key: key);

  @override
  State<WordValueListOne> createState() => _WordValueListOneState();
}

class _WordValueListOneState extends State<WordValueListOne> {
  MWordValue? _value;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() => _loading = true);
    var value = await valueGet(widget.id);
    setState(() => _loading = false);

    if (value == null) return;
    setState(() => _value = value);
  }

  Widget get body {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: widget.index != null
              ? Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text('${widget.index! + 1}.'))
              : null,
        ),
        Expanded(
          child: Text(_value!.params.value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: _loading
          ? Loader(width: randomLoaderSize(), height: 10, radius: 5)
          : _value != null
              ? body
              : null,
    );
  }
}
