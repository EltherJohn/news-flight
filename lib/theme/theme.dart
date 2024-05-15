import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color(0xFF003366), // Dark blue
    secondary: Color(0xFF005B96), // Medium blue
    tertiary: Color(0xFF0077CC), // Light blue
  ),
  // Define a new font color for light mode
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87), // Adjust as needed
    bodyMedium: TextStyle(color: Colors.black87), // Adjust as needed
    titleLarge: TextStyle(color: Colors.black), // Adjust as needed
    // Add more text styles as needed
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF001F3F), // Dark blue
    primary: Color(0xFF003366), // Medium blue
    secondary: Color(0xFF005B96), // Light blue
    tertiary: Color(0xFF0077CC), // Lighter blue
  ),
  // Define a new font color for dark mode
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70), // Adjust as needed
    bodyMedium: TextStyle(color: Colors.white70), // Adjust as needed
    titleLarge: TextStyle(color: Colors.white), // Adjust as needed
    // Add more text styles as needed
  ),
);



