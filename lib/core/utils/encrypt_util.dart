import 'package:encrypt/encrypt.dart';

class EncryptUtil {
  final String _keyString = "&T<Afr`@l89+/2F(oASm!):%/Mb[}YW%";
  Key? _key;

  EncryptUtil() {
    _key = Key.fromUtf8(_keyString);
  }

  String encrypt(String data) {
    if (_key == null) {
      throw Exception('Encryption key is not initialized.');
    }
    final iv = IV.fromLength(16);
    final encrypted = Encrypter(AES(_key!,mode: AESMode.cbc));

    final dataBase64 = encrypted.encrypt(data, iv: iv).base64;
    final ivBase64 = iv.base64;
    return "$ivBase64:$dataBase64";
  }

  String decrypt(String data) {
    if (_key == null) {
      throw Exception('Encryption key is not initialized.');
    }
    final parts = data.split(':');
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);

    final encrypter = Encrypter(AES(_key!, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
