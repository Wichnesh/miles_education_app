import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';
import 'package:miles_education_app/controllers/auth_controller.dart';
import 'package:miles_education_app/screens/auth/login_screen.dart';
import '../mocks/fake_auth_controller.dart';
import '../test_setup.dart';  // Import your mocks

void main() async {
  // Ensure Firebase is initialized before running tests
  setUpAll(() async {
    await testSetup();  // Call the test setup function to initialize Firebase
  });

  testWidgets('LoginScreen renders and validates form', (WidgetTester tester) async {
    // Setup test widget
    await tester.pumpWidget(
      GetMaterialApp(home: LoginScreen()),
    );

    // Your test assertions
    expect(find.text('Login'), findsOneWidget);

    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    final loginButton = find.text('Login');

    // Tap login without input
    await tester.tap(loginButton);
    await tester.pump(); // Trigger validation

    // Add input
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '123456');

    // Tap login again
    await tester.tap(loginButton);
    await tester.pump(const Duration(milliseconds: 400));

    // Ensure CircularProgressIndicator is not shown anymore
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
