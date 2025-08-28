import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Display {
  late final Size size;

  Display.from(BuildContext context) {
    size = MediaQuery.sizeOf(context);
  }

  bool get isMobile => size.width < 600;

  bool get isTabletOrLess => size.width < 1200;
  bool get isTablet => size.width >= 600 && size.width < 1200;
  bool get isTabletOrMore => size.width >= 600;

  bool get isDesktop => size.width >= 1200;
}

class LayoutFeature {
  LayoutFeature();

  static bool desktop({bool allowWeb = false}) {
    if (!kIsWeb) {
      return io.Platform.isWindows ||
          io.Platform.isLinux ||
          io.Platform.isMacOS;
    }
    return allowWeb && kIsWeb;
  }
}
