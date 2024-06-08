import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

class ScreenSettingsBehavior extends StatefulWidget {
  const ScreenSettingsBehavior({super.key});

  @override
  State<ScreenSettingsBehavior> createState() => _ScreenSettingsBehaviorState();
}

class _ScreenSettingsBehaviorState extends State<ScreenSettingsBehavior> {
  final systemInputController = TextEditingController(
      text: prefs?.getString("system") ?? "You are a helpful assistant");

  @override
  void dispose() {
    super.dispose();
    systemInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              Text(AppLocalizations.of(context)!.settingsTitleBehavior),
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
                    const SizedBox(height: 16),
                    TextField(
                        controller: systemInputController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsSystemMessage,
                            hintText: "You are a helpful assistant",
                            suffixIcon: IconButton(
                              onPressed: () {
                                HapticFeedback.selectionClick();
                                prefs?.setString(
                                    "system",
                                    (systemInputController.text.isNotEmpty)
                                        ? systemInputController.text
                                        : "You are a helpful assistant");
                              },
                              icon: const Icon(Icons.save_rounded),
                            ),
                            border: const OutlineInputBorder())),
                    const SizedBox(height: 16),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsDisableMarkdown,
                        (prefs!.getBool("noMarkdown") ?? false), (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("noMarkdown", value);
                      setState(() {});
                    })
                  ]),
                ),
                const SizedBox(height: 16),
                button(
                    AppLocalizations.of(context)!
                        .settingsBehaviorNotUpdatedForOlderChats,
                    Icons.info_rounded,
                    null,
                    color: Colors.grey)
              ]))),
    );
  }
}
