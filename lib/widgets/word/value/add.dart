import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/value.dart';
import 'package:wolofbat/service/word.dart';
import 'package:wolofbat/theme/index.dart';

class WordValueAdd extends StatefulWidget {
  final void Function(MWordValue value)? onFinish;
  final String word;

  const WordValueAdd({
    Key? key,
    required this.word,
    this.onFinish,
  }) : super(key: key);

  @override
  State<WordValueAdd> createState() => _WordValueAddState();
}

class _WordValueAddState extends State<WordValueAdd> {
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
    var value = await valueAdd(word: widget.word, value: _controler.text);
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
                  decoration: const InputDecoration(
                    labelText: 'Mbindinu baat bi',
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
