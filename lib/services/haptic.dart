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

  final now = DateTime.now();
  if (now.difference(_lastHapticChat) < _hapticChatDelay) return;
  _lastHapticChat = now;

  HapticFeedback.selectionClick();
}

const Duration _hapticThinkingDelay = Duration(milliseconds: 150);
DateTime _lastHapticThinking = DateTime.fromMillisecondsSinceEpoch(0);

void chatHapticThinking() {
  if (!Preferences.instance.enableHaptic) return;

  final now = DateTime.now();
  if (now.difference(_lastHapticThinking) < _hapticThinkingDelay) return;
  _lastHapticThinking = now;

  HapticFeedback.successNotification();
}
