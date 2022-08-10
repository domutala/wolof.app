import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/server/index.dart';
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

  return res;
}
