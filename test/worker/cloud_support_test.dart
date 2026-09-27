import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ollama_app/main.dart' as app;
import 'package:ollama_app/worker/clients.dart';
import 'package:ollama_app/worker/sender.dart';
import 'package:ollama_app/worker/secure_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("getRequestHeaders", () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      app.prefs = await SharedPreferences.getInstance();
      app.ollamaApiToken = "";
    });

    test("returns host headers when token is empty", () async {
      await app.prefs!.setString("hostHeaders", '{"X-Test":"1"}');

      final headers = getRequestHeaders();

      expect(headers["X-Test"], "1");
      expect(headers.containsKey("Authorization"), false);
    });

    test("adds bearer token when token exists and no authorization header", () {
      app.ollamaApiToken = "token-123";

      final headers = getRequestHeaders();

      expect(headers["Authorization"], "Bearer " + "token-123");
    });

    test("does not override explicit authorization header", () async {
      await app.prefs!
          .setString("hostHeaders", '{"authorization":"ApiKey existing"}');
      app.ollamaApiToken = "token-123";

      final headers = getRequestHeaders();

      expect(headers["authorization"], "ApiKey existing");
      expect(headers["Authorization"], isNull);
    });
  });

  group("secure token storage", () {
    const channel = MethodChannel("plugins.it_nomads.com/flutter_secure_storage");
    late Map<String, String> memory;

    Future<dynamic> mockHandler(MethodCall call) async {
      final args = (call.arguments as Map?)?.cast<String, dynamic>() ?? {};
      final key = args["key"] as String?;
      switch (call.method) {
        case "read":
          if (key == null) return null;
          return memory[key];
        case "write":
          if (key != null) {
            memory[key] = (args["value"] as String?) ?? "";
          }
          return null;
        case "delete":
          if (key != null) {
            memory.remove(key);
          }
          return null;
      }
      return null;
    }

    setUp(() {
      memory = {};
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, mockHandler);
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test("write trims and read returns trimmed token", () async {
      await writeOllamaApiTokenSecure("  cloud-token  ");

      final token = await readOllamaApiTokenSecure();

      expect(token, "cloud-token");
    });

    test("write empty token deletes existing token", () async {
      await writeOllamaApiTokenSecure("cloud-token");
      await writeOllamaApiTokenSecure("   ");

      final token = await readOllamaApiTokenSecure();

      expect(token, "");
    });
  });

  group("classifyChatError", () {
    DioException dioError(int? statusCode) {
      final options = RequestOptions(path: "/api/chat");
      return DioException(
          requestOptions: options,
          response: (statusCode == null)
              ? null
              : Response(requestOptions: options, statusCode: statusCode));
    }

    test("maps 401/403 responses to auth", () {
      expect(classifyChatError(dioError(401)), "auth");
      expect(classifyChatError(dioError(403)), "auth");
    });

    test("maps 429 responses to ratelimit", () {
      expect(classifyChatError(dioError(429)), "ratelimit");
    });

    test("maps other status codes and unknown errors to timeout", () {
      expect(classifyChatError(dioError(404)), "timeout");
      expect(classifyChatError(dioError(500)), "timeout");
      expect(classifyChatError(dioError(null)), "timeout");
      expect(classifyChatError(Exception("connection refused")), "timeout");
    });

    test("detects auth errors from error text when no typed response", () {
      expect(
          classifyChatError(
              Exception("DioException: invalid status code of 401")),
          "auth");
      expect(classifyChatError(Exception("Unauthorized")), "auth");
      expect(classifyChatError(Exception("Invalid API Key provided")), "auth");
    });
  });
}
