import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.green,
      ),
      primaryColor: Colors.green.shade800,
      accentColor: Colors.green.shade600,
    );
  }
}