import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:customer_management/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create a customer',
      (tester) async {
    await app.main();

    await tester.pumpAndSettle();

    final Finder fab = find.byIcon(Icons.add);

    expect(fab, findsOneWidget);

    await tester.tap(fab);
    await tester.pumpAndSettle();

    final Finder firstNameField = find.byKey(
      const ValueKey('firstNameField'),
    );
    final Finder lastNameField = find.byKey(
      const ValueKey('lastNameField'),
    );
    final Finder birthDateField = find.byKey(
      const ValueKey('birthDateField'),
    );
    final Finder submitButton = find.byKey(
      const ValueKey('submitButton'),
    );

    await tester.enterText(firstNameField, 'John');
    await tester.enterText(lastNameField, 'Doe');
    await tester.enterText(birthDateField, '10/10/1990');

    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    final Finder phoneNumberField = find.byKey(
      const ValueKey('phoneNumberField'),
    );
    final Finder emailField = find.byKey(
      const ValueKey('emailField'),
    );
    final Finder bankAccountField = find.byKey(
      const ValueKey('bankAccountField'),
    );

    await tester.enterText(phoneNumberField, '9307063710');
    await tester.enterText(emailField, 'sajad@gmail.com');
    await tester.enterText(bankAccountField, '123456789');

    await tester.pumpAndSettle();
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    final Finder bankAccount = find.text('123456789');

    expect(bankAccount, findsOneWidget);
  });
}
