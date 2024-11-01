import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controller = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Field Example'),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IntlMobileField(
                  favorite: const ['BD', 'US', 'MY'],
                  favoriteIcon: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  disableFlagTap: true,
                  favoriteIconIsLeft: false,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'BD',
                  disableLengthCounter: true,
                  languageCode: "en",
                  onChanged: (mobile) {
                    log(mobile.completeNumber);
                  },
                  onCountryChanged: (country) {
                    log('Country changed to: ${country.name}');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: MaterialButton(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        log(controller.text);
                        _formKey.currentState?.validate();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
