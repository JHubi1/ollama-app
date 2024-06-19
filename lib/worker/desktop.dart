import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

bool desktopFeature() {
  return (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
}

bool desktopWebFeature() {
  return (Platform.isWindows || Platform.isLinux || Platform.isMacOS || kIsWeb);
}

bool desktopLayout(BuildContext context) {
  return (desktopFeature() || MediaQuery.of(context).size.width >= 1000);
}

bool desktopLayoutRequired(BuildContext context) {
  return (desktopFeature() && MediaQuery.of(context).size.width >= 1000);
}

bool desktopWebLayout(BuildContext context) {
  return (desktopWebFeature() || MediaQuery.of(context).size.width >= 1000);
}

bool desktopWebLayoutRequired(BuildContext context) {
  return (desktopWebFeature() && MediaQuery.of(context).size.width >= 1000);
}

Widget desktopControls(BuildContext context) {
  return SizedBox(
      height: 200,
      child: WindowTitleBarBox(
          child: Row(
        children: [
          SizedBox(
              width: 46,
              height: 200,
              child: MinimizeWindowButton(
                  animate: true,
                  colors: WindowButtonColors(
                      iconNormal: Theme.of(context).colorScheme.primary))),
          SizedBox(
              width: 46,
              height: 72,
              child: MaximizeWindowButton(
                  animate: true,
                  colors: WindowButtonColors(
                      iconNormal: Theme.of(context).colorScheme.primary))),
          SizedBox(
              width: 46,
              height: 72,
              child: CloseWindowButton(
                  animate: true,
                  colors: WindowButtonColors(
                      iconNormal: Theme.of(context).colorScheme.primary))),
        ],
      )));
}

List<Widget>? desktopControlsActions(BuildContext context,
    [List<Widget>? ifNotAvailable]) {
  return desktopFeature() ? <Widget>[desktopControls(context)] : ifNotAvailable;
}
