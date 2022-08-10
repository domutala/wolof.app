import 'package:flutter/material.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/word.dart';
import 'package:wolofbat/service/word.dart' as service_word;
import 'package:wolofbat/widgets/bookmark_add_button.dart';
import 'package:wolofbat/widgets/loading.dart';

class OnePage extends StatefulWidget {
  final dynamic args;
  const OnePage({Key? key, this.args}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  MWord? _word;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    load();
  }

  load() async {
    setState(() => _loading = true);
    var word = await service_word.get(widget.args['id']);
    setState(() => _loading = false);

    if (word == null) return;

    setState(() => _word = word);
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
                    _word!.params.value,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                BookmarkAddButton(word: _word!)
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
                children: const [],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get content {
    return Column(children: [
      header,
      body,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Loading()
          : _word == null
              ? Container()
              : content,
    );
  }
}
