// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../lib/app/helpers/extension_helper.dart';
import '../lib/app/src/models/models.dart' as models;

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Boolean', () {
    var value = 1 / 100;

    expect(value, 0);
  });

  test('Format', () {
    // DateTime.parse("2021-05-07T14:59:17+07:00");
    DateTime date = DateTime.parse("2021-06-25");
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    print(date);

    expect(date.isAtSameMomentAs(today), true);
  });

  test('IsNull', () {
    String text;
    bool isTrue = true;
    if (isTrue != null) text = 'String';

    expect(text, 'String');
  });

  test('Time parser', () {
    print(DateTime.now().toIso8601String());
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse('07/14/2021T00:00:00');

    expect(dateTime, DateTime(2021, 07, 14));
  });

  test('Contains', () {
    String data = 'TEST ';
    String reg = r'+ data+';
    expect('Test Saja'.contains(new RegExp(data, caseSensitive: false)), true);
  });
}
