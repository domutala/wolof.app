import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/widgets/loading.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool _saving = false;

  save() async {
    FocusScope.of(context).unfocus();

    setState(() => _saving = true);
    await Future.delayed(const Duration(seconds: 3));

    setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(height: statusBarHeight.value),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/plus.svg',
                                  color: Theme.of(context).primaryColor,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                const Text('Ajouter un nouveau mot'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              autofocus: true,
                              decoration: const InputDecoration(),
                              onSubmitted: (text) {
                                save();
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: Button(
                    onPressed: save,
                    radius: "round",
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.save_alt),
                        const SizedBox(width: 8),
                        Text(
                          'Enregistrer',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 9, color: lightColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Container(child: _saving ? const Loading() : null),
          )
        ],
      ),
    );
  }
}
