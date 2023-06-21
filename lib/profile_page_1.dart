import 'package:calorie_app_danika/health_log.dart';
import 'package:flutter/material.dart';

class ProfileScreen1 extends StatelessWidget {
  ProfileScreen1({ super.key });

  var name = "Jayden";
  var age = "11";
  var healthStatus = "Healthy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
            Text("My name is " + name),
            Text("My age is " + age),
            Text("Health Status: " + healthStatus)
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LogScreen(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
