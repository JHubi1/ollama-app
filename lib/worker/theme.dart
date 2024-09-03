import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../main.dart';

ColorScheme? colorSchemeLight;
ColorScheme? colorSchemeDark;

void resetSystemNavigation(BuildContext context,
    {Color? color,
    Color? statusBarColor,
    Color? systemNavigationBarColor,
    Duration? delay}) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    // ignore: use_build_context_synchronously
    color ??= themeCurrent(context).colorScheme.surface;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness:
          (((statusBarColor != null) ? statusBarColor : color)!
                      .computeLuminance() >
                  0.179)
              ? Brightness.dark
              : Brightness.light,
      statusBarColor:
          ((((statusBarColor != null) ? statusBarColor : color)!.value !=
                      // ignore: use_build_context_synchronously
                      themeCurrent(context).colorScheme.surface.value) ||
                  kIsWeb)
              ? (statusBarColor != null)
                  ? statusBarColor
                  : color
              : Colors.transparent,
      systemNavigationBarColor:
          (systemNavigationBarColor != null) ? systemNavigationBarColor : color,
    ));
  });
}

ThemeData themeModifier(ThemeData theme) {
  return theme.copyWith(
      // https://docs.flutter.dev/platform-integration/android/predictive-back#set-up-your-app
      pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  ));
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
