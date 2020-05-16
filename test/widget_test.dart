// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meatapp/adjust/widget.dart';

import 'package:meatapp/main.dart';
import 'package:meatapp/screens/FirestScreen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FirstScreen());

    // Verify that our counter starts at 0.
    expect(find.text('CHICKEN'), findsOneWidget);
    expect(find.text('MUTTON'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byWidget(widget: GestureDetector));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
