import 'package:flutter/material.dart';

class SafeAreaPresence extends InheritedWidget {
  final bool hasSafeAreaPadding;
  const SafeAreaPresence({
    super.key,
    required this.hasSafeAreaPadding,
    required super.child,
  });

  static SafeAreaPresence? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SafeAreaPresence>();

  static SafeAreaPresence of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, "No SafeAreaPresence found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(SafeAreaPresence oldWidget) =>
      hasSafeAreaPadding != oldWidget.hasSafeAreaPadding;
}
