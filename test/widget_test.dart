import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ollama_app/screens/settings.dart';

import 'functions.dart';

void main() {
  testWidgets("Widget: button", (WidgetTester tester) async {
    var text = random(10);
    var clicked = false;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: button(text, Icons.add_rounded, () {
      clicked = true;
    }))));

    expect(find.text(text), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
    expect(clicked, false);

    await tester.tap(find.text(text));
    await tester.pump();
    expect(clicked, true);
  });
  testWidgets("Widget: toggle", (WidgetTester tester) async {
    var text = random(10);
    var toggled = false;
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Builder(builder: (context) {
      return toggle(context, text, toggled, (value) {
        toggled = value;
      });
    }))));

    expect(find.textContaining(text), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(toggled, false);

    await tester.tap(find.textContaining(text));
    await tester.pump();
    expect(toggled, true);

    toggled = false;
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(toggled, true);
  });
}
