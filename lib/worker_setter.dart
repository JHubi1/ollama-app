import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';

import 'package:dartx/dartx.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

void setModel(BuildContext context, Function setState) {
  List<String> models = [];
  List<String> modelsReal = [];
  List<bool> modal = [];
  int usedIndex = -1;
  int addIndex = -1;
  bool loaded = false;
  Function? setModalState;
  void load() async {
    try {
      var list = await llama.OllamaClient(
              headers:
                  (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
                      .cast<String, String>(),
              baseUrl: "$host/api")
          .listModels()
          .timeout(const Duration(seconds: 5));
      for (var i = 0; i < list.models!.length; i++) {
        models.add(list.models![i].model!.split(":")[0]);
        modelsReal.add(list.models![i].model!);
        modal.add((list.models![i].details!.families ?? []).contains("clip"));
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
        }
      }
      loaded = true;
      setModalState!(() {});
    } catch (_) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: use_build_context_synchronously
          content: Text(
              // ignore: use_build_context_synchronously
              AppLocalizations.of(context)!.settingsHostInvalid("timeout")),
          showCloseIcon: true));
    }
  }

  load();

  if (useModel) return;
  HapticFeedback.selectionClick();

  var content = StatefulBuilder(builder: (context, setLocalState) {
    setModalState = setLocalState;
    return PopScope(
        canPop: loaded,
        onPopInvoked: (didPop) {
          if (!loaded) return;
          if (usedIndex >= 0 &&
              modelsReal[usedIndex] != model &&
              (prefs!.getBool("resetOnModelSelect") ?? true)) {
            messages = [];
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
          setState(() {});
        },
        child: Container(
            width:
                ((Platform.isWindows || Platform.isLinux || Platform.isMacOS) &&
                        MediaQuery.of(context).size.width >= 1000)
                    ? null
                    : double.infinity,
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom:
                    (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
                        ? 16
                        : 0),
            child: (!loaded)
                ? const LinearProgressIndicator()
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: ((Platform.isWindows ||
                                    Platform.isLinux ||
                                    Platform.isMacOS) &&
                                MediaQuery.of(context).size.width >= 1000)
                            ? 300
                            : double.infinity,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.4),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              spacing: ((Platform.isWindows ||
                                          Platform.isLinux ||
                                          Platform.isMacOS) &&
                                      MediaQuery.of(context).size.width >= 1000)
                                  ? 10.0
                                  : 5.0,
                              runSpacing: (Platform.isWindows ||
                                      Platform.isLinux ||
                                      Platform.isMacOS)
                                  ? (MediaQuery.of(context).size.width >= 1000)
                                      ? 10.0
                                      : 5.0
                                  : 0.0,
                              alignment: WrapAlignment.center,
                              children: List<Widget>.generate(
                                models.length,
                                (int index) {
                                  return ChoiceChip(
                                    label: Text(
                                        (prefs!.getBool("modelTags") ?? false)
                                            ? modelsReal[index]
                                            : models[index]),
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
                                    checkmarkColor: (usedIndex == index)
                                        ? ((MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light)
                                            ? (theme ?? ThemeData())
                                                .colorScheme
                                                .secondary
                                            : (themeDark ?? ThemeData.dark())
                                                .colorScheme
                                                .secondary)
                                        : null,
                                    labelStyle: (usedIndex == index)
                                        ? TextStyle(
                                            color: (MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.light)
                                                ? (theme ?? ThemeData())
                                                    .colorScheme
                                                    .secondary
                                                : (themeDark ??
                                                        ThemeData.dark())
                                                    .colorScheme
                                                    .secondary)
                                        : null,
                                    selectedColor: (MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light)
                                        ? (theme ?? ThemeData())
                                            .colorScheme
                                            .primary
                                        : (themeDark ?? ThemeData.dark())
                                            .colorScheme
                                            .primary,
                                    onSelected: (bool selected) {
                                      if (addIndex == index) {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .modelDialogAddSteps),
                                                showCloseIcon: true));
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

  if ((Platform.isWindows || Platform.isLinux || Platform.isMacOS) &&
      MediaQuery.of(context).size.width >= 1000) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(alignment: Alignment.topCenter, child: content);
        });
  } else {
    showModalBottomSheet(context: context, builder: (context) => content);
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

Future<String> prompt(BuildContext context,
    {String description = "",
    String value = "",
    String title = "",
    String? valueIfCanceled,
    TextInputType keyboard = TextInputType.text,
    Icon? prefixIcon,
    int maxLines = 1,
    String? uuid,
    Future<bool> Function(String content)? validator,
    String? validatorError,
    String? placeholder}) async {
  var returnText = (valueIfCanceled != null) ? valueIfCanceled : value;
  final TextEditingController controller = TextEditingController(text: value);
  bool loading = false;
  String? error;
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          return PopScope(
              child: Container(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: (Platform.isWindows ||
                              Platform.isLinux ||
                              Platform.isMacOS)
                          ? 16
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
                            maxLines: maxLines,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: placeholder,
                                errorText: error,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (validator != null) {
                                        setLocalState(() {
                                          error = null;
                                        });
                                        bool valid =
                                            await validator(controller.text);
                                        if (!valid) {
                                          setLocalState(() {
                                            error = validatorError;
                                          });
                                          return;
                                        }
                                      }
                                      returnText = controller.text;
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.save_rounded)),
                                prefixIcon: (title ==
                                            AppLocalizations.of(context)!
                                                .dialogEnterNewTitle &&
                                        uuid != null)
                                    ? IconButton(
                                        onPressed: () async {
                                          setLocalState(() {
                                            loading = true;
                                          });
                                          for (var i = 0;
                                              i <
                                                  (prefs!.getStringList(
                                                              "chats") ??
                                                          [])
                                                      .length;
                                              i++) {
                                            if (jsonDecode((prefs!
                                                        .getStringList(
                                                            "chats") ??
                                                    [])[i])["uuid"] ==
                                                uuid) {
                                              try {
                                                List history = [];
                                                var tmp = jsonDecode(jsonDecode(
                                                    (prefs!.getStringList(
                                                            "chats") ??
                                                        [])[i])["messages"]);
                                                for (var j = 0;
                                                    j < tmp.length;
                                                    j++) {
                                                  if (tmp[j]["text"] == null) {
                                                    continue;
                                                  }
                                                  history.add(tmp[j]["text"]);
                                                }
                                                if (history.isEmpty) {
                                                  controller
                                                      .text = AppLocalizations
                                                          .of(context)!
                                                      .imageOnlyConversation;
                                                  setLocalState(() {
                                                    loading = false;
                                                  });
                                                  return;
                                                }

                                                final generated = await llama.OllamaClient(
                                                        headers: (jsonDecode(prefs!
                                                                    .getString(
                                                                        "hostHeaders") ??
                                                                "{}") as Map)
                                                            .cast<String,
                                                                String>(),
                                                        baseUrl: "$host/api")
                                                    .generateCompletion(
                                                  request: llama
                                                      .GenerateCompletionRequest(
                                                    model: model!,
                                                    prompt:
                                                        "You must not use markdown or any other formatting language! Create a short title for the subject of the conversation described in the following json object. It is not allowed to be too general; no 'Assistance', 'Help' or similar!\n\n```json\n${jsonEncode(history)}\n```",
                                                  ),
                                                );
                                                var title = generated.response!
                                                    .replaceAll("*", "")
                                                    .replaceAll("_", "")
                                                    .trim();
                                                controller.text = title;
                                                setLocalState(() {
                                                  loading = false;
                                                });
                                              } catch (_) {}
                                              break;
                                            }
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
