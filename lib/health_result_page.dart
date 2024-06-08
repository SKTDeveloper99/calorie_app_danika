import 'dart:io';
import 'dart:math';

import 'package:calorie_app_danika/home_page.dart';
import 'package:calorie_app_danika/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HealthResultPage extends StatefulWidget {
  HealthResultPage({
    super.key,
    required this.date,
    required this.breakfastInfo,
    required this.breakfastCalories,
    required this.lunchInfo,
    required this.lunchCalories,
    required this.dinnerInfo,
    required this.dinnerCalories,
    required this.morningExercises,
    required this.timeMorningExercise,
    required this.noonExercises,
    required this.timeNoonExercise,
    required this.nightExercises,
    required this.timeNightExercise,
    required this.breakfastImage,
    required this.lunchImage,
    required this.dinnerImage,
  });

  final DateTime date;
  String breakfastInfo;
  double breakfastCalories;
  final String lunchInfo;
  final double lunchCalories;
  final String dinnerInfo;
  final double dinnerCalories;
  final String morningExercises;
  final double timeMorningExercise;
  final String noonExercises;
  final double timeNoonExercise;
  final String nightExercises;
  final double timeNightExercise;
  final File breakfastImage;
  final File lunchImage;
  final File dinnerImage;

  @override
  State<HealthResultPage> createState() => HealthResultPageState();
}

class HealthResultPageState extends State<HealthResultPage> {
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
  var list = ["dumpling", "fried rice", "ramen"];
  var list1 = [537, 864, 1280];
  final _random = new Random();
  late String foodBreakfast = "";
  late double caloriesBreakfast = 0;
  late String foodLunch = "";
  late double caloriesLunch = 0;
  late String foodDinner = "";
  late double caloriesDinner = 0;
  bool userInteracts() => widget.breakfastImage != null;

  @override
  void initState() {
    foodBreakfast = list[_random.nextInt(list.length)].toString();
    caloriesBreakfast = list1[_random.nextInt(list1.length)].toDouble();
    foodLunch = list[_random.nextInt(list.length)].toString();
    caloriesLunch = list1[_random.nextInt(list1.length)].toDouble();
    foodDinner = list[_random.nextInt(list.length)].toString();
    caloriesDinner = list1[_random.nextInt(list1.length)].toDouble();
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
    final breakfastUrl = storageRef.child(
        "Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-breakfast.jpg");
    UploadTask uploadBreakfast = breakfastUrl.putFile(widget.breakfastImage);
    await uploadBreakfast.whenComplete(() async => {
          isLoading = false,
          breakfastPicUrl = await breakfastUrl.getDownloadURL(),
        });
    return breakfastPicUrl.toString();
  }

  Future<String> uploadLunchPics() async {
    String lunchPicUrl = "";
    final lunchUrl = storageRef.child(
        "Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-lunch.jpg");
    UploadTask uploadLunch = lunchUrl.putFile(widget.lunchImage);
    await uploadLunch.whenComplete(() async => {
          isLoading = false,
          lunchPicUrl = await lunchUrl.getDownloadURL(),
        });
    return lunchPicUrl.toString();
  }

  Future<String> uploadDinnerPics() async {
    String dinnerPicUrl = "";
    final dinnerUrl = storageRef.child(
        "Users/${user.uid}/${widget.date.year}-${widget.date.month}-${widget.date.day}-$key-dinner.jpg");
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
      appBar: AppBar(title: const Text('Health and Exercise Log Results')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                Text(
                  'Date: ${widget.date}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: foodBreakfast,
                    hintText: 'Input the right name of your breakfast',
                  ),
                  onChanged: (value) {
                    setState(() {
                      foodBreakfast = value;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    //icon: Icon(Icons.person),
                    hintText: 'Input the estimated calorie of your food',
                    labelText: caloriesBreakfast.toString(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      caloriesBreakfast = value as double;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                SizedBox(
                    child: Image.file(
                  widget.breakfastImage,
                  scale: 0.5,
                )),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: foodLunch,
                    hintText: 'Input the right name of your lunch',
                  ),
                  onChanged: (value) {
                    setState(() {
                      foodLunch = value;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    //icon: Icon(Icons.person),
                    hintText: 'Input the estimated calorie of your food',
                    labelText: caloriesLunch.toString(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      caloriesLunch = value as double;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                SizedBox(
                  child: Image.file(
                    widget.lunchImage,
                    scale: 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: foodDinner,
                    hintText: 'Input the right name of your dinner',
                  ),
                  onChanged: (value) {
                    setState(() {
                      foodDinner = value;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    //icon: Icon(Icons.person),
                    hintText: 'Input the estimated calorie of your food',
                    labelText: caloriesDinner.toString(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      caloriesDinner = value as double;
                    });
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                Image.file(widget.dinnerImage),
                const SizedBox(height: 20),
                Text(
                  'Morning Workout: ${widget.morningExercises}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Morning Workout Calories Burned: ${widget.timeMorningExercise * 7}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Noon Workout: ${widget.noonExercises}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Noon Workout Calories Burned: ${widget.timeNoonExercise * 6}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Night Workout: ${widget.nightExercises}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Night Workout Calories Burned: ${widget.timeNightExercise * 7}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: !userInteracts()
                      ? null
                      : () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          final todayFood = <String, dynamic>{
                            "date": widget.date.millisecondsSinceEpoch,
                            // "breakfast": widget.breakfastInfo,
                            "breakfast": foodBreakfast,
                            "breakfastPicUrl": await uploadBreakfastPics(),
                            "lunch": foodLunch,
                            "lunchPicUrl": await uploadLunchPics(),
                            "dinner": foodDinner,
                            "dinnerPicUrl": await uploadDinnerPics(),
                            "caloriesInput": caloriesBreakfast +
                                caloriesLunch +
                                caloriesDinner,
                            "caloriesExercises": widget.timeMorningExercise +
                                widget.timeNoonExercise +
                                widget.timeNightExercise
                          };
                          todayFoodRef
                              .child("/foodlogs/${key}")
                              .set(todayFood)
                              .then((_) => print(
                                  'UID of Food Log has been posted to user'))
                              .catchError(
                                  (error) => print("You got error on $error"));
                          if (mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (Route<dynamic> route) => false);
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
      ),
    );
  }
}
