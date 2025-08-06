import 'dart:convert';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart' as file_selector;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;

import '../../l10n/gen/app_localizations.dart';
import '../../main.dart';
import '../../services/desktop.dart';
import '../../services/haptic.dart';
import '../settings.dart';

class ScreenSettingsExport extends StatefulWidget {
  const ScreenSettingsExport({super.key});

  @override
  State<ScreenSettingsExport> createState() => _ScreenSettingsExportState();
}

class _ScreenSettingsExportState extends State<ScreenSettingsExport> {
  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
              title: Row(children: [
                Text(AppLocalizations.of(context).settingsTitleExport),
                Expanded(child: SizedBox(height: 200, child: MoveWindow()))
              ]),
              actions: desktopControlsActions(context)),
          body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(children: [
                  Expanded(
                    child: ListView(children: [
                      // const SizedBox(height: 8),
                      button(AppLocalizations.of(context).settingsExportChats,
                          Icons.upload_rounded, () async {
                        selectionHaptic();
                        var name =
                            "ollama-export-${DateFormat('yyyy-MM-dd-H-m-s').format(DateTime.now())}.json";
                        var content =
                            jsonEncode(prefs!.getStringList("chats") ?? []);
                        if (kIsWeb) {
                          // web fallback
                          var bytes = utf8.encode(content);
                          var blob = html.Blob([bytes]);
                          var url = html.Url.createObjectUrlFromBlob(blob);
                          var anchor = html.document.createElement("a")
                              as html.AnchorElement
                            ..href = url
                            ..style.display = "none"
                            ..download = name;
                          html.document.body!.children.add(anchor);

                          anchor.click();

                          html.document.body!.children.remove(anchor);
                          html.Url.revokeObjectUrl(url);
                        } else {
                          String? path = "";
                          try {
                            path = (await file_selector
                                    .getSaveLocation(acceptedTypeGroups: [
                              const file_selector.XTypeGroup(
                                  label: "Ollama App File",
                                  extensions: ["json"])
                            ], suggestedName: name))
                                ?.path;
                          } catch (_) {
                            path = await FilePicker.platform.saveFile(
                                type: FileType.custom,
                                allowedExtensions: ["json"],
                                fileName: name,
                                bytes: utf8.encode(jsonEncode(
                                    prefs!.getStringList("chats") ?? [])));
                          }
                          selectionHaptic();
                          if (path == null) return;
                          if (desktopFeature()) {
                            File(path).writeAsString(content);
                          }
                        }
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            // ignore: use_build_context_synchronously
                            content: Text(AppLocalizations.of(context)
                                .settingsExportChatsSuccess),
                            showCloseIcon: true));
                      }),
                      allowMultipleChats
                          ? button(
                              AppLocalizations.of(context).settingsImportChats,
                              Icons.download_rounded, () async {
                              selectionHaptic();
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text(AppLocalizations.of(context)
                                            .settingsImportChatsTitle),
                                        content: Text(AppLocalizations.of(
                                                context)
                                            .settingsImportChatsDescription),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                selectionHaptic();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(AppLocalizations.of(
                                                      context)
                                                  .settingsImportChatsCancel)),
                                          TextButton(
                                              onPressed: () async {
                                                selectionHaptic();
                                                String content;
                                                try {
                                                  if (kIsWeb) {
                                                    throw Exception(
                                                        "web must use file picker");
                                                  }
                                                  var result = await file_selector
                                                      .openFile(
                                                          acceptedTypeGroups: [
                                                        const file_selector
                                                            .XTypeGroup(
                                                            label:
                                                                "Ollama App File",
                                                            extensions: [
                                                              "json"
                                                            ])
                                                      ]);
                                                  if (result == null) {
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.of(context).pop();
                                                    return;
                                                  }
                                                  content = await result
                                                      .readAsString();
                                                } catch (_) {
                                                  var result = await FilePicker
                                                      .platform
                                                      .pickFiles(
                                                          type: FileType.custom,
                                                          allowedExtensions: [
                                                        "json"
                                                      ]);
                                                  if (result == null) {
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.of(context).pop();
                                                    return;
                                                  }
                                                  try {
                                                    var file = File(result
                                                        .files.single.path!);
                                                    content = await file
                                                        .readAsString();
                                                  } catch (_) {
                                                    // web fallback
                                                    content = utf8.decode(result
                                                        .files
                                                        .single
                                                        .bytes! as List<int>);
                                                  }
                                                }
                                                List<dynamic> tmpHistory =
                                                    jsonDecode(content);
                                                var history = <String>[];

                                                for (var i = 0;
                                                    i < tmpHistory.length;
                                                    i++) {
                                                  history.add(tmpHistory[i]);
                                                }

                                                prefs!.setStringList(
                                                    "chats", history);

                                                messages = [];
                                                chatUuid = null;

                                                setState(() {});

                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(AppLocalizations
                                                                // ignore: use_build_context_synchronously
                                                                .of(context)
                                                            .settingsImportChatsSuccess),
                                                        showCloseIcon: true));
                                              },
                                              child: Text(AppLocalizations.of(
                                                      context)
                                                  .settingsImportChatsImport))
                                        ]);
                                  });
                            })
                          : const SizedBox.shrink()
                    ]),
                  ),
                  const SizedBox(height: 8),
                  button(AppLocalizations.of(context).settingsExportInfo,
                      Icons.info_rounded, null,
                      color: Colors.grey.harmonizeWith(
                          Theme.of(context).colorScheme.primary)),
                  button(AppLocalizations.of(context).settingsExportWarning,
                      Icons.warning_rounded, null,
                      color: Colors.orange
                          .harmonizeWith(Theme.of(context).colorScheme.primary))
                ])),
          )),
    );
  }
}
