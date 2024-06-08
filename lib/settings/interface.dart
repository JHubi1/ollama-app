import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:restart_app/restart_app.dart';

class ScreenSettingsInterface extends StatefulWidget {
  const ScreenSettingsInterface({super.key});

  @override
  State<ScreenSettingsInterface> createState() =>
      _ScreenSettingsInterfaceState();
}

class _ScreenSettingsInterfaceState extends State<ScreenSettingsInterface> {
  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              Text(AppLocalizations.of(context)!.settingsTitleInterface),
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
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsShowModelTags,
                        (prefs!.getBool("modelTags") ?? false), (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("modelTags", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsResetOnModelChange,
                        (prefs!.getBool("resetOnModelSelect") ?? true),
                        (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("resetOnModelSelect", value);
                      setState(() {});
                    }),
                    titleDivider(),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsGenerateTitles,
                        (prefs!.getBool("generateTitles") ?? true), (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("generateTitles", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsEnableEditing,
                        (prefs!.getBool("enableEditing") ?? true), (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("enableEditing", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsAskBeforeDelete,
                        (prefs!.getBool("askBeforeDeletion") ?? false),
                        (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("askBeforeDeletion", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsShowTips,
                        (prefs!.getBool("tips") ?? true), (value) {
                      HapticFeedback.selectionClick();
                      prefs!.setBool("tips", value);
                      setState(() {});
                    }),
                    titleDivider(bottom: 20),
                    SegmentedButton(
                        segments: [
                          ButtonSegment(
                              value: "stream",
                              label: Text(AppLocalizations.of(context)!
                                  .settingsRequestTypeStream),
                              icon: const Icon(Icons.stream_rounded)),
                          ButtonSegment(
                              value: "request",
                              label: Text(AppLocalizations.of(context)!
                                  .settingsRequestTypeRequest),
                              icon: const Icon(Icons.send_rounded))
                        ],
                        selected: {
                          prefs!.getString("requestType") ?? "stream"
                        },
                        onSelectionChanged: (p0) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            prefs!.setString("requestType", p0.elementAt(0));
                          });
                        }),
                    const SizedBox(height: 16),
                    SegmentedButton(
                        segments: [
                          ButtonSegment(
                              value: "dark",
                              label: Text(AppLocalizations.of(context)!
                                  .settingsBrightnessDark),
                              icon: const Icon(Icons.brightness_4_rounded)),
                          ButtonSegment(
                              value: "system",
                              label: Text(AppLocalizations.of(context)!
                                  .settingsBrightnessSystem),
                              icon: const Icon(Icons.brightness_auto_rounded)),
                          ButtonSegment(
                              value: "light",
                              label: Text(AppLocalizations.of(context)!
                                  .settingsBrightnessLight),
                              icon: const Icon(Icons.brightness_high_rounded))
                        ],
                        selected: {
                          prefs!.getString("brightness") ?? "system"
                        },
                        onSelectionChanged: (p0) {
                          HapticFeedback.selectionClick();
                          var tmp = prefs!.getString("brightness") ?? "system";
                          prefs!.setString("brightness", p0.elementAt(0));
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setLocalState) {
                                  return PopScope(
                                      onPopInvoked: (didPop) {
                                        prefs!.setString("brightness", tmp);
                                        setState(() {});
                                      },
                                      child: AlertDialog(
                                          title: Text(AppLocalizations.of(
                                                  context)!
                                              .settingsBrightnessRestartTitle),
                                          content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(AppLocalizations.of(
                                                        context)!
                                                    .settingsBrightnessRestartDescription),
                                              ]),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .settingsBrightnessRestartCancel)),
                                            TextButton(
                                                onPressed: () async {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  await prefs!.setString(
                                                      "brightness",
                                                      p0.elementAt(0));
                                                  if (Platform.isWindows ||
                                                      Platform.isLinux ||
                                                      Platform.isMacOS) {
                                                    exit(0);
                                                  } else {
                                                    Restart.restartApp();
                                                  }
                                                },
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .settingsBrightnessRestartRestart))
                                          ]));
                                });
                              });
                        }),
                  ]),
                ),
                const SizedBox(height: 16)
              ]))),
    );
  }
}
