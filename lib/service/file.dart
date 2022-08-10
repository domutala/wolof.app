import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mime/mime.dart';
import 'package:wolofbat/server/index.dart';

Future<String?> askToAdd() async {
  var res = await Server.req(path: '/file/add');
  if (res is String) return res;
  return null;
}

Future getData(String id) async {
  var res = await Server.req(path: '/file/data', query: {'id': id});
  return res;
}

Future<String?> add(File file) async {
  var token = await askToAdd();
  if (token == null) return null;

  String fileName = file.path.split('/').last;
  final mimeType = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]);

  if (mimeType == null) return null;

  dio.FormData formData = dio.FormData.fromMap({
    "files": await dio.MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
    ),
  });

  dio.Dio client = dio.Dio();
  client.options.baseUrl = Server.root;
  client.options.headers = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
  };

  try {
    var response = await client.post(
      "/servile/add",
      queryParameters: {'token': token},
      data: formData,
    );

    if (response.data is Map<String, dynamic>) {
      if (response.data['error'] == true) {
        throw (response.data['name']);
      }
    }

    return response.data;
  } catch (e) {
    Server.showError(e);
    return null;
  }
}
