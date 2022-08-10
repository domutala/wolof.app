import 'package:flutter/material.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/service/user.dart';

class UserNameUpdate extends StatefulWidget {
  final void Function(MUser user)? onFinish;
  const UserNameUpdate({Key? key, this.onFinish}) : super(key: key);

  @override
  State<UserNameUpdate> createState() => _UserNameUpdateState();
}

class _UserNameUpdateState extends State<UserNameUpdate> {
  final TextEditingController _controler = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _controler.text = mUser.value!.params.name;
    setState(() {});
  }

  save() async {
    if (_controler.text.isEmpty) return;
    if (_controler.text == mUser.value!.params.name) return;

    setState(() => _loading = true);

    await updateName(_controler.text);

    setState(() => _loading = false);
  }

  Widget get body {
    return TextField(
      controller: _controler,
      decoration: InputDecoration(
        labelText: 'Saw tur',
        suffixIcon: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: _controler.text.isNotEmpty &&
                        _controler.text != mUser.value!.params.name
                    ? SizedBox(
                        height: 36,
                        child: Button(
                          theme: 'light',
                          padding: 0,
                          onPressed: () {},
                          child: Text(
                            'Enregistrer',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ), // Icon(Icons.save),
                        ),
                      )
                    : _loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : null,
              ),
            ],
          ),
        ),
      ),
      onSubmitted: (text) {
        save();
      },
      onChanged: (text) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
