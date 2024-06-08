import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'package:ollama_app/worker_setter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings/behavior.dart';
import 'settings/interface.dart';
import 'settings/export.dart';
import 'settings/about.dart';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart' as http;
import 'package:bitsdojo_window/bitsdojo_window.dart';

Widget toggle(BuildContext context, String text, bool value,
    Function(bool value) onChanged) {
  var space = "⁣"; // Invisible character: U+2063
  var spacePlus = "    $space";
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: () {
      onChanged(!value);
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Stack(children: [
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            child: Divider(
                color: (Theme.of(context).brightness == Brightness.light)
                    ? Colors.grey[300]
                    : Colors.grey[900])),
        Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: Text(text + spacePlus,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      backgroundColor:
                          (Theme.of(context).brightness == Brightness.light)
                              ? (theme ?? ThemeData()).colorScheme.surface
                              : (themeDark ?? ThemeData.dark())
                                  .colorScheme
                                  .surface))),
          Container(
              padding: const EdgeInsets.only(left: 16),
              color: (Theme.of(context).brightness == Brightness.light)
                  ? (theme ?? ThemeData()).colorScheme.surface
                  : (themeDark ?? ThemeData.dark()).colorScheme.surface,
              child: SizedBox(
                  height: 40,
                  child: Switch(value: value, onChanged: onChanged)))
        ]),
      ]),
    ),
  );
}

Widget title(String text, {double top = 16, double bottom = 16}) {
  return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: top, bottom: bottom),
      child: Row(children: [
        const Expanded(child: Divider()),
        Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Text(text)),
        const Expanded(child: Divider())
      ]));
}

Widget titleDivider({double top = 16, double bottom = 16}) {
  return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: top, bottom: bottom),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Divider()),
        ],
      ));
}

Widget button(String text, IconData icon, void Function()? onPressed,
    {Color? color}) {
  return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          Icon(icon, color: color),
          const SizedBox(width: 16, height: 42),
          Expanded(child: Text(text, style: TextStyle(color: color)))
        ]),
      ));
}

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  final hostInputController = TextEditingController(
      text: (useHost)
          ? fixedHost
          : (prefs?.getString("host") ?? "http://localhost:11434"));
  bool hostLoading = false;
  bool hostInvalidUrl = false;
  bool hostInvalidHost = false;
  void checkHost() async {
    setState(() {
      hostLoading = true;
      hostInvalidUrl = false;
      hostInvalidHost = false;
    });
    var tmpHost = hostInputController.text.trim().removeSuffix("/").trim();

    if (tmpHost.isEmpty || !Uri.parse(tmpHost).isAbsolute) {
      setState(() {
        hostInvalidUrl = true;
        hostLoading = false;
      });
      return;
    }

    http.Response request;
    try {
      request = await http
          .get(
        Uri.parse(tmpHost),
        headers: (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
            .cast<String, String>(),
      )
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return http.Response("Error", 408);
      });
    } catch (e) {
      setState(() {
        hostInvalidHost = true;
        hostLoading = false;
      });
      return;
    }
    if ((request.statusCode == 200 && request.body == "Ollama is running") ||
        (Uri.parse(tmpHost).toString() == fixedHost)) {
      setState(() {
        hostLoading = false;
        host = tmpHost;
        if (hostInputController.text != host!) {
          hostInputController.text = host!;
        }
      });
      prefs?.setString("host", host!);
    } else {
      setState(() {
        hostInvalidHost = true;
        hostLoading = false;
      });
    }
    HapticFeedback.selectionClick();
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    checkHost();
  }

  @override
  void dispose() {
    super.dispose();
    hostInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: !hostLoading,
        onPopInvoked: (didPop) {
          settingsOpen = false;
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WindowBorder(
            color: Theme.of(context).colorScheme.surface,
            child: Scaffold(
                appBar: AppBar(
                  title: Row(children: [
                    Text(AppLocalizations.of(context)!.optionSettings),
                    Expanded(child: SizedBox(height: 200, child: MoveWindow()))
                  ]),
                  actions: (Platform.isWindows ||
                          Platform.isLinux ||
                          Platform.isMacOS)
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
                              controller: hostInputController,
                              keyboardType: TextInputType.url,
                              readOnly: useHost,
                              onSubmitted: (value) {
                                HapticFeedback.selectionClick();
                                checkHost();
                              },
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .settingsHost,
                                  hintText: "http://localhost:11434",
                                  prefixIcon: IconButton(
                                      onPressed: () async {
                                        HapticFeedback.selectionClick();
                                        String tmp = await prompt(context,
                                            placeholder:
                                                "{\"Authorization\": \"Bearer ...\"}",
                                            title: AppLocalizations.of(context)!
                                                .settingsHostHeaderTitle,
                                            value: (prefs!
                                                    .getString("hostHeaders") ??
                                                ""),
                                            valueIfCanceled: "{}",
                                            validator: (content) async {
                                          try {
                                            var tmp = jsonDecode(content);
                                            tmp as Map<String, dynamic>;
                                            return true;
                                          } catch (_) {
                                            return false;
                                          }
                                        },
                                            validatorError:
                                                AppLocalizations.of(context)!
                                                    .settingsHostHeaderInvalid);
                                        prefs!.setString("hostHeaders", tmp);
                                      },
                                      icon: const Icon(Icons.add_rounded)),
                                  suffixIcon: useHost
                                      ? const SizedBox.shrink()
                                      : (hostLoading
                                          ? Transform.scale(
                                              scale: 0.5,
                                              child:
                                                  const CircularProgressIndicator())
                                          : IconButton(
                                              onPressed: () {
                                                HapticFeedback.selectionClick();
                                                checkHost();
                                              },
                                              icon: const Icon(
                                                  Icons.save_rounded),
                                            )),
                                  border: const OutlineInputBorder(),
                                  error: (hostInvalidHost || hostInvalidUrl)
                                      ? InkWell(
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(AppLocalizations
                                                            .of(context)!
                                                        .settingsHostInvalidDetailed(
                                                            hostInvalidHost
                                                                ? "host"
                                                                : "url")),
                                                    showCloseIcon: true));
                                          },
                                          highlightColor: Colors.transparent,
                                          splashFactory: NoSplash.splashFactory,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.error_rounded,
                                                  color: Colors.red),
                                              const SizedBox(width: 8),
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .settingsHostInvalid(
                                                          hostInvalidHost
                                                              ? "host"
                                                              : "url"),
                                                  style: const TextStyle(
                                                      color: Colors.red))
                                            ],
                                          ))
                                      : null,
                                  helper: InkWell(
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                      },
                                      highlightColor: Colors.transparent,
                                      splashFactory: NoSplash.splashFactory,
                                      child: hostLoading
                                          ? Row(
                                              children: [
                                                const Icon(Icons.search_rounded,
                                                    color: Colors.grey),
                                                const SizedBox(width: 8),
                                                Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .settingsHostChecking,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily:
                                                            "monospace"))
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                const Icon(Icons.check_rounded,
                                                    color: Colors.green),
                                                const SizedBox(width: 8),
                                                Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .settingsHostValid,
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontFamily:
                                                            "monospace"))
                                              ],
                                            )))),
                          titleDivider(bottom: 4),
                          button(
                              AppLocalizations.of(context)!
                                  .settingsTitleBehavior,
                              Icons.psychology_rounded, () {
                            HapticFeedback.selectionClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsBehavior()));
                          }),
                          button(
                              AppLocalizations.of(context)!
                                  .settingsTitleInterface,
                              Icons.web_asset_rounded, () {
                            HapticFeedback.selectionClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsInterface()));
                          }),
                          button(
                              AppLocalizations.of(context)!.settingsTitleExport,
                              Icons.share_rounded, () {
                            HapticFeedback.selectionClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsExport()));
                          }),
                          button(
                              AppLocalizations.of(context)!.settingsTitleAbout,
                              Icons.help_rounded, () {
                            HapticFeedback.selectionClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsAbout()));
                          })
                        ]),
                      ),
                      const SizedBox(height: 16),
                      button(
                          AppLocalizations.of(context)!
                              .settingsSavedAutomatically,
                          Icons.info_rounded,
                          null,
                          color: Colors.grey)
                    ])))));
  }
}
