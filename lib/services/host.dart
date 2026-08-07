import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ollama_dart/ollama_dart.dart' as ollama;

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import 'clients.dart' as clients;
import 'services.dart';

enum HostSettingError {
  invalidUrl,
  unreachable,
  undetectable,
  timeout,
  outdated,
  other;

  String title(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return appLocalizations.settingsHostInvalid(name);
  }

  String description(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return appLocalizations.settingsHostInvalidDetailed(name);
  }
}

typedef HostSettingErrorCallbackStore = ({
  Object exception,
  StackTrace stackTrace,
});

class HostManager extends ChangeNotifier {
  static final HostManager _instance = HostManager._();
  static HostManager get instance => _instance;

  bool _silentFlag = false;

  Uri? _host;
  Uri? get host => _host;
  set host(Uri? value) {
    assert(!useHost, "Host is fixed to $fixedHost and cannot be changed.");
    if (useHost) return;

    var uri = value;
    if (uri != null && uri.path.endsWith("/")) {
      uri = uri.replace(path: uri.path.substring(0, uri.path.length - 1));
    }

    if (uri == _host) return;
    _host = uri;
    Preferences.instance.host = uri;
    if (!_silentFlag) notifyListeners();
  }

  HostManager._()
    : _host = useHost ? Uri.parse(fixedHost) : Preferences.instance.host;

  Future<HostSettingError?> smartSetHost(
    BuildContext context,
    String value,
  ) async {
    assert(!useHost, "Host is fixed to $fixedHost and cannot be changed.");

    final uri = Uri.tryParse(value)?.normalizePath();
    if (uri == null || (uri.scheme != "http" && uri.scheme != "https")) {
      return HostSettingError.invalidUrl;
    }

    final oldHost = this.host;
    final host = uri.resolve("api/version");

    try {
      HostSettingErrorCallbackStore? error;
      final response = await errorGuard(
        context,
        "S4XS48Z9",
        () async => clients.httpClient
            .get(host, headers: Preferences.instance.hostHeaders)
            .timeout(
              TimeoutMultiplier.medium,
              onTimeout: () => throw HostSettingError.timeout,
            ),
        errorMessage: errorGuardErrorMessageWithFallback(
          (_) => "Failed to connect to host.",
        ),
        enableReporting: false,
        onError: (e, s) => error = (exception: e, stackTrace: s),
      );
      if (response == null) {
        Error.throwWithStackTrace(error!.exception, error!.stackTrace);
      }

      if (response.statusCode == 200) {
        final version = jsonDecode(response.body)["version"] as String?;
        if (!RegExp(r"(?:.*?\.){2}.*").hasMatch(version ?? "")) {
          return HostSettingError.undetectable;
        }

        _silentFlag = true;
        this.host = host.resolve("..");
        ollama.ListResponse? data;

        try {
          if (context.mounted) {
            data = await errorGuard(
              context,
              "U7K91OW8",
              () async => clients.ollamaClient.models.list().timeout(
                TimeoutMultiplier.medium,
                onTimeout: () => throw HostSettingError.timeout,
              ),
              enableReporting: false,
              onError: (e, s) => error = (exception: e, stackTrace: s),
            );
          }
          if (data == null) {
            Error.throwWithStackTrace(error!.exception, error!.stackTrace);
          }
        } on HostSettingError catch (_) {
          rethrow;
        } catch (_) {
          this.host = oldHost;
          return HostSettingError.undetectable;
        }

        // TODO: maybe implement version checking

        ModelManager.instance.loadModelsRaw(data: data);
        _silentFlag = false;
        notifyListeners();
        return null;
      }
    } on HostSettingError catch (e) {
      return e;
    } catch (_) {}

    return HostSettingError.unreachable;
  }
}
