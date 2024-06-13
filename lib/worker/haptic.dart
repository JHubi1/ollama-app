import 'package:flutter/services.dart';
import '../main.dart';

void lightHaptic() {
  if (!(prefs!.getBool("enableHaptic") ?? true)) return;
  HapticFeedback.lightImpact();
}

void mediumHaptic() {
  if (!(prefs!.getBool("enableHaptic") ?? true)) return;
  HapticFeedback.mediumImpact();
}

void heavyHaptic() {
  if (!(prefs!.getBool("enableHaptic") ?? true)) return;
  HapticFeedback.heavyImpact();
}

void selectionHaptic() {
  if (!(prefs!.getBool("enableHaptic") ?? true)) return;
  // same name but for better experience, change behavior
  HapticFeedback.lightImpact();
  // HapticFeedback.selectionClick();
}
