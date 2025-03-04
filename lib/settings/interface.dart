import 'package:flutter/material.dart';

import '../main.dart';
import '../worker/haptic.dart';
import '../worker/desktop.dart';
import '../worker/theme.dart';
import '../screen_settings.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dartx/dartx.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenSettingsInterface extends StatefulWidget {
  const ScreenSettingsInterface({super.key});

  @override
  State<ScreenSettingsInterface> createState() =>
      _ScreenSettingsInterfaceState();
}

String secondsBeautify(double seconds) {
  String? endString;
  int? endMinutes;
  int? endSeconds;

  if (seconds > 60) {
    endSeconds = seconds.toInt() % 60;
    endMinutes = (seconds - endSeconds) ~/ 60;

    endString = "${endMinutes}m";
    if (endSeconds > 0) {
      endString += " ${endSeconds}s";
    }
    return "($endString)";
  } else {
    return "";
  }
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
              actions: desktopControlsActions(context)),
          body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(children: [
                  Expanded(
                    child: ListView(children: [
                      // const SizedBox(height: 8),
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
                          AppLocalizations.of(context)!.settingsPreloadModels,
                          (prefs!.getBool("preloadModel") ?? true), (value) {
                        selectionHaptic();
                        prefs!.setBool("preloadModel", value);
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
                      titleDivider(
                          bottom: desktopLayoutNotRequired(context) ? 38 : 20,
                          context: context),
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
                      titleDivider(context: context),
                      toggle(
                          context,
                          AppLocalizations.of(context)!
                              .settingsKeepModelLoadedAlways,
                          int.parse(prefs!.getString("keepAlive") ?? "300") ==
                              -1, (value) {
                        selectionHaptic();
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
                          int.parse(prefs!.getString("keepAlive") ?? "300") ==
                              0, (value) {
                        selectionHaptic();
                        setState(() {
                          if (value) {
                            prefs!.setString("keepAlive", "0");
                          } else {
                            prefs!.setString("keepAlive", "300");
                          }
                        });
                      }),
                      button(
                          (int.parse(prefs!.getString("keepAlive") ?? "300") >
                                  0)
                              ? AppLocalizations.of(context)!
                                  .settingsKeepModelLoadedSet((int.parse(
                                              prefs!.getString("keepAlive") ??
                                                  "300") ~/
                                          60)
                                      .toString())
                              : AppLocalizations.of(context)!
                                  .settingsKeepModelLoadedFor,
                          Icons.snooze_rounded, () async {
                        selectionHaptic();
                        bool loaded = false;
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  alignment: desktopLayout(context)
                                      ? null
                                      : Alignment.bottomRight,
                                  child: StatefulBuilder(
                                      builder: (context, setLocalState) {
                                    if (int.parse(
                                                prefs!.getString("keepAlive") ??
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
                                              await Future.delayed(
                                                  const Duration(
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
                                            prefs!
                                                .setString("keepAlive", "300");
                                            loaded = true;
                                          } catch (_) {
                                            prefs!
                                                .setString("keepAlive", "300");
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
                                        data: (prefs?.getBool(
                                                    "useDeviceTheme") ??
                                                false)
                                            ? Theme.of(context)
                                            : ThemeData.from(
                                                colorScheme:
                                                    ColorScheme.fromSeed(
                                                        seedColor: Colors.black,
                                                        brightness:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .brightness)),
                                        child: DurationPicker(
                                            duration: Duration(
                                                seconds: int.parse(prefs!
                                                        .getString(
                                                            "keepAlive") ??
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
                      titleDivider(context: context),
                      button(
                          AppLocalizations.of(context)!
                              .settingsTimeoutMultiplier,
                          Icons.info_rounded,
                          null,
                          iconAfterwards: true,
                          context: context,
                          alwaysMobileDescription: true,
                          description:
                              "\n${AppLocalizations.of(context)!.settingsTimeoutMultiplierDescription}"),
                      Slider(
                          value: (prefs!.getDouble("timeoutMultiplier") ?? 1),
                          min: 0.5,
                          divisions: 19,
                          max: 10,
                          label: (prefs!.getDouble("timeoutMultiplier") ?? 1)
                              .toString()
                              .removeSuffix(".0"),
                          onChanged: (value) {
                            selectionHaptic();
                            prefs!.setDouble("timeoutMultiplier", value);
                            setState(() {});
                          }),
                      button(
                          AppLocalizations.of(context)!
                              .settingsTimeoutMultiplierExample,
                          Icons.calculate_rounded,
                          null,
                          onlyDesktopDescription: false,
                          // making it complicated because web is weird and doesn't like to round numbers
                          description: "\n${() {
                            var value =
                                (prefs!.getDouble("timeoutMultiplier") ?? 1);
                            if (value == 10) {
                              return "${value.round()}.";
                            } else {
                              if (!value.toString().contains(".")) {
                                return "${value.toString()}.0";
                              }
                              return value;
                            }
                          }.call()} x 30s = ${((prefs!.getDouble("timeoutMultiplier") ?? 1) * 30).round()}s ${secondsBeautify((prefs!.getDouble("timeoutMultiplier") ?? 1) * 30)}"),
                      titleDivider(context: context),
                      toggle(
                          context,
                          AppLocalizations.of(context)!
                              .settingsEnableHapticFeedback,
                          (prefs!.getBool("enableHaptic") ?? true), (value) {
                        prefs!.setBool("enableHaptic", value);
                        selectionHaptic();
                        setState(() {});
                      }),
                      desktopFeature()
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
                                icon:
                                    const Icon(Icons.brightness_auto_rounded)),
                            ButtonSegment(
                                value: "light",
                                label: Text(AppLocalizations.of(context)!
                                    .settingsBrightnessLight),
                                icon: const Icon(Icons.brightness_high_rounded))
                          ],
                          selected: {
                            prefs!.getString("brightness") ?? "system"
                          },
                          onSelectionChanged: (p0) async {
                            selectionHaptic();
                            await prefs!
                                .setString("brightness", p0.elementAt(0));
                            setMainAppState!(() {});
                            setState(() {});
                          }),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: desktopLayoutNotRequired(context) ? 16 : 8),
                      (colorSchemeLight != null && colorSchemeDark != null)
                          ? SegmentedButton(
                              segments: [
                                  ButtonSegment(
                                      value: "device",
                                      label: Text(AppLocalizations.of(context)!
                                          .settingsThemeDevice),
                                      icon: const Icon(Icons.devices_rounded)),
                                  ButtonSegment(
                                      value: "ollama",
                                      label: Text(AppLocalizations.of(context)!
                                          .settingsThemeOllama),
                                      icon: const ImageIcon(
                                          AssetImage("assets/logo512.png")))
                                ],
                              selected: {
                                  (prefs?.getBool("useDeviceTheme") ?? false)
                                      ? "device"
                                      : "ollama"
                                },
                              onSelectionChanged: (p0) async {
                                selectionHaptic();
                                await prefs!.setBool("useDeviceTheme",
                                    p0.elementAt(0) == "device");
                                setMainAppState!(() {});
                                setState(() {});
                              })
                          : const SizedBox.shrink(),
                      titleDivider(),
                      button(
                          AppLocalizations.of(context)!.settingsTemporaryFixes,
                          Icons.fast_forward_rounded, () {
                        selectionHaptic();
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                      bottom: desktopLayout(context) ? 16 : 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        button(
                                            AppLocalizations.of(context)!
                                                .settingsTemporaryFixesDescription,
                                            Icons.info_rounded,
                                            null,
                                            color: Colors.grey.harmonizeWith(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        button(
                                            AppLocalizations.of(context)!
                                                .settingsTemporaryFixesInstructions,
                                            Icons.warning_rounded,
                                            null,
                                            color: Colors.orange.harmonizeWith(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        titleDivider(),
                                        // Text(
                                        //     AppLocalizations.of(context)!
                                        //         .settingsTemporaryFixesNoFixes,
                                        //     style: const TextStyle(
                                        //         color: Colors.grey)),
                                        toggle(
                                            context,
                                            "Fixing code block not scrollable",
                                            (prefs!.getBool(
                                                    "fixCodeblockScroll") ??
                                                false), (value) {
                                          selectionHaptic();
                                          prefs!.setBool(
                                              "fixCodeblockScroll", value);
                                          if ((prefs!.getBool(
                                                      "fixCodeblockScroll") ??
                                                  false) ==
                                              false) {
                                            prefs!.remove("fixCodeblockScroll");
                                          }
                                          setState(() {});
                                        }, onLongTap: () {
                                          selectionHaptic();
                                          launchUrl(Uri.parse(
                                              "https://github.com/JHubi1/ollama-app/issues/26"));
                                        }),
                                        const SizedBox(height: 16)
                                      ]),
                                );
                              });
                            });
                      }),
                      const SizedBox(height: 16)
                    ]),
                  )
                ])),
          )),
    );
  }
}
