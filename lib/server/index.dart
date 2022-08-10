import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wolofbat/theme/index.dart';
import 'package:wolofbat/utils/rsa.dart';
import 'package:wolofbat/utils/store.dart';

class Server {
  static String root = "http://192.168.169.215:7007";

  static dio.Dio get client {
    dio.Dio client = dio.Dio();
    client.options.baseUrl = root;
    client.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    client.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            String? serverPublicKey = await Store.get('server.rsa.public.key');

            final body = options.data;
            final params = options.queryParameters;
            Map<String, dynamic> headers = {};

            options.data = {};
            options.queryParameters = {};

            if (serverPublicKey != null) {
              headers['version'] = "0.0.0";
              headers['token'] = await Store.get('session.token');
              headers['publicKey'] = await Store.get('public.key');

              options.data['headers'] = encrypt(
                jsonEncode(headers),
                serverPublicKey,
              );

              options.data['body'] = await encrypt(
                jsonEncode(body),
                serverPublicKey,
              );

              options.data['params'] = await encrypt(
                jsonEncode(params),
                serverPublicKey,
              );
            }

            options.data['publicKey'] = await Store.get('rsa.public.key');

            return handler.next(options);
          } catch (e) {
            handler.reject(
              dio.DioError(requestOptions: options, error: 'appError'),
            );
          }
        },
        onResponse: (response, handler) async {
          if (response.data != null) {
            var dt = response.data;
            response.data = null;

            if (dt is String) {
              if (dt.split(";;").isNotEmpty) dt = dt.split(";;");
            }

            var body = decrypt(dt, await Store.get('rsa.private.key'));

            // ignore: unnecessary_null_comparison
            if (body != null && body.isNotEmpty) {
              final data = jsonDecode(body);
              response.data = data;
            }
          }

          return handler.next(response);
        },
        // onError: (DioError dioError) => errorInterceptor(dioError),
      ),
    );

    return client;
  }

  static Future<dynamic> req({
    required String path,
    String? root,
    Map<String, dynamic>? query,
    dynamic body,
  }) async {
    root ??= Server.root;

    try {
      dio.Response response;
      response = await client.post(
        path,
        queryParameters: query,
        data: body,
      );

      if (response.data is Map<String, dynamic>) {
        if (response.data['error'] == true) {
          throw (response.data['name']);
        }
      }

      return response.data;
    } catch (e) {
      showError(e);
      return null;
    }
  }

  static showError(response) async {
    var message = response.toString();

    // if (response is dio.DioError) {
    //   message = response.message;
    // }

    if (response is dio.DioError) {
      message = "Impossible d'accéder au serveur.";
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: dangerColor,
      textColor: darkColor,
    );
  }
}
