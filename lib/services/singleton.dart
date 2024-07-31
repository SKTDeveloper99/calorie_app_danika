import 'package:flutter/material.dart';
import 'package:calorie_app_danika/shared/themes.dart';

class Singleton extends ChangeNotifier {
  static final Singleton _instance = Singleton._internal();

  factory Singleton() => _instance;

  Singleton._internal();

  void notifyListenersSafe() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setUserData(Map<String, dynamic> data) {
    userdata = data;
    notifyListenersSafe();
  }

  Map<String, dynamic>? userdata;

  String serverURL = "https://calorie-app-danika.onrender.com/process_image";

  Map<String, dynamic> calorieReference = {
    "apple": 95,
    "banana": 105,
    "orange": 45,
  };

  // Add theme data
  ColorScheme colorScheme = lightRedColorScheme;
  ColorScheme alternateColorScheme = darkRedColorScheme;
  bool isDarkMode = false;

  void setTheme(ColorScheme newColorScheme, bool darkMode) {
    colorScheme = newColorScheme;

    switch (colorScheme) {
      case lightRedColorScheme:
        alternateColorScheme = darkRedColorScheme;
        break;
      case lightBlueColorScheme:
        alternateColorScheme = darkBlueColorScheme;
        break;
      case lightGreenColorScheme:
        alternateColorScheme = darkGreenColorScheme;
        break;
      case lightPurpleColorScheme:
        alternateColorScheme = darkPurpleColorScheme;
        break;
      case lightYellowColorScheme:
        alternateColorScheme = darkYellowColorScheme;
        break;
      case lightOrangeColorScheme:
        alternateColorScheme = darkOrangeColorScheme;
        break;
      case lightPinkColorScheme:
        alternateColorScheme = darkPinkColorScheme;
        break;
      case lightBrownColorScheme:
        alternateColorScheme = darkBrownColorScheme;
        break;
      case lightGreyColorScheme:
        alternateColorScheme = darkGreyColorScheme;
        break;
    }

    isDarkMode = darkMode;
    notifyListenersSafe();
  }
}
