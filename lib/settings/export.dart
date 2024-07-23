import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';
import '../worker/haptic.dart';
import '../worker/desktop.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_color/dynamic_color.dart';

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
                Text(AppLocalizations.of(context)!.settingsTitleExport),
                Expanded(child: SizedBox(height: 200, child: MoveWindow()))
              ]),
              actions: desktopControlsActions(context)),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    // const SizedBox(height: 8),
                    button(AppLocalizations.of(context)!.settingsExportChats,
                        Icons.upload_rounded, () async {
                      selectionHaptic();
                      var path = await FilePicker.platform.saveFile(
                          type: FileType.custom,
                          allowedExtensions: ["json"],
                          fileName:
                              "ollama-export-${DateFormat('yyyy-MM-dd-H-m-s').format(DateTime.now())}.json",
                          bytes: utf8.encode(
                              jsonEncode(prefs!.getStringList("chats") ?? [])));
                      selectionHaptic();
                      if (path == null) return;
                      if (desktopFeature()) {
                        File(path).writeAsString(
                            jsonEncode(prefs!.getStringList("chats") ?? []));
                      }
                    }),
                    allowMultipleChats
                        ? button(
                            AppLocalizations.of(context)!.settingsImportChats,
                            Icons.download_rounded, () {
                            selectionHaptic();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(AppLocalizations.of(context)!
                                          .settingsImportChatsTitle),
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .settingsImportChatsDescription),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              selectionHaptic();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(AppLocalizations.of(
                                                    context)!
                                                .settingsImportChatsCancel)),
                                        TextButton(
                                            onPressed: () async {
                                              selectionHaptic();
                                              FilePickerResult? result =
                                                  await FilePicker.platform
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

                                              File file = File(
                                                  result.files.single.path!);
                                              var content =
                                                  await file.readAsString();
                                              List<dynamic> tmpHistory =
                                                  jsonDecode(content);
                                              List<String> history = [];

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
                                                              .of(context)!
                                                          .settingsImportChatsSuccess),
                                                      showCloseIcon: true));
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .settingsImportChatsImport))
                                      ]);
                                });
                          })
                        : const SizedBox.shrink()
                  ]),
                ),
                const SizedBox(height: 8),
                button(AppLocalizations.of(context)!.settingsExportInfo,
                    Icons.info_rounded, null,
                    color: Colors.grey
                        .harmonizeWith(Theme.of(context).colorScheme.primary)),
                button(AppLocalizations.of(context)!.settingsExportWarning,
                    Icons.warning_rounded, null,
                    color: Colors.orange
                        .harmonizeWith(Theme.of(context).colorScheme.primary))
              ]))),
    );
  }
}
