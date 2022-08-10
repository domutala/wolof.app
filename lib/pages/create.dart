// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/main.dart';
import 'package:wolofbat/models/word.dart';
import 'package:wolofbat/service/word.dart' as service_word;
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/widgets/loading.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  MWord? _lastAdded;
  bool _saving = false;
  final TextEditingController _controler = TextEditingController();

  save() async {
    if (_controler.text.isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() => _saving = true);

    var word = await service_word.add(_controler.text);
    setState(() => _saving = false);

    if (word == null) return;

    Fluttertoast.showToast(
      msg: "'${word.params.value}' est ajouté avec succès.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: successColor,
      textColor: lightColor,
    );

    setState(() => _controler.text = "");

    await Future.delayed(const Duration(seconds: 3));
    setState(() => _lastAdded = word);
    await Future.delayed(const Duration(seconds: 5));
    setState(() => _lastAdded = null);
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
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(
                            //       'assets/svgs/plus.svg',
                            //       color: Theme.of(context).primaryColor,
                            //       width: 20,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     const Text('Ajouter un nouveau mot'),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            TextField(
                              autofocus: true,
                              decoration: const InputDecoration(
                                labelText: 'Ajouter un nouveau mot',
                              ),
                              onSubmitted: (text) {
                                save();
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                              controller: _controler,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              child: _controler.text.isNotEmpty
                                  ? Button(
                                      onPressed: save,
                                      child: Text(
                                        'Enregistrer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: _lastAdded != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 120,
                        child: Center(
                          child: Button(
                            radius: 'circle',
                            // onPressed: save,
                            child: Text(
                              "Ajouter un description à '${_lastAdded!.params.value}'",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      )
                    : null,
              )
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
