import 'package:flutter/material.dart';
import 'package:intl_mobile_field_example/country_drop_down_screen.dart';
import 'package:intl_mobile_field_example/mobile_number_screen.dart';

class HomePage extends StatelessWidget {
  final Function(String) onLanguageChange;
  final TextDirection textDirection;
  final String Function(String, {Map<String, String>? args}) translate;

  const HomePage({
    Key? key,
    required this.onLanguageChange,
    required this.textDirection,
    required this.translate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Field Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MobileNumberScreen(
                    onLanguageChange: onLanguageChange,
                    textDirection: textDirection,
                    translate: translate,
                  ),
                ),
              ),
              child: const Text('Mobile Field'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CountryDropDownScreen(),
                ),
              ),
              child: const Text('Flag Dropdown'),
            ),
          ],
        ),
      ),
    );
  }
}
