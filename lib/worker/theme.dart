import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

ColorScheme? colorSchemeLight;
ColorScheme? colorSchemeDark;

void resetSystemNavigation(BuildContext context,
    {Color? color,
    Color? statusBarColor,
    Color? systemNavigationBarColor,
    Duration? delay}) {
  ColorScheme getColorScheme() {
    final ColorScheme schemeLight = themeLight().colorScheme;
    final ColorScheme schemeDark = themeDark().colorScheme;
    if (themeMode() == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        return schemeLight;
      } else {
        return schemeDark;
      }
    } else {
      if (themeMode() == ThemeMode.light) {
        return schemeLight;
      } else {
        return schemeDark;
      }
    }
  }

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    color ??= getColorScheme().surface;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness:
          (((statusBarColor != null) ? statusBarColor : color)!
                      .computeLuminance() >
                  0.179)
              ? Brightness.dark
              : Brightness.light,
      statusBarColor:
          (((statusBarColor != null) ? statusBarColor : color)!.value !=
                  getColorScheme().surface.value)
              ? (statusBarColor != null)
                  ? statusBarColor
                  : color
              : Colors.transparent,
      systemNavigationBarColor:
          (systemNavigationBarColor != null) ? systemNavigationBarColor : color,
    ));
  });
}

ThemeData themeLight() {
  if (!(prefs?.getBool("useDeviceTheme") ?? false) ||
      colorSchemeLight == null) {
    return ThemeData.from(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black));
  } else {
    return ThemeData.from(colorScheme: colorSchemeLight!);
  }
}

ThemeData themeDark() {
  if (!(prefs?.getBool("useDeviceTheme") ?? false) || colorSchemeDark == null) {
    return ThemeData.from(
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.black,
            surface: Colors.black,
            onSurface: Colors.white));
  } else {
    return ThemeData.from(colorScheme: colorSchemeDark!);
  }
}

ThemeMode themeMode() {
  return ((prefs?.getString("brightness") ?? "system") == "system")
      ? ThemeMode.system
      : ((prefs!.getString("brightness") == "dark")
          ? ThemeMode.dark
          : ThemeMode.light);
}
