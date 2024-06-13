import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ollama_app/worker/haptic.dart';

import '../main.dart';
// import '../worker/haptic.dart';
import '../screen_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dynamic_color/dynamic_color.dart';

class ScreenSettingsVoice extends StatefulWidget {
  const ScreenSettingsVoice({super.key});

  @override
  State<ScreenSettingsVoice> createState() => _ScreenSettingsVoiceState();
}

class _ScreenSettingsVoiceState extends State<ScreenSettingsVoice> {
  bool permissionLoading = true;
  bool permissionRecord = false;
  bool permissionBluetooth = false;

  Iterable<String> languageOptionIds = [];
  Iterable<String> languageOptions = [];

  @override
  void initState() {
    super.initState();
    void load() async {
      var tmp = await speech.locales();
      languageOptionIds = tmp.map((e) => e.localeId);
      languageOptions = tmp.map((e) => e.name);

      permissionRecord = await Permission.microphone.isGranted;
      permissionBluetooth = await Permission.bluetoothConnect.isGranted;
      permissionLoading = false;
      setState(() {});
    }

    load();
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.settingsTitleVoice)),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    // const SizedBox(height: 16),
                    ((prefs!.getBool("voiceModeEnabled") ?? false) ||
                            permissionLoading ||
                            (permissionBluetooth &&
                                permissionRecord &&
                                voiceSupported))
                        ? const SizedBox.shrink()
                        : button(
                            permissionLoading
                                ? AppLocalizations.of(context)!
                                    .settingsVoicePermissionLoading
                                : (permissionBluetooth && permissionRecord)
                                    ? AppLocalizations.of(context)!
                                        .settingsVoiceNotSupported
                                    : AppLocalizations.of(context)!
                                        .settingsVoicePermissionNot,
                            Icons.info_rounded, () {
                            if (permissionLoading) return;
                            if (!(permissionBluetooth && permissionRecord)) {
                              void load() async {
                                try {
                                  if (await Permission
                                          .bluetooth.isPermanentlyDenied ||
                                      await Permission
                                          .microphone.isPermanentlyDenied) {
                                    await openAppSettings();
                                  }
                                  permissionRecord = await Permission.microphone
                                      .request()
                                      .isGranted;
                                  permissionBluetooth = await Permission
                                      .bluetoothConnect
                                      .request()
                                      .isGranted;
                                  permissionLoading = false;

                                  if (permissionBluetooth && permissionRecord) {
                                    voiceSupported = await speech.initialize();
                                  }

                                  setState(() {});
                                } catch (_) {
                                  permissionLoading = false;
                                  try {
                                    setState(() {});
                                  } catch (_) {}
                                }
                              }

                              load();
                            }
                          }),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsVoiceEnable,
                        (prefs!.getBool("voiceModeEnabled") ?? false), (value) {
                      selectionHaptic();
                      prefs!.setBool("voiceModeEnabled", value);
                      setState(() {});
                    }, disabled: !voiceSupported),
                    button(
                        ((prefs!.getString("voiceLanguage") ?? "") == "" ||
                                languageOptions.isEmpty)
                            ? AppLocalizations.of(context)!
                                .settingsVoiceNoLanguage
                            : () {
                                for (int i = 0;
                                    i < languageOptionIds.length;
                                    i++) {
                                  if (languageOptionIds.elementAt(i) ==
                                      prefs!.getString("voiceLanguage")) {
                                    return languageOptions.elementAt(i);
                                  }
                                }
                                return "";
                              }(),
                        Icons.language_rounded, () {
                      int usedIndex = -1;
                      Function? setModalState;
                      void load() async {
                        var tmp = await speech.locales();
                        languageOptionIds = tmp.map((e) => e.localeId);
                        languageOptions = tmp.map((e) => e.name);

                        if ((prefs!.getString("voiceLanguage") ?? "") != "") {
                          for (int i = 0; i < languageOptionIds.length; i++) {
                            if (languageOptionIds.elementAt(i) ==
                                (prefs!.getString("voiceLanguage") ?? "")) {
                              usedIndex = i;
                              setModalState!(() {});
                              break;
                            }
                          }
                        }
                      }

                      selectionHaptic();

                      load();

                      showModalBottomSheet(
                          context: context,
                          builder:
                              (context) => StatefulBuilder(
                                      builder: (context, setLocalState) {
                                    setModalState = setLocalState;
                                    return PopScope(
                                        onPopInvoked: (didPop) {
                                          if (usedIndex == -1) return;
                                          prefs!.setString(
                                              "voiceLanguage",
                                              languageOptionIds
                                                  .elementAt(usedIndex));
                                          setState(() {});
                                        },
                                        child: Container(
                                            width: ((Platform.isWindows ||
                                                        Platform.isLinux ||
                                                        Platform.isMacOS) &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width >=
                                                        1000)
                                                ? null
                                                : double.infinity,
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 16,
                                                bottom: (Platform.isWindows ||
                                                        Platform.isLinux ||
                                                        Platform.isMacOS)
                                                    ? 16
                                                    : 0),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      width: ((Platform
                                                                      .isWindows ||
                                                                  Platform
                                                                      .isLinux ||
                                                                  Platform
                                                                      .isMacOS) &&
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >=
                                                                  1000)
                                                          ? 300
                                                          : double.infinity,
                                                      constraints: BoxConstraints(
                                                          maxHeight:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.4),
                                                      child:
                                                          SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Wrap(
                                                                spacing: ((Platform.isWindows ||
                                                                            Platform
                                                                                .isLinux ||
                                                                            Platform
                                                                                .isMacOS) &&
                                                                        MediaQuery.of(context).size.width >=
                                                                            1000)
                                                                    ? 10.0
                                                                    : 5.0,
                                                                runSpacing: (Platform.isWindows ||
                                                                        Platform
                                                                            .isLinux ||
                                                                        Platform
                                                                            .isMacOS)
                                                                    ? (MediaQuery.of(context).size.width >=
                                                                            1000)
                                                                        ? 10.0
                                                                        : 5.0
                                                                    : 0.0,
                                                                alignment:
                                                                    WrapAlignment
                                                                        .center,
                                                                children: List<
                                                                    Widget>.generate(
                                                                  languageOptionIds
                                                                      .length,
                                                                  (int index) {
                                                                    return ChoiceChip(
                                                                      label: Text(
                                                                          languageOptions
                                                                              .elementAt(index)),
                                                                      selected:
                                                                          usedIndex ==
                                                                              index,
                                                                      avatar: (usedIndex ==
                                                                              index)
                                                                          ? null
                                                                          : (languageOptionIds.elementAt(index).startsWith(AppLocalizations.of(context)!.localeName))
                                                                              ? const Icon(Icons.star_rounded)
                                                                              : null,
                                                                      checkmarkColor: (usedIndex ==
                                                                              index)
                                                                          ? ((MediaQuery.of(context).platformBrightness == Brightness.light)
                                                                              ? (theme ?? ThemeData()).colorScheme.secondary
                                                                              : (themeDark ?? ThemeData.dark()).colorScheme.secondary)
                                                                          : null,
                                                                      labelStyle: (usedIndex ==
                                                                              index)
                                                                          ? TextStyle(
                                                                              color: (MediaQuery.of(context).platformBrightness == Brightness.light) ? (theme ?? ThemeData()).colorScheme.secondary : (themeDark ?? ThemeData.dark()).colorScheme.secondary)
                                                                          : null,
                                                                      selectedColor: (MediaQuery.of(context).platformBrightness ==
                                                                              Brightness
                                                                                  .light)
                                                                          ? (theme ?? ThemeData())
                                                                              .colorScheme
                                                                              .primary
                                                                          : (themeDark ?? ThemeData.dark())
                                                                              .colorScheme
                                                                              .primary,
                                                                      onSelected:
                                                                          (bool
                                                                              selected) {
                                                                        selectionHaptic();
                                                                        setLocalState(
                                                                            () {
                                                                          usedIndex = selected
                                                                              ? index
                                                                              : -1;
                                                                        });
                                                                      },
                                                                    );
                                                                  },
                                                                ).toList(),
                                                              )))
                                                ])));
                                  }));
                    },
                        disabled: (!voiceSupported ||
                            !(prefs!.getBool("voiceModeEnabled") ?? false))),
                    titleDivider(),
                    toggle(
                        context,
                        AppLocalizations.of(context)!
                            .settingsVoiceLimitLanguage,
                        (prefs!.getBool("voiceLimitLanguage") ?? true),
                        (value) {
                      selectionHaptic();
                      prefs!.setBool("voiceLimitLanguage", value);
                      setState(() {});
                    },
                        disabled: (!voiceSupported ||
                            !(prefs!.getBool("voiceModeEnabled") ?? false))),
                    toggle(
                        context,
                        AppLocalizations.of(context)!.settingsVoicePunctuation,
                        (prefs!.getBool("aiPunctuation") ?? true), (value) {
                      selectionHaptic();
                      prefs!.setBool("aiPunctuation", value);
                      setState(() {});
                    },
                        disabled: (!voiceSupported ||
                            !(prefs!.getBool("voiceModeEnabled") ?? false)))
                  ]),
                ),
                const SizedBox(height: 16),
                button(
                    AppLocalizations.of(context)!
                        .settingsExperimentalBetaFeature,
                    Icons.warning_rounded,
                    null,
                    color: Colors.orange
                        .harmonizeWith(Theme.of(context).colorScheme.primary),
                    onLongTap: () {
                  selectionHaptic();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .settingsExperimentalBetaDescription),
                      showCloseIcon: true));
                })
              ]))),
    );
  }
}
