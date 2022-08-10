import 'package:crypton/crypton.dart';
import 'package:wolofbat/utils/store.dart';

const maxLength = 86;

Future<void> init() async {
  String? publicKey = await Store.get('rsa.public.key');
  String? privateKey = await Store.get('rsa.private.key');

  if (publicKey == null || privateKey == null) {
    RSAKeypair rsaKeypair = RSAKeypair.fromRandom();

    publicKey = rsaKeypair.publicKey.toPEM();
    await Store.save(key: 'rsa.public.key', value: publicKey);

    privateKey = rsaKeypair.privateKey.toPEM();
    await Store.save(key: 'rsa.private.key', value: privateKey);
  }
}

dynamic encrypt(String data, String key) {
  try {
    if (data.length > maxLength) {
      List<String> datas = [];

      for (var i = 0; i < data.length; i += maxLength) {
        var l = i + maxLength;
        if (l > data.length) l = data.length;

        final dt = data.substring(i, l);
        final enc = encrypt(dt, key);
        datas.add(enc);
      }

      return datas;
    }
    var k = RSAPublicKey.fromPEM(key);
    return k.encrypt(data);
  } catch (e) {
    rethrow;
  }
}

String decrypt(data, String key) {
  if (data is List) {
    var datas = "";

    for (var dt in data) {
      datas += decrypt(dt, key);
    }

    return datas;
  }

  var k = RSAPrivateKey.fromPEM(key);
  return k.decrypt(data);
}
