import 'package:wolofbat/models/word.dart';
import 'package:wolofbat/server/index.dart';
import 'package:wolofbat/utils/store.dart';

Future<MWord?> add(String value) async {
  var res = await Server.req(path: '/word/add', body: {'value': value});
  if (res == null) return null;

  MWord word = await saveWordInStore(res);
  return word;
}

Future<MWord?> get(String id) async {
  var res = await Server.req(path: '/word/get', query: {'id': id});
  if (res == null) return null;

  MWord word = await saveWordInStore(res);
  return word;
}

Future<List<String>?> filter(dynamic params) async {
  var res = await Server.req(path: '/word/filter', query: params);
  if (res == null) return null;

  var ids = (res as List).map((e) => e.toString()).toList();
  return ids;
}

Future<MWord> saveWordInStore(res) async {
  var word = MWord.fromJson(res);
  await Store.save(key: word.id, value: word.toJson(), folder: 'words');
  return word;
}
