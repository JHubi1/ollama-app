import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';

import 'package:http/http.dart' as http;
import 'package:dartx/dartx.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;

void setHost(BuildContext context, [bool force = true]) {
  bool loading = false;
  bool invalidHost = false;
  bool invalidUrl = false;
  final hostInputController =
      TextEditingController(text: prefs?.getString("host") ?? "");
  showDialog(
      context: context,
      barrierDismissible: !force,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => PopScope(
              canPop: !force,
              child: AlertDialog(
                  title: Text(AppLocalizations.of(context)!.hostDialogTitle),
                  content: loading
                      ? const LinearProgressIndicator()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(AppLocalizations.of(context)!
                                  .hostDialogDescription),
                              invalidHost
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .hostDialogErrorInvalidHost,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                  : const SizedBox.shrink(),
                              invalidUrl
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .hostDialogErrorInvalidUrl,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 8),
                              TextField(
                                  controller: hostInputController,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                      hintText: "http://example.com:8080"))
                            ]),
                  actions: [
                    !force
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                AppLocalizations.of(context)!.hostDialogCancel))
                        : const SizedBox.shrink(),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                            invalidUrl = false;
                            invalidHost = false;
                          });
                          var tmpHost = hostInputController.text
                              .trim()
                              .removeSuffix("/")
                              .trim();

                          if (tmpHost.isEmpty) {
                            setState(() {
                              loading = false;
                            });
                            return;
                          }

                          var url = Uri.parse(tmpHost);
                          if (!url.isAbsolute) {
                            setState(() {
                              invalidUrl = true;
                              loading = false;
                            });
                            return;
                          }

                          http.Response request;
                          try {
                            request = await http.get(url).timeout(
                                const Duration(seconds: 5), onTimeout: () {
                              return http.Response('Error', 408);
                            });
                          } catch (e) {
                            invalidHost = true;
                            loading = false;
                            setState(() {});
                            return;
                          }
                          if (request.statusCode != 200 ||
                              request.body != "Ollama is running") {
                            setState(() {
                              invalidHost = true;
                              loading = false;
                            });
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            messages = [];
                            setState(() {});
                            host = tmpHost;
                            prefs?.setString("host", host!);
                          }
                        },
                        child:
                            Text(AppLocalizations.of(context)!.hostDialogSave))
                  ]))));
}

void setModel(BuildContext context, Function setState) {
  List<String> models = [];
  List<bool> modal = [];
  int usedIndex = -1;
  int addIndex = -1;
  bool loaded = false;
  Function? setModalState;
  void load() async {
    var list = await llama.OllamaClient(baseUrl: "$host/api").listModels();
    for (var i = 0; i < list.models!.length; i++) {
      models.add(list.models![i].model!.split(":")[0]);
      modal.add((list.models![i].details!.families ?? []).contains("clip"));
    }
    addIndex = models.length;
    // ignore: use_build_context_synchronously
    models.add(AppLocalizations.of(context)!.modelDialogAddModel);
    modal.add(false);
    for (var i = 0; i < models.length; i++) {
      if (models[i] == model) {
        usedIndex = i;
      }
    }
    loaded = true;
    setModalState!(() {});
  }

  load();

  if (useModel) return;
  HapticFeedback.selectionClick();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          setModalState = setLocalState;
          return PopScope(
              canPop: loaded,
              onPopInvoked: (didPop) {
                if (usedIndex >= 0 && models[usedIndex] != model) {
                  messages = [];
                }
                model = (usedIndex >= 0) ? models[usedIndex] : null;
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
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: (!loaded)
                      ? const LinearProgressIndicator()
                      : Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.4),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Wrap(
                                    spacing: 5.0,
                                    alignment: WrapAlignment.center,
                                    children: List<Widget>.generate(
                                      models.length,
                                      (int index) {
                                        return ChoiceChip(
                                          label: Text(models[index]),
                                          selected: usedIndex == index,
                                          avatar: (addIndex == index)
                                              ? const Icon(Icons.add_rounded)
                                              : ((recommendedModels
                                                      .contains(models[index]))
                                                  ? const Icon(
                                                      Icons.star_rounded)
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
                                                  : (themeDark ??
                                                          ThemeData.dark())
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
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                right: 16,
                                                                top: 16),
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .modelDialogAddSteps));
                                                  });
                                            }
                                            if (!chatAllowed) return;
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
      });
}

void deleteChat(BuildContext context, Function setState) {
  if (prefs!.getBool("askBeforeDeletion") ?? true && messages.isNotEmpty) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setLocalState) {
            return AlertDialog(
                title: Text(AppLocalizations.of(context)!.deleteDialogTitle),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(AppLocalizations.of(context)!.deleteDialogDescription),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!
                            .deleteDialogAskAlways),
                        const Expanded(child: SizedBox()),
                        Switch(
                          value: prefs!.getBool("askBeforeDeletion") ?? true,
                          onChanged: (value) {
                            prefs!.setBool("askBeforeDeletion", value);
                            setLocalState(() {});
                          },
                        )
                      ])
                ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          AppLocalizations.of(context)!.deleteDialogCancel)),
                  TextButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.of(context).pop();
                        messages = [];
                        setState(() {});
                      },
                      child: Text(
                          AppLocalizations.of(context)!.deleteDialogDelete))
                ]);
          });
        });
  } else {
    messages = [];
    setState(() {});
  }
}

void setAskBeforeDeletion(BuildContext context, Function setState) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          return Dialog(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!
                            .deleteDialogAskAlways),
                        const Expanded(child: SizedBox()),
                        Switch(
                          value: prefs!.getBool("askBeforeDeletion") ?? true,
                          onChanged: (value) {
                            prefs!.setBool("askBeforeDeletion", value);
                            setLocalState(() {});
                          },
                        )
                      ])));
        });
      });
}
