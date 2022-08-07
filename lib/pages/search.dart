import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/input.dart';
import 'package:wolofbat/widgets/word.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool searching = false;

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
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
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
                    child: searching
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
                    for (var i = 0; i < 5; i++) WordListOne(id: i.toString()),
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
