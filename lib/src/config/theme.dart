import 'package:flutter/material.dart';

class Theme {
  const Theme();

  static const Color gradientStart = Color(0xFF2980B9);
  static const Color gradientEnd = Color(0xFF6DD5FA);

  static const gradient = LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0]);
}
