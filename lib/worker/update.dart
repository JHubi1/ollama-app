import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ollama_app/worker/clients.dart';
import 'package:ollama_app/worker/desktop.dart';

import 'haptic.dart';
import 'theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

import 'package:install_referrer/install_referrer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

const repoUrl = "https://github.com/JHubi1/ollama-app";

bool updateChecked = false;
bool updateLoading = false;
String updateStatus = "ok";
String? updateUrl;
String? latestVersion;
String? currentVersion;
String? updateChangeLog;
Future<bool> updatesSupported(Function setState,
    [bool takeAction = false]) async {
  bool returnValue = true;
  var installerApps = [
    "org.fdroid.fdroid",
    "org.gdroid.gdroid",
    "eu.bubu1.fdroidclassic",
    "in.sunilpaulmathew.izzyondroid",
    "com.looker.droidify",
    "com.machiav3lli.fdroid",
    "nya.kitsunyan.foxydroid"
  ];
  if (!desktopFeature(web: true)) {
    if ((await InstallReferrer.referrer !=
            InstallationAppReferrer.androidManually) ||
        (installerApps
            .contains((await InstallReferrer.app).packageName ?? ""))) {
      returnValue = false;
      if (await InstallReferrer.referrer ==
          InstallationAppReferrer.androidDebug) {
        returnValue = true;
      }
    }
    if (!repoUrl.startsWith("https://github.com")) {
      returnValue = false;
    }
  }

  if (!returnValue && takeAction) {
    setState(() {
      updateStatus = "notAvailable";
      updateLoading = false;
    });
  }
  return returnValue;
}

Future<bool> checkUpdate(Function setState) async {
  try {
    setState(() {
      updateChecked = true;
      updateLoading = true;
    });

    if (!await updatesSupported(setState)) {
      setState(() {
        updateStatus = "notAvailable";
        updateLoading = false;
      });
      return false;
    }

    var repo = repoUrl.split("/");

    currentVersion = (await PackageInfo.fromPlatform()).version;
    // currentVersion = "1.0.0";

    String? version;
    try {
      var request = await httpClient
          .get(Uri.parse(
              "https://api.github.com/repos/${repo[3]}/${repo[4]}/releases"))
          .timeout(Duration(
              milliseconds:
                  (5000.0 * (prefs!.getDouble("timeoutMultiplier") ?? 1.0))
                      .round()));
      if (request.statusCode == 403) {
        setState(() {
          updateStatus = "rateLimit";
          updateLoading = false;
        });
        return false;
      }
      version = jsonDecode(request.body)[0]["tag_name"];
      updateChangeLog = jsonDecode(request.body)[0]["body"];
      updateUrl = jsonDecode(request.body)[0]["html_url"];
    } catch (_) {
      setState(() {
        updateStatus = "error";
        updateLoading = false;
      });
      return false;
    }

    latestVersion = version;
    updateStatus = "ok";

    setState(() {
      updateLoading = false;
    });
  } catch (e) {
    setState(() {
      updateStatus = "notAvailable";
      updateLoading = false;
    });
  }
  return (updateStatus == "ok" &&
      (Version.parse(latestVersion ?? "1.0.0") >
          Version.parse(currentVersion ?? "2.0.0")));
}

void updateDialog(BuildContext context, Function title) async {
  resetSystemNavigation(context,
      systemNavigationBarColor: Color.alphaBlend(
          Colors.black54, Theme.of(context).colorScheme.surface));
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title:
                Text(AppLocalizations.of(context)!.settingsUpdateDialogTitle),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(AppLocalizations.of(context)!
                  .settingsUpdateDialogDescription),
              title(AppLocalizations.of(context)!.settingsUpdateChangeLog),
              Flexible(
                  child: SingleChildScrollView(
                      child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: MarkdownBody(
                    data: updateChangeLog ?? "No changelog given.",
                    shrinkWrap: true),
              )))
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    selectionHaptic();
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!
                      .settingsUpdateDialogCancel)),
              TextButton(
                  onPressed: () {
                    selectionHaptic();
                    Navigator.of(context).pop();
                    launchUrl(
                        mode: LaunchMode.inAppBrowserView,
                        Uri.parse(updateUrl!));
                  },
                  child: Text(
                      AppLocalizations.of(context)!.settingsUpdateDialogUpdate))
            ]);
      });
  // ignore: use_build_context_synchronously
  resetSystemNavigation(context);
}
