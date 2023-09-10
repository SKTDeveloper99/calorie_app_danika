import 'dart:io';

import 'package:calorie_app_danika/health_result_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ExercisesLogPage extends StatefulWidget {
  const ExercisesLogPage({
    super.key,
    required this.date,
    required this.breakfastInfo,
    required this.breakfastCalories,
    required this.lunchInfo,
    required this.lunchCalories,
    required this.dinnerInfo,
    required this.dinnerCalories,
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
  final File breakfastImage;
  final File lunchImage;
  final File dinnerImage;
  @override
  State<ExercisesLogPage> createState() => _ExercisesLogPageState();
}

class _ExercisesLogPageState extends State<ExercisesLogPage> {
  final _formKey = GlobalKey<FormState>();
  String morningExercises = ' ';
  String noonExercises = ' ';
  String nightExercises = ' ';
  double morningCaloriesBurned = 0;
  double noonCaloriesBurned = 0;
  double nightCaloriesBurned = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Log')
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for breakfast...',
                            labelText: 'Breakfast',
                          ),
                          onChanged: (value) {
                            morningExercises = value;
                          },
                          maxLines: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Calorie Amount',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Text(
                              intl.NumberFormat.currency(
                                  symbol: "", decimalDigits: 0)
                                  .format(morningCaloriesBurned),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Slider(
                              min: 0,
                              max: 3000,
                              divisions: 500,
                              value: morningCaloriesBurned,
                              onChanged: (value) {
                                setState(() {
                                  morningCaloriesBurned = value;
                                });
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for lunch...',
                            labelText: 'Lunch',
                          ),
                          onChanged: (value) {
                            noonExercises = value;
                          },
                          maxLines: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Calorie Amount',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Text(
                              intl.NumberFormat.currency(
                                  symbol: "", decimalDigits: 0)
                                  .format(noonCaloriesBurned),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Slider(
                              min: 0,
                              max: 3000,
                              divisions: 500,
                              value: noonCaloriesBurned,
                              onChanged: (value) {
                                setState(() {
                                  noonCaloriesBurned = value;
                                });
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for dinner...',
                            labelText: 'Dinner',
                          ),
                          onChanged: (value) {
                            nightExercises = value;
                          },
                          maxLines: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Calorie Amount',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Text(
                              intl.NumberFormat.currency(
                                  symbol: "", decimalDigits: 0)
                                  .format(nightCaloriesBurned),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Slider(
                              min: 0,
                              max: 3000,
                              divisions: 500,
                              value: nightCaloriesBurned,
                              onChanged: (value) {
                                setState(() {
                                  nightCaloriesBurned = value;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HealthResultPage(
                                      date: widget.date,
                                      breakfastInfo: widget.breakfastInfo,
                                      breakfastCalories: widget.breakfastCalories,
                                      lunchInfo: widget.lunchInfo,
                                      lunchCalories: widget.lunchCalories,
                                      dinnerInfo: widget.dinnerInfo,
                                      dinnerCalories: widget.dinnerCalories,
                                      morningExercises: morningExercises,
                                      morningCaloriesBurned: morningCaloriesBurned,
                                      noonExercises: noonExercises,
                                      noonCaloriesBurned: noonCaloriesBurned,
                                      nightExercises: nightExercises,
                                      nightCaloriesBurned: nightCaloriesBurned,
                                      breakfastImage: widget.breakfastImage,
                                      lunchImage: widget.lunchImage,
                                      dinnerImage: widget.dinnerImage,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Your Exercises Results')
                        )
                      ].expand(
                            (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}