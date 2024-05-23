import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

SharedPreferences? prefs;
ThemeData? theme;
ThemeData? themeDark;

void main() {
  runApp(const App());
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
      SharedPreferences tmp = await SharedPreferences.getInstance();
      setState(() {
        prefs = tmp;
      });
    }

    load();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (!(prefs?.getBool("useDeviceTheme") ?? false)) {
          theme = ThemeData.from(
              colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          ));
          themeDark = ThemeData.from(
              colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.black,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          ));
          WidgetsBinding
              .instance.platformDispatcher.onPlatformBrightnessChanged = () {
            // invert colors used, because brightness not updated yet
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                systemNavigationBarColor:
                    (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? themeDark!.colorScheme.background
                        : theme!.colorScheme.background));
          };
          // brightness changed function not run at first startup
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor:
                  (MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? theme!.colorScheme.background
                      : themeDark!.colorScheme.background));
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme, darkTheme: themeDark, home: const MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<types.Message> _messages = [];
  final _user = types.User(id: const Uuid().v4());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(children: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.menu_open_rounded)),
          const SizedBox(width: 16),
          Expanded(
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Text("data")]));
                        });
                  },
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  child: const SizedBox(
                      height: 72,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                                child: Text("<none>",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontFamily: "monospace",
                                        fontSize: 16))),
                            SizedBox(width: 4),
                            Icon(Icons.expand_more_rounded)
                          ])))),
          const SizedBox(width: 16),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.restart_alt_rounded))
        ])),
        body: SizedBox.expand(
            child: Chat(
                messages: _messages,
                onSendPressed: (p0) {},
                user: _user,
                theme: (MediaQuery.of(context).platformBrightness ==
                        Brightness.light)
                    ? DefaultChatTheme(
                        backgroundColor: theme!.colorScheme.background,
                        primaryColor: theme!.colorScheme.primary)
                    : DarkChatTheme(
                        backgroundColor: themeDark!.colorScheme.background,
                        primaryColor: themeDark!.colorScheme.primary))));
  }
}
