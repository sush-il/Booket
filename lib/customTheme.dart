import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      secondary: Colors.grey,
    ));

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        background: Colors.black,
        primary: Colors.white,
        secondary: Colors.grey,
        tertiary: Colors.tealAccent));
