import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

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
            actions:
                (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
                    ? [
                        SizedBox(
                            height: 200,
                            child: WindowTitleBarBox(
                                child: Row(
                              children: [
                                SizedBox(
                                    height: 200,
                                    child: MinimizeWindowButton(
                                        animate: true,
                                        colors: WindowButtonColors(
                                            iconNormal: Theme.of(context)
                                                .colorScheme
                                                .primary))),
                                SizedBox(
                                    height: 72,
                                    child: MaximizeWindowButton(
                                        animate: true,
                                        colors: WindowButtonColors(
                                            iconNormal: Theme.of(context)
                                                .colorScheme
                                                .primary))),
                                SizedBox(
                                    height: 72,
                                    child: CloseWindowButton(
                                        animate: true,
                                        colors: WindowButtonColors(
                                            iconNormal: Theme.of(context)
                                                .colorScheme
                                                .primary))),
                              ],
                            )))
                      ]
                    : null,
          ),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    // const SizedBox(height: 16),
                    button(AppLocalizations.of(context)!.settingsExportChats,
                        Icons.upload_rounded, () async {
                      HapticFeedback.selectionClick();
                      var path = await FilePicker.platform.saveFile(
                          type: FileType.custom,
                          allowedExtensions: ["json"],
                          fileName:
                              "ollama-export-${DateFormat('yyyy-MM-dd-H-m-s').format(DateTime.now())}.json",
                          bytes: utf8.encode(
                              jsonEncode(prefs!.getStringList("chats") ?? [])));
                      HapticFeedback.selectionClick();
                      if (path == null) return;
                      if (Platform.isWindows ||
                          Platform.isLinux ||
                          Platform.isMacOS) {
                        File(path).writeAsString(
                            jsonEncode(prefs!.getStringList("chats") ?? []));
                      }
                    }),
                    button(AppLocalizations.of(context)!.settingsImportChats,
                        Icons.download_rounded, () {
                      HapticFeedback.selectionClick();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text(AppLocalizations.of(context)!
                                    .settingsImportChatsTitle),
                                content: Text(AppLocalizations.of(context)!
                                    .settingsImportChatsDescription),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        HapticFeedback.selectionClick();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .settingsImportChatsCancel)),
                                  TextButton(
                                      onPressed: () async {
                                        HapticFeedback.selectionClick();
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ["json"]);
                                        if (result == null) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();
                                          return;
                                        }

                                        File file =
                                            File(result.files.single.path!);
                                        var content = await file.readAsString();
                                        List<dynamic> tmpHistory =
                                            jsonDecode(content);
                                        List<String> history = [];

                                        for (var i = 0;
                                            i < tmpHistory.length;
                                            i++) {
                                          history.add(tmpHistory[i]);
                                        }

                                        prefs!.setStringList("chats", history);

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
                                      child: Text(AppLocalizations.of(context)!
                                          .settingsImportChatsImport))
                                ]);
                          });
                    })
                  ]),
                ),
                const SizedBox(height: 16),
                button(AppLocalizations.of(context)!.settingsExportInfo,
                    Icons.info_rounded, null,
                    color: Colors.grey),
                button(AppLocalizations.of(context)!.settingsExportWarning,
                    Icons.warning_rounded, null,
                    color: Colors.orange)
              ]))),
    );
  }
}
