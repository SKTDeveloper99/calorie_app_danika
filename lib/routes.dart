import 'package:calorie_app_danika/authentication/register.dart';
import 'package:calorie_app_danika/authentication/login.dart';
import 'package:calorie_app_danika/authentication/auth.dart';
import 'package:calorie_app_danika/home_page.dart';
import 'package:calorie_app_danika/initializer.dart';
import 'main.dart';

var screenRoutes = {
  // "/": (context) => startScreen(),
  "/": (context) => Initializer(),
  // "/loginScreen": (context) => AuthGate(),
  "/loginScreen": (context) => LoginScreen(),
  "/registerScreen": (context) => RegisterScreen(),
  "/homeScreen": (context) => homeScreen(),
};
