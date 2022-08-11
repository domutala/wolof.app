import 'package:flutter/material.dart';
import 'package:wolofbat/models/mean.dart';
import 'package:wolofbat/service/word.dart';
import 'package:wolofbat/widgets/loader.dart';

class WordMeanListOne extends StatefulWidget {
  final int? index;
  final String id;

  const WordMeanListOne({
    Key? key,
    this.index,
    required this.id,
  }) : super(key: key);

  @override
  State<WordMeanListOne> createState() => _WordMeanListOneState();
}

class _WordMeanListOneState extends State<WordMeanListOne> {
  MWordMean? _mean;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() => _loading = true);
    var mean = await meanGet(widget.id);
    setState(() => _loading = false);

    if (mean == null) return;
    setState(() => _mean = mean);
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
          child: Text(_mean!.params.value),
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
          : _mean != null
              ? body
              : null,
    );
  }
}
