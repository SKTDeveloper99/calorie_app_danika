import 'dart:io';

import 'package:calorie_app_danika/home_page.dart';
import 'package:calorie_app_danika/main.dart';
import 'package:calorie_app_danika/testFirebaseDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class HealthResultPage extends StatefulWidget {
  const HealthResultPage({
    super.key,
    required this.date,
    required this.breakfastInfo,
    required this.breakfastCalories,
    required this.lunchInfo,
    required this.lunchCalories,
    required this.dinnerInfo,
    required this.dinnerCalories,
    required this.morningExercises,
    required this.morningCaloriesBurned,
    required this.noonExercises,
    required this.noonCaloriesBurned,
    required this.nightExercises,
    required this.nightCaloriesBurned,
    required this.breakfastImage,
    required this.lunchImage,
    required this.dinnerImage,
  });

  final DateTime date;
  final String breakfastInfo;
  final double breakfastCalories;
  final String lunchInfo;
  final double lunchCalories;
  final String dinnerInfo;
  final double dinnerCalories;
  final String morningExercises;
  final double morningCaloriesBurned;
  final String noonExercises;
  final double noonCaloriesBurned;
  final String nightExercises;
  final double nightCaloriesBurned;
  final File breakfastImage;
  final File lunchImage;
  final File dinnerImage;

  @override
  State<HealthResultPage> createState() => _HealthResultPageState();
}

class _HealthResultPageState extends State<HealthResultPage> {
  final database = FirebaseDatabase.instance.ref();
  final storageRef = FirebaseStorage.instance.ref();
  late final DatabaseReference todayFoodRef;
  late String key;

  late User user;
  bool isLoading = false;

  String morningExercises = ' ';
  String noonExercise = ' ';
  String nightExercise = ' ';
  double breakfastValue = 0;
  double lunchValue = 0;
  double dinnerValue = 0;

  @override
  void initState() {
    user = auth.currentUser!;

    todayFoodRef = database.child("/users/${user.uid}");
    key = database.push().key.toString();

    auth.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    //controller.removeListener(_onNameChanged);
    super.dispose();
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<String> uploadBreakfastPics() async {
    String breakfastPicUrl = "";
    final breakfastUrl = storageRef.child("Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-breakfast.jpg");
    UploadTask uploadBreakfast = breakfastUrl.putFile(widget.breakfastImage);
    await uploadBreakfast.whenComplete(() async => {
      isLoading = false,
      breakfastPicUrl = await breakfastUrl.getDownloadURL(),
    });
    return breakfastPicUrl.toString();
  }

  Future<String> uploadLunchPics() async {
    String lunchPicUrl = "";
    final lunchUrl = storageRef.child("Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-lunch.jpg");
    UploadTask uploadLunch = lunchUrl.putFile(widget.lunchImage);
    await uploadLunch.whenComplete(() async => {
      isLoading = false,
      lunchPicUrl = await lunchUrl.getDownloadURL(),
    });
    return lunchPicUrl.toString();
  }

  Future<String> uploadDinnerPics() async {
    String dinnerPicUrl = "";
    final dinnerUrl = storageRef.child("Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-dinner.jpg");
    UploadTask uploadDinner = dinnerUrl.putFile(widget.dinnerImage);
    await uploadDinner.whenComplete(() async => {
      isLoading = false,
      dinnerPicUrl = await dinnerUrl.getDownloadURL(),
    });
    return dinnerPicUrl;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Health and Exercise Log Results')
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              Text(
                'Date: ${widget.date}',
                  style: TextStyle(
                fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  'Breakfast: ${widget.breakfastInfo}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Breakfast Calories: ${widget.breakfastCalories}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Image.file(widget.breakfastImage),
              const SizedBox(height: 20),
              Text(
                  'Lunch: ${widget.lunchInfo}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Lunch Calories: ${widget.lunchCalories}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Image.file(widget.lunchImage),
              const SizedBox(height: 20),
              Text(
                  'Dinner: ${widget.dinnerInfo}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Dinner Calories: ${widget.dinnerCalories}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Image.file(widget.dinnerImage),
              const SizedBox(height: 20),
              Text(
                  'Morning Workout: ${widget.morningExercises}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Morning Workout Calories Burned: ${widget.noonCaloriesBurned}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  'Noon Workout: ${widget.noonExercises}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Noon Workout Calories Burned: ${widget.noonCaloriesBurned}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  'Night Workout: ${widget.nightExercises}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                  'Night Workout Calories Burned: ${widget.nightCaloriesBurned}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final todayFood = <String, dynamic> {
                      "date": widget.date.millisecondsSinceEpoch,
                      "breakfast": widget.breakfastInfo,
                      "breakfastPicUrl": await uploadBreakfastPics(),
                      "lunch": widget.lunchInfo,
                      "lunchPicUrl": await uploadLunchPics(),
                      "dinner": widget.dinnerInfo,
                      "dinnerPicUrl": await uploadDinnerPics(),
                      "caloriesInput": widget.breakfastCalories + widget.lunchCalories + widget.dinnerCalories,
                      "caloriesExercises": widget.morningCaloriesBurned + widget.noonCaloriesBurned + widget.nightCaloriesBurned
                    };
                    todayFoodRef
                        .child("/foodlogs/${key}")
                        .set(todayFood)
                        .then((_) => print('UID of Food Log has been posted to user'))
                        .catchError((error) => print("You got error on $error"));
                    if(mounted) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          const TestRealtimeDatabase()), (Route<dynamic> route) => false);
                    }
                    },
                  child: const Text(
                    "Update your diet today!",
                      style: TextStyle(
                        fontSize: 15,
                    ),
                  ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}