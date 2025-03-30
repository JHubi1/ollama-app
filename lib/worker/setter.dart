import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:ollama_app/worker/clients.dart';
import 'desktop.dart';
import 'haptic.dart';
import '../main.dart';
import 'sender.dart';
import 'theme.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';

import 'package:dartx/dartx.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

void setModel(BuildContext context, Function setState) {
  List<String> models = [];
  List<String> modelsReal = [];
  List<bool> modal = [];
  int usedIndex = -1;
  int oldIndex = -1;
  int addIndex = -1;
  bool loaded = false;
  Function? setModalState;
  desktopTitleVisible = false;
  setState(() {});
  void load() async {
    try {
      var list = await ollamaClient.listModels().timeout(Duration(
          seconds:
              (10.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0)).round()));
      for (var i = 0; i < list.models!.length; i++) {
        models.add(list.models![i].model!.split(":")[0]);
        modelsReal.add(list.models![i].model!);
        var families = list.model![i].details!.families ?? [];
        var modelInfo = list.model![i].details!.model_info ?? {};
        var visionModelFamilies = ["clip", "gemma3"];
        if (families.any((family) => visionModelFamilies.contains(family)) || modelInfo.keys.any((key) => key.contains("vision"))) {
          modal.add(true);
        }
        else {
          modal.add(false);
        }
      }
      addIndex = models.length;
      // ignore: use_build_context_synchronously
      models.add(AppLocalizations.of(context)!.modelDialogAddModel);
      // ignore: use_build_context_synchronously
      modelsReal.add(AppLocalizations.of(context)!.modelDialogAddModel);
      modal.add(false);
      for (var i = 0; i < modelsReal.length; i++) {
        if (modelsReal[i] == model) {
          usedIndex = i;
          oldIndex = usedIndex;
        }
      }
      if (prefs!.getBool("modelTags") == null) {
        List duplicateFinder = [];
        for (var model in models) {
          if (duplicateFinder.contains(model)) {
            prefs!.setBool("modelTags", true);
            break;
          } else {
            duplicateFinder.add(model);
          }
        }
      }
      loaded = true;
      setModalState!(() {});
    } catch (_) {
      setState(() {
        desktopTitleVisible = true;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              // ignore: use_build_context_synchronously
              AppLocalizations.of(context)!.settingsHostInvalid("timeout")),
          showCloseIcon: true));
    }
  }

  if (useModel) return;
  selectionHaptic();

  load();

  var content = StatefulBuilder(builder: (context, setLocalState) {
    setModalState = setLocalState;
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!loaded) return;
          loaded = false;
          bool preload = false;
          if (usedIndex >= 0 && modelsReal[usedIndex] != model) {
            preload = true;
            if (prefs!.getBool("resetOnModelSelect") ??
                true && allowMultipleChats) {
              messages = [];
              chatUuid = null;
            }
          }
          model = (usedIndex >= 0) ? modelsReal[usedIndex] : null;
          chatAllowed = !(model == null);
          multimodal = (usedIndex >= 0) ? modal[usedIndex] : false;
          if (model != null) {
            prefs?.setString("model", model!);
          } else {
            prefs?.remove("model");
          }
          prefs?.setBool("multimodal", multimodal);

          if (model != null &&
              preload &&
              int.parse(prefs!.getString("keepAlive") ?? "300") != 0 &&
              (prefs!.getBool("preloadModel") ?? true)) {
            setLocalState(() {});
            try {
              // don't use llama client, package doesn't support just loading without content
              await httpClient
                  .post(
                    Uri.parse("$host/api/generate"),
                    headers: {
                      "Content-Type": "application/json",
                      ...(jsonDecode(prefs!.getString("hostHeaders") ?? "{}")
                          as Map)
                    }.cast<String, String>(),
                    body: jsonEncode({
                      "model": model!,
                      "keep_alive":
                          int.parse(prefs!.getString("keepAlive") ?? "300")
                    }),
                  )
                  .timeout(Duration(
                      seconds: (10.0 *
                              (prefs!.getDouble("timeoutMultiplier") ?? 1.0))
                          .round()));
            } catch (_) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // ignore: use_build_context_synchronously
                  content: Text(AppLocalizations.of(context)!
                      .settingsHostInvalid("timeout")),
                  showCloseIcon: true));
              setState(() {
                model = null;
                chatAllowed = false;
              });
            }
            setState(() {
              desktopTitleVisible = true;
            });
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          } else {
            setState(() {
              desktopTitleVisible = true;
            });
            try {
              Navigator.of(context).pop();
            } catch (_) {}
          }
        },
        child: Container(
            width: desktopLayout(context) ? null : double.infinity,
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: desktopLayout(context) ? 16 : 0),
            child: (!loaded)
                ? SizedBox(
                    width: desktopLayout(context) ? 300 : double.infinity,
                    child: const LinearProgressIndicator())
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: desktopLayout(context) ? 300 : double.infinity,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.4),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              spacing: desktopLayout(context) ? 10.0 : 5.0,
                              runSpacing:
                                  desktopFeature(web: true) ? 10.0 : 0.0,
                              alignment: WrapAlignment.center,
                              children: List<Widget>.generate(
                                models.length,
                                (int index) {
                                  return ChoiceChip(
                                    label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(models[index]),
                                          ((prefs!.getBool("modelTags") ??
                                                      false) &&
                                                  modelsReal[index]
                                                          .split(":")
                                                          .length >
                                                      1)
                                              ? Text(
                                                  ":${modelsReal[index].split(":")[1]}",
                                                  style: const TextStyle(
                                                      color: Colors.grey))
                                              : const SizedBox.shrink()
                                        ]),
                                    selected: usedIndex == index,
                                    avatar: (usedIndex == index)
                                        ? null
                                        : (addIndex == index)
                                            ? const Icon(Icons.add_rounded)
                                            : ((recommendedModels
                                                    .contains(models[index]))
                                                ? const Icon(Icons.star_rounded)
                                                : ((modal[index])
                                                    ? const Icon(Icons
                                                        .collections_rounded)
                                                    : null)),
                                    checkmarkColor: (usedIndex == index &&
                                            !(prefs?.getBool(
                                                    "useDeviceTheme") ??
                                                false))
                                        ? ((MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light)
                                            ? themeLight().colorScheme.secondary
                                            : themeDark().colorScheme.secondary)
                                        : null,
                                    labelStyle: (usedIndex == index &&
                                            !(prefs?.getBool(
                                                    "useDeviceTheme") ??
                                                false))
                                        ? TextStyle(
                                            color: (MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.light)
                                                ? themeLight()
                                                    .colorScheme
                                                    .secondary
                                                : themeDark()
                                                    .colorScheme
                                                    .secondary)
                                        : null,
                                    selectedColor: (prefs
                                                ?.getBool("useDeviceTheme") ??
                                            false)
                                        ? null
                                        : (MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light)
                                            ? themeLight().colorScheme.primary
                                            : themeDark().colorScheme.primary,
                                    onSelected: (bool selected) {
                                      selectionHaptic();
                                      if (addIndex == index) {
                                        usedIndex = oldIndex;
                                        Navigator.of(context).pop();
                                        addModel(context, setState);
                                      }
                                      if (!chatAllowed && model != null) {
                                        return;
                                      }
                                      setLocalState(() {
                                        usedIndex = selected ? index : -1;
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            )))
                  ])));
  });

  if (desktopLayoutNotRequired(context)) {
    showDialog(
        context: context,
        builder: (context) {
          return Transform.translate(
            offset: desktopLayoutRequired(context)
                ? const Offset(289, 0)
                : const Offset(0, 0),
            child: Dialog(
                surfaceTintColor:
                    (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.grey[800]
                        : null,
                alignment: desktopLayoutRequired(context)
                    ? Alignment.topLeft
                    : Alignment.topCenter,
                child: content),
          );
        });
  } else {
    showModalBottomSheet(
        context: context, builder: (context) => Container(child: content));
  }
}

void addModel(BuildContext context, Function setState) async {
  bool canceled = false;
  bool networkError = false;
  bool ratelimitError = false;
  bool alreadyExists = false;
  final String invalidText =
      AppLocalizations.of(context)!.modelDialogAddPromptInvalid;
  final networkErrorText =
      AppLocalizations.of(context)!.settingsHostInvalid("other");
  final timeoutErrorText =
      AppLocalizations.of(context)!.settingsHostInvalid("timeout");
  final ratelimitErrorText =
      AppLocalizations.of(context)!.settingsHostInvalid("ratelimit");
  final alreadyExistsText =
      AppLocalizations.of(context)!.modelDialogAddPromptAlreadyExists;
  final downloadSuccessText =
      AppLocalizations.of(context)!.modelDialogAddDownloadSuccess;
  final downloadFailedText =
      AppLocalizations.of(context)!.modelDialogAddDownloadFailed;
  var requestedModel = await prompt(
    context,
    title: AppLocalizations.of(context)!.modelDialogAddPromptTitle,
    description: AppLocalizations.of(context)!.modelDialogAddPromptDescription,
    placeholder: "llama3:latest",
    enableSuggestions: false,
    validator: (content) async {
      var model = content.trim();
      model = model.removeSuffix(":latest");
      if (model == "") return false;
      canceled = false;
      networkError = false;
      ratelimitError = false;
      alreadyExists = false;
      try {
        var request = await ollamaClient.listModels().timeout(Duration(
            seconds: (10.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0))
                .round()));
        for (var element in request.models!) {
          var localModel = element.model!.removeSuffix(":latest");
          if (localModel == model) {
            alreadyExists = true;
          }
        }
        if (alreadyExists) return false;
      } catch (_) {
        networkError = true;
        return false;
      }
      var endpoint = "https://ollama.com/library/";
      if (kIsWeb) {
        if (!(prefs!.getBool("allowWebProxy") ?? false)) {
          bool returnValue = false;
          await showDialog(
              context: mainContext!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                    title: Text(AppLocalizations.of(context)!
                        .modelDialogAddAllowanceTitle),
                    content: SizedBox(
                      width: 640,
                      child: Text(AppLocalizations.of(context)!
                          .modelDialogAddAllowanceDescription),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            canceled = true;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!
                              .modelDialogAddAllowanceDeny)),
                      TextButton(
                          onPressed: () {
                            returnValue = true;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!
                              .modelDialogAddAllowanceAllow))
                    ]);
              });
          if (!returnValue) return false;
          prefs!.setBool("allowWebProxy", true);
        }
        endpoint = "https://end.jhubi1.com/ollama-proxy/";
      }
      http.Response response;
      try {
        response = await httpClient
            .get(Uri.parse("$endpoint${Uri.encodeComponent(model)}"))
            .timeout(Duration(
                seconds: (10.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0))
                    .round()));
      } catch (_) {
        networkError = true;
        return false;
      }
      if (response.statusCode == 200) {
        bool returnValue = false;
        await showDialog(
            context: mainContext!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                  title: Text(AppLocalizations.of(context)!
                      .modelDialogAddAssuranceTitle(model)),
                  content: SizedBox(
                    width: 640,
                    child: Text(AppLocalizations.of(context)!
                        .modelDialogAddAssuranceDescription(model)),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          canceled = true;
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!
                            .modelDialogAddAssuranceCancel)),
                    TextButton(
                        onPressed: () {
                          returnValue = true;
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!
                            .modelDialogAddAssuranceAdd))
                  ]);
            });
        return returnValue;
      }
      if (response.statusCode == 429) {
        ratelimitError = true;
      }
      return false;
    },
    validatorErrorCallback: (content) {
      if (networkError) return networkErrorText;
      if (ratelimitError) return ratelimitErrorText;
      if (alreadyExists) return alreadyExistsText;
      if (canceled) return null;
      return invalidText;
    },
  );
  if (requestedModel == "") return;
  requestedModel = requestedModel.removeSuffix(":latest");
  double? percent;
  Function? setDialogState;
  showModalBottomSheet(
      context: mainContext!,
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          setDialogState = setLocalState;
          return PopScope(
              canPop: false,
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: desktopLayout(context) ? 16 : 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        percent == null
                            ? AppLocalizations.of(context)!
                                .modelDialogAddDownloadPercentLoading
                            : AppLocalizations.of(context)!
                                .modelDialogAddDownloadPercent(
                                    (percent * 100).round().toString()),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      LinearProgressIndicator(value: percent),
                    ],
                  )));
        });
      });
  try {
    final stream = ollamaClient
        .pullModelStream(request: llama.PullModelRequest(model: requestedModel))
        .timeout(Duration(
            seconds: (10.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0))
                .round()));
    bool alreadyProgressed = false;
    await for (final res in stream) {
      double tmpPercent =
          ((res.completed ?? 0).toInt() / (res.total ?? 100).toInt());
      if ((tmpPercent * 100).round() == 0) {
        if (!alreadyProgressed) {
          percent = null;
        }
      } else {
        percent = tmpPercent;
        alreadyProgressed = true;
      }
      setDialogState!(() {});
    }
    // done downloading
    if (prefs!.getBool("resetOnModelSelect") ?? true && allowMultipleChats) {
      messages = [];
      chatUuid = null;
    }
    model = requestedModel;
    if (model!.split(":").length == 1) {
      model = "$model:latest";
    }
    bool exists = false;
    try {
      var request = await ollamaClient.listModels().timeout(Duration(
          seconds:
              (10.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0)).round()));
      for (var element in request.models!) {
        if (element.model == model) {
          exists = true;
          multimodal = (element.details!.families ?? []).contains("clip");
        }
      }
      if (!exists) {
        throw Exception();
      }
    } catch (_) {
      setState(() {
        model = null;
        multimodal = false;
        chatAllowed = false;
      });
      prefs?.remove("model");
      prefs?.setBool("multimodal", multimodal);
      Navigator.of(mainContext!).pop();
      if (!exists) {
        ScaffoldMessenger.of(mainContext!).showSnackBar(
            SnackBar(content: Text(downloadFailedText), showCloseIcon: true));
      } else {
        ScaffoldMessenger.of(mainContext!).showSnackBar(
            SnackBar(content: Text(timeoutErrorText), showCloseIcon: true));
      }
      return;
    }
    prefs?.setString("model", model!);
    prefs?.setBool("multimodal", multimodal);
    setState(() {
      chatAllowed = true;
    });
    Navigator.of(mainContext!).pop();
    ScaffoldMessenger.of(mainContext!).showSnackBar(
        SnackBar(content: Text(downloadSuccessText), showCloseIcon: true));
  } catch (_) {
    Navigator.of(mainContext!).pop();
    ScaffoldMessenger.of(mainContext!).showSnackBar(
        SnackBar(content: Text(downloadFailedText), showCloseIcon: true));
  }
}

void saveChat(String uuid, Function setState) async {
  int index = -1;
  for (var i = 0; i < (prefs!.getStringList("chats") ?? []).length; i++) {
    if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] == uuid) {
      index = i;
    }
  }
  if (index == -1) return;
  List<Map<String, String>> history = [];
  for (var i = 0; i < messages.length; i++) {
    if ((jsonDecode(jsonEncode(messages[i])) as Map).containsKey("text")) {
      history.add({
        "role": (messages[i].author == user) ? "user" : "assistant",
        "content": jsonDecode(jsonEncode(messages[i]))["text"]
      });
    } else {
      var uri = jsonDecode(jsonEncode(messages[i]))["uri"] as String;
      String content = (uri.startsWith("data:image/png;base64,"))
          ? uri.removePrefix("data:image/png;base64,")
          : base64.encode(await File(uri).readAsBytes());
      history.add({
        "role": (messages[i].author == user) ? "user" : "assistant",
        "type": "image",
        "name": (messages[i] as types.ImageMessage).name,
        "size": (messages[i] as types.ImageMessage).size.toString(),
        "content": content
      });
    }
  }
  if (messages.isEmpty && uuid == chatUuid) {
    for (var i = 0; i < (prefs!.getStringList("chats") ?? []).length; i++) {
      if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
          chatUuid) {
        List<String> tmp = prefs!.getStringList("chats")!;
        tmp.removeAt(i);
        prefs!.setStringList("chats", tmp);
        chatUuid = null;
        return;
      }
    }
  }
  if (jsonDecode((prefs!.getStringList("chats") ?? [])[index])["messages"]
          .length >=
      1) {
    if (jsonDecode(jsonDecode((prefs!.getStringList("chats") ?? [])[index])[
            "messages"])[0]["role"] ==
        "system") {
      history.add({
        "role": "system",
        "content": jsonDecode(jsonDecode(
                (prefs!.getStringList("chats") ?? [])[index])["messages"])[0]
            ["content"]
      });
    }
  } else {
    var system = prefs?.getString("system") ?? "You are a helpful assistant";
    if (prefs!.getBool("noMarkdown") ?? false) {
      system +=
          " You must not use markdown or any other formatting language in any way!";
    }
    history.add({"role": "system", "content": system});
  }
  history = history.reversed.toList();
  List<String> tmp = prefs!.getStringList("chats") ?? [];
  tmp.removeAt(index);
  tmp.insert(
      0,
      jsonEncode({
        "title":
            jsonDecode((prefs!.getStringList("chats") ?? [])[index])["title"],
        "uuid": uuid,
        "model": model,
        "messages": jsonEncode(history)
      }));
  prefs!.setStringList("chats", tmp);
  setState(() {});
}

void loadChat(String uuid, Function setState) {
  int index = -1;
  for (var i = 0; i < (prefs!.getStringList("chats") ?? []).length; i++) {
    if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] == uuid) {
      index = i;
    }
  }
  if (index == -1) return;
  messages = [];
  model = null;
  setState(() {});
  var history = jsonDecode(
      jsonDecode((prefs!.getStringList("chats") ?? [])[index])["messages"]);
  for (var i = 0; i < history.length; i++) {
    if (history[i]["role"] != "system") {
      if ((history[i] as Map).containsKey("type") &&
          history[i]["type"] == "image") {
        messages.insert(
            0,
            types.ImageMessage(
                author: (history[i]["role"] == "user") ? user : assistant,
                id: const Uuid().v4(),
                name: history[i]["name"],
                size: int.parse(history[i]["size"]),
                uri: "data:image/png;base64,${history[i]["content"]}"));
      } else {
        messages.insert(
            0,
            types.TextMessage(
                author: (history[i]["role"] == "user") ? user : assistant,
                id: const Uuid().v4(),
                text: history[i]["content"]));
      }
    }
  }
  model = jsonDecode((prefs!.getStringList("chats") ?? [])[index])["model"];
  setState(() {});
}

Future<bool> deleteChatDialog(BuildContext context, Function setState,
    {bool takeAction = true,
    bool? additionalCondition,
    String? uuid,
    bool popSidebar = false}) async {
  additionalCondition ??= true;
  uuid ??= chatUuid;

  bool returnValue = false;
  void delete(BuildContext context) {
    returnValue = true;
    if (takeAction) {
      for (var i = 0; i < (prefs!.getStringList("chats") ?? []).length; i++) {
        if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
            uuid) {
          List<String> tmp = prefs!.getStringList("chats")!;
          tmp.removeAt(i);
          prefs!.setStringList("chats", tmp);
          break;
        }
      }
      if (chatUuid == uuid) {
        messages = [];
        chatUuid = null;
        if (!desktopLayoutRequired(context) &&
            Navigator.of(context).canPop() &&
            popSidebar) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  if ((prefs!.getBool("askBeforeDeletion") ?? false) && additionalCondition) {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setLocalState) {
            return AlertDialog(
                title: Text(AppLocalizations.of(context)!.deleteDialogTitle),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(AppLocalizations.of(context)!.deleteDialogDescription),
                ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        selectionHaptic();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          AppLocalizations.of(context)!.deleteDialogCancel)),
                  TextButton(
                      onPressed: () {
                        selectionHaptic();
                        Navigator.of(context).pop();
                        delete(context);
                      },
                      child: Text(
                          AppLocalizations.of(context)!.deleteDialogDelete))
                ]);
          });
        });
  } else {
    delete(context);
  }
  setState(() {});
  return returnValue;
}

Future<String> prompt(BuildContext context,
    {String description = "",
    String value = "",
    String title = "",
    String? valueIfCanceled,
    TextInputType keyboard = TextInputType.text,
    bool autocorrect = true,
    Iterable<String> autofillHints = const [],
    bool enableSuggestions = true,
    Icon? prefixIcon,
    int maxLines = 1,
    String? uuid,
    Future<bool> Function(String content)? validator,
    String? validatorError,
    String? Function(String content)? validatorErrorCallback,
    String? placeholder,
    bool prefill = true}) async {
  var returnText = (valueIfCanceled != null) ? valueIfCanceled : value;
  final TextEditingController controller =
      TextEditingController(text: prefill ? value : "");
  bool loading = false;
  String? error;
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          void submit() async {
            selectionHaptic();
            if (validator != null) {
              setLocalState(() {
                error = null;
                loading = true;
              });
              bool valid = await validator(controller.text);
              setLocalState(() {
                loading = false;
              });
              if (!valid) {
                setLocalState(() {
                  if (validatorError != null) {
                    error = validatorError;
                  } else if (validatorErrorCallback != null) {
                    error = validatorErrorCallback(controller.text);
                  } else {
                    error = null;
                  }
                });
                return;
              }
            }
            returnText = controller.text;
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }

          return PopScope(
              child: Container(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: desktopFeature(web: true)
                          ? 12
                          : MediaQuery.of(context).viewInsets.bottom),
                  width: double.infinity,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (title != "")
                            ? Text(title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                            : const SizedBox.shrink(),
                        (title != "")
                            ? const Divider()
                            : const SizedBox.shrink(),
                        (description != "")
                            ? Text(description)
                            : const SizedBox.shrink(),
                        const SizedBox(height: 8),
                        TextField(
                            controller: controller,
                            autofocus: true,
                            keyboardType: keyboard,
                            autocorrect: autocorrect,
                            autofillHints: autofillHints,
                            enableSuggestions: enableSuggestions,
                            maxLines: maxLines,
                            onSubmitted: (_) => submit(),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: placeholder,
                                errorText: error,
                                suffixIcon: IconButton(
                                    enableFeedback: false,
                                    tooltip: AppLocalizations.of(context)!
                                        .tooltipSave,
                                    onPressed: submit,
                                    icon: const Icon(Icons.save_rounded)),
                                prefixIcon: (title ==
                                            AppLocalizations.of(context)!
                                                .dialogEnterNewTitle &&
                                        uuid != null)
                                    ? IconButton(
                                        enableFeedback: false,
                                        tooltip: AppLocalizations.of(context)!
                                            .tooltipLetAIThink,
                                        onPressed: () async {
                                          selectionHaptic();
                                          setLocalState(() {
                                            loading = true;
                                          });

                                          try {
                                            var title = await getTitleAi(
                                                getHistoryString(uuid));
                                            controller.text = title;
                                            setLocalState(() {
                                              loading = false;
                                            });
                                          } catch (_) {
                                            try {
                                              setLocalState(() {
                                                loading = false;
                                              });
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          AppLocalizations.of(
                                                                  // ignore: use_build_context_synchronously
                                                                  context)!
                                                              .settingsHostInvalid(
                                                                  "timeout")),
                                                      showCloseIcon: true));
                                            } catch (_) {}
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.auto_awesome_rounded))
                                    : prefixIcon)),
                        SizedBox(
                            height: 3,
                            child: (loading)
                                ? const LinearProgressIndicator()
                                : const SizedBox.shrink()),
                        (MediaQuery.of(context).viewInsets.bottom != 0)
                            ? const SizedBox(height: 16)
                            : const SizedBox.shrink()
                      ])));
        });
      });
  return returnText;
}
