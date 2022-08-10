import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/service/session.dart' as session_service;
import 'package:wolofbat/theme/settings.dart';
import 'package:wolofbat/widgets/avatar.dart';
import 'package:wolofbat/widgets/avatar_update.dart';
import 'package:wolofbat/widgets/login.dart';
import 'package:wolofbat/widgets/modal_bottom.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with AutomaticKeepAliveClientMixin<Settings> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mUser.addListener(updateState);
    themeMode.addListener(updateState);
  }

  updateState() {
    setState(() {});
  }

  updateAvatar() async {
    showModalBottom(
      child: AvatarUpdate(onFinish: (user) {
        OneContext().pop('success');
      }),
    );
  }

  Widget get profile {
    return SizedBox(
      width: double.infinity,
      child: Button(
        radius: 'square',
        theme: 'light',
        padding: 20,
        onPressed: () {
          if (mUser.value == null) {
            openLoginInModal();
          } else {
            OneContext()
                .pushNamed('user:show', arguments: {'id': mUser.value!.id});
          }
        },
        child: Row(
          children: [
            Avatar(size: 48, user: mUser.value),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mUser.value != null ? mUser.value!.params.name : 'Duggoo de',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(height: 1),
                ),
                Text(
                  mUser.value != null
                      ? 'Consulter votre profil'
                      : 'Koccal fi ngir dugg',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get logout {
    return Container(
      child: mUser.value != null
          ? SizedBox(
              width: double.infinity,
              child: Button(
                radius: 'square',
                theme: 'light',
                padding: 20,
                onPressed: () {
                  session_service.logout();
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: SvgPicture.asset(
                        'assets/svgs/logout.svg',
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Génn",
                      overflow: TextOverflow.ellipsis,
                      // style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget get edit {
    return Container(
      child: mUser.value != null
          ? SizedBox(
              width: double.infinity,
              child: Button(
                radius: 'square',
                theme: 'light',
                padding: 20,
                onPressed: () {
                  OneContext().pushNamed('user:update');
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: SvgPicture.asset(
                        'assets/svgs/pen.svg',
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Soppi",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget get body {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                profile,
                edit,
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    radius: 'square',
                    theme: 'light',
                    padding: 20,
                    onPressed: ThemeSettings.toggle,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: SvgPicture.asset(
                            'assets/svgs/${themeMode.value == 'light' ? 'sun' : themeMode.value == 'dark' ? 'moon' : 'laptop'}.svg',
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Theme",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              themeMode.value == 'dark'
                                  ? "Lëndëm"
                                  : themeMode.value == 'light'
                                      ? "Leer"
                                      : "Dëppo ak jumtukaay gi",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                logout,
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return body;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    mUser.removeListener(updateState);
    themeMode.removeListener(updateState);
  }
}
