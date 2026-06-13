import 'package:flutter/material.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/country_drop_down.dart';

class CountryDropDownScreen extends StatelessWidget {
  const CountryDropDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country DropDown"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text("Type : 1"),
            CountryDropDown(
              countries: countries,
              // countryCodeDisable: true,
              showFieldCountryFlag:
                  true, // default is true, if You want to hide country flag, set it to false
              showDialogCountryFlag:
                  false, // default is true, if You want to hide country flag in dialog box, set it to false
              showCountryName:
                  false, // default is true. if You want to show country name, set it to false
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
              flagWidth: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Type : 2"),
            CountryDropDown(
              countries: countries,
              // countryCodeDisable: true,
              showFieldCountryFlag: false,
              showDialogCountryFlag:
                  false, // default is true, if You want to hide country flag in dialog box, set it to false
              showCountryName:
                  false, // default is true. if You want to show country name, set it to false
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
              flagWidth: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Type : 3"),
            CountryDropDown(
              countries: countries,
              // countryCodeDisable: true,
              showFieldCountryFlag: false,
              showDialogCountryFlag:
                  false, // default is true, if You want to hide country flag in dialog box, set it to false
              showCountryName:
                  true, // default is true. if You want to show country name, set it to false
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
              flagWidth: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Type : 4"),
            CountryDropDown(
              countries: countries,
              countryCodeDisable: true,
              showFieldCountryFlag: false,
              showDialogCountryFlag:
                  false, // default is true, if You want to hide country flag in dialog box, set it to false
              showCountryName:
                  true, // default is true. if You want to show country name, set it to false
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
              flagWidth: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Type : 5"),
            CountryDropDown(
              countries: countries,
              countryCodeDisable: true,
              showFieldCountryFlag: true,
              showDialogCountryFlag:
                  false, // default is true, if You want to hide country flag in dialog box, set it to false
              showCountryName:
                  false, // default is true. if You want to show country name, set it to false
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
              flagWidth: 150,
            ),
          ],
        ),
      ),
    );
  }
}
