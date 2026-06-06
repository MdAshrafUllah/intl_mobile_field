import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl_mobile_field_example/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');
  TextDirection _textDirection = TextDirection.ltr;
  Map<String, Map<String, String>> _localizations = {};
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadLocalizations();
  }

  Future<void> _loadLocalizations() async {
    final enJson = await rootBundle.loadString('lib/l10n/en_US.json');
    final arJson = await rootBundle.loadString('lib/l10n/ar_SA.json');

    setState(() {
      _localizations = {
        'en': Map<String, String>.from(json.decode(enJson)),
        'ar': Map<String, String>.from(json.decode(arJson)),
      };
      _isLoaded = true;
    });
  }

  String _translate(String key, {Map<String, String>? args}) {
    String text = _localizations[_locale.languageCode]?[key] ?? key;
    if (args != null) {
      args.forEach((k, v) {
        text = text.replaceAll('{$k}', v);
      });
    }
    return text;
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
      _textDirection =
          languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Mobile Field Example',
      home: Directionality(
        textDirection: _textDirection,
        child: HomePage(
          onLanguageChange: _changeLanguage,
          currentLanguage: _locale.languageCode,
          textDirection: _textDirection,
          translate: _translate,
        ),
      ),
    );
  }
}
