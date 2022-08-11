import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/mean.dart';
import 'package:wolofbat/service/word.dart';
import 'package:wolofbat/theme/index.dart';

class WordMeanAdd extends StatefulWidget {
  final void Function(MWordMean value)? onFinish;
  final String word;

  const WordMeanAdd({
    Key? key,
    required this.word,
    this.onFinish,
  }) : super(key: key);

  @override
  State<WordMeanAdd> createState() => _WordMeanAddState();
}

class _WordMeanAddState extends State<WordMeanAdd> {
  bool _saving = false;
  final TextEditingController _controler = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  save() async {
    if (_saving) return;
    if (_controler.text.isEmpty) return;

    setState(() => _saving = true);
    var value = await meanAdd(word: widget.word, value: _controler.text);
    setState(() => _saving = false);

    if (value == null) return;
    if (widget.onFinish != null) widget.onFinish!(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Tekki',
                  ),
                  onSubmitted: (text) {
                    save();
                  },
                  onChanged: (text) {
                    setState(() {});
                  },
                  controller: _controler,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Button(
                    onPressed: save,
                    child: const Text('Enregistrer'),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: SizedBox(
              child: _saving
                  ? Container(
                      color: Theme.of(context).primaryColorDark.withOpacity(.3),
                      child: Center(
                        child: CircularProgressIndicator(color: darkColor),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
