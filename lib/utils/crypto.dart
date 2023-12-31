import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:path/path.dart';
import 'package:hex/hex.dart';

const String iv = '9b03b05cdd49a972ba82f4c3a92cbb08';
const String key = //
    '13c648fb7341ad3af0ca55952b7405d8'
    '284a3113530de28bded96798bc6ad15d';

class Crypto {
  final IV _iv = IV(Uint8List.fromList(HEX.decode(iv)));
  final Key _key = Key(Uint8List.fromList(HEX.decode(key)));
  late Encrypter _encrypter;

  Crypto() {
    _initialize();
  }

  Future<void> _initialize() async {
    _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
  }

  Encrypted encryptPlainText(String input) {
    return _encrypter.encrypt(input, iv: _iv);
  }

  String decryptPlainText(Encrypted encrypted) {
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  Future<Encrypted> encryptBytes(
    File file, [
    bool shouldSave = true,
    String? outputPath,
    String? outputName,
  ]) async {
    final Uint8List input = await file.readAsBytes();
    final Encrypted encrypted = _encrypter.encryptBytes(input, iv: _iv);

    if (shouldSave) {
      final filePath = outputPath ?? Directory(file.path).parent.path;
      final filename = outputName ?? basename(file.path).split('.').first;
      final outputFilePath = '$filePath/$filename.aes';
      await File(outputFilePath).writeAsBytes(encrypted.bytes);
    }
    return encrypted;
  }

  List<int> decryptBytes(Uint8List buffer) {
    return _encrypter.decryptBytes(Encrypted(buffer), iv: _iv);
  }
}
