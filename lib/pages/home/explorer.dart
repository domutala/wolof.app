import 'package:flutter/material.dart';
import 'package:wolofbat/theme/input.dart';

class Explorer extends StatefulWidget {
  const Explorer({
    Key? key,
  }) : super(key: key);

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer>
    with AutomaticKeepAliveClientMixin<Explorer> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('search');
                  },
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Rechercher...',
                      fillColor:
                          Theme.of(context).primaryColorDark.withOpacity(.1),
                      disabledBorder: inputBorder.copyWith(
                        borderRadius: BorderRadius.circular(200),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
