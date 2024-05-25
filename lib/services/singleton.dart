import 'package:flutter/widgets.dart';

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

  String serverURL = "https://calorie-app-danika.onrender.com";

  Map<String, dynamic> calorieReference = {
    "apple": 95,
    "banana": 105,
    "orange": 45,
  };
}
