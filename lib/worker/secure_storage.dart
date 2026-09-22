import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _apiTokenKey = "ollamaApiToken";
const _secureStorage = FlutterSecureStorage();

Future<String> readOllamaApiTokenSecure() async {
  return (await _secureStorage.read(key: _apiTokenKey) ?? "").trim();
}

Future<void> writeOllamaApiTokenSecure(String token) async {
  final trimmed = token.trim();
  if (trimmed.isEmpty) {
    await _secureStorage.delete(key: _apiTokenKey);
    return;
  }
  await _secureStorage.write(key: _apiTokenKey, value: trimmed);
}
