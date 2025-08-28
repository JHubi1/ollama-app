import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pwa_install/pwa_install.dart' as pwa;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:universal_html/html.dart' as html;
import 'package:uuid/uuid.dart';

import 'l10n/gen/app_localizations.dart';
import 'screens/main.dart';
import 'services/clients.dart';
import 'services/responsive.dart';
import 'services/theme.dart';

// client configuration

// use host or not, if false dialog is shown
const bool useHost = false;
// host of ollama, must be accessible from the client, without trailing slash
// ! will always be accepted as valid, even if [useHost] is false
const String fixedHost = "http://example.com:11434";
// use model or not, if false selector is shown
const bool useModel = false;
// model name as string, must be valid ollama model!
const String fixedModel = "gemma3";
// recommended models, shown with a star in model selector
const List<String> recommendedModels = ["gemma3", "llama3.3"];
// allow opening of settings
const bool allowSettings = true;
// allow multiple chats
const bool allowMultipleChats = true;

// client configuration end

Completer<void> prefsReady = Completer<void>();
SharedPreferencesWithCache? prefs;

String? host;

bool chatAllowed = true;
String hoveredChat = "";

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
  pwa.PWAInstall().setup();

  try {
    HttpOverrides.global = OllamaHttpOverrides();
  } catch (_) {}

  runApp(const App());

  if (LayoutFeature.desktop()) {
    doWhenWindowReady(() {
      appWindow.minSize = const Size(600, 450);
      appWindow.size = const Size(1200, 650);
      if (prefs!.getBool("maximizeOnStart") ?? false) appWindow.maximize();
      appWindow.show();
    });
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    if (kIsWeb) html.querySelector(".loader")?.remove();
    // FlutterDisplayMode.setHighRefreshRate().catchError((_) {});

    Future<void> load() async {
      SharedPreferences.setPrefix("ollama.");
      await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
        legacySharedPreferencesInstance: await SharedPreferences.getInstance(),
        sharedPreferencesAsyncOptions: const SharedPreferencesOptions(),
        migrationCompletedKey: "migrationCompleted",
      );
      prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );
      prefsReady.complete();

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
      builder: (ColorScheme? dynamicLight, ColorScheme? dynamicDark) {
        return ThemeBuilder(
          data: ThemeBuilderData(
            dynamicLight: dynamicLight,
            dynamicDark: dynamicDark,
          ),
          builder: (themeMode, themeLight, themeDark) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appTitle,
              theme: themeLight,
              darkTheme: themeDark,
              themeMode: themeMode,
              home: const ScreenMain(),
            );
          },
        );
      },
    );
  }
}
