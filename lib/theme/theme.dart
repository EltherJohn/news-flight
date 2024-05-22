import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 255, 255, 255),
    primary: Color(0xFF003366), 
    secondary: Color(0xFF005B96), 
    tertiary: Color(0xFF0077CC), 
  ),
  // Define a new font color for light mode
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87), 
    bodyMedium: TextStyle(color: Colors.black87), 
    titleLarge: TextStyle(color: Colors.black), 
    // Add more text styles as needed
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF001F3F), 
    primary: Color(0xFF003366), 
    secondary: Color(0xFF005B96), 
    tertiary: Color(0xFF0077CC), 
  ),
 
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70), 
    bodyMedium: TextStyle(color: Colors.white70), 
    titleLarge: TextStyle(color: Colors.white), 
    
  ),
);



