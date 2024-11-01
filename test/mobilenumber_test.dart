// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/mobile_number.dart';

void main() {
  group('MobileNumber', () {
    test('create a Mobile number', () {
      MobileNumber mobileNumber = MobileNumber(
          countryISOCode: "UK", countryCode: "+44", number: "7891234567");
      String actual = mobileNumber.completeNumber;
      String expected = "+447891234567";

      expect(actual, expected);
      expect(mobileNumber.isValidNumber(), true);
    });

    test('create a Guernsey number', () {
      MobileNumber mobileNumber = MobileNumber(
          countryISOCode: "GG", countryCode: "+441481", number: "960194");
      String actual = mobileNumber.completeNumber;
      String expected = "+441481960194";

      expect(actual, expected);
      expect(mobileNumber.isValidNumber(), true);
    });

    test('look up UK as a country code', () {
      Country country = MobileNumber.getCountry("+447891234567");
      expect(country.name, "United Kingdom");
      expect(country.code, "GB");
      expect(country.regionCode, "");
    });

    test('look up Guernsey as a country code', () {
      Country country = MobileNumber.getCountry("+441481960194");
      expect(country.name, "Guernsey");
      expect(country.code, "GG");
      expect(country.regionCode, "1481");
    });

    test('create with empty complete number', () {
      MobileNumber mobileNumber =
          MobileNumber.fromCompleteNumber(completeNumber: "");
      expect(mobileNumber.countryISOCode, "");
      expect(mobileNumber.countryCode, "");
      expect(mobileNumber.number, "");
      expect(() => mobileNumber.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('create HK  number +85212345678', () {
      MobileNumber mobileNumber =
          MobileNumber.fromCompleteNumber(completeNumber: "+85212345678");
      expect(mobileNumber.countryISOCode, "HK");
      expect(mobileNumber.countryCode, "852");
      expect(mobileNumber.number, "12345678");
      expect(mobileNumber.isValidNumber(), true);
    });

    test('Number is too short number +8521234567', () {
      MobileNumber ph =
          MobileNumber.fromCompleteNumber(completeNumber: "+8521234567");
      expect(() => ph.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('cannot create from too long number +852123456789', () {
      MobileNumber ph =
          MobileNumber.fromCompleteNumber(completeNumber: "+852123456789");

      expect(() => ph.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooLongException>()));
    });

    test('create UK MobileNumber from +447891234567', () {
      MobileNumber mobileNumber =
          MobileNumber.fromCompleteNumber(completeNumber: "+447891234567");
      expect(mobileNumber.countryISOCode, "GB");
      expect(mobileNumber.countryCode, "44");
      expect(mobileNumber.number, "7891234567");
      expect(mobileNumber.isValidNumber(), true);
    });

    test('create Guernsey MobileNumber from +441481960194', () {
      MobileNumber mobileNumber =
          MobileNumber.fromCompleteNumber(completeNumber: "+441481960194");
      expect(mobileNumber.countryISOCode, "GG");
      expect(mobileNumber.countryCode, "441481");
      expect(mobileNumber.number, "960194");
      expect(mobileNumber.isValidNumber(), true);
    });

    test('create alpha character in  MobileNumber from +44abcdef', () {
      expect(() => MobileNumber.fromCompleteNumber(completeNumber: "+44abcdef"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });

    test('create alpha character in  MobileNumber from +44abcdef1', () {
      expect(
          () => MobileNumber.fromCompleteNumber(completeNumber: "+44abcdef1"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });
  });
}
