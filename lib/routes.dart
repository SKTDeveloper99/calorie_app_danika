import 'package:calorie_app_danika/authentication/register.dart';
import 'package:calorie_app_danika/authentication/login.dart';
// import 'package:calorie_app_danika/authentication/auth.dart';
import 'package:calorie_app_danika/home_page.dart';
import 'package:calorie_app_danika/initializer.dart';
import 'package:calorie_app_danika/screens/setup.dart';
import 'package:calorie_app_danika/screens/add_screen_captures/food_camera.dart';
import 'package:calorie_app_danika/screens/add_screen.dart';
// import 'package:calorie_app_danika/screens/add_screen_captures/results.dart';
// import 'main.dart';

var screenRoutes = {
  // "/": (context) => startScreen(),
  "/": (context) => const Initializer(),
  // "/loginScreen": (context) => AuthGate(),
  "/loginScreen": (context) => const LoginScreen(),
  "/registerScreen": (context) => const RegisterScreen(),
  "/setupScreen": (context) => const SetupScreen(),
  "/homeScreen": (context) => HomeScreen(),
  "/foodCamera": (context) => FoodCamera(),
  "/addScreen": (context) => const AddScreen(),
  // "/resultsScreen": (context) => ResultScreen(identifiedObject: '',),
};
