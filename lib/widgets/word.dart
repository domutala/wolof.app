import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/widgets/loader.dart';

class WordListOne extends StatefulWidget {
  final String id;
  const WordListOne({Key? key, required this.id}) : super(key: key);

  @override
  State<WordListOne> createState() => _WordListOneState();
}

class _WordListOneState extends State<WordListOne> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _loading = true;
    await Future.delayed(const Duration(seconds: 5));

    _loading = false;
    setState(() {});
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
            children: const [
              SizedBox(width: 150, height: 20, child: Loader()),
              SizedBox(height: 2),
              SizedBox(width: 270, height: 10, child: Loader()),
              SizedBox(height: 2),
              SizedBox(width: 200, height: 10, child: Loader()),
            ],
          ),
        ),
      ],
    );
  }

  Widget get body {
    return Row(
      children: [
        Expanded(
          child: Button(
            radius: 'square',
            theme: 'light',
            onPressed: () {},
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
                          'Select',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        RichText(
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
