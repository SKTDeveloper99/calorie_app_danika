import 'package:calorie_app_danika/authentication/register.dart';
import 'package:calorie_app_danika/authentication/auth.dart';
import 'package:calorie_app_danika/home_page.dart';
import 'main.dart';

var screenRoutes = {
  "/": (context) => startScreen(),
  "/loginScreen": (context) => AuthGate(),
  "/registerScreen": (context) => RegisterScreen(),
};
