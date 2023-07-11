import 'package:calorie_app_danika/result_page.dart';
import 'package:calorie_app_danika/test.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  LogScreen({ super.key });

  var breakfast = "cereal";
  var lunch = "rice and beans";
  var dinner = "taco";
  var date = "6/16/2023";
  var date2 = "6/17/2023";
  var date3 = "6/18/2023";
  var date4 = "6/19/2023";
  var date5 = "6/20/2023";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Log'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('https://post.healthline.com/wp-content/uploads/2021/11/cereal_with_blueberries_and_milk-1296x728-header-732x549.jpg'),
              Text("Breakfast: " + breakfast),
              Text("Lunch: " + lunch),
              Text("Dinner: " + dinner),
              Text("Date: " + date),
              Image.network('https://funwithoutfodmaps.com/wp-content/uploads/2022/07/Low-FODMAP-Beef-Tacos-Square.jpg'),
              Text("Breakfast: " + breakfast),
              Text("Lunch: " + lunch),
              Text("Dinner: " + dinner),
              Text("Date: " + date2),
              Image.network('https://www.eatwell101.com/wp-content/uploads/2022/06/viral-Salmon-Rice-Bowl.jpg'),
              Text("Breakfast: " + breakfast),
              Text("Lunch: " + lunch),
              Text("Dinner: " + dinner),
              Text("Date: " + date3),
              Image.network('https://www.allrecipes.com/thmb/ggiyFcDVOLtboBdHmZbAlZ6PIcU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/14172-ceasar-salad-supreme-armag-4x3-102369087-f709f7d6e1ac402ba07335f2d18e9272.jpg'),
              Text("Breakfast: " + breakfast),
              Text("Lunch: " + lunch),
              Text("Dinner: " + dinner),
              Text("Date: " + date4),
              Image.network('https://picsum.photos/250?image=9'),
              Text("Breakfast: " + breakfast),
              Text("Lunch: " + lunch),
              Text("Dinner: " + dinner),
              Text("Date: " + date5)
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}


