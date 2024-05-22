import 'package:flutter/material.dart';
import 'package:nf_og/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  ThemeMode get themeMode => _themeMode;

  // void toggleTheme() {
  //   if (_themeMode == ThemeMode.light) {
  //     _themeMode = ThemeMode.dark;
  //     _themeData = darkMode;
  //   } else {
  //     _themeMode = ThemeMode.light;
  //     _themeData = lightMode;
  //   }
  //   notifyListeners();
  // }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    switch (mode) {
      case ThemeMode.light:
        _themeData = lightMode;
        break;
      case ThemeMode.dark:
        _themeData = darkMode;
        break;
      case ThemeMode.system:
        _themeData = WidgetsBinding.instance.window.platformBrightness == Brightness.dark ? darkMode : lightMode;
        break;
    }
    notifyListeners();
  }
}
