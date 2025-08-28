import 'package:flutter/services.dart';

import 'preferences.dart';

void lightHaptic() {
  if (!Preferences.instance.enableHaptic) return;
  HapticFeedback.lightImpact();
}

void mediumHaptic() {
  if (!Preferences.instance.enableHaptic) return;
  HapticFeedback.mediumImpact();
}

void heavyHaptic() {
  if (!Preferences.instance.enableHaptic) return;
  HapticFeedback.heavyImpact();
}

void selectionHaptic() {
  if (!Preferences.instance.enableHaptic) return;
  HapticFeedback.selectionClick();
}

// MARK: Chat Haptic

const Duration _hapticChatDelay = Duration(milliseconds: 45);
DateTime _lastHapticChat = DateTime.fromMillisecondsSinceEpoch(0);

void chatHaptic() {
  if (!Preferences.instance.enableHaptic) return;

  var now = DateTime.now();
  if (now.difference(_lastHapticChat) < _hapticChatDelay) return;
  _lastHapticChat = now;

  HapticFeedback.selectionClick();
}
