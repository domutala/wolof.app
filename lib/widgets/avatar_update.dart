import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/components/button.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/server/index.dart';
import 'package:wolofbat/theme/color.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/widgets/avatar.dart';
import 'package:wolofbat/utils/file.dart' as util_file;
import 'package:wolofbat/service/file.dart' as service_file;
import 'package:wolofbat/service/user.dart' as service_user;

class AvatarUpdate extends StatefulWidget {
  final void Function(MUser user)? onFinish;
  const AvatarUpdate({Key? key, this.onFinish}) : super(key: key);

  @override
  State<AvatarUpdate> createState() => _AvatarUpdateState();
}

class _AvatarUpdateState extends State<AvatarUpdate> {
  bool _is = false;
  bool _loading = false;
  File? _file;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    load();
  }

  load() async {
    if (mUser.value != null && mUser.value!.params.avatar != null) {
      setState(() => _loading = true);

      var token = mUser.value!.params.avatar;
      var url = '${Server.root}/servile/get?token=$token';
      _file = await DefaultCacheManager().getSingleFile(url);

      _loading = false;
      setState(() {});
      select();
    } else {
      select();
    }
  }

  select() async {
    var file = await util_file.select(type: FileType.image);
    if (file == null) return;

    _file = file;
    _is = true;
    setState(() {});
  }

  Widget get body {
    return SizedBox(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: select,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _file == null
                              ? const Avatar(size: 124)
                              : Image(
                                  width: 124,
                                  height: 124,
                                  image: FileImage(_file!),
                                  fit: BoxFit.cover,
                                ),
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
                              color: darken(
                                  Theme.of(context).primaryColorLight, .1),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/svgs/pen.svg',
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
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Button(
                    onPressed: () async {
                      if (_file == null) return;
                      if (!_is) return;

                      setState(() => _loading = true);
                      MUser? user;

                      try {
                        var fileId = await service_file.add(_file!);
                        if (fileId == null) return;

                        user = await service_user.updateAvatar(fileId);
                        setState(() {});
                      } finally {
                        setState(() => _loading = false);
                      }

                      if (user == null || widget.onFinish == null) {
                        return;
                      }

                      widget.onFinish!(user);
                    },
                    child: const Text('Enregistrer'),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: SizedBox(
              child: _loading
                  ? Container(
                      color: Theme.of(context).primaryColorDark.withOpacity(.3),
                      child: Center(
                        child: CircularProgressIndicator(color: darkColor),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
