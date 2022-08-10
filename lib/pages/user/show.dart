import 'package:flutter/material.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/service/user.dart' as service_user;
import 'package:wolofbat/theme/settings.dart';
import 'package:wolofbat/widgets/avatar.dart';
import 'package:wolofbat/widgets/loader.dart';

class UserShowPage extends StatefulWidget {
  final dynamic args;
  const UserShowPage({Key? key, this.args}) : super(key: key);

  @override
  State<UserShowPage> createState() => _UserShowPageState();
}

class _UserShowPageState extends State<UserShowPage> {
  MUser? _user;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    themeMode.addListener(updateState);

    if (widget.args == null) return;
    setState(() => _loading = true);

    _user = await service_user.get(widget.args['id']);
    _loading = false;

    setState(() {});
  }

  updateState() {
    setState(() {});
  }

  Widget get loader {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Loader(width: 96, height: 96, radius: 100),
          const SizedBox(height: 10),
          const Loader(width: 150, height: 20, radius: 10),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Loader(width: 50, height: 12, radius: 10),
                ),
            ],
          ),
          const SizedBox(height: 50),
          const Loader(width: 250, height: 15, radius: 10),
          const SizedBox(height: 10),
          const Loader(width: 300, height: 15, radius: 10),
          const SizedBox(height: 10),
          const Loader(width: 220, height: 15, radius: 10),
        ],
      ),
    );
  }

  Widget get avatar {
    return Avatar(size: 96, user: _user);
  }

  Widget get body {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      avatar,
                      const SizedBox(height: 10),
                      Text(
                        _user!.params.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: _loading
          ? loader
          : _user == null
              ? const Text('null')
              : body,
    );
  }

  @override
  void dispose() {
    super.dispose();
    themeMode.removeListener(updateState);
  }
}
