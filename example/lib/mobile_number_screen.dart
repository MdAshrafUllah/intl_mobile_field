import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/flags_drop_down.dart';

class MobileNumberScreen extends StatefulWidget {
  final Function(String) onLanguageChange;
  final String currentLanguage;
  final TextDirection textDirection;
  final String Function(String, {Map<String, String>? args}) translate;

  const MobileNumberScreen({
    Key? key,
    required this.onLanguageChange,
    required this.currentLanguage,
    required this.textDirection,
    required this.translate,
  }) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController mobileControllerSeparate =
      TextEditingController();
  FocusNode focusNode = FocusNode();
  String? mobileNumber;
  String? countryCode;

  final List<Map<String, dynamic>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
  ];

  String t(String key, {Map<String, String>? args}) {
    return widget.translate(key, args: args);
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = widget.textDirection == TextDirection.rtl;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Field Example'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: !isRTL,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.currentLanguage,
                icon: const Icon(Icons.language, color: Colors.white),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                items: _languages.map((lang) {
                  return DropdownMenuItem<String>(
                    value: lang['code'],
                    child: Row(
                      children: [
                        Text(lang['flag']),
                        const SizedBox(width: 8),
                        Text(lang['name']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != widget.currentLanguage) {
                    widget.onLanguageChange(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              // Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: t('name'),
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.name,
                textAlign: isRTL ? TextAlign.end : TextAlign.start,
              ),
              const SizedBox(height: 10),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: t('email'),
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.emailAddress,
                textAlign: isRTL ? TextAlign.end : TextAlign.start,
              ),
              const SizedBox(height: 10),

              // IntlMobileField with RTL support
              // IntlMobileField(
              //   controller: mobileController,
              //   enabled: true,
              //   initialCountryCode: "BD",
              //   favorite: const ['BD', 'US', 'MY'],
              //   favoriteIcon: Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   // favoriteIconPosition: Position.leading,
              //   decoration: InputDecoration(
              //     labelText: t('mobileNumber'),
              //     hintText: t('mobileNumber'),
              //     hintTextDirection: TextDirection.ltr,
              //     alignLabelWithHint: true,
              //     errorMaxLines: 2,
              //     contentPadding: EdgeInsets.symmetric(
              //       horizontal: 10,
              //       vertical: 14,
              //     ),
              //     border: const OutlineInputBorder(),
              //   ),
              //   textAlign: isRTL ? TextAlign.end : TextAlign.start,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   invalidNumberMessage: t('invalidMobileNumber'),
              //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //   flagsButtonPadding: EdgeInsetsDirectional.only(start: 8),
              //   dropdownIconPosition:
              //       isRTL ? Position.leading : Position.trailing,
              //   dropdownIcon: Icon(
              //     Icons.keyboard_arrow_down_rounded,
              //     size: 20,
              //     color: Colors.black54,
              //   ),
              //   pickerDialogStyle: PickerDialogStyle(
              //     backgroundColor: Colors.white,
              //     width: double.infinity,
              //     listTileDivider: const Divider(),
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 16,
              //     ),
              //     searchFieldInputDecoration: InputDecoration(
              //       hintText: t('searchCountry'),
              //       contentPadding: EdgeInsets.symmetric(horizontal: 16),
              //       filled: true,
              //       prefixIconConstraints: BoxConstraints(
              //         maxWidth: 40,
              //         minHeight: 20,
              //       ),
              //       prefixIcon: Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12),
              //         child: Icon(
              //           Icons.search,
              //           color: Colors.grey,
              //         ),
              //       ),
              //       border: const OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15))),
              //       enabledBorder: const OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15))),
              //       focusedBorder: const OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15))),
              //       errorBorder: const OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15))),
              //     ),
              //     countryCodeStyle: const TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.black,
              //     ),
              //     countryNameStyle: const TextStyle(
              //       fontSize: 14,
              //       color: Colors.black87,
              //     ),
              //     searchFieldCursorColor: Colors.blue,
              //   ),
              //   dialogCountryListDense: false,
              //   languageCode: widget.currentLanguage,
              //   onCountryChanged: (country) {
              //     log('Country Dial Code: ${country.dialCode}');
              //     log('Country Code: ${country.code}');
              //   },
              //   onChanged: (MobileNumber number) {
              //     setState(() {
              //       mobileNumber = "${number.countryCode}${number.number}";
              //     });

              //     log("full Number: $mobileNumber");
              //   },
              //   onSubmitted: (_) {
              //     log('onSubmitted: ${mobileController.text}');
              //   },
              //   validator: (MobileNumber? number) {
              //     if (number == null || number.number.isEmpty) {
              //       return t('pleaseEnterMobile');
              //     }
              //     if (!RegExp(r'^[0-9]+$').hasMatch(number.number)) {
              //       return t('onlyDigitsAllowed');
              //     }
              //     if (number.number.length < 9) {
              //       return t('enterValidMobile');
              //     }
              //     return null;
              //   },
              //   favoriteIconPosition: Position.trailing,
              // ),
              // const SizedBox(height: 10),
              Row(
                spacing: 10,
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: Colors.black87),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CountryDropDown(
                      countries: countries,
                      onCountryChanged: (value) {
                        setState(() {
                          countryCode = value.dialCode;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: mobileControllerSeparate,
                      decoration: InputDecoration(
                        labelText: t('mobileNumber'),
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) {
                        log("Mobile: $countryCode$value");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(t('formSubmitted')),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Text(
                    t('submit'),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
