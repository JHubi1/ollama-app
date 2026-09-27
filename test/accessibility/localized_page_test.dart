// The Accessibility page must render in every supported locale without
// crashing, with its statement/summary strings actually on screen, and the
// Persian locale must render right-to-left.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';
import 'package:ollama_app/settings/accessibility.dart';

import 'helpers.dart';

void main() {
  for (final Locale locale in AppLocalizations.supportedLocales) {
    final String tag = locale.toLanguageTag();

    testWidgets('localized a11y page: $tag renders collapsed sections',
        (WidgetTester tester) async {
      await pumpA11y(tester, const AccessibilityBody(), locale: locale);

      expect(tester.takeException(), isNull,
          reason: 'the Accessibility page crashed for locale $tag');

      final AppLocalizations l10n = AppLocalizations.of(
          tester.element(find.byType(AccessibilityBody)))!;

      // High-level view is always visible, sections start collapsed.
      expect(find.text(l10n.accessibilitySummaryConformance), findsOneWidget,
          reason: 'conformance summary missing for locale $tag');
      expect(find.byType(ExpansionTile), findsNWidgets(4),
          reason: 'the four expandable sections are missing for locale '
              '$tag');

      // The statement and contact headings render in the locale's language.
      expect(find.text(l10n.accessibilityStatementTitle), findsWidgets,
          reason: 'statement title missing for locale $tag');
      expect(find.textContaining(l10n.accessibilitySectionContactSummary),
          findsOneWidget,
          reason: 'contact section summary missing for locale $tag');

      if (locale.languageCode == 'fa') {
        expect(
            Directionality.of(tester.element(find.byType(AccessibilityBody))),
            TextDirection.rtl,
            reason: 'fa must render the Accessibility page under RTL '
                'directionality');
      }
    });

    testWidgets('localized a11y page: $tag expands every section',
        (WidgetTester tester) async {
      await pumpA11y(tester, const AccessibilityBody(), locale: locale);

      final AppLocalizations l10n = AppLocalizations.of(
          tester.element(find.byType(AccessibilityBody)))!;

      // Expand all four sections: statement, tests, standards, contact.
      //
      // The list builds children lazily: once an earlier section expands,
      // its content pushes the remaining tiles out of the build range, so
      // scroll each keyed tile back into the tree before tapping it.
      const List<Key> sectionKeys = <Key>[
        Key('a11y-section-statement'),
        Key('a11y-section-tests'),
        Key('a11y-section-standards'),
        Key('a11y-section-contact'),
      ];
      for (final Key sectionKey in sectionKeys) {
        final Finder tile = find.byKey(sectionKey);
        await tester.scrollUntilVisible(tile, 160,
            scrollable: find.byType(Scrollable).first);
        await tester.pumpAndSettle();
        await tester.tap(tile);
        await tester.pumpAndSettle();
      }

      expect(tester.takeException(), isNull,
          reason: 'expanding sections crashed for locale $tag');

      // After expansion the test-results table and the contact form are on
      // screen (long localized strings must wrap, not crash).
      expect(find.byType(TextFormField), findsNWidgets(4),
          reason: 'contact form fields missing for locale $tag');
      expect(find.text(l10n.accessibilitySupportLevelLimited), findsOneWidget,
          reason: 'the limited-support level label is missing for locale '
              '$tag');
    });
  }
}