import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/sensor_card.dart';

void main() {
  testWidgets('Home dashboard renders SensorCard widgets and 2-line Soil Health & Compost card', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('স্বাগতম'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'নতুন অ্যাকাউন্ট তৈরি করুন'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    expect(find.text('গাজীপুর'), findsOneWidget);
    expect(find.textContaining('জমি নির্বাচন'), findsOneWidget);
    expect(find.text('🌱 মাটির স্বাস্থ্য ও কম্পোস্ট সুপারিশ'), findsOneWidget);

    // Verify Line 1 (মাটির স্বাস্থ্য %) and Line 2 (প্রয়োজনীয় কম্পোস্ট KG)
    expect(find.text('মাটির স্বাস্থ্য: '), findsOneWidget);
    expect(find.text('89%'), findsWidgets);
    expect(find.text('প্রয়োজনীয় কম্পোস্ট'), findsWidgets);
    expect(find.text('1175 কেজি'), findsOneWidget);

    // Verify reusable SensorCard widgets render
    expect(find.byType(SensorCard), findsNWidgets(8));
    expect(find.text('আর্দ্রতা'), findsWidgets);
    expect(find.text('তাপমাত্রা'), findsWidgets);
    expect(find.text('pH লেভেল'), findsWidgets);
    expect(find.text('নাইট্রোজেন'), findsWidgets);
    expect(find.text('ফসফরাস'), findsWidgets);
    expect(find.text('পটাশিয়াম'), findsWidgets);
    expect(find.text('EC'), findsWidgets);
    expect(find.text('মাটির স্বাস্থ্য স্কোর'), findsWidgets);
  });

  testWidgets('Signup flow without role selection', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('স্বাগতম'), findsOneWidget);

    final createAccountButton = find.widgetWithText(OutlinedButton, 'নতুন অ্যাকাউন্ট তৈরি করুন');
    await tester.ensureVisible(createAccountButton);
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    expect(find.text('আমাদের সাথে যুক্ত হন'), findsOneWidget);

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), 'newuser@example.com');
    await tester.enterText(textFields.at(1), 'password123');
    await tester.enterText(textFields.at(2), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'অ্যাকাউন্ট তৈরি করুন'));
    await tester.pumpAndSettle();

    expect(find.text('গাজীপুর'), findsOneWidget);
    expect(find.textContaining('জমি নির্বাচন'), findsOneWidget);
  });

  testWidgets('Logout redirects to login page from monitor tab', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('পর্যবেক্ষণ'));
    await tester.pumpAndSettle();

    expect(find.text('লগআউট'), findsWidgets);

    await tester.tap(find.text('লগআউট').first);
    await tester.pumpAndSettle();

    expect(find.text('স্বাগতম'), findsOneWidget);
  });

  testWidgets('Monitor page shows live and compare tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('পর্যবেক্ষণ'));
    await tester.pumpAndSettle();

    expect(find.text('লাইভ'), findsWidgets);
    expect(find.text('তুলনা'), findsWidgets);
    expect(find.textContaining('নাইট্রোজেন'), findsWidgets);
  });

  testWidgets('Alerts page shows active alerts', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('সতর্কতা'));
    await tester.pumpAndSettle();

    expect(find.text('সতর্কতা'), findsWidgets);
    expect(find.textContaining('ফসফরাস কম'), findsOneWidget);
  });

  testWidgets('Graph page renders metric chips', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('গ্রাফ'));
    await tester.pumpAndSettle();

    expect(find.text('গ্রাফ বিশ্লেষণ'), findsWidgets);
    expect(find.text('আর্দ্রতা'), findsWidgets);
    expect(find.text('তাপমাত্রা'), findsWidgets);
    expect(find.text('pH'), findsWidgets);
  });

  testWidgets('Profile page renders shortcut cards', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সাইন ইন করুন'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('প্রোফাইল'));
    await tester.pumpAndSettle();

    expect(find.text('রহিম উদ্দিন'), findsOneWidget);
    expect(find.text('গাজীপুর · ৩টি জমি যুক্ত'), findsOneWidget);
    expect(find.text('জমির ম্যাপ'), findsWidgets);
    expect(find.text('ফসল পরামর্শ'), findsOneWidget);

    await tester.tap(find.text('জমির ম্যাপ').last);
    await tester.pumpAndSettle();

    expect(find.text('জমির ম্যাপ'), findsWidgets);
    expect(find.text('উত্তর মাঠ'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('নতুন জমি যোগ করুন'), findsOneWidget);

    final formFields = find.byType(TextFormField);
    await tester.enterText(formFields.at(0), 'পূর্ব মাঠ');
    await tester.enterText(formFields.at(1), 'কুমিল্লা');
    await tester.enterText(formFields.at(2), '৩.০ বিঘা');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'সংরক্ষণ করুন'));
    await tester.pumpAndSettle();

    expect(find.text('পূর্ব মাঠ'), findsOneWidget);
    expect(find.textContaining('কুমিল্লা'), findsWidgets);
  });
}
