import 'countries.dart';

class NumberTooLongException implements Exception {}

class NumberTooShortException implements Exception {}

class InvalidCharactersException implements Exception {}

class MobileNumber {
  String countryISOCode;
  String countryCode;
  String number;

  MobileNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  factory MobileNumber.fromCompleteNumber({required String completeNumber}) {
    if (completeNumber == "") {
      return MobileNumber(countryISOCode: "", countryCode: "", number: "");
    }

    // remove white spaces and dashes
    completeNumber = completeNumber.replaceAll(RegExp(r'\s+'), '');
    completeNumber = completeNumber.replaceAll(RegExp('-+'), '');

    try {
      Country country = getCountry(completeNumber);
      String number;
      if (completeNumber.startsWith('+')) {
        number = completeNumber
            .substring(1 + country.dialCode.length + country.regionCode.length);
      } else {
        number = completeNumber
            .substring(country.dialCode.length + country.regionCode.length);
      }
      return MobileNumber(
          countryISOCode: country.code,
          countryCode: country.dialCode + country.regionCode,
          number: number);
    } on InvalidCharactersException {
      rethrow;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      return MobileNumber(countryISOCode: "", countryCode: "", number: "");
    }
  }

  bool isValidNumber() {
    Country country = getCountry(completeNumber);
    if (number.length < country.minLength) {
      throw NumberTooShortException();
    }

    if (number.length > country.maxLength) {
      throw NumberTooLongException();
    }
    return true;
  }

  String get completeNumber {
    return countryCode + number;
  }

  static Country getCountry(String mobileNumber) {
    if (mobileNumber == "") {
      throw NumberTooShortException();
    }

    final validMobileNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validMobileNumber.hasMatch(mobileNumber)) {
      throw InvalidCharactersException();
    }

    if (mobileNumber.startsWith('+')) {
      return countries.firstWhere((country) => mobileNumber
          .substring(1)
          .startsWith(country.dialCode + country.regionCode));
    }
    return countries.firstWhere((country) =>
        mobileNumber.startsWith(country.dialCode + country.regionCode));
  }

  @override
  String toString() =>
      'Mobile Number(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
