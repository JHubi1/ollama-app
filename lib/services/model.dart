import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ollama_dart/ollama_dart.dart' as ollama;

import '../main.dart';
import 'clients.dart' as clients;
import 'preferences.dart';

typedef ModelCapability = ollama.Capability;

class Model {
  final String name;

  String _family;
  String get family => _family;

  Set<String> _families;
  Set<String> get families => Set.unmodifiable(_families);

  Set<ModelCapability> _capabilities;
  Set<ModelCapability> get capabilities => Set.unmodifiable(_capabilities);

  Model._(
    this.name, {
    required String family,
    Set<String> families = const {},
    Set<ModelCapability> capabilities = const {},
  }) : _family = family,
       _families = families,
       _capabilities = capabilities;

  factory Model.fromApi({required ollama.Model model, ollama.ModelInfo? info}) {
    return Model._(
      model.model!,
      family: model.details!.family!,
      families: model.details!.families?.toSet() ?? {},
      capabilities: info?.capabilities?.toSet() ?? {},
    );
  }

  Future<void> updateData() async {
    var data = await clients.ollamaClient.showModelInfo(
      request: ollama.ModelInfoRequest(model: name),
    );

    // just in case, but should always be present
    if (data.details != null) {
      _family = data.details!.family!;
      _families = data.details!.families?.toSet() ?? {};
    }
    _capabilities = data.capabilities!.toSet();
  }

  Future<void> loadIntoMemory() async {
    // unable to use [ollamaClient] here, because the library does not support
    // sending a [GenerateChatCompletionRequest] without [messages], which is
    // required for loading, otherwise a message will be generated

    var headers = <String, String>{
      "Content-Type": "application/json",
      ...(jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map),
    };
    var body = {
      "model": name,
      "keep_alive": int.parse(prefs!.getString("keepAlive") ?? "300"),
    };

    await clients.httpClient
        .post(
          Uri.parse("${clients.ollamaClient.baseUrl}/api/generate"),
          headers: headers,
          body: jsonEncode(body),
        )
        .timeout(TimeoutMultiplier.medium);
  }

  @override
  operator ==(Object other) {
    return other is Model && other.name == name;
  }

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
    _currentModelName = name;
    Preferences.instance.model = name;
    notifyListeners();
  }

  Model? get currentModel => _currentModelName == null
      ? null
      : _models.singleWhere((e) => e.name == _currentModelName);
  set currentModel(Model? model) => currentModelName = model?.name;

  final Set<Model> _models = {};
  Set<Model> get models => Set.unmodifiable(_models);

  ModelManager._() : _currentModelName = Preferences.instance.model;

  Future<void> loadModels({bool fetchCapabilitiesInBackground = true}) async {
    var data = await clients.ollamaClient.listModels();
    _models.clear();
    for (var model in data.models!) {
      _models.add(Model.fromApi(model: model));
    }

    _initialized = true;
    notifyListeners();

    if (fetchCapabilitiesInBackground) {
      compute((_) async {
        for (var model in _instance.models) {
          await model.updateData().catchError((_) {});
        }
      }, null);
    }
  }
}

// MARK: Model Set Dialog

// class ModelSetDialog extends StatefulWidget {
//   final bool contentOnly;

//   const ModelSetDialog({super.key, this.contentOnly = false});

//   @override
//   State<ModelSetDialog> createState() => _ModelSetDialogState();
// }

// class _ModelSetDialogState extends State<ModelSetDialog> {
//   @override
//   void initState() {
//     super.initState();
//     ModelManager.instance.addListener(onChange);
//     ModelManager.instance.loadModels();
//   }

//   @override
//   void dispose() {
//     ModelManager.instance.removeListener(onChange);
//     super.dispose();
//   }

//   void onChange() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget main = Placeholder();

//     if (widget.contentOnly) {
//       return main;
//     } else {
//       return AlertDialog();
//     }
//   }
// }

// void showModelSetDialog(BuildContext context) {
//   if (Display.of(context).isDesktop) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => const ModelSetDialog(contentOnly: true),
//     );
//   } else {
//     showDialog(context: context, builder: (_) => const ModelSetDialog());
//   }
// }
