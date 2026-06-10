// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Home dashboard renders and calculates compost', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Create an Account'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Dhaka'), findsOneWidget);
    expect(find.text('Selected Friend'), findsOneWidget);
    expect(find.text('Compost Calculator'), findsOneWidget);
    expect(find.text('Moisture'), findsWidgets);

    final homeTextField = find.byType(TextField).last;
    await tester.enterText(homeTextField, '1000');
    final enterButton = find.widgetWithText(ElevatedButton, 'Enter');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('kg compost lagbe'), findsOneWidget);
  });

  testWidgets('Signup flow without role selection', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify we're on login page
    expect(find.text('Welcome Back'), findsOneWidget);

    // Tap "Create an Account" button
    final createAccountButton = find.widgetWithText(OutlinedButton, 'Create an Account');
    await tester.ensureVisible(createAccountButton);
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    // Verify signup page loads
    expect(find.text('Join Our Community'), findsOneWidget);
    expect(find.text('Create your account to start monitoring soil health'), findsOneWidget);

    // Get all TextFields and fill them in order: email, password, confirm password
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), 'newuser@example.com');
    await tester.enterText(textFields.at(1), 'password123');
    await tester.enterText(textFields.at(2), 'password123');
    await tester.pumpAndSettle();

    // Tap "Create Account" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Dhaka'), findsOneWidget);
    expect(find.text('Selected Friend'), findsOneWidget);
  });

  testWidgets('Logout redirects to login page from monitor tab', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Monitor'));
    await tester.pumpAndSettle();

    expect(find.text('Logout'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('Alerts page shows active and resolved alert cards', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Alerts'));
    await tester.pumpAndSettle();

    expect(find.text('Alerts'), findsWidgets);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Resolved'), findsOneWidget);
    expect(find.textContaining('Low Phosphorus'), findsOneWidget);
    expect(find.textContaining('Rain expected tomorrow'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Resolve').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('Just now'), findsWidgets);
  });
}
