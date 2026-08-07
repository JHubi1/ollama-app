import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dartx/dartx.dart';
import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide RouteSettings;
// import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pwa_install/pwa_install.dart' as pwa;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:universal_html/html.dart' as html;

import 'l10n/gen/app_localizations.dart';
import 'main.gr.dart';
import 'services/services.dart';

// client configuration

/// forces usage of [fixedHost] as the host
const bool useHost = false;

/// the host used when [useHost] is true; not validated!
const String fixedHost = "http://example.com:11434";

/// forces usage of [fixedModel] as the model
const bool useModel = false;

/// the model used when [useModel] is true; not validated!
const String fixedModel = "gemma3:latest";

// client configuration end

Completer<void> prefsReady = Completer<void>();
SharedPreferencesWithCache? prefs;

SpeechToText speech = SpeechToText();
FlutterTts voice = FlutterTts();
bool voiceSupported = false;

Color adaptedSurfaceFromColorScheme(ColorScheme cs) => cs.surface;
Color adaptedOnSurfaceFromColorScheme(ColorScheme cs) => cs.surfaceContainerLow;

const kDisabledOpacity = 0.38;

const kImageLogo = AssetImage("assets/logo512.png");
const kImageLogoError = AssetImage("assets/logo512error.png");

final uuidRegex = RegExp(
  r"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$",
  caseSensitive: false,
);

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RouteMain.page,
      path: "/",
      children: [
        AutoRoute(page: RouteNewChat.page, path: ""),
        AutoRoute(page: RouteChat.page, path: "c/:id"),

        AutoRoute(
          page: RouteSettingsShell.page,
          path: "settings",
          children: [
            AutoRoute(page: RouteSettings.page, path: "", initial: true),
            AutoRoute(page: RouteSettingsOverview.page, path: "overview"),

            AutoRoute(page: RouteSettingsBehavior.page, path: "behavior"),
            AutoRoute(page: RouteSettingsInterface.page, path: "interface"),
            AutoRoute(page: RouteSettingsVoice.page, path: "voice"),
            AutoRoute(page: RouteSettingsExport.page, path: "export"),
            AutoRoute(page: RouteSettingsAbout.page, path: "about"),
          ],
        ),
      ],
    ),
    RedirectRoute(path: "*", redirectTo: "/"),
  ];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await initializeDateFormatting(null, null);
  pwa.PWAInstall().setup();

  try {
    HttpOverrides.global = OllamaHttpOverrides();
  } catch (_) {}

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
  Preferences.instance;

  chatDb = ChatDatabase();
  await ChatManager.instance.loadChats();

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
  final _appRouter = AppRouter();
  Chat? _currentChat;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) html.querySelector(".loader")?.remove();
    // FlutterDisplayMode.setHighRefreshRate().catchError((_) {});

    Future<void> load() async {
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

    ChatManager.instance.addListener(onChatUpdate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(kImageLogo, context);
      precacheImage(kImageLogoError, context);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onChatUpdate);
    super.dispose();
  }

  void onUpdate() {
      if (mounted) setState(() {});
  }

  void onChatUpdate() {
    if (ChatManager.instance.currentChat != _currentChat) {
      _currentChat?.removeListener(onUpdate);
      _currentChat = ChatManager.instance.currentChat;
      _currentChat?.addListener(onUpdate);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
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
            return MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateTitle: (context) {
                final currentId = _appRouter.currentPath
                    .split("/")
                    .where(uuidRegex.hasMatch)
                    .lastOrNull;
                final currentTitle = currentId != null
                    ? ChatManager.instance.chats
                              .firstOrNullWhere((chat) => chat.id == currentId)
                              ?.title ??
                          AppLocalizations.of(context).newChatTitle
                    : null;

                return AppLocalizations.of(context).appTitle(switch (kIsWeb
                    ? "web"
                    : Platform.operatingSystem) {
                  "android" || "ios" => "short",
                  "web" when (currentTitle != null) => "integrated",
                  _ => "other",
                }, currentTitle ?? "");
              },
              theme: themeLight,
              darkTheme: themeDark,
              themeMode: themeMode,
              routerConfig: _appRouter.config(
                navigatorObservers: () => [
                  GlobalNavigationObserver(),
                  HeroController(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class GlobalNavigationObserver extends NavigatorObserver {
  static String? _path;
  static String? get path => _path;

  static final StreamController<void> _routerStream =
      StreamController<void>.broadcast();
  static Stream<void> get routerStream => _routerStream.stream;

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    super.didChangeTop(topRoute, previousTopRoute);

    var node = topRoute.data;
    var path = node?.path ?? "";
    while (node?.parent != null) {
      node = node!.parent;
      if (node?.path != null && node!.path.isNotEmpty) {
        path = "${node.path}/$path";
      }
    }
    path = "/${path.replaceAll(RegExp(r"(^/+)|(/+$)"), "")}";

    _path = path;
    _routerStream.add(null);
  }
}
