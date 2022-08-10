import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/service/word.dart' as service_word;
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/input.dart';
import 'package:wolofbat/widgets/word.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _mark = 0;
  bool _searching = false;
  List<String> _ids = [];
  final TextEditingController _controler = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  init() {}

  filter() async {
    var mymark = _mark + 1;
    setState(() => _mark = mymark);

    if (_controler.text.isEmpty) {
      setState(() => _searching = false);
      setState(() => _ids = []);
      return;
    }

    setState(() => _searching = true);

    var ids = await service_word.filter({'value': _controler.text});
    if (_mark != mymark) return;

    setState(() => _ids = ids ?? []);
    setState(() => _searching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: statusBarHeight.value),
          Column(
            children: [
              TextField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                controller: _controler,
                onChanged: (text) {
                  setState(() {});
                  filter();
                },
                onSubmitted: (value) => filter(),
                decoration: InputDecoration(
                  hintText: 'Bindël baat bi nga soxla...',
                  focusedBorder: inputBorder.copyWith(
                    borderSide: const BorderSide(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: inputBorder.copyWith(
                    borderSide: const BorderSide(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  ),
                  prefixIcon: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/loupe.svg',
                          width: 20,
                          color: darken(
                            Theme.of(context).primaryColorLight,
                            .5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: SizedBox(
                    child: _searching
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(1),
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),
              Container(
                color: darken(Theme.of(context).primaryColorLight, .05),
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  children: [
                    for (var id in _ids) WordListOne(id: id, key: Key(id)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
