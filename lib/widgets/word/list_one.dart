import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
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
              Loader(width: randomLoaderSize(), height: 7, radius: 5),
              const SizedBox(height: 2),
              Loader(width: randomLoaderSize(), height: 7, radius: 5),
              const SizedBox(height: 2),
              Loader(width: randomLoaderSize(), height: 7, radius: 5),
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
              OneContext().pushNamed('one', arguments: {'id': widget.id});
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
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: _word!.params.mean,
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
