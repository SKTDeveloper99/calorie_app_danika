import 'package:calorie_app_danika/health_log.dart';
import 'package:calorie_app_danika/test.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({ super.key });

  var food = "Apple";
  var appleQuantity = 1;
  var appleCalories = 95;
  var food2 = "Banana";
  var bananaQuantity = 1;
  var bananaCalories = 105;
  var food3 = "Strawberry";
  var strawberryQuantity = 1;
  var strawberryCalories = 5.75;

  addition() {
    return appleCalories * appleQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('https://rainierfruit.com/wp-content/uploads/2021/12/Rainier-Fruit-Apple.png'),
              Text(food),
              Text("You ate: " + appleQuantity.toString()),
              Text("Calories: " + appleCalories.toString()),
              Image.network('https://target.scene7.com/is/image/Target/GUEST_f5d0cfc3-9d02-4ee0-a6c6-ed5dc09971d1?wid=488&hei=488&fmt=pjpeg'),
              Text(food2),
              Text("You ate: " + bananaQuantity.toString()),
              Text("Calories: " + bananaCalories.toString()),
              Image.network('https://static.onecms.io/wp-content/uploads/sites/19/2018/02/13/strawberry-calories-hero-getty-2000.jpg'),
              Text(food3),
              Text("You ate: " + strawberryQuantity.toString()),
              Text("Calories: " + strawberryCalories.toString())
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Bird(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}

