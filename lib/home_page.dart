import 'package:calorie_app_danika/screens/dashboard.dart';
import 'package:calorie_app_danika/screens/settings.dart';
import 'package:calorie_app_danika/screens/daily_log.dart';
import 'package:calorie_app_danika/screens/add_screen.dart';
import 'package:calorie_app_danika/screens/goals.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Flutter code sample for [BottomNavigationBar].

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    DailyLogScreen(subtitleList: [
      const Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      const Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      const Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      const Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: const Text("Setup Automatic Tracking",
              style: TextStyle(fontSize: 15)))
    ]),
    const AddScreen(),
    const GoalScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Singleton>(
      builder: (context, singleton, child) {
        final List<Widget> _bodyOptions = <Widget>[
          ..._widgetOptions,
          SettingsScreen(
            onColorSchemeSelected: singleton.setTheme,
          ),
        ];
        return Scaffold(
          body: Center(
            child: _bodyOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.home),
                label: 'Home',
                backgroundColor: singleton.alternateColorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.clipboard),
                label: 'Daily Log',
                backgroundColor: singleton.alternateColorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.plusCircle),
                label: 'Add',
                backgroundColor: singleton.alternateColorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.bullseye),
                label: 'My Goals',
                backgroundColor: singleton.alternateColorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: singleton.alternateColorScheme.primary,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
