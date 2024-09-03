import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screen_settings.dart';
import 'screen_voice.dart';
import 'screen_welcome.dart';
import 'worker/setter.dart';
import 'worker/haptic.dart';
import 'worker/sender.dart';
import 'worker/desktop.dart';
import 'worker/theme.dart';
import 'worker/update.dart';

import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

// client configuration

// use host or not, if false dialog is shown
const bool useHost = false;
// host of ollama, must be accessible from the client, without trailing slash
// ! will always be accepted as valid, even if [useHost] is false
const String fixedHost = "http://example.com:11434";
// use model or not, if false selector is shown
const bool useModel = false;
// model name as string, must be valid ollama model!
const String fixedModel = "gemma";
// recommended models, shown with a star in model selector
const List<String> recommendedModels = ["gemma", "llama3"];
// allow opening of settings
const bool allowSettings = true;
// allow multiple chats
const bool allowMultipleChats = true;

// client configuration end

SharedPreferences? prefs;

String? model;
String? host;

bool multimodal = false;

List<types.Message> messages = [];
String? chatUuid;
bool chatAllowed = true;
String hoveredChat = "";

GlobalKey<ChatState>? chatKey;
final user = types.User(id: const Uuid().v4());
final assistant = types.User(id: const Uuid().v4());

bool settingsOpen = false;
bool desktopTitleVisible = true;
bool logoVisible = true;
bool menuVisible = false;
bool sendable = false;
bool updateDetectedOnStart = false;
double sidebarIconSize = 1;

SpeechToText speech = SpeechToText();
FlutterTts voice = FlutterTts();
bool voiceSupported = false;

BuildContext? mainContext;
void Function(void Function())? setGlobalState;
void Function(void Function())? setMainAppState;

void main() {
  runApp(const App());

  if (desktopFeature()) {
    doWhenWindowReady(() {
      appWindow.minSize = const Size(600, 450);
      appWindow.size = const Size(1200, 650);
      appWindow.alignment = Alignment.center;
      if (prefs!.getBool("maximizeOnStart") ?? false) {
        appWindow.maximize();
      }
      appWindow.show();
    });
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    void load() async {
      try {
        await FlutterDisplayMode.setHighRefreshRate();
      } catch (_) {}

      SharedPreferences.setPrefix("ollama.");
      SharedPreferences tmp = await SharedPreferences.getInstance();
      setState(() {
        prefs = tmp;
      });

      try {
        if ((await Permission.bluetoothConnect.isGranted) &&
            (await Permission.microphone.isGranted)) {
          voiceSupported = await speech.initialize();
        } else {
          prefs!.setBool("voiceModeEnabled", false);
          voiceSupported = false;
        }
      } catch (_) {
        prefs!.setBool("voiceModeEnabled", false);
        voiceSupported = false;
      }
    }

    load();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      colorSchemeLight = lightDynamic;
      colorSchemeDark = darkDynamic;
      return StatefulBuilder(builder: (context, setState) {
        setMainAppState = setState;
        return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeListResolutionCallback: (deviceLocales, supportedLocales) {
              if (deviceLocales != null) {
                for (final locale in deviceLocales) {
                  var newLocale = Locale(locale.languageCode);
                  if (supportedLocales.contains(newLocale)) {
                    return locale;
                  }
                }
              }
              return const Locale("en");
            },
            onGenerateTitle: (context) {
              return AppLocalizations.of(context)!.appTitle;
            },
            theme: themeLight(),
            darkTheme: themeDark(),
            themeMode: themeMode(),
            home: const MainApp());
      });
    });
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int tipId = Random().nextInt(5);

  List<Widget> sidebar(BuildContext context, Function setState) {
    var padding = EdgeInsets.only(
        left: desktopLayoutRequired(context) ? 17 : 12,
        right: desktopLayoutRequired(context) ? 17 : 12);
    return List.from([
      desktopFeature() ? const SizedBox(height: 8) : const SizedBox.shrink(),
      desktopLayoutNotRequired(context)
          ? const SizedBox.shrink()
          : (Padding(
              padding: padding,
              child: InkWell(
                  enableFeedback: false,
                  customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onTap: () async {
                    // ester egg? gimmick? not sure if it should be kept
                    return;
                    // ignore: dead_code
                    if (sidebarIconSize != 1) return;
                    setState(() {
                      sidebarIconSize = 0.8;
                    });
                    await Future.delayed(const Duration(milliseconds: 200));
                    setState(() {
                      sidebarIconSize = 1.2;
                    });
                    await Future.delayed(const Duration(milliseconds: 200));
                    setState(() {
                      sidebarIconSize = 1;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 16, right: 12),
                            child: AnimatedScale(
                                scale: sidebarIconSize,
                                duration: const Duration(milliseconds: 400),
                                child: const ImageIcon(
                                    AssetImage("assets/logo512.png")))),
                        Expanded(
                          child: Text(AppLocalizations.of(context)!.appTitle,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 16),
                      ]))))),
      (desktopLayoutNotRequired(context) ||
              (!allowMultipleChats && !allowSettings))
          ? const SizedBox.shrink()
          : Divider(
              color: desktopLayout(context)
                  ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
                  : null),
      (allowMultipleChats)
          ? (Padding(
              padding: padding,
              child: InkWell(
                  enableFeedback: false,
                  customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onTap: () {
                    selectionHaptic();
                    if (!desktopLayout(context)) {
                      Navigator.of(context).pop();
                    }
                    if (!chatAllowed && model != null) return;
                    chatUuid = null;
                    messages = [];
                    setState(() {});
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: Icon(Icons.add_rounded)),
                        Expanded(
                          child: Text(
                              AppLocalizations.of(context)!.optionNewChat,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 16),
                      ])))))
          : const SizedBox.shrink(),
      (allowSettings)
          ? (Padding(
              padding: padding,
              child: InkWell(
                  enableFeedback: false,
                  customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onTap: () {
                    selectionHaptic();
                    if (!desktopLayout(context)) {
                      Navigator.of(context).pop();
                    }
                    setState(() {
                      settingsOpen = true;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenSettings()));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 16, right: 12),
                            child: (updateStatus == "ok" &&
                                    updateDetectedOnStart &&
                                    (Version.parse(latestVersion ?? "1.0.0") >
                                        Version.parse(
                                            currentVersion ?? "2.0.0")))
                                ? const Badge(child: Icon(Icons.dns_rounded))
                                : const Icon(Icons.dns_rounded)),
                        Expanded(
                          child: Text(
                              AppLocalizations.of(context)!.optionSettings,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 16),
                      ])))))
          : const SizedBox.shrink(),
      (desktopLayoutNotRequired(context) &&
              (!allowMultipleChats && !allowSettings))
          ? const SizedBox.shrink()
          : Divider(
              color: desktopLayout(context)
                  ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
                  : null),
      ((prefs?.getStringList("chats") ?? []).isNotEmpty)
          ? const SizedBox.shrink()
          : (Padding(
              padding: padding,
              child: InkWell(
                  enableFeedback: false,
                  customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onTap: () {
                    selectionHaptic();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: Icon(Icons.question_mark_rounded,
                                color: Colors.grey)),
                        Expanded(
                          child: Text(
                              AppLocalizations.of(context)!.optionNoChatFound,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                        const SizedBox(width: 16),
                      ]))))),
      Builder(builder: (context) {
        String tip = (tipId == 0)
            ? AppLocalizations.of(context)!.tip0
            : (tipId == 1)
                ? AppLocalizations.of(context)!.tip1
                : (tipId == 2)
                    ? AppLocalizations.of(context)!.tip2
                    : (tipId == 3)
                        ? AppLocalizations.of(context)!.tip3
                        : AppLocalizations.of(context)!.tip4;
        return (!(prefs?.getBool("tips") ?? true) ||
                (prefs?.getStringList("chats") ?? []).isNotEmpty ||
                !allowSettings)
            ? const SizedBox.shrink()
            : (Padding(
                padding: padding,
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    selectionHaptic();
                    var tmpTip = tipId;
                    while (tmpTip == tipId) {
                      tipId = Random().nextInt(5);
                    }
                    setState(() {});
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: Icon(Icons.tips_and_updates_rounded,
                                color: Colors.grey)),
                        Expanded(
                          child: Text(
                              AppLocalizations.of(context)!.tipPrefix + tip,
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                        const SizedBox(width: 16),
                      ])),
                )));
      }),
    ])
      ..addAll((prefs?.getStringList("chats") ?? []).map((item) {
        var child = Padding(
            padding: padding,
            child: InkWell(
                enableFeedback: false,
                customBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                onTap: () {
                  selectionHaptic();
                  if (!desktopLayoutRequired(context)) {
                    Navigator.of(context).pop();
                  }
                  if (!chatAllowed) return;
                  if (chatUuid == jsonDecode(item)["uuid"]) return;
                  loadChat(jsonDecode(item)["uuid"], setState);
                  chatUuid = jsonDecode(item)["uuid"];
                },
                onHover: (value) {
                  setState(() {
                    if (value) {
                      hoveredChat = jsonDecode(item)["uuid"];
                    } else {
                      hoveredChat = "";
                    }
                  });
                },
                onLongPress: desktopFeature()
                    ? null
                    : () async {
                        selectionHaptic();
                        if (!chatAllowed &&
                            chatUuid == jsonDecode(item)["uuid"]) return;
                        if (!allowSettings) return;
                        String oldTitle = jsonDecode(item)["title"];
                        var newTitle = await prompt(context,
                            title: AppLocalizations.of(context)!
                                .dialogEnterNewTitle,
                            value: oldTitle,
                            uuid: jsonDecode(item)["uuid"]);
                        var tmp = (prefs!.getStringList("chats") ?? []);
                        for (var i = 0; i < tmp.length; i++) {
                          if (jsonDecode((prefs!.getStringList("chats") ??
                                  [])[i])["uuid"] ==
                              jsonDecode(item)["uuid"]) {
                            var tmp2 = jsonDecode(tmp[i]);
                            tmp2["title"] = newTitle;
                            tmp[i] = jsonEncode(tmp2);
                            break;
                          }
                        }
                        prefs!.setStringList("chats", tmp);
                        setState(() {});
                      },
                child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(children: [
                      allowMultipleChats
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Icon((chatUuid == jsonDecode(item)["uuid"])
                                  ? Icons.location_on_rounded
                                  : Icons.restore_rounded))
                          : const SizedBox(width: 16),
                      Expanded(
                        child: Text(jsonDecode(item)["title"],
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          child:
                              ((desktopFeature() &&
                                          (hoveredChat ==
                                              jsonDecode(item)["uuid"])) ||
                                      !allowMultipleChats)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: IconButton(
                                          tooltip: AppLocalizations.of(context)!
                                              .tooltipReset,
                                          onPressed: () {
                                            if (!chatAllowed &&
                                                chatUuid ==
                                                    jsonDecode(item)["uuid"]) {
                                              return;
                                            }
                                            if (!allowMultipleChats) {
                                              for (var i = 0;
                                                  i <
                                                      (prefs!.getStringList(
                                                                  "chats") ??
                                                              [])
                                                          .length;
                                                  i++) {
                                                if (jsonDecode((prefs!
                                                            .getStringList(
                                                                "chats") ??
                                                        [])[i])["uuid"] ==
                                                    jsonDecode(item)["uuid"]) {
                                                  List<String> tmp = prefs!
                                                      .getStringList("chats")!;
                                                  tmp.removeAt(i);
                                                  prefs!.setStringList(
                                                      "chats", tmp);
                                                  break;
                                                }
                                              }
                                              messages = [];
                                              chatUuid = null;
                                              if (!desktopLayoutRequired(
                                                  context)) {
                                                Navigator.of(context).pop();
                                              }
                                              setState(() {});
                                              return;
                                            }
                                            if (!allowSettings) {
                                              deleteChatDialog(
                                                  context, setState,
                                                  additionalCondition: false,
                                                  uuid:
                                                      jsonDecode(item)["uuid"],
                                                  popSidebar: true);
                                              return;
                                            }
                                            if (!desktopLayoutRequired(
                                                context)) {
                                              Navigator.of(context).pop();
                                            }
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              top: 16),
                                                      child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child: OutlinedButton
                                                                    .icon(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          deleteChatDialog(
                                                                              context,
                                                                              setState,
                                                                              uuid: jsonDecode(item)["uuid"],
                                                                              popSidebar: true);
                                                                        },
                                                                        icon: const Icon(Icons
                                                                            .delete_forever_rounded),
                                                                        label: Text(
                                                                            AppLocalizations.of(context)!.deleteChat))),
                                                            const SizedBox(
                                                                height: 8),
                                                            SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child: OutlinedButton
                                                                    .icon(
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          String
                                                                              oldTitle =
                                                                              jsonDecode(item)["title"];
                                                                          var newTitle = await prompt(
                                                                              context,
                                                                              title: AppLocalizations.of(context)!.dialogEnterNewTitle,
                                                                              value: oldTitle,
                                                                              uuid: jsonDecode(item)["uuid"]);
                                                                          var tmp =
                                                                              (prefs!.getStringList("chats") ?? []);
                                                                          for (var i = 0;
                                                                              i < tmp.length;
                                                                              i++) {
                                                                            if (jsonDecode((prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
                                                                                jsonDecode(item)["uuid"]) {
                                                                              var tmp2 = jsonDecode(tmp[i]);
                                                                              tmp2["title"] = newTitle;
                                                                              tmp[i] = jsonEncode(tmp2);
                                                                              break;
                                                                            }
                                                                          }
                                                                          prefs!.setStringList(
                                                                              "chats",
                                                                              tmp);
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        icon: const Icon(Icons
                                                                            .edit_rounded),
                                                                        label: Text(
                                                                            AppLocalizations.of(context)!.renameChat))),
                                                            const SizedBox(
                                                                height: 16)
                                                          ]));
                                                });
                                          },
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          icon: Transform.translate(
                                            offset: const Offset(-8, -8),
                                            // ignore const suggestion, because values could be not const
                                            // ignore: prefer_const_constructors
                                            child: Icon(allowMultipleChats
                                                ? allowSettings
                                                    ? Icons.more_horiz_rounded
                                                    : Icons.close_rounded
                                                : Icons.restart_alt_rounded),
                                          ),
                                        ),
                                      ))
                                  : const SizedBox(width: 16)),
                    ]))));
        return desktopFeature() || !allowMultipleChats
            ? child
            : Dismissible(
                key: Key(jsonDecode(item)["uuid"]),
                direction: (chatAllowed)
                    ? DismissDirection.startToEnd
                    : DismissDirection.none,
                confirmDismiss: (direction) async {
                  if (!chatAllowed && chatUuid == jsonDecode(item)["uuid"]) {
                    return false;
                  }
                  return await deleteChatDialog(context, setState,
                      takeAction: false);
                },
                onDismissed: (direction) {
                  selectionHaptic();
                  for (var i = 0;
                      i < (prefs!.getStringList("chats") ?? []).length;
                      i++) {
                    if (jsonDecode(
                            (prefs!.getStringList("chats") ?? [])[i])["uuid"] ==
                        jsonDecode(item)["uuid"]) {
                      List<String> tmp = prefs!.getStringList("chats")!;
                      tmp.removeAt(i);
                      prefs!.setStringList("chats", tmp);
                      break;
                    }
                  }
                  if (chatUuid == jsonDecode(item)["uuid"]) {
                    messages = [];
                    chatUuid = null;
                    if (!desktopLayoutRequired(context)) {
                      Navigator.of(context).pop();
                    }
                  }
                  setState(() {});
                },
                child: child);
      }).toList());
  }

  @override
  void initState() {
    super.initState();
    mainContext = context;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (prefs == null) {
          await Future.doWhile(
              () => Future.delayed(const Duration(milliseconds: 1)).then((_) {
                    return prefs == null;
                  }));
        }

        if (!(allowSettings || useHost)) {
          // ignore: use_build_context_synchronously
          resetSystemNavigation(context,
              statusBarColor: Colors.black,
              systemNavigationBarColor: Colors.black);
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) {
                // ignore: prefer_const_constructors
                return PopScope(
                    canPop: false,
                    // ignore: prefer_const_constructors
                    child: Dialog.fullscreen(
                        backgroundColor: Colors.black,
                        // ignore: prefer_const_constructors
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            // ignore: prefer_const_constructors
                            child: Text(
                                "*Build Error:*\n\nuseHost: $useHost\nallowSettings: $allowSettings\n\nYou created this build? One of them must be set to true or the app is not functional!\n\nYou received this build by someone else? Please contact them and report the issue.",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: "monospace")))));
              });
        }

        // prefs!.remove("welcomeFinished");
        if (!(prefs!.getBool("welcomeFinished") ?? false) && allowSettings) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ScreenWelcome()));
          return;
        }

        if (!allowMultipleChats &&
            (prefs!.getStringList("chats") ?? []).isNotEmpty) {
          chatUuid =
              jsonDecode((prefs!.getStringList("chats") ?? [])[0])["uuid"];
          loadChat(chatUuid!, setState);
        }

        setState(() {
          model = useModel ? fixedModel : prefs!.getString("model");
          chatAllowed = !(model == null);
          multimodal = prefs?.getBool("multimodal") ?? false;
          host = useHost ? fixedHost : prefs?.getString("host");
        });

        if (host == null) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // ignore: use_build_context_synchronously
              content: Text(AppLocalizations.of(context)!.noHostSelected),
              showCloseIcon: true));
        }

        setState(() {});
        if (prefs!.getBool("checkUpdateOnSettingsOpen") ?? false) {
          updateDetectedOnStart = await checkUpdate(setState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    resetSystemNavigation(context);

    Widget selector = InkWell(
        onTap: !useModel
            ? () {
                if (host == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(AppLocalizations.of(context)!.noHostSelected),
                      showCloseIcon: true));
                  return;
                }
                setModel(context, setState);
              }
            : null,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        enableFeedback: false,
        hoverColor: Colors.transparent,
        child: SizedBox(
            height: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Text(
                          (model ??
                                  AppLocalizations.of(context)!.noSelectedModel)
                              .split(":")[0],
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontFamily: "monospace", fontSize: 16))),
                  useModel
                      ? const SizedBox.shrink()
                      : const Icon(Icons.expand_more_rounded)
                ])));

    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                  children: desktopFeature()
                      ? desktopLayoutRequired(context)
                          ? [
                              SizedBox(
                                  width: 304, height: 200, child: MoveWindow()),
                              SizedBox(
                                  height: 200,
                                  child: AnimatedOpacity(
                                      opacity: menuVisible ? 1.0 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: VerticalDivider(
                                          width: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(20)))),
                              AnimatedOpacity(
                                opacity: desktopTitleVisible ? 1.0 : 0.0,
                                duration: desktopTitleVisible
                                    ? const Duration(milliseconds: 300)
                                    : const Duration(milliseconds: 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: selector,
                                ),
                              ),
                              Expanded(
                                  child: SizedBox(
                                      height: 200, child: MoveWindow()))
                            ]
                          : [
                              SizedBox(
                                  width: 90, height: 200, child: MoveWindow()),
                              Expanded(
                                  child: SizedBox(
                                      height: 200, child: MoveWindow())),
                              selector,
                              Expanded(
                                  child: SizedBox(
                                      height: 200, child: MoveWindow()))
                            ]
                      : desktopLayoutRequired(context)
                          ? [
                              // bottom left tile
                              const SizedBox(width: 304, height: 200),
                              SizedBox(
                                  height: 200,
                                  child: AnimatedOpacity(
                                      opacity: menuVisible ? 1.0 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: VerticalDivider(
                                          width: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(20)))),
                              AnimatedOpacity(
                                opacity: desktopTitleVisible ? 1.0 : 0.0,
                                duration: desktopTitleVisible
                                    ? const Duration(milliseconds: 300)
                                    : const Duration(milliseconds: 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: selector,
                                ),
                              ),
                              const Expanded(child: SizedBox(height: 200))
                            ]
                          : [Expanded(child: selector)]),
              actions: desktopControlsActions(context, [
                const SizedBox(width: 4),
                allowMultipleChats
                    ? IconButton(
                        onPressed: () {
                          selectionHaptic();
                          if (!chatAllowed) return;
                          deleteChatDialog(context, setState,
                              additionalCondition: messages.isNotEmpty);
                        },
                        icon: const Icon(Icons.restart_alt_rounded))
                    : const SizedBox.shrink()
              ]),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1),
                  child: (!chatAllowed && model != null)
                      ? const LinearProgressIndicator()
                      : desktopLayout(context)
                          ? AnimatedOpacity(
                              opacity: menuVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Divider(
                                  height: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(20)))
                          : const SizedBox.shrink()),
              automaticallyImplyLeading: !desktopLayoutRequired(context)),
          body: Row(
            children: [
              desktopLayoutRequired(context)
                  ? SizedBox(
                      width: 304,
                      height: double.infinity,
                      child: VisibilityDetector(
                          key: const Key("menuVisible"),
                          onVisibilityChanged: (VisibilityInfo info) {
                            if (settingsOpen) return;
                            menuVisible = info.visibleFraction > 0;
                            try {
                              setState(() {});
                            } catch (_) {}
                          },
                          child: AnimatedOpacity(
                              opacity: menuVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: ListView(
                                  children: sidebar(context, setState)))))
                  : const SizedBox.shrink(),
              desktopLayout(context)
                  ? AnimatedOpacity(
                      opacity: menuVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: VerticalDivider(
                          width: 2,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(20)))
                  : const SizedBox.shrink(),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1000),
                          child: Chat(
                              messages: messages,
                              key: chatKey,
                              textMessageBuilder: (p0,
                                  {required messageWidth, required showName}) {
                                var white =
                                    const TextStyle(color: Colors.white);
                                bool greyed = false;
                                String text = p0.text;
                                if (text.trim() == "") {
                                  text =
                                      "_Empty AI response, try restarting conversation_";
                                  greyed = true;
                                }
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 23,
                                        top: 17,
                                        bottom: 17),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          scrollbarTheme:
                                              const ScrollbarThemeData(
                                                  thumbColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.grey))),
                                      child: MarkdownBody(
                                          data: text,
                                          onTapLink: (text, href, title) async {
                                            selectionHaptic();
                                            try {
                                              var url = Uri.parse(href!);
                                              if (await canLaunchUrl(url)) {
                                                launchUrl(
                                                    mode: LaunchMode
                                                        .inAppBrowserView,
                                                    url);
                                              } else {
                                                throw Exception();
                                              }
                                            } catch (_) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          AppLocalizations.of(
                                                                  // ignore: use_build_context_synchronously
                                                                  context)!
                                                              .settingsHostInvalid(
                                                                  "url")),
                                                      showCloseIcon: true));
                                            }
                                          },
                                          extensionSet: md.ExtensionSet(
                                            md.ExtensionSet.gitHubFlavored
                                                .blockSyntaxes,
                                            <md.InlineSyntax>[
                                              md.EmojiSyntax(),
                                              ...md.ExtensionSet.gitHubFlavored
                                                  .inlineSyntaxes
                                            ],
                                          ),
                                          imageBuilder: (uri, title, alt) {
                                            Widget errorImage = InkWell(
                                                onTap: () {
                                                  selectionHaptic();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .notAValidImage),
                                                          showCloseIcon: true));
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Colors.black),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 100,
                                                            right: 100,
                                                            top: 32),
                                                    child: const Image(
                                                        image: AssetImage(
                                                            "assets/logo512error.png"))));
                                            if (uri.isAbsolute) {
                                              return Image.network(
                                                  uri.toString(), errorBuilder:
                                                      (context, error,
                                                          stackTrace) {
                                                return errorImage;
                                              });
                                            } else {
                                              return errorImage;
                                            }
                                          },
                                          styleSheet: (p0.author == user)
                                              ? MarkdownStyleSheet(
                                                  p: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  blockquoteDecoration:
                                                      BoxDecoration(
                                                    color: Colors.grey[800],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  code: const TextStyle(
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white),
                                                  codeblockDecoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(
                                                          8)),
                                                  h1: white,
                                                  h2: white,
                                                  h3: white,
                                                  h4: white,
                                                  h5: white,
                                                  h6: white,
                                                  listBullet: white,
                                                  horizontalRuleDecoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .grey[800]!,
                                                              width: 1))),
                                                  tableBorder: TableBorder.all(
                                                      color: Colors.white),
                                                  tableBody: white)
                                              : (Theme.of(context).brightness ==
                                                      Brightness.light)
                                                  ? MarkdownStyleSheet(
                                                      p: TextStyle(
                                                          color: greyed
                                                              ? Colors.grey
                                                              : Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      blockquoteDecoration:
                                                          BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      code: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor: Colors.black),
                                                      codeblockDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                                                      horizontalRuleDecoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1))))
                                                  : MarkdownStyleSheet(
                                                      p: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                      blockquoteDecoration: BoxDecoration(
                                                        color:
                                                            Colors.grey[800]!,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      code: const TextStyle(color: Colors.black, backgroundColor: Colors.white),
                                                      codeblockDecoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                                      horizontalRuleDecoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1))))),
                                    ));
                              },
                              imageMessageBuilder: (p0,
                                  {required messageWidth}) {
                                return SizedBox(
                                    width:
                                        desktopLayout(context) ? 360.0 : 160.0,
                                    child: MarkdownBody(
                                        data: "![${p0.name}](${p0.uri})"));
                              },
                              disableImageGallery: true,
                              emptyState: Center(
                                  child: VisibilityDetector(
                                      key: const Key("logoVisible"),
                                      onVisibilityChanged:
                                          (VisibilityInfo info) {
                                        if (settingsOpen) return;
                                        logoVisible = info.visibleFraction > 0;
                                        try {
                                          setState(() {});
                                        } catch (_) {}
                                      },
                                      child: AnimatedOpacity(
                                          opacity: logoVisible ? 1.0 : 0.0,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: const ImageIcon(
                                              AssetImage("assets/logo512.png"),
                                              size: 44)))),
                              onSendPressed: (p0) {
                                send(p0.text, context, setState);
                              },
                              onMessageDoubleTap: (context, p1) {
                                selectionHaptic();
                                if (!chatAllowed) return;
                                if (p1.author == assistant) return;
                                for (var i = 0; i < messages.length; i++) {
                                  if (messages[i].id == p1.id) {
                                    List messageList =
                                        (jsonDecode(jsonEncode(messages))
                                                as List)
                                            .reversed
                                            .toList();
                                    bool found = false;
                                    List index = [];
                                    for (var j = 0;
                                        j < messageList.length;
                                        j++) {
                                      if (messageList[j]["id"] == p1.id) {
                                        found = true;
                                      }
                                      if (found) {
                                        index.add(messageList[j]["id"]);
                                      }
                                    }
                                    for (var j = 0; j < index.length; j++) {
                                      for (var k = 0;
                                          k < messages.length;
                                          k++) {
                                        if (messages[k].id == index[j]) {
                                          messages.removeAt(k);
                                        }
                                      }
                                    }
                                    break;
                                  }
                                }
                                saveChat(chatUuid!, setState);
                                setState(() {});
                              },
                              onMessageLongPress: (context, p1) async {
                                selectionHaptic();

                                if (!(prefs!.getBool("enableEditing") ??
                                    true)) {
                                  return;
                                }

                                var index = -1;
                                if (!chatAllowed) return;
                                for (var i = 0; i < messages.length; i++) {
                                  if (messages[i].id == p1.id) {
                                    index = i;
                                    break;
                                  }
                                }

                                var text =
                                    (messages[index] as types.TextMessage).text;
                                var input = await prompt(
                                  context,
                                  title: AppLocalizations.of(context)!
                                      .dialogEditMessageTitle,
                                  value: text,
                                  keyboard: TextInputType.multiline,
                                  maxLines: (text.length >= 100)
                                      ? 10
                                      : ((text.length >= 50) ? 5 : 3),
                                );
                                if (input == "") return;

                                messages[index] = types.TextMessage(
                                  author: p1.author,
                                  createdAt: p1.createdAt,
                                  id: p1.id,
                                  text: input,
                                );
                                setState(() {});
                              },
                              onAttachmentPressed: (!multimodal)
                                  ? (prefs?.getBool("voiceModeEnabled") ??
                                          false)
                                      ? (model != null)
                                          ? () {
                                              selectionHaptic();
                                              setGlobalState = setState;
                                              settingsOpen = true;
                                              logoVisible = false;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ScreenVoice()));
                                            }
                                          : null
                                      : null
                                  : () {
                                      selectionHaptic();
                                      if (!chatAllowed || model == null) {
                                        return;
                                      }
                                      if (desktopFeature()) {
                                        FilePicker.platform
                                            .pickFiles(type: FileType.image)
                                            .then((value) async {
                                          if (value == null) return;
                                          if (!multimodal) return;

                                          var encoded = base64.encode(
                                              await File(
                                                      value.files.first.path!)
                                                  .readAsBytes());
                                          messages.insert(
                                              0,
                                              types.ImageMessage(
                                                  author: user,
                                                  id: const Uuid().v4(),
                                                  name: value.files.first.name,
                                                  size: value.files.first.size,
                                                  uri:
                                                      "data:image/png;base64,$encoded"));

                                          setState(() {});
                                        });

                                        return;
                                      }
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 16),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      (prefs?.getBool(
                                                                  "voiceModeEnabled") ??
                                                              false)
                                                          ? SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: OutlinedButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () async {
                                                                        selectionHaptic();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        setGlobalState =
                                                                            setState;
                                                                        settingsOpen =
                                                                            true;
                                                                        logoVisible =
                                                                            false;
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const ScreenVoice()));
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .headphones_rounded),
                                                                      label: Text(
                                                                          AppLocalizations.of(context)!
                                                                              .settingsTitleVoice)))
                                                          : const SizedBox
                                                              .shrink(),
                                                      (prefs?.getBool(
                                                                  "voiceModeEnabled") ??
                                                              false)
                                                          ? const SizedBox(
                                                              height: 8)
                                                          : const SizedBox
                                                              .shrink(),
                                                      SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: OutlinedButton
                                                              .icon(
                                                                  onPressed:
                                                                      () async {
                                                                    selectionHaptic();

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    final result =
                                                                        await ImagePicker()
                                                                            .pickImage(
                                                                      source: ImageSource
                                                                          .camera,
                                                                    );
                                                                    if (result ==
                                                                        null) {
                                                                      return;
                                                                    }

                                                                    final bytes =
                                                                        await result
                                                                            .readAsBytes();
                                                                    final image =
                                                                        await decodeImageFromList(
                                                                            bytes);

                                                                    final message =
                                                                        types
                                                                            .ImageMessage(
                                                                      author:
                                                                          user,
                                                                      createdAt:
                                                                          DateTime.now()
                                                                              .millisecondsSinceEpoch,
                                                                      height: image
                                                                          .height
                                                                          .toDouble(),
                                                                      id: const Uuid()
                                                                          .v4(),
                                                                      name: result
                                                                          .name,
                                                                      size: bytes
                                                                          .length,
                                                                      uri: result
                                                                          .path,
                                                                      width: image
                                                                          .width
                                                                          .toDouble(),
                                                                    );

                                                                    messages.insert(
                                                                        0,
                                                                        message);
                                                                    setState(
                                                                        () {});
                                                                    selectionHaptic();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .photo_camera_rounded),
                                                                  label: Text(AppLocalizations.of(
                                                                          context)!
                                                                      .takeImage))),
                                                      const SizedBox(height: 8),
                                                      SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: OutlinedButton
                                                              .icon(
                                                                  onPressed:
                                                                      () async {
                                                                    selectionHaptic();

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    final result =
                                                                        await ImagePicker()
                                                                            .pickImage(
                                                                      source: ImageSource
                                                                          .gallery,
                                                                    );
                                                                    if (result ==
                                                                        null) {
                                                                      return;
                                                                    }

                                                                    final bytes =
                                                                        await result
                                                                            .readAsBytes();
                                                                    final image =
                                                                        await decodeImageFromList(
                                                                            bytes);

                                                                    final message =
                                                                        types
                                                                            .ImageMessage(
                                                                      author:
                                                                          user,
                                                                      createdAt:
                                                                          DateTime.now()
                                                                              .millisecondsSinceEpoch,
                                                                      height: image
                                                                          .height
                                                                          .toDouble(),
                                                                      id: const Uuid()
                                                                          .v4(),
                                                                      name: result
                                                                          .name,
                                                                      size: bytes
                                                                          .length,
                                                                      uri: result
                                                                          .path,
                                                                      width: image
                                                                          .width
                                                                          .toDouble(),
                                                                    );

                                                                    messages.insert(
                                                                        0,
                                                                        message);
                                                                    setState(
                                                                        () {});
                                                                    selectionHaptic();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .image_rounded),
                                                                  label: Text(AppLocalizations.of(
                                                                          context)!
                                                                      .uploadImage)))
                                                    ]));
                                          });
                                    },
                              l10n: ChatL10nEn(
                                  inputPlaceholder: AppLocalizations.of(context)!
                                      .messageInputPlaceholder,
                                  attachmentButtonAccessibilityLabel:
                                      AppLocalizations.of(context)!
                                          .tooltipAttachment,
                                  sendButtonAccessibilityLabel:
                                      AppLocalizations.of(context)!
                                          .tooltipSend),
                              inputOptions: InputOptions(
                                  keyboardType: TextInputType.multiline,
                                  onTextChanged: (p0) {
                                    setState(() {
                                      sendable = p0.trim().isNotEmpty;
                                    });
                                  },
                                  sendButtonVisibilityMode: desktopFeature()
                                      ? SendButtonVisibilityMode.always
                                      : (sendable)
                                          ? SendButtonVisibilityMode.always
                                          : SendButtonVisibilityMode.hidden),
                              user: user,
                              hideBackgroundOnEmojiMessages: false,
                              theme: (Theme.of(context).brightness ==
                                      Brightness.light)
                                  ? DefaultChatTheme(
                                      backgroundColor:
                                          themeLight().colorScheme.surface,
                                      primaryColor:
                                          themeLight().colorScheme.primary,
                                      attachmentButtonIcon: !multimodal
                                          ? (prefs?.getBool("voiceModeEnabled") ?? false)
                                              ? Icon(Icons.headphones_rounded, color: Theme.of(context).iconTheme.color)
                                              : null
                                          : Icon(Icons.add_a_photo_rounded, color: Theme.of(context).iconTheme.color),
                                      sendButtonIcon: SizedBox(
                                        height: 24,
                                        child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            radius: 12,
                                            child: Icon(
                                                Icons.arrow_upward_rounded,
                                                color: (prefs?.getBool(
                                                            "useDeviceTheme") ??
                                                        false)
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                    : null)),
                                      ),
                                      sendButtonMargin: EdgeInsets.zero,
                                      attachmentButtonMargin: EdgeInsets.zero,
                                      inputBackgroundColor: themeLight().colorScheme.onSurface.withAlpha(10),
                                      inputTextColor: themeLight().colorScheme.onSurface,
                                      inputBorderRadius: BorderRadius.circular(32),
                                      inputPadding: const EdgeInsets.all(16),
                                      inputMargin: EdgeInsets.only(left: (MediaQuery.of(context).viewInsets.bottom == 0.0 && !desktopFeature()) ? 8 : 6, right: (MediaQuery.of(context).viewInsets.bottom == 0.0 && !desktopFeature()) ? 8 : 6, bottom: (MediaQuery.of(context).viewInsets.bottom == 0.0 && !desktopFeature()) ? 0 : 8),
                                      messageMaxWidth: (MediaQuery.of(context).size.width >= 1000)
                                          ? (MediaQuery.of(context).size.width >= 1600)
                                              ? (MediaQuery.of(context).size.width >= 2200)
                                                  ? 1900
                                                  : 1300
                                              : 700
                                          : 440)
                                  : DarkChatTheme(
                                      backgroundColor: themeDark().colorScheme.surface,
                                      primaryColor: themeDark().colorScheme.primary.withAlpha(40),
                                      secondaryColor: themeDark().colorScheme.primary.withAlpha(20),
                                      attachmentButtonIcon: !multimodal
                                          ? (prefs?.getBool("voiceModeEnabled") ?? false)
                                              ? Icon(Icons.headphones_rounded, color: Theme.of(context).iconTheme.color)
                                              : null
                                          : Icon(Icons.add_a_photo_rounded, color: Theme.of(context).iconTheme.color),
                                      sendButtonIcon: SizedBox(
                                        height: 24,
                                        child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            radius: 12,
                                            child: Icon(
                                                Icons.arrow_upward_rounded,
                                                color: (prefs?.getBool(
                                                            "useDeviceTheme") ??
                                                        false)
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                    : null)),
                                      ),
                                      sendButtonMargin: EdgeInsets.zero,
                                      attachmentButtonMargin: EdgeInsets.zero,
                                      inputBackgroundColor: themeDark().colorScheme.onSurface.withAlpha(40),
                                      inputTextColor: themeDark().colorScheme.onSurface,
                                      inputBorderRadius: const BorderRadius.all(Radius.circular(64)),
                                      inputPadding: const EdgeInsets.all(16),
                                      inputMargin: EdgeInsets.only(left: 8, right: 8, bottom: (MediaQuery.of(context).viewInsets.bottom == 0.0 && !desktopFeature()) ? 0 : 8),
                                      messageMaxWidth: (MediaQuery.of(context).size.width >= 1000)
                                          ? (MediaQuery.of(context).size.width >= 1600)
                                              ? (MediaQuery.of(context).size.width >= 2200)
                                                  ? 1900
                                                  : 1300
                                              : 700
                                          : 440)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawerEdgeDragWidth: (prefs?.getBool("fixCodeblockScroll") ?? false)
              ? null
              : (desktopLayout(context)
                  ? null
                  : MediaQuery.of(context).size.width),
          drawer: Builder(builder: (context) {
            if (desktopLayoutRequired(context) && !settingsOpen) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              });
            }
            return NavigationDrawer(
                onDestinationSelected: (value) {
                  if (value == 1) {
                  } else if (value == 2) {}
                },
                selectedIndex: 1,
                children: sidebar(context, setState));
          })),
    );
  }
}
