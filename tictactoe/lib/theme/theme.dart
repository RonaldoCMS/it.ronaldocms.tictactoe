import 'package:flutter/material.dart';

ThemeData themeDefault() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade200,
    fontFamily: 'Digital',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    ),
  );
}
