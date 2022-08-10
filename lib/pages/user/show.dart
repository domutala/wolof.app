import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/service/user.dart' as service_user;
import 'package:wolofbat/widgets/avatar.dart';
import 'package:wolofbat/widgets/avatar_update.dart';
import 'package:wolofbat/widgets/loader.dart';
import 'package:wolofbat/widgets/modal_bottom.dart';
import 'package:wolofbat/widgets/theme_button.dart';

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
    if (widget.args == null) return;
    setState(() => _loading = true);

    _user = await service_user.get(widget.args['id']);
    _loading = false;

    setState(() {});
  }

  updateAvatar() async {
    showModalBottom(
      context: context,
      child: AvatarUpdate(onFinish: (user) {
        Navigator.of(context).pop();
        _user = user;
        setState(() {});
      }),
    );
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
    return Button(
      padding: 0,
      radius: 'circle',
      theme: 'light',
      onPressed: updateAvatar,
      child: Avatar(size: 96, user: _user),
    );
  }

  Widget get body {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Center(
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
                  const SizedBox(height: 30),
                  const ThemeButton(),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 120,
          child: Center(
            child: Button(
              radius: 'circle',
              // onPressed: save,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/logout.svg',
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Génn",
                    overflow: TextOverflow.ellipsis,
                    // style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        )
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
}
