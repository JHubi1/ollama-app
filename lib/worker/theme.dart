import 'package:flutter/material.dart';

import '../main.dart';

ColorScheme? colorSchemeLight;
ColorScheme? colorSchemeDark;

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
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
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
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
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
