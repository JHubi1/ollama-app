import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
                        ? (themeDark ?? ThemeData.dark()).colorScheme.background
                        : (theme ?? ThemeData()).colorScheme.background));
          };
          // brightness changed function not run at first startup
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor: (MediaQuery.of(context)
                          .platformBrightness ==
                      Brightness.light)
                  ? (theme ?? ThemeData()).colorScheme.background
                  : (themeDark ?? ThemeData.dark()).colorScheme.background));
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: "Ollama",
        theme: theme,
        darkTheme: themeDark,
        home: const MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<types.Message> _messages = [];
  final _user = types.User(id: const Uuid().v4());

  bool logoVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
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
              child: SizedBox(
                  height: 72,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Text(
                                AppLocalizations.of(context)!.noSelectedModel,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                    fontFamily: "monospace", fontSize: 16))),
                        const SizedBox(width: 4),
                        const Icon(Icons.expand_more_rounded)
                      ]))),
          actions: [
            IconButton(
                onPressed: () {
                  _messages = [];
                  HapticFeedback.selectionClick();
                  setState(() {});
                },
                icon: const Icon(Icons.restart_alt_rounded))
          ],
        ),
        body: SizedBox.expand(
            child: Chat(
                messages: _messages,
                emptyState: Center(
                    child: VisibilityDetector(
                        key: const Key("logoVisible"),
                        onVisibilityChanged: (VisibilityInfo info) {
                          logoVisible = info.visibleFraction > 0;
                          setState(() {});
                        },
                        child: AnimatedOpacity(
                            opacity: logoVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: const ImageIcon(AssetImage("assets/logo512.png"),
                                size: 44)))),
                onSendPressed: (p0) {
                  _messages.insert(
                      0,
                      types.TextMessage(
                          author: _user, id: const Uuid().v4(), text: p0.text));
                  setState(() {});
                  HapticFeedback.selectionClick();
                },
                onMessageDoubleTap: (context, p1) {
                  for (var i = 0; i < _messages.length; i++) {
                    if (_messages[i].id == p1.id) {
                      _messages.removeAt(i);
                      break;
                    }
                  }
                  setState(() {});
                  HapticFeedback.selectionClick();
                },
                onAttachmentPressed: () {
                  HapticFeedback.selectionClick();
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                          onPressed: () async {
                                            HapticFeedback.selectionClick();

                                            Navigator.of(context).pop();
                                            final result =
                                                await ImagePicker().pickImage(
                                              source: ImageSource.gallery,
                                            );
                                            if (result == null) return;

                                            final bytes =
                                                await result.readAsBytes();
                                            final image =
                                                await decodeImageFromList(
                                                    bytes);

                                            final message = types.ImageMessage(
                                              author: _user,
                                              createdAt: DateTime.now()
                                                  .millisecondsSinceEpoch,
                                              height: image.height.toDouble(),
                                              id: const Uuid().v4(),
                                              name: result.name,
                                              size: bytes.length,
                                              uri: result.path,
                                              width: image.width.toDouble(),
                                            );

                                            _messages.insert(0, message);
                                            setState(() {});
                                            HapticFeedback.selectionClick();
                                          },
                                          icon: const Icon(Icons.image_rounded),
                                          label: Text(
                                              AppLocalizations.of(context)!
                                                  .uploadImage))),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                          onPressed: () async {
                                            HapticFeedback.selectionClick();

                                            Navigator.of(context).pop();
                                            final result = await FilePicker
                                                .platform
                                                .pickFiles(
                                                    type: FileType.custom,
                                                    allowedExtensions: ["pdf"]);
                                            if (result == null ||
                                                result.files.single.path ==
                                                    null) return;

                                            final message = types.FileMessage(
                                              author: _user,
                                              createdAt: DateTime.now()
                                                  .millisecondsSinceEpoch,
                                              id: const Uuid().v4(),
                                              name: result.files.single.name,
                                              size: result.files.single.size,
                                              uri: result.files.single.path!,
                                            );

                                            _messages.insert(0, message);
                                            setState(() {});
                                            HapticFeedback.selectionClick();
                                          },
                                          icon: const Icon(
                                              Icons.file_copy_rounded),
                                          label: Text(
                                              AppLocalizations.of(context)!
                                                  .uploadFile)))
                                ]));
                      });
                },
                l10n: ChatL10nEn(
                    inputPlaceholder:
                        AppLocalizations.of(context)!.messageInputPlaceholder),
                inputOptions: const InputOptions(
                    keyboardType: TextInputType.text,
                    sendButtonVisibilityMode: SendButtonVisibilityMode.always),
                user: _user,
                hideBackgroundOnEmojiMessages: false,
                theme: (MediaQuery.of(context).platformBrightness == Brightness.light)
                    ? DefaultChatTheme(
                        backgroundColor:
                            (theme ?? ThemeData()).colorScheme.background,
                        primaryColor:
                            (theme ?? ThemeData()).colorScheme.primary,
                        attachmentButtonIcon:
                            const Icon(Icons.file_upload_rounded),
                        sendButtonIcon: const Icon(Icons.send_rounded),
                        inputBackgroundColor: (theme ?? ThemeData())
                            .colorScheme
                            .onBackground
                            .withAlpha(10),
                        inputTextColor:
                            (theme ?? ThemeData()).colorScheme.onBackground,
                        inputBorderRadius:
                            const BorderRadius.all(Radius.circular(64)),
                        inputPadding: const EdgeInsets.all(16),
                        inputMargin: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom:
                                (MediaQuery.of(context).viewInsets.bottom == 0.0)
                                    ? 0
                                    : 8))
                    : DarkChatTheme(
                        backgroundColor: (themeDark ?? ThemeData.dark()).colorScheme.background,
                        primaryColor: (themeDark ?? ThemeData.dark()).colorScheme.primary.withAlpha(40),
                        attachmentButtonIcon: const Icon(Icons.file_upload_rounded),
                        sendButtonIcon: const Icon(Icons.send_rounded),
                        inputBackgroundColor: (themeDark ?? ThemeData()).colorScheme.onBackground.withAlpha(40),
                        inputTextColor: (themeDark ?? ThemeData()).colorScheme.onBackground,
                        inputBorderRadius: const BorderRadius.all(Radius.circular(64)),
                        inputPadding: const EdgeInsets.all(16),
                        inputMargin: EdgeInsets.only(left: 8, right: 8, bottom: (MediaQuery.of(context).viewInsets.bottom == 0.0) ? 0 : 8)))),
        drawer: NavigationDrawer(
            onDestinationSelected: (value) {
              if (value == 1) {
                HapticFeedback.selectionClick();
                Navigator.of(context).pop();
                _messages = [];
                setState(() {});
              } else if (value == 2) {
                HapticFeedback.selectionClick();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Settings not implemented yet."),
                    showCloseIcon: true));
              }
            },
            selectedIndex: 1,
            children: [
              NavigationDrawerDestination(
                icon: const ImageIcon(AssetImage("assets/logo512.png")),
                label: Text(AppLocalizations.of(context)!.appTitle),
              ),
              const Divider(),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.add_rounded),
                  label: Text(AppLocalizations.of(context)!.optionNewChat)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.settings_rounded),
                  label: Text(AppLocalizations.of(context)!.optionSettings))
            ]));
  }
}
