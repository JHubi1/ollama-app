import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ollama_app/worker/haptic.dart';
import 'package:ollama_app/worker/setter.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:ollama_dart/ollama_dart.dart' as llama;
import 'package:datetime_loop/datetime_loop.dart';
import 'package:volume_controller/volume_controller.dart';

import 'main.dart';
import 'worker/sender.dart';
import 'settings/voice.dart';

class ScreenVoice extends StatefulWidget {
  const ScreenVoice({super.key});

  @override
  State<ScreenVoice> createState() => _ScreenVoiceState();
}

class _ScreenVoiceState extends State<ScreenVoice> {
  Iterable<String> languageOptionIds = [];
  Iterable<String> languageOptions = [];

  bool speaking = false;
  bool aiThinking = false;

  bool sttDone = true;
  String text = "";
  String aiText = "";

  bool intendedStop = false;

  void setBrightness() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      // invert colors used, because brightness not updated yet
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:
              (prefs!.getString("brightness") ?? "system") == "system"
                  ? ((MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? (themeDark ?? ThemeData.dark()).colorScheme.surface
                      : (theme ?? ThemeData()).colorScheme.surface)
                  : (prefs!.getString("brightness") == "dark"
                      ? (themeDark ?? ThemeData()).colorScheme.surface
                      : (theme ?? ThemeData.dark()).colorScheme.surface),
          systemNavigationBarIconBrightness:
              (((prefs!.getString("brightness") ?? "system") == "system" &&
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark) ||
                      prefs!.getString("brightness") == "light")
                  ? Brightness.dark
                  : Brightness.light));
    };
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            (prefs!.getString("brightness") ?? "system") == "system"
                ? ((MediaQuery.of(context).platformBrightness ==
                        Brightness.light)
                    ? (theme ?? ThemeData.dark()).colorScheme.surface
                    : (themeDark ?? ThemeData()).colorScheme.surface)
                : (prefs!.getString("brightness") == "dark"
                    ? (themeDark ?? ThemeData()).colorScheme.surface
                    : (theme ?? ThemeData.dark()).colorScheme.surface),
        systemNavigationBarIconBrightness:
            (((prefs!.getString("brightness") ?? "system") == "system" &&
                        MediaQuery.of(context).platformBrightness ==
                            Brightness.light) ||
                    prefs!.getString("brightness") == "light")
                ? Brightness.dark
                : Brightness.light));
  }

  void process() async {
    setState(() {
      speaking = true;
      sttDone = false;
    });
    var textOldOld = text;
    var textOld = "";
    text = "";

    speech.listen(
        localeId: (prefs!.getString("voiceLanguage") ?? ""),
        listenOptions:
            stt.SpeechListenOptions(listenMode: stt.ListenMode.dictation),
        onResult: (result) {
          lightHaptic();
          if (!speaking) return;
          setState(() {
            sttDone = result.finalResult;
            text = result.recognizedWords;
          });
        },
        pauseFor: const Duration(seconds: 3));

    DateTime start = DateTime.now();
    bool timeout = false;
    await Future.doWhile(() =>
        Future.delayed(const Duration(milliseconds: 1)).then((_) {
          if (textOld != text) {
            start = DateTime.now();
          }
          timeout =
              (DateTime.now().difference(start) >= const Duration(seconds: 3));
          textOld = text;
          return !sttDone && speaking && !timeout;
        }));
    if (!sttDone || timeout) {
      sttDone = true;
      speech.stop();
      if (timeout) {
        text = textOldOld;
        try {
          setState(() {});
        } catch (_) {}
      }
      if (!intendedStop) {
        speaking = false;
        try {
          setState(() {});
        } catch (_) {}
        return;
      } else {
        intendedStop = false;
        try {
          setState(() {});
        } catch (_) {}
      }
    }

    if (text.isEmpty) {
      setState(() {
        speaking = false;
      });
      return;
    }

    aiText = "";
    heavyHaptic();

    aiThinking = true;
    try {
      if (prefs!.getBool("aiPunctuation") ?? true) {
        final generated = await llama.OllamaClient(
          headers: (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
              .cast<String, String>(),
          baseUrl: "$host/api",
        )
            .generateCompletion(
              request: llama.GenerateCompletionRequest(
                  model: model!,
                  prompt:
                      "Add punctuation and syntax to the following sentence. You must not change order of words or a word in itself! You must not add any word or phrase or remove one! Do not change between formal and personal form, keep the original one!\n\n$text",
                  keepAlive: int.parse(prefs!.getString("keepAlive") ?? "300")),
            )
            .timeout(const Duration(seconds: 10));
        setState(() {
          text = generated.response!;
        });
      }
    } catch (_) {}

    // ignore: use_build_context_synchronously
    send(text, context, setState, onStream: (currentText, done) async {
      setState(() {
        aiText = currentText;
        lightHaptic();
      });

      if (done &&
          (await voice.getLanguages as List).contains(
              (prefs!.getString("voiceLanguage") ?? "en_US")
                  .replaceAll("_", "-"))) {
        aiThinking = false;
        heavyHaptic();
        voice.setLanguage((prefs!.getString("voiceLanguage") ?? "en_US")
            .replaceAll("_", "-"));
        voice.setSpeechRate(0.6);
        voice.setCompletionHandler(() async {
          speaking = false;
          try {
            setState(() {});
          } catch (_) {}
          process();
        });
        var tmp = aiText;
        tmp.replaceAll("-", ".");
        tmp.replaceAll("*", ".");

        // var volume = await VolumeController().getVolume();
        // var voicesTmp1 = await voice.getLanguages;
        // var voices = jsonEncode(voicesTmp1);
        // var isVoiceAvailable = (await voice.isLanguageAvailable(
        //         (prefs!.getString("voiceLanguage") ?? "en_US")
        //             .replaceAll("_", "-")))
        //     .toString();
        // var voices2Tmp1 = await speech.locales();
        // var voices2Tmp2 = [];
        // for (var voice in voices2Tmp1) {
        //   voices2Tmp2.add(voice.localeId.replaceAll("_", "-"));
        // }
        // var voices2 = jsonEncode(voices2Tmp2);
        // await showDialog(
        //     // ignore: use_build_context_synchronously
        //     context: context,
        //     builder: (context) {
        //       return Dialog.fullscreen(
        //           child: ListView(children: [
        //         const Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisSize: MainAxisSize.max,
        //             children: [
        //               Expanded(child: Divider(color: Colors.red)),
        //               SizedBox(width: 8),
        //               Text("START", style: TextStyle(color: Colors.red)),
        //               SizedBox(width: 8),
        //               Expanded(child: Divider(color: Colors.red))
        //             ]),
        //         Text((prefs!.getString("voiceLanguage") ?? "en_US")
        //             .replaceAll("_", "-")),
        //         const Divider(),
        //         Text(volume.toString()),
        //         const Divider(),
        //         Text(voices),
        //         const Divider(),
        //         Text(voicesTmp1
        //             .contains((prefs!.getString("voiceLanguage") ?? "en_US")
        //                 .replaceAll("_", "-"))
        //             .toString()),
        //         const Divider(),
        //         Text(isVoiceAvailable),
        //         const Divider(),
        //         Text(voices2),
        //         const Divider(),
        //         Text(voices2Tmp2
        //             .contains((prefs!.getString("voiceLanguage") ?? "en_US")
        //                 .replaceAll("_", "-"))
        //             .toString()),
        //         const Divider(),
        //         Text(speech.isAvailable.toString()),
        //         const Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisSize: MainAxisSize.max,
        //             children: [
        //               Expanded(child: Divider(color: Colors.red)),
        //               SizedBox(width: 8),
        //               Text("END", style: TextStyle(color: Colors.red)),
        //               SizedBox(width: 8),
        //               Expanded(child: Divider(color: Colors.red))
        //             ])
        //       ]));
        //     });

        voice.speak(tmp);
      }
    },
        addToSystem: (prefs!.getBool("voiceLimitLanguage") ?? true)
            ? "You must write in the following language: ${prefs!.getString("voiceLanguage") ?? "en_US"}!"
            : null);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
          () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor:
                (themeDark ?? ThemeData.dark()).colorScheme.surface,
            systemNavigationBarIconBrightness: Brightness.dark));
      };

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:
              (themeDark ?? ThemeData.dark()).colorScheme.surface,
          systemNavigationBarIconBrightness: Brightness.dark));
      setState(() {});
    });

    void load() async {
      var tmp = await speech.locales();
      languageOptionIds = tmp.map((e) => e.localeId);
      languageOptions = tmp.map((e) => e.name);
      setState(() {});
    }

    load();

    void loadProcess() async {
      await Future.delayed(const Duration(milliseconds: 500));
      process();
    }

    loadProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: themeDark!,
        child: PopScope(
            canPop: !aiThinking,
            onPopInvoked: (didPop) {
              speaking = false;
              voice.stop();
              if (chatUuid != null) {
                loadChat(chatUuid!, setMainState!);
              }
              settingsOpen = false;
              logoVisible = true;
              setBrightness();
            },
            child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          speaking = false;
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.grey)),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(model!.split(":")[0],
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                    fontFamily: "monospace", fontSize: 16))),
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            speaking = false;
                            settingsOpen = false;
                            logoVisible = true;
                            setBrightness();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsVoice()));
                          },
                          icon: const Icon(
                            Icons.settings_rounded,
                            color: Colors.grey,
                          ))
                    ]),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Center(
                              child: Text(text,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "monospace"))),
                        ))
                      ]),
                    ),
                    Expanded(
                        child: Center(
                            child: DateTimeLoopBuilder(
                                timeUnit: TimeUnit.seconds,
                                builder: (context, dateTime, child) {
                                  return SizedBox(
                                    height: 96,
                                    width: 96,
                                    child: AnimatedScale(
                                        scale: speaking
                                            ? aiThinking
                                                ? (dateTime.second).isEven
                                                    ? 2.4
                                                    : 2
                                                : 2
                                            : dateTime.second
                                                    .toString()
                                                    .endsWith("1")
                                                ? 1.6
                                                : 1.4,
                                        duration: aiThinking
                                            ? const Duration(seconds: 1)
                                            : const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(48),
                                            onTap: () {
                                              if (speaking && !aiThinking) {
                                                intendedStop = true;
                                                speaking = false;
                                                voice.stop();
                                                return;
                                              }
                                              process();
                                            },
                                            child: CircleAvatar(
                                                backgroundColor: themeDark!
                                                    .colorScheme.primary
                                                    .withAlpha(
                                                        !speaking ? 200 : 255),
                                                child: AnimatedSwitcher(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: speaking
                                                        ? aiThinking
                                                            ? Icon(Icons.auto_awesome_rounded,
                                                                color: themeDark!
                                                                    .colorScheme
                                                                    .secondary,
                                                                key: const ValueKey(
                                                                    "aiThinking"))
                                                            : sttDone
                                                                ? Icon(Icons.volume_up_rounded,
                                                                    color: themeDark!
                                                                        .colorScheme
                                                                        .secondary,
                                                                    key: const ValueKey(
                                                                        "tts"))
                                                                : Icon(Icons.mic_rounded, color: themeDark!.colorScheme.secondary, key: const ValueKey("stt"))
                                                        : null)))),
                                  );
                                }))),
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Center(
                              child: Text(aiText,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontFamily: "monospace"))),
                        ))
                      ]),
                    )
                  ],
                ))));
  }
}
