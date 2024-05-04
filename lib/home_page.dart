import 'package:calorie_app_danika/profile_page.dart';
import 'package:calorie_app_danika/health_log_screen.dart';
import 'package:calorie_app_danika/screens/dashboard.dart';
import 'package:calorie_app_danika/screens/settings.dart';
import 'package:calorie_app_danika/screens/daily_log.dart';
import 'package:calorie_app_danika/screens/add_screen.dart';
import 'package:calorie_app_danika/screens/goals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    DailyLogScreen(subtitleList: [
      Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
      TextButton(
          // TODO: make custom text button widget that is shorter
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child:
              Text("Setup Automatic Tracking", style: TextStyle(fontSize: 15)))
    ]),
    const AddScreen(),
    const GoalScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.home),
            label: 'home',
            backgroundColor: ThemeData.dark().colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.clipboard),
            label: 'daily log',
            backgroundColor: ThemeData.dark().colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.plusCircle),
            label: 'add',
            backgroundColor: ThemeData.dark().colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.bullseye),
            label: 'my goals',
            backgroundColor: ThemeData.dark().colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'settings',
            backgroundColor: ThemeData.dark().colorScheme.primary,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
