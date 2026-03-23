import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('App loads to login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SentryKSAApp());

    // Verify we are on the login screen
    expect(find.text("ENTER CLEARANCE CODE"), findsOneWidget);
  });
}
