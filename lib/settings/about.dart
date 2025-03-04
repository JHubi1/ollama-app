import 'package:flutter/material.dart';

import '../main.dart';
import '../screen_settings.dart';
import '../worker/haptic.dart';
import '../worker/update.dart';
import '../worker/desktop.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

    void setCurrentVersion(Function setState) async {
      currentVersion = (await PackageInfo.fromPlatform()).version;
      setState(() {});
    }

    if (currentVersion == null) {
      setCurrentVersion(setState);
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
              actions: desktopControlsActions(context)),
          body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
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
                                      Version.parse(
                                          currentVersion ?? "2.0.0")) &&
                                  (updateStatus == "ok")) {
                                updateDialog(context, title);
                              } else {
                                checkUpdate(setState);
                                return;
                              }
                            },
                              iconBadge: (updateStatus == "ok" &&
                                      updateDetectedOnStart &&
                                      (Version.parse(latestVersion ?? "1.0.0") >
                                          Version.parse(currentVersion ?? "2.0.0")))
                                  ? ""
                                  : null),
                      (updateStatus == "notAvailable")
                          ? const SizedBox.shrink()
                          : toggle(
                              context,
                              AppLocalizations.of(context)!
                                  .settingsCheckForUpdates,
                              (prefs!.getBool("checkUpdateOnSettingsOpen") ??
                                  true), (value) {
                              selectionHaptic();
                              prefs!
                                  .setBool("checkUpdateOnSettingsOpen", value);
                              setState(() {});
                            }),
                      titleDivider(context: context),
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
                      button(AppLocalizations.of(context)!.settingsLicenses,
                          Icons.gavel_rounded, () {
                        selectionHaptic();
                        String legal = "Copyright 2024 JHubi1";
                        Widget icon = const Padding(
                          padding: EdgeInsets.all(16),
                          child: ImageIcon(AssetImage("assets/logo512.png"),
                              size: 48),
                        );
                        if (desktopFeature()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: LicensePage(
                                      applicationName: "Ollama App",
                                      applicationVersion: currentVersion,
                                      applicationIcon: icon,
                                      applicationLegalese: legal),
                                ));
                              });
                        } else {
                          showLicensePage(
                              context: context,
                              applicationName: "Ollama App",
                              applicationVersion: currentVersion,
                              applicationIcon: icon,
                              applicationLegalese: legal);
                        }
                      }),
                      const SizedBox(height: 16)
                    ]),
                  )
                ])),
          )),
    );
  }
}
