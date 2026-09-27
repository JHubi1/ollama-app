// flutter_test accessibility-guideline checks for the app's own widgets.
//
// What is verified here backs the "Test results" table on the in-app
// Accessibility page (lib/settings/accessibility.dart):
//   - textContrastGuideline      -> "Contrast" check
//   - labeledTapTargetGuideline  -> "Labeled tap targets" check
//   - androidTapTargetGuideline  -> "Android tap target size" check
//   - iOSTapTargetGuideline      -> "iOS tap target size" check
//
// The probes are the shared settings factories (button / toggle) plus the
// Accessibility page itself, pumped in both light and dark themes on a small
// phone surface — the exact widgets real users interact with.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/screen_settings.dart';
import 'package:ollama_app/settings/accessibility.dart';

import 'helpers.dart';

/// The settings factories the whole app builds its controls from.
Widget _controlProbes() => ListView(children: <Widget>[
      button('A11y probe button', Icons.help_outline_rounded, () {}),
      Builder(
          builder: (BuildContext context) =>
              toggle(context, 'A11y probe toggle', true, (bool _) {})),
      Builder(
          builder: (BuildContext context) => toggle(
              context, 'A11y probe disabled toggle', false, (bool _) {},
              disabled: true)),
      button('A11y probe described button', Icons.help_outline_rounded, () {},
          description: '\nA11y probe description'),
    ]);

void main() {
  for (final Brightness brightness in Brightness.values) {
    final String theme = (brightness == Brightness.light) ? 'light' : 'dark';

    testWidgets('guidelines: control factories [$theme]',
        (WidgetTester tester) async {
      await pumpA11y(tester, _controlProbes(), brightness: brightness);

      expect(tester.takeException(), isNull,
          reason: 'control probes crashed in the $theme theme');

      await expectLater(tester, meetsGuideline(textContrastGuideline),
          reason: 'control factories violate text contrast in the $theme '
              'theme');
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline),
          reason: 'control factories have unlabeled tap targets in the '
              '$theme theme');
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline),
          reason: 'control factories violate the Android 48dp tap-target '
              'minimum in the $theme theme');
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline),
          reason: 'control factories violate the iOS 44x44dp tap-target '
              'minimum in the $theme theme');
    });

    testWidgets('guidelines: Accessibility page [$theme]',
        (WidgetTester tester) async {
      await pumpA11y(tester, const AccessibilityBody(), brightness: brightness);

      expect(tester.takeException(), isNull,
          reason: 'the Accessibility page crashed in the $theme theme');

      await expectLater(tester, meetsGuideline(textContrastGuideline),
          reason: 'the Accessibility page violates text contrast in the '
              '$theme theme');
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline),
          reason: 'the Accessibility page has unlabeled tap targets in the '
              '$theme theme');
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline),
          reason: 'the Accessibility page violates the Android 48dp '
              'tap-target minimum in the $theme theme');
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline),
          reason: 'the Accessibility page violates the iOS 44x44dp '
              'tap-target minimum in the $theme theme');
    });
  }
}