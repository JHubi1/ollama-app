// Shared helpers for the accessibility widget-test suite.
//
// Everything here pumps real app widgets (the settings factories, the
// Accessibility page) inside a MaterialApp using the app's own themes and
// localization setup, on a small phone-sized surface.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';
import 'package:ollama_app/worker/theme.dart';

/// Surface every accessibility probe is pumped into (a small phone).
const Size a11ySurface = Size(360, 640);

/// Pumps [child] inside a MaterialApp using the real app theme and the
/// given [locale], wrapped in a SizedBox the size of [a11ySurface].
///
/// The app's real localization setup is used so accessibility labels resolve
/// exactly as they do at runtime (including the fr-CA / pt-BR variants).
Future<void> pumpA11y(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
  Brightness brightness = Brightness.light,
}) async {
  await tester.pumpWidget(
    SizedBox(
      width: a11ySurface.width,
      height: a11ySurface.height,
      child: MaterialApp(
        theme: (brightness == Brightness.light) ? themeLight() : themeDark(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pumpAndSettle();
}