import 'package:wolofbat/models/mean.dart';
import 'package:wolofbat/models/value.dart';
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

Future<List<String>?> valueList(dynamic params) async {
  var res = await Server.req(path: '/word/value/list', query: params);
  if (res == null) return null;

  var ids = (res as List).map((e) => e.toString()).toList();
  return ids;
}

Future<MWordValue?> valueGet(String id) async {
  var res = await Server.req(path: '/word/value/get', query: {'id': id});
  if (res == null) return null;

  var value = saveValueInStore(res);
  return value;
}

Future<MWordValue?> valueAdd({
  required String value,
  required String word,
}) async {
  var res = await Server.req(
    path: '/word/value/add',
    body: {'value': value, 'word': word},
  );
  if (res == null) return null;

  MWordValue val = await saveValueInStore(res);
  return val;
}

Future<MWordValue> saveValueInStore(res) async {
  var value = MWordValue.fromJson(res);
  await Store.save(key: value.id, value: value.toJson(), folder: 'words');
  return value;
}

/// mean

Future<List<String>?> meanList(dynamic params) async {
  var res = await Server.req(path: '/word/mean/list', query: params);
  if (res == null) return null;

  var ids = (res as List).map((e) => e.toString()).toList();
  return ids;
}

Future<MWordMean?> meanGet(String id) async {
  var res = await Server.req(path: '/word/mean/get', query: {'id': id});
  if (res == null) return null;

  var mean = saveMeanInStore(res);
  return mean;
}

Future<MWordMean?> meanAdd({
  required String value,
  required String word,
}) async {
  var res = await Server.req(
    path: '/word/mean/add',
    body: {'value': value, 'word': word},
  );
  if (res == null) return null;

  MWordMean mean = await saveMeanInStore(res);
  return mean;
}

Future<MWordMean> saveMeanInStore(res) async {
  var mean = MWordMean.fromJson(res);
  await Store.save(key: mean.id, value: mean.toJson(), folder: 'words');
  return mean;
}
