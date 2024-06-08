import 'dart:io';

import 'package:calorie_app_danika/health_result_page.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' as intl;

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
  String morningExercises = 'No exercise';
  String noonExercises = 'No exercise';
  String nightExercises = 'No exercise';
  double timeMorningExercise = 0;
  double timeNoonExercise = 0;
  double timeNightExercise = 0;
  var activities = [
    'No exercise',
    'Running',
    'Tennis',
    'Treadmill',
    'Swimming'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Log')),
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
                        DropdownButton(
                          // Initial Value
                          value: morningExercises,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: activities.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              morningExercises = newValue!;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText:
                                    'Enter the number of minutes you exercised...',
                                labelText: 'Morning Exercise Minutes',
                              ),
                              onChanged: (value) {
                                timeMorningExercise = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        DropdownButton(
                          // Initial Value
                          value: noonExercises,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: activities.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              noonExercises = newValue!;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText:
                                    'Enter the number of minutes you exercised...',
                                labelText: 'Noon Exercise Minutes',
                              ),
                              onChanged: (value) {
                                timeNoonExercise = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        DropdownButton(
                          // Initial Value
                          value: nightExercises,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: activities.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              nightExercises = newValue!;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText:
                                    'Enter the number of minutes you exercised...',
                                labelText: 'Night Exercise Minutes',
                              ),
                              onChanged: (value) {
                                timeNightExercise = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
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
                                    timeMorningExercise: timeMorningExercise,
                                    noonExercises: noonExercises,
                                    timeNoonExercise: timeNoonExercise,
                                    nightExercises: nightExercises,
                                    timeNightExercise: timeNightExercise,
                                    breakfastImage: widget.breakfastImage,
                                    lunchImage: widget.lunchImage,
                                    dinnerImage: widget.dinnerImage,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Log Your Exercise Results'))
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
