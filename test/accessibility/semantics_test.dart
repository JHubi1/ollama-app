// Screen-reader semantics tests for the app's own widgets.
//
// Verifies the semantics the accessibility work added:
//   - the toggle factory exposes one merged node with label + toggled state
//   - the button factory exposes a button node with a human label
//   - the Accessibility page exposes headers, collapsible sections, labeled
//     form fields, and labeled send buttons
//   - the welcome screen labels its FAB and describes its onboarding images
//
// Voice-mode and main-app-shell semantics (voice orb, live region, logo) are
// part of the same pass but live behind speech/STT platform channels that a
// unit test environment cannot provide; they are verified by code review and
// by `flutter analyze` rather than by pumping those screens here.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';
import 'package:ollama_app/screen_settings.dart';
import 'package:ollama_app/screen_welcome.dart';
import 'package:ollama_app/settings/accessibility.dart';

import 'helpers.dart';

void main() {
  testWidgets('semantics: toggle exposes one labeled toggled node',
      (WidgetTester tester) async {
    await pumpA11y(
        tester,
        Builder(
            builder: (BuildContext context) =>
                toggle(context, 'A11y toggle probe', true, (bool _) {})));

    final Finder toggleFinder = find.byType(Switch);
    expect(toggleFinder, findsOneWidget);

    // The whole row is one semantic node announcing the label and the state.
    final Semantics semantics = tester.firstWidget<Semantics>(
        find.byWidgetPredicate((Widget widget) =>
            widget is Semantics &&
            widget.properties.label == 'A11y toggle probe'));
    expect(semantics.properties.toggled, true);
    expect(semantics.properties.enabled, true);
  });

  testWidgets('semantics: button exposes a labeled button node',
      (WidgetTester tester) async {
    await pumpA11y(
        tester, button('A11y button probe', Icons.help_outline_rounded, () {}));

    final Finder buttonSemanticsFinder = find.byWidgetPredicate(
        (Widget widget) => widget is Semantics && widget.properties.button == true);
    expect(buttonSemanticsFinder, findsOneWidget);
  });

  testWidgets('semantics: Accessibility page headers and sections',
      (WidgetTester tester) async {
    await pumpA11y(tester, const AccessibilityBody());

    final l10n = AppLocalizations.of(
        tester.element(find.byType(AccessibilityBody)))!;

    // Four collapsible sections, all collapsed by default.
    expect(find.byType(ExpansionTile), findsNWidgets(4));
    for (final ExpansionTile tile in tester.widgetList<ExpansionTile>(
        find.byType(ExpansionTile))) {
      expect(tile.initiallyExpanded, false,
          reason: 'sections must start collapsed so the page is not '
              'overwhelming');
    }

    // The top-level conformance summary is always visible.
    expect(find.text(l10n.accessibilitySummaryConformance), findsOneWidget);

    // Each section title is announced as a header.
    final Finder headerFinder = find.ancestor(
        of: find.text(l10n.accessibilityStatementTitle),
        matching: find.byType(Semantics));
    expect(headerFinder, findsWidgets);
    final Semantics headerSemantics =
        tester.firstWidget<Semantics>(headerFinder);
    expect(headerSemantics.properties.header, true);
  });

  testWidgets('semantics: Accessibility page form is labeled',
      (WidgetTester tester) async {
    await pumpA11y(tester, const AccessibilityBody());

    final l10n = AppLocalizations.of(
        tester.element(find.byType(AccessibilityBody)))!;

    // Expand the contact section so the form is in the tree.
    await tester.tap(find.text(l10n.accessibilityContactTitle));
    await tester.pumpAndSettle();

    // Labels provide each field's accessible name; the fields render.
    expect(find.text(l10n.accessibilityFormName), findsOneWidget);
    expect(find.text(l10n.accessibilityFormEmail), findsOneWidget);
    expect(find.text(l10n.accessibilityFormAssistiveTech), findsOneWidget);
    expect(find.text(l10n.accessibilityFormDescription), findsOneWidget);

    // Both send actions are exposed as buttons with labels.
    final Finder sendEmailFinder = find.ancestor(
        of: find.text(l10n.accessibilityFormSendEmail),
        matching: find.byType(Semantics));
    expect(sendEmailFinder, findsWidgets);
    final Semantics sendEmailSemantics =
        tester.firstWidget<Semantics>(sendEmailFinder);
    expect(sendEmailSemantics.properties.button, true);
  });

  testWidgets('semantics: welcome FAB tooltip and image labels',
      (WidgetTester tester) async {
    await pumpA11y(tester, const ScreenWelcome());

    expect(tester.takeException(), isNull,
        reason: 'the welcome screen crashed');

    final l10n = AppLocalizations.of(
        tester.element(find.byType(ScreenWelcome)))!;

    // The FAB announces what it does on the first page.
    final FloatingActionButton fab =
        tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
    expect(fab.tooltip, l10n.tooltipWelcomeNext);

    // Each onboarding image carries its description for screen readers.
    for (final String label in <String>[
      l10n.accessibilityWelcomePage1,
      l10n.accessibilityWelcomePage2,
      l10n.accessibilityWelcomePage3,
    ]) {
      final Finder imageSemanticsFinder = find.byWidgetPredicate(
          (Widget widget) =>
              widget is Semantics &&
              widget.properties.label == label &&
              widget.properties.image == true);
      expect(imageSemanticsFinder, findsOneWidget,
          reason: 'welcome image description "$label" missing');
    }

    // The page dots are decorative and excluded from the semantics tree.
    final Finder dotsSemantics = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(ExcludeSemantics));
    expect(dotsSemantics, findsOneWidget);
  });
}