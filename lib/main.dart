import 'package:calorie_app_danika/authentication/auth.dart';
import 'package:calorie_app_danika/home_page.dart';
// import 'package:calorie_app_danika/profile_page.dart';
import 'package:calorie_app_danika/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import 'routes.dart';
import 'size_config.dart';
import 'firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(ChangeNotifierProvider(
      create: (context) => Singleton(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // Define a method to access the state from the `MaterialApp`.
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }
}

class _MyAppState extends State<MyApp> {
  // Define a state variable for the color scheme.
  ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.grey, brightness: Brightness.light);

  // Define a method to change the color scheme.
  void changeColorScheme(Color color, bool isDarkMode) {
    setState(() {
      colorScheme = ColorScheme.fromSeed(
          seedColor: color,
          brightness: (!isDarkMode) ? Brightness.light : Brightness.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProperPlates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: colorScheme),
      routes: screenRoutes,
      // Pass the changeColorScheme method to the settings screen.
      onGenerateRoute: (settings) {
        if (settings.name == '/settings') {
          return MaterialPageRoute(
            builder: (context) =>
                SettingsScreen(onColorSelected: changeColorScheme),
          );
        }
        // Handle other routes...
      },
    );
  }
}

class startScreen extends StatelessWidget {
  const startScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Visibility(
                visible: constraints.maxWidth >= 1200,
                child: Expanded(
                  child: Container(
                    height: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Authentication Page',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 1200
                    ? constraints.maxWidth / 2
                    : constraints.maxWidth,
                child: StreamBuilder<User?>(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const HomeScreen();
                    }
                    return const AuthGate();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
