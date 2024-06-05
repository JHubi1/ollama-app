import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'worker_update.dart';
import 'package:ollama_app/worker_setter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart' as http;
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restart_app/restart_app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:version/version.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

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

  final systemInputController = TextEditingController(
      text: prefs?.getString("system") ?? "You are a helpful assistant");

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    checkHost();
    updatesSupported(setState, true);
    if (prefs!.getBool("checkUpdateOnSettingsOpen") ?? false) {
      checkUpdate(setState);
    }
  }

  @override
  void dispose() {
    super.dispose();
    hostInputController.dispose();
  }

  Widget toggle(String text, bool value, Function(bool value) onChanged) {
    var space = "⁣"; // Invisible character: U+2063
    var spacePlus = "    $space";
    return Stack(children: [
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
                height: 40, child: Switch(value: value, onChanged: onChanged)))
      ]),
    ]);
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
                child: ListView(children: [
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  TextField(
                      controller: hostInputController,
                      keyboardType: TextInputType.url,
                      readOnly: useHost,
                      onSubmitted: (value) {
                        HapticFeedback.selectionClick();
                        checkHost();
                      },
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.settingsHost,
                          hintText: "http://localhost:11434",
                          prefixIcon: IconButton(
                              onPressed: () async {
                                HapticFeedback.selectionClick();
                                String tmp = await prompt(context,
                                    placeholder:
                                        "{\"Authorization\": \"Bearer ...\"}",
                                    title: AppLocalizations.of(context)!
                                        .settingsHostHeaderTitle,
                                    value:
                                        (prefs!.getString("hostHeaders") ?? ""),
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
                                      child: const CircularProgressIndicator())
                                  : IconButton(
                                      onPressed: () {
                                        HapticFeedback.selectionClick();
                                        checkHost();
                                      },
                                      icon: const Icon(Icons.save_rounded),
                                    )),
                          border: const OutlineInputBorder(),
                          error: (hostInvalidHost || hostInvalidUrl)
                              ? InkWell(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(AppLocalizations.of(
                                                    context)!
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
                                            AppLocalizations.of(context)!
                                                .settingsHostChecking,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontFamily: "monospace"))
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        const Icon(Icons.check_rounded,
                                            color: Colors.green),
                                        const SizedBox(width: 8),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .settingsHostValid,
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontFamily: "monospace"))
                                      ],
                                    )))),
                  title(AppLocalizations.of(context)!.settingsTitleBehavior,
                      bottom: 24),
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
                  toggle(AppLocalizations.of(context)!.settingsDisableMarkdown,
                      (prefs!.getBool("noMarkdown") ?? false), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("noMarkdown", value);
                    setState(() {});
                  }),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.warning_rounded, color: Colors.grey),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Text(
                            AppLocalizations.of(context)!
                                .settingsBehaviorNotUpdatedForOlderChats,
                            style: const TextStyle(color: Colors.grey)))
                  ]),
                  title(AppLocalizations.of(context)!.settingsTitleInterface),
                  SegmentedButton(
                      segments: const [
                        ButtonSegment(
                            value: "stream",
                            label: Text("Stream"),
                            icon: Icon(Icons.stream_rounded)),
                        ButtonSegment(
                            value: "request",
                            label: Text("Request"),
                            icon: Icon(Icons.send_rounded))
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
                  toggle(AppLocalizations.of(context)!.settingsGenerateTitles,
                      (prefs!.getBool("generateTitles") ?? true), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("generateTitles", value);
                    setState(() {});
                  }),
                  toggle(AppLocalizations.of(context)!.settingsAskBeforeDelete,
                      (prefs!.getBool("askBeforeDeletion") ?? false), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("askBeforeDeletion", value);
                    setState(() {});
                  }),
                  toggle(
                      AppLocalizations.of(context)!.settingsResetOnModelChange,
                      (prefs!.getBool("resetOnModelSelect") ?? true), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("resetOnModelSelect", value);
                    setState(() {});
                  }),
                  toggle(AppLocalizations.of(context)!.settingsEnableEditing,
                      (prefs!.getBool("enableEditing") ?? false), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("enableEditing", value);
                    setState(() {});
                  }),
                  toggle(AppLocalizations.of(context)!.settingsShowTips,
                      (prefs!.getBool("tips") ?? true), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("tips", value);
                    setState(() {});
                  }),
                  toggle(AppLocalizations.of(context)!.settingsShowModelTags,
                      (prefs!.getBool("modelTags") ?? false), (value) {
                    HapticFeedback.selectionClick();
                    prefs!.setBool("modelTags", value);
                    setState(() {});
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
                                              Text(AppLocalizations.of(context)!
                                                  .settingsBrightnessRestartDescription),
                                            ]),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                HapticFeedback.selectionClick();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(AppLocalizations.of(
                                                      context)!
                                                  .settingsBrightnessRestartCancel)),
                                          TextButton(
                                              onPressed: () async {
                                                HapticFeedback.selectionClick();
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
                  title(AppLocalizations.of(context)!.settingsTitleExport),
                  InkWell(
                      onTap: () async {
                        var path = await FilePicker.platform.saveFile(
                            type: FileType.custom,
                            allowedExtensions: ["json"],
                            fileName:
                                "ollama-export-${DateFormat('yyyy-MM-dd-H-m-s').format(DateTime.now())}.json",
                            bytes: utf8.encode(jsonEncode(
                                prefs!.getStringList("chats") ?? [])));
                        if (path == null) return;
                        if (Platform.isWindows ||
                            Platform.isLinux ||
                            Platform.isMacOS) {
                          File(path).writeAsString(
                              jsonEncode(prefs!.getStringList("chats") ?? []));
                        }
                      },
                      child: Row(children: [
                        const Icon(Icons.upload_rounded),
                        const SizedBox(width: 16, height: 42),
                        Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .settingsExportChats))
                      ])),
                  InkWell(
                      onTap: () {
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
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .settingsImportChatsCancel)),
                                    TextButton(
                                        onPressed: () async {
                                          HapticFeedback.selectionClick();
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

                                          File file =
                                              File(result.files.single.path!);
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

                                          prefs!
                                              .setStringList("chats", history);

                                          messages = [];
                                          chatUuid = null;

                                          setState(() {});

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
                      },
                      child: Row(children: [
                        const Icon(Icons.download_rounded),
                        const SizedBox(width: 16, height: 42),
                        Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .settingsImportChats))
                      ])),
                  title(AppLocalizations.of(context)!.settingsTitleContact),
                  (updateStatus == "notAvailable")
                      ? const SizedBox.shrink()
                      : InkWell(
                          onTap: () {
                            if (updateLoading) return;
                            if ((Version.parse(latestVersion ?? "1.0.0") >
                                    Version.parse(currentVersion ?? "2.0.0")) &&
                                (updateStatus == "ok")) {
                              updateDialog(context, title);
                            } else {
                              checkUpdate(setState);
                              return;
                            }
                          },
                          child: Row(children: [
                            updateLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Transform.scale(
                                        scale: 0.5,
                                        child:
                                            const CircularProgressIndicator()),
                                  )
                                : Icon((updateStatus != "ok")
                                    ? Icons.warning_rounded
                                    : (Version.parse(latestVersion ?? "1.0.0") >
                                            Version.parse(
                                                currentVersion ?? "2.0.0"))
                                        ? Icons.info_outline_rounded
                                        : Icons.update_rounded),
                            const SizedBox(width: 16, height: 42),
                            Expanded(
                                child: Text(!updateChecked
                                    ? AppLocalizations.of(context)!
                                        .settingsUpdateCheck
                                    : updateLoading
                                        ? AppLocalizations.of(context)!
                                            .settingsUpdateChecking
                                        : (updateStatus == "rateLimit")
                                            ? AppLocalizations.of(context)!
                                                .settingsUpdateRateLimit
                                            : (updateStatus != "ok")
                                                ? AppLocalizations.of(context)!
                                                    .settingsUpdateIssue
                                                : (Version.parse(
                                                            latestVersion ??
                                                                "1.0.0") >
                                                        Version.parse(
                                                            currentVersion ??
                                                                "2.0.0"))
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .settingsUpdateAvailable(
                                                            latestVersion!)
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .settingsUpdateLatest))
                          ])),
                  (updateStatus == "notAvailable")
                      ? const SizedBox.shrink()
                      : toggle(
                          AppLocalizations.of(context)!.settingsCheckForUpdates,
                          (prefs!.getBool("checkUpdateOnSettingsOpen") ??
                              false), (value) {
                          HapticFeedback.selectionClick();
                          prefs!.setBool("checkUpdateOnSettingsOpen", value);
                          setState(() {});
                        }),
                  InkWell(
                      onTap: () {
                        launchUrl(
                            mode: LaunchMode.inAppBrowserView,
                            Uri.parse(repoUrl));
                      },
                      child: Row(children: [
                        const Icon(SimpleIcons.github),
                        const SizedBox(width: 16, height: 42),
                        Expanded(
                            child: Text(
                                AppLocalizations.of(context)!.settingsGithub))
                      ])),
                  InkWell(
                      onTap: () {
                        launchUrl(
                            mode: LaunchMode.inAppBrowserView,
                            Uri.parse("$repoUrl/issues"));
                      },
                      child: Row(children: [
                        const Icon(Icons.report_rounded),
                        const SizedBox(width: 16, height: 42),
                        Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .settingsReportIssue))
                      ])),
                  InkWell(
                      onTap: () {
                        launchUrl(
                            mode: LaunchMode.inAppBrowserView,
                            Uri.parse(repoUrl.substring(
                                0, repoUrl.lastIndexOf('/'))));
                      },
                      child: Row(children: [
                        const Icon(Icons.developer_board_rounded),
                        const SizedBox(width: 16, height: 42),
                        Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .settingsMainDeveloper))
                      ])),
                  const SizedBox(height: 16),
                ]))),
      ),
    );
  }
}
