import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'haptic.dart';
import 'setter.dart';
import '../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ollama_dart/ollama_dart.dart' as llama;
import 'package:dartx/dartx.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

List<String> images = [];
Future<List<llama.Message>> getHistory([String? addToSystem]) async {
  var system = prefs?.getString("system") ?? "You are a helpful assistant";
  if (prefs!.getBool("noMarkdown") ?? false) {
    system +=
        "\nYou must not use markdown or any other formatting language in any way!";
  }
  if (addToSystem != null) {
    system += "\n$addToSystem";
  }

  List<llama.Message> history = (prefs!.getBool("useSystem") ?? true)
      ? [llama.Message(role: llama.MessageRole.system, content: system)]
      : [];
  List<llama.Message> history2 = [];
  images = [];
  for (var i = 0; i < messages.length; i++) {
    if (jsonDecode(jsonEncode(messages[i]))["text"] != null) {
      history2.add(llama.Message(
          role: (messages[i].author.id == user.id)
              ? llama.MessageRole.user
              : llama.MessageRole.system,
          content: jsonDecode(jsonEncode(messages[i]))["text"],
          images: (images.isNotEmpty) ? images : null));
      images = [];
    } else {
      var uri = jsonDecode(jsonEncode(messages[i]))["uri"] as String;
      String content = (uri.startsWith("data:image/png;base64,"))
          ? uri.removePrefix("data:image/png;base64,")
          : base64.encode(await File(uri).readAsBytes());
      uri = uri.removePrefix("data:image/png;base64,");
      images.add(content);
    }
  }

  history.addAll(history2.reversed.toList());
  return history;
}

Future<String> getTitleAi(List history) async {
  final generated = await (llama.OllamaClient(
          headers: (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
              .cast<String, String>(),
          baseUrl: "$host/api"))
      .generateChatCompletion(
        request: llama.GenerateChatCompletionRequest(
            model: model!,
            messages: [
              const llama.Message(
                  role: llama.MessageRole.system,
                  content:
                      "You must not use markdown or any other formatting language! Create a short title for the subject of the conversation described in the following json object. It is not allowed to be too general; no 'Assistance', 'Help' or similar!"),
              llama.Message(
                  role: llama.MessageRole.user, content: jsonEncode(history))
            ],
            keepAlive: int.parse(prefs!.getString("keepAlive") ?? "300")),
      )
      .timeout(const Duration(seconds: 10));
  var title = generated.message!.content
      .replaceAll("\"", "")
      .replaceAll("'", "")
      .replaceAll("*", "")
      .replaceAll("_", "")
      .replaceAll("\n", " ")
      .trim();
  return title;
}

Future<void> setTitleAi(List history) async {
  try {
    var title = await getTitleAi(history);
    var tmp = (prefs!.getStringList("chats") ?? []);
    for (var i = 0; i < tmp.length; i++) {
      if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
          chatUuid) {
        var tmp2 = jsonDecode(tmp[i]);
        tmp2["title"] = title;
        tmp[i] = jsonEncode(tmp2);
        break;
      }
    }
    prefs!.setStringList("chats", tmp);
  } catch (_) {}
}

Future<String> send(String value, BuildContext context, Function setState,
    {void Function(String currentText, bool done)? onStream,
    String? addToSystem}) async {
  selectionHaptic();
  setState(() {
    sendable = false;
  });

  if (host == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.noHostSelected),
        showCloseIcon: true));
    if (onStream != null) {
      onStream("", true);
    }
    return "";
  }

  if (!chatAllowed || model == null) {
    if (model == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.noModelSelected),
          showCloseIcon: true));
    }
    if (onStream != null) {
      onStream("", true);
    }
    return "";
  }

  bool newChat = false;
  if (chatUuid == null) {
    newChat = true;
    chatUuid = const Uuid().v4();
    prefs!.setStringList(
        "chats",
        (prefs!.getStringList("chats") ?? []).append([
          jsonEncode({
            "title": AppLocalizations.of(context)!.newChatTitle,
            "uuid": chatUuid,
            "messages": []
          })
        ]).toList());
  }

  var history = await getHistory(addToSystem);

  history.add(llama.Message(
      role: llama.MessageRole.user,
      content: value.trim(),
      images: (images.isNotEmpty) ? images : null));
  messages.insert(
      0,
      types.TextMessage(
          author: user, id: const Uuid().v4(), text: value.trim()));

  saveChat(chatUuid!, setState);

  setState(() {});
  chatAllowed = false;

  String text = "";

  String newId = const Uuid().v4();
  llama.OllamaClient client = llama.OllamaClient(
      headers: (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
          .cast<String, String>(),
      baseUrl: "$host/api");

  try {
  if ((prefs!.getString("requestType") ?? "stream") == "stream") {
    final stream = client
        .generateChatCompletionStream(
          request: llama.GenerateChatCompletionRequest(
              model: model!,
              messages: history,
              keepAlive: int.parse(prefs!.getString("keepAlive") ?? "300")),
        )
        .timeout(const Duration(seconds: 30));

    await for (final res in stream) {
      text += (res.message?.content ?? "");
      for (var i = 0; i < messages.length; i++) {
        if (messages[i].id == newId) {
          messages.removeAt(i);
          break;
        }
      }
      if (chatAllowed) return "";
      // if (text.trim() == "") {
      //   throw Exception();
      // }
      messages.insert(
          0, types.TextMessage(author: assistant, id: newId, text: text));
      if (onStream != null) {
        onStream(text, false);
      }
      setState(() {});
      heavyHaptic();
    }
  } else {
    llama.GenerateChatCompletionResponse request;
    request = await client
        .generateChatCompletion(
          request: llama.GenerateChatCompletionRequest(
              model: model!,
              messages: history,
              keepAlive: int.parse(prefs!.getString("keepAlive") ?? "300")),
        )
        .timeout(const Duration(seconds: 30));
    if (chatAllowed) return "";
    // if (request.message!.content.trim() == "") {
    //   throw Exception();
    // }
    messages.insert(
        0,
        types.TextMessage(
            author: assistant, id: newId, text: request.message!.content));
    text = request.message!.content;
    setState(() {});
    heavyHaptic();
  }
  } catch (e) {
    for (var i = 0; i < messages.length; i++) {
      if (messages[i].id == newId) {
        messages.removeAt(i);
        break;
      }
    }
    setState(() {
      chatAllowed = true;
      messages.removeAt(0);
      if (messages.isEmpty) {
        var tmp = (prefs!.getStringList("chats") ?? []);
        for (var i = 0; i < tmp.length; i++) {
          if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
              chatUuid) {
            tmp.removeAt(i);
            prefs!.setStringList("chats", tmp);
            break;
          }
        }
        chatUuid = null;
      }
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            // ignore: use_build_context_synchronously
            Text(AppLocalizations.of(context)!.settingsHostInvalid("timeout")),
        showCloseIcon: true));
    return "";
  }

  if ((prefs!.getString("requestType") ?? "stream") == "stream") {
    if (onStream != null) {
      onStream(text, true);
    }
  }
  saveChat(chatUuid!, setState);

  if (newChat && (prefs!.getBool("generateTitles") ?? true)) {
    void setTitle() async {
      await setTitleAi(await getHistory());
      setState(() {});
    }

    setTitle();
  }

  setState(() {});
  chatAllowed = true;
  return text;
}
