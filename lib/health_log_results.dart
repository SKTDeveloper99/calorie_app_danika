import 'package:flutter/material.dart';

class HealthLogResultsPage extends StatefulWidget {
  const HealthLogResultsPage({
    super.key,
    required this.date,
    required this.breakfastInfo,
    required this.breakfastCalories,
    required this.lunchInfo,
    required this.lunchCalories,
    required this.dinnerInfo,
    required this.dinnerCalories,
    required this.snacksInfo,
    required this.snacksCalories,
  });

  final DateTime date;
  final String breakfastInfo;
  final double breakfastCalories;
  final String lunchInfo;
  final double lunchCalories;
  final String dinnerInfo;
  final double dinnerCalories;
  final String snacksInfo;
  final double snacksCalories;

  @override
  State<HealthLogResultsPage> createState() => _HealthLogResultsPageState();
}

class _HealthLogResultsPageState extends State<HealthLogResultsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Log Results')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Super Date: ${widget.date}'),
            Text('Breakfast: ${widget.breakfastInfo}'),
            Text('Breakfast Calories: ${widget.breakfastCalories}'),
            Text('Lunch: ${widget.lunchInfo}'),
            Text('Lunch Calories: ${widget.lunchCalories}'),
            Text('Dinner: ${widget.dinnerInfo}'),
            Text('Dinner Calories: ${widget.dinnerCalories}'),
            Text('Snacks: ${widget.snacksInfo}'),
            Text('Snack Calories: ${widget.snacksCalories}'),

          ],
        ),
      ),
    );
  }
}