// Keyboard traversal smoke test.
//
// WCAG 2.2 / AODA require that keyboard focus follows a meaningful order
// (2.4.3 Focus Order). This test walks Tab through three labeled controls
// rendered in visual order and asserts focus lands on them in that same
// order — the baseline the app's layouts follow (controls are authored in
// visual order in the widget tree, which is also the traversal order).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('traversal: Tab moves focus in visual order',
      (WidgetTester tester) async {
    final List<FocusNode> focusNodes = <FocusNode>[
      FocusNode(debugLabel: 'first'),
      FocusNode(debugLabel: 'second'),
      FocusNode(debugLabel: 'third'),
    ];

    await pumpA11y(
      tester,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < focusNodes.length; i++)
            TextButton(
              focusNode: focusNodes[i],
              onPressed: () {},
              child: Text('Traversal target ${i + 1}'),
            ),
        ],
      ),
    );

    // Focus starts nowhere; each Tab lands on the next control in visual
    // (top-to-bottom) order.
    for (int i = 0; i < focusNodes.length; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(FocusManager.instance.primaryFocus, focusNodes[i],
          reason: 'Tab #${i + 1} must focus the control in position '
              '${i + 1}, matching the visual order');
    }
  });
}