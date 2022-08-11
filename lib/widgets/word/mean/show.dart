import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/models/word.dart';
import 'package:wolofbat/service/word.dart';
import 'package:wolofbat/widgets/modal_bottom.dart';
import 'package:wolofbat/widgets/word/mean/add.dart';
import 'package:wolofbat/widgets/word/mean/list_one.dart';

class WordMeanShow extends StatefulWidget {
  final MWord word;
  const WordMeanShow({Key? key, required this.word}) : super(key: key);

  @override
  State<WordMeanShow> createState() => _WordMeanShowState();
}

class _WordMeanShowState extends State<WordMeanShow> {
  List<String> _ids = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() => _loading = true);
    var ids = await meanList({"word": widget.word.id});
    setState(() => _loading = false);

    if (ids == null) return;
    setState(() => _ids = ids);
  }

  add() async {
    showModalBottom(
      child: WordMeanAdd(
        word: widget.word.id,
        onFinish: (value) {
          OneContext().popDialog('success');
          setState(() => _ids.add(value.id));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColorDark.withOpacity(.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Mbindin',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  child: mUser.value != null
                      ? SizedBox(
                          width: 32,
                          height: 32,
                          child: Button(
                            theme: 'light',
                            radius: 'circle',
                            padding: 0,
                            onPressed: add,
                            child: const Icon(Icons.add_rounded),
                          ),
                        )
                      : _loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 1),
                            )
                          : null,
                ),
              ],
            ),
          ),
          for (var i = 0; i < _ids.length; i++)
            WordMeanListOne(index: _ids.length == 1 ? null : i, id: _ids[i]),
        ],
      ),
    );
  }
}
