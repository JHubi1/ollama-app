import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ollama_app/worker/theme.dart';

import 'main.dart';
import 'worker/haptic.dart';
import 'worker/update.dart';
import 'worker/desktop.dart';
import 'worker/setter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings/behavior.dart';
import 'settings/interface.dart';
import 'settings/voice.dart';
import 'settings/export.dart';
import 'settings/about.dart';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart' as http;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:transparent_image/transparent_image.dart';

Widget toggle(BuildContext context, String text, bool value,
    Function(bool value) onChanged,
    {bool disabled = false,
    void Function()? onDisabledTap,
    void Function()? onLongTap,
    void Function()? onDoubleTap,
    Widget? icon}) {
  var space = "⁣"; // Invisible character: U+2063
  var spacePlus = "    $space";
  return InkWell(
    enableFeedback: false,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: () {
      if (disabled) {
        selectionHaptic();
        if (onDisabledTap != null) {
          onDisabledTap();
        }
      } else {
        onChanged(!value);
      }
    },
    onLongPress: onLongTap,
    onDoubleTap: onDoubleTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Stack(children: [
        Padding(
            padding: EdgeInsets.only(
                left: (icon == null) ? 16 : 32, right: 16, top: 12),
            child: Divider(
                color: (Theme.of(context).brightness == Brightness.light)
                    ? Colors.grey[300]
                    : Colors.grey[900])),
        Row(mainAxisSize: MainAxisSize.max, children: [
          (icon != null)
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: icon,
                )
              : const SizedBox.shrink(),
          Expanded(
              child: Text(text + spacePlus,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: disabled ? Colors.grey : null,
                      backgroundColor:
                          (Theme.of(context).brightness == Brightness.light)
                              ? themeLight().colorScheme.surface
                              : themeDark().colorScheme.surface))),
          Container(
              padding: const EdgeInsets.only(left: 16),
              color: (Theme.of(context).brightness == Brightness.light)
                  ? themeLight().colorScheme.surface
                  : themeDark().colorScheme.surface,
              child: SizedBox(
                  height: 40,
                  child: Switch(
                      value: value,
                      onChanged: disabled
                          ? (onDisabledTap != null)
                              ? (p0) {
                                  selectionHaptic();
                                  onDisabledTap();
                                }
                              : null
                          : onChanged,
                      activeTrackColor: disabled
                          ? Theme.of(context).colorScheme.primary.withAlpha(50)
                          : null,
                      trackOutlineColor: disabled
                          ? WidgetStatePropertyAll(Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(150))
                          : null,
                      thumbColor: disabled
                          ? WidgetStatePropertyAll(Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(150))
                          : !(prefs?.getBool("useDeviceTheme") ?? false) &&
                                  value
                              ? WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.secondary)
                              : null)))
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
        const Expanded(child: Divider(height: 1))
      ]));
}

Widget titleDivider({double? top, double? bottom, BuildContext? context}) {
  top ??= (context != null && desktopLayoutNotRequired(context)) ? 32 : 16;
  bottom ??= (context != null && desktopLayoutNotRequired(context)) ? 32 : 16;
  return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(left: 8, right: 8, top: top, bottom: bottom),
      child: const Row(
          mainAxisSize: MainAxisSize.max,
          children: [Expanded(child: Divider())]));
}

Widget verticalTitleDivider(
    {double? left, double? right, BuildContext? context}) {
  left ??= (context != null && desktopLayoutNotRequired(context)) ? 32 : 16;
  right ??= (context != null && desktopLayoutNotRequired(context)) ? 32 : 16;
  return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(left: left, right: right, top: 8, bottom: 8),
      child: const Row(
          mainAxisSize: MainAxisSize.max,
          children: [VerticalDivider(width: 1)]));
}

Widget button(String text, IconData? icon, void Function()? onPressed,
    {BuildContext? context,
    Color? color,
    bool disabled = false,
    bool replaceIconIfNull = false,
    String? description,
    void Function()? onDisabledTap,
    void Function()? onLongTap,
    void Function()? onDoubleTap}) {
  if (description != null &&
      (context != null && desktopLayoutNotRequired(context)) &&
      !description.startsWith("\n")) {
    description = " • $description";
  }
  return Padding(
    padding: (context != null && desktopLayoutNotRequired(context))
        ? const EdgeInsets.only(top: 8, bottom: 8)
        : EdgeInsets.zero,
    child: InkWell(
        enableFeedback: false,
        onTap: disabled
            ? () {
                selectionHaptic();
                if (onDisabledTap != null) {
                  onDisabledTap();
                }
              }
            : (onPressed == null && (onLongTap != null || onDoubleTap != null))
                ? () {
                    selectionHaptic();
                  }
                : onPressed,
        onLongPress: (description != null && context != null)
            ? desktopLayoutNotRequired(context)
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(description!.trim()),
                        showCloseIcon: true));
                  }
            : onLongTap,
        onDoubleTap: onDoubleTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            (icon != null || replaceIconIfNull)
                ? replaceIconIfNull
                    ? ImageIcon(MemoryImage(kTransparentImage))
                    : Icon(icon, color: disabled ? Colors.grey : color)
                : const SizedBox.shrink(),
            (icon != null || replaceIconIfNull)
                ? const SizedBox(width: 16, height: 42)
                : const SizedBox.shrink(),
            Expanded(
                child: (context != null)
                    ? RichText(
                        text: TextSpan(
                            text: text,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                color: disabled ? Colors.grey : color),
                            children: [
                            (description != null &&
                                    desktopLayoutNotRequired(context))
                                ? TextSpan(
                                    text: description,
                                    style: const TextStyle(color: Colors.grey))
                                : const TextSpan()
                          ]))
                    : Text(text,
                        style:
                            TextStyle(color: disabled ? Colors.grey : color)))
          ]),
        )),
  );
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

    http.Response? request;
    try {
      var client = http.Client();
      final requestBase = http.Request("get", Uri.parse(tmpHost))
        ..headers.addAll(
          (jsonDecode(prefs!.getString("hostHeaders") ?? "{}") as Map)
              .cast<String, String>(),
        )
        ..followRedirects = false;
      request = await http.Response.fromStream(await requestBase
          .send()
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return http.StreamedResponse(const Stream.empty(), 408);
      }));
      client.close();
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
        if (hostInputController.text != host! &&
            (Uri.parse(tmpHost).toString() != fixedHost)) {
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
    selectionHaptic();
  }

  double iconSize = 1;
  bool animatedInitialized = false;
  bool animatedDesktop = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    if ((Uri.parse(hostInputController.text.trim().removeSuffix("/").trim())
            .toString() !=
        fixedHost)) {
      checkHost();
    }
    updatesSupported(setState, true);
  }

  @override
  void dispose() {
    super.dispose();
    hostInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!animatedInitialized) {
      animatedInitialized = true;
      animatedDesktop = desktopLayoutNotRequired(context);
    }
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
                      Expanded(
                          child: SizedBox(height: 200, child: MoveWindow()))
                    ]),
                    actions: desktopControlsActions(context)),
                body: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: LayoutBuilder(builder: (context, constraints) {
                      var column1 =
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: animatedDesktop ? 8 : 0,
                            child: const SizedBox.shrink()),
                        const SizedBox(height: 8),
                        TextField(
                            controller: hostInputController,
                            keyboardType: TextInputType.url,
                            autofillHints: const [AutofillHints.url],
                            readOnly: useHost,
                            onSubmitted: (value) {
                              selectionHaptic();
                              checkHost();
                            },
                            decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context)!.settingsHost,
                                hintText: "http://localhost:11434",
                                prefixIcon: IconButton(
                                    tooltip: AppLocalizations.of(context)!
                                        .tooltipAddHostHeaders,
                                    onPressed: () async {
                                      selectionHaptic();
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
                                                  .settingsHostHeaderInvalid,
                                          prefill: !((prefs!.getString(
                                                      "hostHeaders") ??
                                                  {}) ==
                                              "{}"));
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
                                            tooltip:
                                                AppLocalizations.of(context)!
                                                    .tooltipSave,
                                            onPressed: () {
                                              selectionHaptic();
                                              checkHost();
                                            },
                                            icon:
                                                const Icon(Icons.save_rounded),
                                          )),
                                border: const OutlineInputBorder(),
                                error: (hostInvalidHost || hostInvalidUrl)
                                    ? InkWell(
                                        onTap: () {
                                          selectionHaptic();
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
                                        splashFactory: NoSplash.splashFactory,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Icon(Icons.error_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                            const SizedBox(width: 8),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .settingsHostInvalid(
                                                        hostInvalidHost
                                                            ? "host"
                                                            : "url"),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error))
                                          ],
                                        ))
                                    : null,
                                helper: InkWell(
                                    onTap: () {
                                      selectionHaptic();
                                    },
                                    splashFactory: NoSplash.splashFactory,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
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
                                              Icon(Icons.check_rounded,
                                                  color: Colors.green
                                                      .harmonizeWith(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary)),
                                              const SizedBox(width: 8),
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .settingsHostValid,
                                                  style: TextStyle(
                                                      color: Colors.green
                                                          .harmonizeWith(
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                      fontFamily: "monospace"))
                                            ],
                                          ))))
                      ]);
                      var column2 =
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        button(
                            AppLocalizations.of(context)!.settingsTitleBehavior,
                            Icons.psychology_rounded, () {
                          selectionHaptic();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenSettingsBehavior()));
                        },
                            context: context,
                            description:
                                "\n${AppLocalizations.of(context)!.settingsDescriptionBehavior}"),
                        button(
                            AppLocalizations.of(context)!
                                .settingsTitleInterface,
                            Icons.web_asset_rounded, () {
                          selectionHaptic();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenSettingsInterface()));
                        },
                            context: context,
                            description:
                                "\n${AppLocalizations.of(context)!.settingsDescriptionInterface}"),
                        (!desktopFeature(web: true))
                            ? button(
                                AppLocalizations.of(context)!
                                    .settingsTitleVoice,
                                Icons.headphones_rounded, () {
                                selectionHaptic();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenSettingsVoice()));
                              },
                                context: context,
                                description:
                                    "\n${AppLocalizations.of(context)!.settingsDescriptionVoice}")
                            : const SizedBox.shrink(),
                        button(
                            AppLocalizations.of(context)!.settingsTitleExport,
                            Icons.share_rounded, () {
                          selectionHaptic();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenSettingsExport()));
                        },
                            context: context,
                            description:
                                "\n${AppLocalizations.of(context)!.settingsDescriptionExport}"),
                        button(AppLocalizations.of(context)!.settingsTitleAbout,
                            Icons.help_rounded, () {
                          selectionHaptic();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenSettingsAbout()));
                        },
                            context: context,
                            description:
                                "\n${AppLocalizations.of(context)!.settingsDescriptionAbout}")
                      ]);
                      animatedDesktop = desktopLayoutNotRequired(context);
                      return Column(children: [
                        Expanded(
                            child: desktopLayoutNotRequired(context)
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Expanded(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                              column1,
                                              Expanded(
                                                  child: Center(
                                                      child: InkWell(
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                highlightColor:
                                                    Colors.transparent,
                                                enableFeedback: false,
                                                hoverColor: Colors.transparent,
                                                onTap: () async {
                                                  if (iconSize != 1) return;
                                                  heavyHaptic();
                                                  setState(() {
                                                    iconSize = 0.8;
                                                  });
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 200));
                                                  setState(() {
                                                    iconSize = 1.2;
                                                  });
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 200));
                                                  setState(() {
                                                    iconSize = 1;
                                                  });
                                                },
                                                child: AnimatedScale(
                                                  scale: iconSize,
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  child: const ImageIcon(
                                                      AssetImage(
                                                          "assets/logo512.png"),
                                                      size: 44),
                                                ),
                                              ))),
                                              Transform.translate(
                                                offset: const Offset(0, 8),
                                                child: button(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .settingsSavedAutomatically,
                                                    Icons.info_rounded,
                                                    null,
                                                    color: Colors.grey
                                                        .harmonizeWith(
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary)),
                                              )
                                            ])),
                                        verticalTitleDivider(context: context),
                                        Expanded(child: column2)
                                      ])
                                : ListView(children: [
                                    column1,
                                    AnimatedOpacity(
                                        opacity: animatedDesktop ? 0 : 1,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: titleDivider(bottom: 4)),
                                    AnimatedOpacity(
                                        opacity: animatedDesktop ? 0 : 1,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: column2)
                                  ])),
                        const SizedBox(height: 8),
                        desktopLayoutNotRequired(context)
                            ? const SizedBox.shrink()
                            : button(
                                AppLocalizations.of(context)!
                                    .settingsSavedAutomatically,
                                Icons.info_rounded,
                                null,
                                color: Colors.grey.harmonizeWith(
                                    Theme.of(context).colorScheme.primary))
                      ]);
                    })))));
  }
}
