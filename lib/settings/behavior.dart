import 'package:flutter/material.dart';

import '../main.dart';
import '../worker/haptic.dart';
import '../worker/desktop.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dynamic_color/dynamic_color.dart';

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
              actions: desktopControlsActions(context)),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    const SizedBox(height: 8),
                    TextField(
                        controller: systemInputController,
                        keyboardType: TextInputType.multiline,
                        maxLines: desktopLayoutNotRequired(context) ? 5 : 2,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsSystemMessage,
                            hintText: "You are a helpful assistant",
                            suffixIcon: IconButton(
                              tooltip:
                                  AppLocalizations.of(context)!.tooltipSave,
                              onPressed: () {
                                selectionHaptic();
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
                      selectionHaptic();
                      prefs!.setBool("noMarkdown", value);
                      setState(() {});
                    })
                  ]),
                ),
                const SizedBox(height: 8),
                button(
                    AppLocalizations.of(context)!
                        .settingsBehaviorNotUpdatedForOlderChats,
                    Icons.info_rounded,
                    null,
                    color: Colors.grey
                        .harmonizeWith(Theme.of(context).colorScheme.primary))
              ]))),
    );
  }
}
