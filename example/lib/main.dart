import 'package:flutter/material.dart';
import 'package:intl_mobile_field/flags_drop_down.dart';
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

  String? mobileNumber;

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
                IntlMobileField(
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  prefixIcon: FlagsDropDown(
                    initialCountryCode: 'BD',
                    dropdownIcon: Icon(Icons.abc),
                  ),
                  onChanged: (number) {
                    setState(() {
                      mobileNumber = "${number.countryCode}${number.number}";
                    });
                    debugPrint(
                        "Changed: ${number.countryCode}${number.number}");
                  },
                  validator: (mobileNumber) {
                    if (mobileNumber == null || mobileNumber.number.isEmpty) {
                      return 'Please, Enter a mobile number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber.number)) {
                      return 'Only digits are allowed';
                    }
                    return null;
                  },
                  suffixIcon: Icon(Icons.contacts),
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
