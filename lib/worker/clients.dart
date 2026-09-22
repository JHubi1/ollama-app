import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ollama_dart/ollama_dart.dart' as llama;

import '../main.dart';

class OllamaHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

final httpClient = http.Client();

Map<String, String> getRequestHeaders() {
  final headers = (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
      .cast<String, String>();
  final apiToken = ollamaApiToken.trim();
  final hasAuthorizationHeader =
      headers.keys.any((key) => key.toLowerCase() == "authorization");
  if (apiToken.isNotEmpty && !hasAuthorizationHeader) {
    headers["Authorization"] = "Bearer " + apiToken;
  }
  return headers;
}

llama.OllamaClient get ollamaClient => llama.OllamaClient(
    headers: getRequestHeaders(),
    baseUrl: "$host/api",
    client: httpClient);
