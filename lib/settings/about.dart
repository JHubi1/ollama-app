import 'dart:io';

import 'package:flutter/material.dart';

import '../main.dart';
import '../screen_settings.dart';
import '../worker/haptic.dart';
import '../worker/update.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class ScreenSettingsAbout extends StatefulWidget {
  const ScreenSettingsAbout({super.key});

  @override
  State<ScreenSettingsAbout> createState() => _ScreenSettingsAboutState();
}

class _ScreenSettingsAboutState extends State<ScreenSettingsAbout> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    updatesSupported(setState, true);
    setState(() {});
    if (prefs!.getBool("checkUpdateOnSettingsOpen") ?? false) {
      checkUpdate(setState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              Text(AppLocalizations.of(context)!.settingsTitleAbout),
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
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    // const SizedBox(height: 8),
                    button(
                        AppLocalizations.of(context)!
                            .settingsVersion(currentVersion ?? ""),
                        Icons.verified_rounded,
                        null),
                    (updateStatus == "notAvailable")
                        ? const SizedBox.shrink()
                        : button(
                            (!updateChecked
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
                                            : (Version.parse(latestVersion ??
                                                        "1.0.0") >
                                                    Version.parse(
                                                        currentVersion ??
                                                            "2.0.0"))
                                                ? AppLocalizations.of(context)!
                                                    .settingsUpdateAvailable(
                                                        latestVersion!)
                                                : AppLocalizations.of(context)!
                                                    .settingsUpdateLatest),
                            ((updateStatus != "ok")
                                ? Icons.warning_rounded
                                : (Version.parse(latestVersion ?? "1.0.0") >
                                        Version.parse(
                                            currentVersion ?? "2.0.0"))
                                    ? Icons.info_outline_rounded
                                    : Icons.update_rounded), () {
                            if (updateLoading) return;
                            selectionHaptic();
                            if ((Version.parse(latestVersion ?? "1.0.0") >
                                    Version.parse(currentVersion ?? "2.0.0")) &&
                                (updateStatus == "ok")) {
                              updateDialog(context, title);
                            } else {
                              checkUpdate(setState);
                              return;
                            }
                          }),
                    (updateStatus == "notAvailable")
                        ? const SizedBox.shrink()
                        : toggle(
                            context,
                            AppLocalizations.of(context)!
                                .settingsCheckForUpdates,
                            (prefs!.getBool("checkUpdateOnSettingsOpen") ??
                                false), (value) {
                            selectionHaptic();
                            prefs!.setBool("checkUpdateOnSettingsOpen", value);
                            setState(() {});
                          }),
                    titleDivider(),
                    button(AppLocalizations.of(context)!.settingsGithub,
                        SimpleIcons.github, () {
                      selectionHaptic();
                      launchUrl(
                          mode: LaunchMode.inAppBrowserView,
                          Uri.parse(repoUrl));
                    }),
                    button(AppLocalizations.of(context)!.settingsReportIssue,
                        Icons.report_rounded, () {
                      selectionHaptic();
                      launchUrl(
                          mode: LaunchMode.inAppBrowserView,
                          Uri.parse("$repoUrl/issues"));
                    }),
                    button(AppLocalizations.of(context)!.settingsMainDeveloper,
                        Icons.developer_board_rounded, () {
                      selectionHaptic();
                      launchUrl(
                          mode: LaunchMode.inAppBrowserView,
                          Uri.parse(
                              repoUrl.substring(0, repoUrl.lastIndexOf('/'))));
                    }),
                    const SizedBox(height: 16)
                  ]),
                )
              ]))),
    );
  }
}
