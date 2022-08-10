import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/widgets/avatar.dart';
import 'package:wolofbat/widgets/avatar_update.dart';
import 'package:wolofbat/widgets/loader.dart';
import 'package:wolofbat/widgets/modal_bottom.dart';
import 'package:wolofbat/widgets/user_name_update.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({Key? key}) : super(key: key);

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mUser.addListener(updateState);
  }

  updateAvatar() async {
    showModalBottom(
      child: AvatarUpdate(onFinish: (user) {
        OneContext().popDialog('success');
      }),
    );
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
    return GestureDetector(
      onTap: updateAvatar,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Avatar(size: 92, user: mUser.value),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // ignore: use_build_context_synchronously
                color: darken(Theme.of(context).primaryColorLight, .1),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/photo.svg',
                  width: 18,
                  height: 18,
                  // ignore: use_build_context_synchronously
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get body {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    avatar,
                    const SizedBox(height: 20),
                    const UserNameUpdate(),
                  ],
                ),
              ),
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
      body: body,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mUser.removeListener(updateState);
  }
}
