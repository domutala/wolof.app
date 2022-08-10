import 'package:wolofbat/models/user.dart';
import 'package:wolofbat/server/index.dart';
import 'package:wolofbat/utils/store.dart';

Future<MUser?> get(String id) async {
  var res = await Server.req(path: '/user/get', query: {'id': id});
  if (res == null) return null;

  return MUser.fromJson(res);
}

Future<MUser?> updateAvatar(String file) async {
  var res = await Server.req(
    path: '/user/update/avatar',
    body: {'file': file},
  );
  if (res == null) return null;

  var user = MUser.fromJson(res);

  if (mUser.value != null && mUser.value!.id == user.id) {
    await Store.save(key: 'session.user', value: res);
    mUser.value = user;
  }

  return user;
}
