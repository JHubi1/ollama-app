import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../worker/haptic.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:restart_app/restart_app.dart';
import 'package:duration_picker/duration_picker.dart';

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
                      selectionHaptic();
                      prefs!.setBool("modelTags", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsResetOnModelChange,
                        (prefs!.getBool("resetOnModelSelect") ?? true),
                        (value) {
                      selectionHaptic();
                      prefs!.setBool("resetOnModelSelect", value);
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
                          selectionHaptic();
                          setState(() {
                            prefs!.setString("requestType", p0.elementAt(0));
                          });
                        }),
                    const SizedBox(height: 16),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsGenerateTitles,
                        (prefs!.getBool("generateTitles") ?? true), (value) {
                      selectionHaptic();
                      prefs!.setBool("generateTitles", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsEnableEditing,
                        (prefs!.getBool("enableEditing") ?? true), (value) {
                      selectionHaptic();
                      prefs!.setBool("enableEditing", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsAskBeforeDelete,
                        (prefs!.getBool("askBeforeDeletion") ?? false),
                        (value) {
                      selectionHaptic();
                      prefs!.setBool("askBeforeDeletion", value);
                      setState(() {});
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsShowTips,
                        (prefs!.getBool("tips") ?? true), (value) {
                      selectionHaptic();
                      prefs!.setBool("tips", value);
                      setState(() {});
                    }),
                    titleDivider(),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsKeepModelLoadedAlways,
                        int.parse(prefs!.getString("keepAlive") ?? "300") == -1,
                        (value) {
                      setState(() {
                        if (value) {
                          prefs!.setString("keepAlive", "-1");
                        } else {
                          prefs!.setString("keepAlive", "300");
                        }
                      });
                    }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsKeepModelLoadedNever,
                        int.parse(prefs!.getString("keepAlive") ?? "300") == 0,
                        (value) {
                      setState(() {
                        if (value) {
                          prefs!.setString("keepAlive", "0");
                        } else {
                          prefs!.setString("keepAlive", "300");
                        }
                      });
                    }),
                    button(
                        (int.parse(prefs!.getString("keepAlive") ?? "300") > 0)
                            ? AppLocalizations.of(context)!
                                .settingsKeepModelLoadedSet((int.parse(
                                            prefs!.getString("keepAlive") ??
                                                "300") ~/
                                        60)
                                    .toString())
                            : AppLocalizations.of(context)!
                                .settingsKeepModelLoadedFor,
                        Icons.snooze_rounded, () async {
                      bool loaded = false;
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                alignment: (Platform.isWindows ||
                                        Platform.isLinux ||
                                        Platform.isMacOS)
                                    ? null
                                    : Alignment.bottomRight,
                                child: StatefulBuilder(
                                    builder: (context, setLocalState) {
                                  if (int.parse(prefs!.getString("keepAlive") ??
                                              "0") <=
                                          0 &&
                                      loaded == false) {
                                    prefs!.setString("keepAlive", "0");
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      setLocalState(() {});
                                      void load() async {
                                        try {
                                          while (int.parse(prefs!
                                                  .getString("keepAlive")!) <
                                              300) {
                                            await Future.delayed(const Duration(
                                                milliseconds: 5));
                                            prefs!.setString(
                                                "keepAlive",
                                                (int.parse(prefs!.getString(
                                                            "keepAlive")!) +
                                                        30)
                                                    .toString());
                                            setLocalState(() {});
                                            setState(() {});
                                          }
                                          prefs!.setString("keepAlive", "300");
                                          loaded = true;
                                        } catch (_) {
                                          prefs!.setString("keepAlive", "300");
                                          loaded = true;
                                        }
                                      }

                                      load();
                                    });
                                  } else {
                                    loaded = true;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Theme(
                                      data: ThemeData.from(
                                          colorScheme: ColorScheme.fromSeed(
                                              seedColor: Colors.black)),
                                      child: DurationPicker(
                                          duration: Duration(
                                              seconds: int.parse(prefs!
                                                      .getString("keepAlive") ??
                                                  "300")),
                                          baseUnit: BaseUnit.minute,
                                          lowerBound:
                                              const Duration(minutes: 1),
                                          upperBound:
                                              const Duration(minutes: 60),
                                          onChange: (value) {
                                            if (!loaded) return;
                                            if (value.inSeconds == 0) return;
                                            prefs!.setString("keepAlive",
                                                value.inSeconds.toString());
                                            setLocalState(() {});
                                            setState(() {});
                                          }),
                                    ),
                                  );
                                }));
                          });
                    }),
                    titleDivider(),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsEnableHapticFeedback,
                        (prefs!.getBool("enableHaptic") ?? true), (value) {
                      prefs!.setBool("enableHaptic", value);
                      selectionHaptic();
                      setState(() {});
                    }),
                    (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
                        ? toggle(
                            context,
                            AppLocalizations.of(context)!
                                .settingsMaximizeOnStart,
                            (prefs!.getBool("maximizeOnStart") ?? false),
                            (value) {
                            selectionHaptic();
                            prefs!.setBool("maximizeOnStart", value);
                            setState(() {});
                          })
                        : const SizedBox.shrink(),
                    const SizedBox(height: 8),
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
                          selectionHaptic();
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
                    const SizedBox(height: 16)
                  ]),
                )
              ]))),
    );
  }
}
