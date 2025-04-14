import 'package:flutter/material.dart';

class FlagImage extends StatelessWidget {
  final String countryCode;
  final double width;
  final double height;

  const FlagImage({
    super.key,
    required this.countryCode,
    this.width = 32,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/flags/${countryCode.toLowerCase()}.png',
      package: 'intl_mobile_field',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
