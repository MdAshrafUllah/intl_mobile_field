import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key, required this.mobileNumber, this.countryCode});

  final String mobileNumber;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Intl Mobile Field',
        home: Scaffold(
          appBar: AppBar(title: const Text("")),
          body: IntlMobileField(
            initialValue: mobileNumber,
            initialCountryCode: countryCode,
          ),
        ));
  }
}

void main() {
  testWidgets('Test intl_mobile_field setup with completeNumber',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      mobileNumber: '+447891234467',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test intl_mobile_field setup with Guernsey number: +441481960194',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      mobileNumber: '+441481960194',
      countryCode: 'GG',
    ));

    final countryCodeFinder = find.text('+44 1481');
    final numberFinder = find.text('960194');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('Test intl_mobile_field setup with UK number: +447891244567',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      mobileNumber: '+447891244567',
      countryCode: 'GB',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891244567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });
}
