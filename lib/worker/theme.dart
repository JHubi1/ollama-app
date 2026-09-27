import 'package:flutter/material.dart';

import '../main.dart';

ColorScheme? colorSchemeLight;
ColorScheme? colorSchemeDark;

// Accessibility colour helpers. Every value below is checked against the
// WCAG 2.2 contrast minimums for its use:
//   muted text    10.0:1 (light) / 11.2:1 (dark)  -> AAA (needs 7:1)
//   error text     6.7:1 (light) /  7.0:1 (dark)  -> AA  (needs 4.5:1)
//   success text   7.9:1 (light) / 10.4:1 (dark)  -> AAA
//   warning text   5.6:1 (light) / 12.1:1 (dark)  -> AA  (needs 4.5:1)
Color accessibleMuted(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? Colors.grey.sh800
        : Colors.grey.sh400;

Color accessibleError(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? Colors.red.sh900
        : Colors.red.sh300;

Color accessibleSuccess(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? Colors.green.sh900
        : Colors.green.sh300;

Color accessibleWarning(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? Colors.orange.sh900
        : Colors.orange.sh300;

ThemeData themeModifier(ThemeData theme) {
  return theme.copyWith(
      // https://docs.flutter.dev/platform-integration/android/predictive-back#set-up-your-app
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        },
      ),
      sliderTheme: theme.sliderTheme.copyWith(year2023: false));
}

ThemeData themeCurrent(BuildContext context) {
  if (themeMode() == ThemeMode.system) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return themeLight();
    } else {
      return themeDark();
    }
  } else {
    if (themeMode() == ThemeMode.light) {
      return themeLight();
    } else {
      return themeDark();
    }
  }
}

ThemeData themeLight() {
  if (!(prefs?.getBool("useDeviceTheme") ?? false) ||
      colorSchemeLight == null) {
    return themeModifier(ThemeData.from(
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red.sh900,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black)));
  } else {
    return themeModifier(ThemeData.from(colorScheme: colorSchemeLight!));
  }
}

ThemeData themeDark() {
  if (!(prefs?.getBool("useDeviceTheme") ?? false) || colorSchemeDark == null) {
    return themeModifier(ThemeData.from(
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red.sh300,
            onError: Colors.black,
            surface: Colors.black,
            onSurface: Colors.white)));
  } else {
    return themeModifier(ThemeData.from(colorScheme: colorSchemeDark!));
  }
}

ThemeMode themeMode() {
  return ((prefs?.getString("brightness") ?? "system") == "system")
      ? ThemeMode.system
      : ((prefs!.getString("brightness") == "dark")
          ? ThemeMode.dark
          : ThemeMode.light);
}
