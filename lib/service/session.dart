import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_context/one_context.dart';
import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/server/index.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/utils/firebase.dart' as firebase;
import 'package:wolofbat/utils/store.dart';

Future<bool> init() async {
  final token = await Store.get('session.token');
  if (token != null) return true;

  var res = await Server.req(path: '/session/init');
  if (res == null) return false;

  await Store.save(key: 'session.token', value: res['token']);
  await Store.save(key: 'server.rsa.public.key', value: res['publicKey']);

  return true;
}

Future login({String credential = "google"}) async {
  var u = await Store.get('session.user');
  if (u != null) {
    mUser.value = MUser.fromJson(u);
    return u;
  }

  var uid = await firebase.init(credential: credential);
  if (uid == null) return;

  var res = await Server.req(path: '/session/login', body: {'token': uid});
  if (res == null) return null;

  await Store.save(key: 'session.user', value: res);
  mUser.value = MUser.fromJson(res);

  Fluttertoast.showToast(
    msg: 'Jall nga ci biir',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: successColor,
    textColor: lightColor,
  );

  return res;
}

Future logout({String credential = "google"}) async {
  OneContext().showOverlay(
    builder: (_) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: OneContext().theme.primaryColorLight.withOpacity(1),
            border: Border(
              top: BorderSide(
                color: OneContext().theme.primaryColorDark.withOpacity(.1),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "Ya ngi ci yoonu genn",
                  textAlign: TextAlign.center,
                  style: OneContext().textTheme.bodySmall,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
  var res = await Server.req(path: '/session/logout');
  OneContext().hideOverlay();

  if (res != true) return;

  await clearSessionInfos();
  await init();
  // OneContext().pushNamedAndRemoveUntil('start', (route) => false);
}

Future<void> clearSessionInfos() async {
  mUser.value = null;

  await Store.clear('session.user');
  await Store.clear('session.token');
}
