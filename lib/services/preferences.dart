import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

class Preferences extends ChangeNotifier {
  static final Preferences _instance = Preferences._();
  static Preferences get instance => _instance;

  Preferences._() {
    if (!prefsReady.isCompleted) {
      prefsReady.future.then((_) => notifyListeners());
    }
  }

  String? get host => prefs?.getString("host") ?? (useHost ? fixedHost : null);
  set host(String? value) {
    if (value == null || value.isEmpty) {
      prefs?.remove("host");
    } else {
      prefs?.setString("host", value);
    }
    notifyListeners();
  }

  Map<String, String> get hostHeaders =>
      (jsonDecode(prefs?.getString("hostHeaders") ?? "{}") as Map).cast();
  set hostHeaders(Map value) {
    if (value.isEmpty) {
      prefs?.remove("hostHeaders");
    } else {
      prefs?.setString("hostHeaders", jsonEncode(value));
    }
    notifyListeners();
  }

  double get timeoutMultiplier => prefs?.getDouble("timeoutMultiplier") ?? 1.0;
  set timeoutMultiplier(double value) {
    prefs?.setDouble("timeoutMultiplier", value);
    notifyListeners();
  }

  bool get useSystem => prefs?.getBool("useSystem") ?? true;
  set useSystem(bool value) {
    prefs?.setBool("useSystem", value);
    notifyListeners();
  }

  String? get system => useSystem
      ? prefs?.getString("system") ?? "You are a helpful assistant."
      : null;
  set system(String? value) {
    if (value == null || value.isEmpty) {
      prefs?.remove("system");
    } else {
      prefs?.setString("system", value);
    }
    notifyListeners();
  }

  bool get thinking => prefs?.getBool("thinking") ?? true;
  set thinking(bool value) {
    prefs?.setBool("thinking", value);
    notifyListeners();
  }

  bool get generateTitles => prefs?.getBool("generateTitles") ?? true;
  set generateTitles(bool value) {
    prefs?.setBool("generateTitles", value);
    notifyListeners();
  }

  bool get askBeforeDeletion => prefs!.getBool("askBeforeDeletion") ?? false;
  set askBeforeDeletion(bool value) {
    prefs!.setBool("askBeforeDeletion", value);
    notifyListeners();
  }

  int get keepAlive => int.parse(prefs!.getString("keepAlive") ?? "300");
  set keepAlive(int value) {
    prefs!.setString("keepAlive", value.toString());
    notifyListeners();
  }

  String? get model => prefs?.getString("model");
  set model(String? value) {
    if (value == null || value.isEmpty) {
      prefs?.remove("model");
    } else {
      prefs?.setString("model", value);
    }
    notifyListeners();
  }

  bool get welcomeFinished => prefs?.getBool("welcomeFinished") ?? false;
  set welcomeFinished(bool value) {
    prefs?.setBool("welcomeFinished", value);
    notifyListeners();
  }

  bool get enableHaptic => prefs?.getBool("enableHaptic") ?? true;
  set enableHaptic(bool value) {
    prefs?.setBool("enableHaptic", value);
    notifyListeners();
  }

  ThemeMode get themeMode =>
      ThemeMode.values.byName(prefs?.getString("themeMode") ?? "system");
  set themeMode(ThemeMode value) {
    prefs?.setString("themeMode", value.name);
    notifyListeners();
  }

  bool get themeSystem => prefs?.getBool("themeSystem") ?? false;
  set themeSystem(bool value) {
    prefs?.setBool("themeSystem", value);
    notifyListeners();
  }
}

class TimeoutMultiplier {
  static Duration calculate(Duration base) =>
      base * Preferences.instance.timeoutMultiplier;

  /// Short time interval. Equals 3 seconds with default multiplier.
  ///
  /// This multiplier should not be used for AI tasks, as it is too short.
  /// Instead, use it for quick checks or UI updates.
  static Duration get short => calculate(const Duration(seconds: 3));

  /// Medium time interval. Equals 10 seconds with default multiplier.
  static Duration get medium => calculate(const Duration(seconds: 10));

  /// Long time interval. Equals 30 seconds with default multiplier.
  static Duration get long => calculate(const Duration(seconds: 30));

  /// Very long time interval. Equals 60 seconds with default multiplier.
  static Duration get veryLong => calculate(const Duration(seconds: 60));
}
