import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ollama_dart/ollama_dart.dart' as ollama;

import '../main.dart';
import 'clients.dart' as clients;
import 'preferences.dart';

/// Container class for model capabilities.
///
/// See more:
/// - https://github.com/ollama/ollama/blob/main/types/model/capability.go
class ModelCapability {
  final String name;

  ModelCapability(this.name);

  static ModelCapability completion = ModelCapability("completion");
  static ModelCapability tools = ModelCapability("tools");
  static ModelCapability insertion = ModelCapability("insert");
  static ModelCapability vision = ModelCapability("vision");
  static ModelCapability embedding = ModelCapability("embedding");
  static ModelCapability thinking = ModelCapability("thinking");
  static ModelCapability image = ModelCapability("image");
  static ModelCapability audio = ModelCapability("audio");

  @override
  operator ==(Object other) => other is ModelCapability && other.name == name;
  @override
  int get hashCode => name.hashCode;

  IconData? get icon => switch (name) {
    "completion" => Icons.text_fields,
    "tools" => Icons.build,
    "insert" => Icons.read_more,
    "vision" => Icons.visibility_outlined,
    "embedding" => Icons.link,
    "thinking" => Icons.emoji_objects_outlined,
    "image" => Icons.image_outlined,
    "audio" => Icons.audiotrack_outlined,
    _ => Icons.inventory_2_outlined,
  };
}

class Model extends ChangeNotifier {
  final String name;

  List<TextSpan> nameColored(BuildContext context) =>
      nameColoredStatic(name: name, context: context)!;
  static List<TextSpan>? nameColoredStatic({
    required String? name,
    required BuildContext context,
  }) {
    if (name == null) return null;
    final colorScheme = ColorScheme.of(context);

    final parts = name.split(":");
    assert(
      parts.isNotEmpty && parts.length <= 2,
      "Model name should be in format family:version, but got $name",
    );

    return [
      TextSpan(text: parts.first),
      if (parts.length == 2)
        TextSpan(
          text: ":${parts.last}",
          style: TextStyle(color: colorScheme.outline),
        ),
    ];
  }

  DateTime _modifiedAt;
  DateTime get modifiedAt => _modifiedAt;

  int _size;
  int get size => _size;

  String _family;
  String get family => _family;

  Set<String> _families;
  Set<String> get families => Set.unmodifiable(_families);

  String _parameterSize;
  String get parameterSize => _parameterSize;

  Set<ModelCapability> _capabilities;
  Set<ModelCapability> get capabilities => Set.unmodifiable(_capabilities);

  Model._(
    this.name, {
    required this._modifiedAt,
    required this._size,
    required this._family,
    this._families = const {},
    required this._parameterSize,
  }) : _capabilities = const {};

  factory Model.fromApi({required ollama.ModelSummary model}) {
    return Model._(
      model.model!,
      modifiedAt:
          DateTime.tryParse(model.modifiedAt!)?.toLocal() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      size: model.size ?? 0,
      family: model.details!.family!,
      families: model.details!.families?.toSet() ?? {},
      parameterSize: model.details!.parameterSize!.replaceAll(".0", ""),
    );
  }

  bool _didCallUpdateData = false;
  bool get didCallUpdateData => _didCallUpdateData;

  Future<void> updateData() async {
    final data = await clients.ollamaClient.models.show(
      request: ollama.ShowRequest(model: name),
    );

    // just in case, but should always be present
    if (data.details != null) {
      _family = data.details?["family"] ?? _family;
      _families = data.details?["families"] != null
          ? (data.details!["families"] as List).map((e) => e.toString()).toSet()
          : _families;
      _parameterSize = data.details?["parameterSize"] ?? _parameterSize;
    }
    _capabilities = data.capabilities!.map(ModelCapability.new).toSet();

    _didCallUpdateData = true;
    notifyListeners();
  }

  Future<void> loadIntoMemory() async {
    // unable to use [ollamaClient] here, because the library does not support
    // sending a [GenerateChatCompletionRequest] without [messages], which is
    // required for loading, otherwise a message will be generated

    final headers = <String, String>{
      "Content-Type": "application/json",
      ...Preferences.instance.hostHeaders,
    };
    final body = {"model": name, "keep_alive": Preferences.instance.keepAlive};

    await clients.httpClient
        .post(
          Uri.parse("${clients.ollamaClient.config.baseUrl}/api/generate"),
          headers: headers,
          body: jsonEncode(body),
        )
        .timeout(TimeoutMultiplier.medium);
  }

  @override
  operator ==(Object other) => other is Model && other.name == name;
  @override
  int get hashCode => name.hashCode;
}

class ModelManager extends ChangeNotifier {
  static final ModelManager _instance = ModelManager._();
  static ModelManager get instance => _instance;

  bool _initialized = false;
  bool get initialized => _initialized;

  String? _currentModelName;
  String? get currentModelName => _currentModelName;
  set currentModelName(String? name) {
    assert(!useModel, "Model if fixed to $fixedModel and cannot be changed.");
    if (useModel) return;

    if (name == _currentModelName) return;
    _currentModelName = name;
    Preferences.instance.model = name;
    notifyListeners();
  }

  Model? get currentModel => _currentModelName == null || _models.isEmpty
      ? null
      : _models.singleWhere((e) => e.name == _currentModelName);
  set currentModel(Model? model) => currentModelName = model?.name;

  final Set<Model> _models = {};
  Set<Model> get models => Set.unmodifiable(_models);

  ModelManager._()
    : _currentModelName = useModel ? fixedModel : Preferences.instance.model;

  Future<void> loadModels({bool fetchCapabilitiesInBackground = true}) async {
    final data = await clients.ollamaClient.models.list().timeout(
      TimeoutMultiplier.medium,
    );
    loadModelsRaw(
      data: data,
      fetchCapabilitiesInBackground: fetchCapabilitiesInBackground,
    );
  }

  void loadModelsRaw({
    required ollama.ListResponse data,
    bool fetchCapabilitiesInBackground = true,
  }) {
    for (var model in _models) {
      model.dispose();
    }
    _models.clear();

    for (var model in data.models!) {
      _models.add(Model.fromApi(model: model)..addListener(notifyListeners));
    }
    if (_currentModelName != null &&
        !_models.any((e) => e.name == _currentModelName)) {
      _currentModelName = null;
    }

    _initialized = true;
    notifyListeners();

    if (fetchCapabilitiesInBackground) {
      compute((_) async {
        for (var model in _instance.models) {
          await model.updateData().catchError((_) {});
          notifyListeners();
        }
      }, null);
    }
  }
}

String bytesToHumanReadable(int bytes, {String? locale}) {
  const units = ["B", "KB", "MB", "GB", "TB"];
  var value = bytes.toDouble();
  var unitIndex = 0;

  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex++;
  }
  final nf = NumberFormat.decimalPattern(locale)
    ..maximumFractionDigits = 2
    ..minimumFractionDigits = 0;

  final separator =
      RegExp(r"(\s)")
          .firstMatch(
            NumberFormat.simpleCurrency(locale: locale, name: "USD").format(0),
          )
          ?.group(1) ??
      "";

  return "${nf.format(value)}$separator${units[unitIndex]}";
}

extension FilterSupportedCapabilities on Iterable<ModelCapability> {
  Iterable<ModelCapability> filterSupportedCapabilities() => where(
    (capability) => switch (capability.name) {
      "completion" => false,
      "tools" => false,
      "insert" => false,
      "vision" => true,
      "embedding" => false,
      "thinking" => true,
      "image" => false,
      "audio" => false,
      _ => false,
    },
  );
}
