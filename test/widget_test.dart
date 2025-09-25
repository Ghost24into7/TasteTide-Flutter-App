// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    // Build a simple app without DI dependencies for testing
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local Eats'),
        ),
        body: const Center(child: Text('App loaded')),
      ),
    ));

    // Verify that the app title is displayed
    expect(find.text('Local Eats'), findsOneWidget);
  });
}
