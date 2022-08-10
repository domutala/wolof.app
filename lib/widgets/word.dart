import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/word.dart';
import 'package:wolofbat/service/word.dart' as service_word;
import 'package:wolofbat/widgets/loader.dart';

class WordListOne extends StatefulWidget {
  final String id;
  const WordListOne({Key? key, required this.id}) : super(key: key);

  @override
  State<WordListOne> createState() => _WordListOneState();
}

class _WordListOneState extends State<WordListOne> {
  bool _loading = false;
  MWord? _word;

  @override
  void initState() {
    super.initState();
    init();
  }

  double size() {
    var max = MediaQuery.of(context).size.width - 60;
    return Random().nextDouble() * max;
  }

  init() async {
    setState(() => _loading = true);
    var word = await service_word.get(widget.id);
    setState(() => _loading = false);

    if (word == null) return;

    setState(() => _word = word);
  }

  Widget get loader {
    return Row(
      children: [
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Loader(width: 150, height: 15, radius: 5),
              const SizedBox(height: 2),
              Loader(width: size(), height: 7, radius: 5),
              const SizedBox(height: 2),
              Loader(width: size(), height: 7, radius: 5),
              const SizedBox(height: 2),
              Loader(width: size(), height: 7, radius: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget get body {
    if (_word == null) return Container();

    return Row(
      children: [
        Expanded(
          child: Button(
            radius: 'square',
            theme: 'light',
            onPressed: () {
              Navigator.of(context).pushNamed(
                'one',
                arguments: {'id': widget.id},
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _word!.params.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Container(
                          child: _word!.params.mean != null
                              ? RichText(
                                  overflow: TextOverflow.ellipsis,
                                  // strutStyle: StrutStyle(fontSize: 12.0),
                                  maxLines: 2,
                                  text: TextSpan(
                                    text:
                                        'Select other important details like Organization, your preferred Android Language and iOS Language as well. Then click on Finish to create new flutter project.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 11),
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? loader : body;
  }
}
