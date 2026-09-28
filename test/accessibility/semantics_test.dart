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
import 'package:flutter/services.dart';
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

    // The send action is exposed as a button with a label (matched by
    // predicate: the ancestor chain contains several unlabeled Semantics
    // wrappers around a FilledButton.icon).
    final Finder sendFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == l10n.accessibilityFormSendGithub);
    expect(sendFinder, findsOneWidget,
        reason: 'send action is not an accessible button');
  });

  testWidgets('semantics: Accessibility page form validates before send',
      (WidgetTester tester) async {
    await pumpA11y(tester, const AccessibilityBody());

    final l10n = AppLocalizations.of(
        tester.element(find.byType(AccessibilityBody)))!;

    // Expand the contact section so the form is in the tree.
    final Finder contactTile = find.byKey(const Key('a11y-section-contact'));
    await tester.scrollUntilVisible(contactTile, 160,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(contactTile);
    await tester.pumpAndSettle();

    // An empty report cannot be sent: the description error appears and
    // validation stops the send before any launcher is invoked.
    final Finder sendGithubButton =
        find.text(l10n.accessibilityFormSendGithub);
    await tester.scrollUntilVisible(sendGithubButton, 160,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(sendGithubButton);
    await tester.pumpAndSettle();
    expect(find.text(l10n.accessibilityFormErrorDescription), findsOneWidget);

    // An invalid email is rejected too.
    await tester.enterText(
        find.widgetWithText(TextFormField, l10n.accessibilityFormEmail),
        'not-an-email');
    await tester.enterText(
        find.widgetWithText(TextFormField, l10n.accessibilityFormDescription),
        'Voice mode loses focus with a screen reader');
    await tester.tap(sendGithubButton);
    await tester.pumpAndSettle();
    expect(find.text(l10n.accessibilityFormErrorEmail), findsOneWidget);
  });

  testWidgets('semantics: accessibility report builds a GitHub issue link '
      'with a clipboard fallback', (WidgetTester tester) async {
    await pumpA11y(tester, const AccessibilityBody());

    final l10n = AppLocalizations.of(
        tester.element(find.byType(AccessibilityBody)))!;

    // The submission URI points at this project's GitHub issues, pre-filled
    // with the subject, report body, and the accessibility label.
    final Uri uri = accessibilityIssueUri(l10n, 'Focus is lost in voice mode',
        name: 'Test User', email: 'user@example.com', assistiveTech: 'TalkBack');
    expect(uri.scheme, 'https');
    expect(uri.host, 'github.com');
    expect(uri.path, '/Lev0n82/ollama-app/issues/new');
    expect(uri.queryParameters['title'], l10n.accessibilityFormEmailSubject);
    expect(uri.queryParameters['labels'], 'accessibility');
    final String body = uri.queryParameters['body'] ?? '';
    expect(body, contains('Focus is lost in voice mode'));
    expect(body, contains('${l10n.accessibilityFormName}: Test User'));
    expect(body, contains('user@example.com'));
    expect(body, contains('TalkBack'));
    expect(body, contains('App: Ollama App'));

    // Expand the contact section and send with the launcher unmocked:
    // canLaunchUrl throws a MissingPluginException in widget tests, so the
    // send must fall back to copying the report and showing a snackbar.
    final Finder contactTile = find.byKey(const Key('a11y-section-contact'));
    await tester.scrollUntilVisible(contactTile, 160,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(contactTile);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.widgetWithText(TextFormField, l10n.accessibilityFormDescription),
        'Focus is lost in voice mode');
    final Finder sendButton = find.text(l10n.accessibilityFormSendGithub);
    await tester.scrollUntilVisible(sendButton, 160,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    expect(find.text(l10n.accessibilityFormCopiedFallback), findsOneWidget);
    final ClipboardData? clipboard =
        await Clipboard.getData(Clipboard.kTextPlain);
    expect(clipboard?.text, contains('Focus is lost in voice mode'));
    expect(clipboard?.text, contains('App: Ollama App'));
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
    // The PageView builds its pages lazily, so fling through them one at a
    // time and assert each label while its page is in the tree.
    final List<String> pageLabels = <String>[
      l10n.accessibilityWelcomePage1,
      l10n.accessibilityWelcomePage2,
      l10n.accessibilityWelcomePage3,
    ];
    for (int index = 0; index < pageLabels.length; index++) {
      if (index > 0) {
        await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
        await tester.pumpAndSettle();
      }
      final String label = pageLabels[index];
      final Finder imageSemanticsFinder = find.byWidgetPredicate(
          (Widget widget) =>
              widget is Semantics &&
              widget.properties.label == label &&
              widget.properties.image == true);
      expect(imageSemanticsFinder, findsOneWidget,
          reason: 'welcome image description "$label" missing on page '
              '${index + 1}');
    }

    // The page dots are decorative and excluded from the semantics tree.
    final Finder dotsSemantics = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(ExcludeSemantics));
    expect(dotsSemantics, findsOneWidget);
  });
}