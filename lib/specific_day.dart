import 'package:flutter/material.dart';

class DayDetailScreen extends StatefulWidget {
  const DayDetailScreen({
    super.key,
    required this.info,
    required this.date
  });

  final Map info;
  final String date;

  @override
  State<DayDetailScreen> createState() => _DayDetailScreenState();
}

class _DayDetailScreenState extends State<DayDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.date),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Calories Total Input: ${widget.info["caloriesInput"]}'),
              Text('Calories Work Out: ${widget.info["caloriesExercises"]}'),
              Text('Super Date: ${widget.date}'),
              Text('Breakfast: ${widget.info["breakfast"]}'),
              Image.network(widget.info["breakfastPicUrl"]),
              Text('Lunch: ${widget.info["lunch"]}'),
              Image.network(widget.info["lunchPicUrl"]),
              Text('Dinner: ${widget.info["dinner"]}'),
              Image.network(widget.info["dinnerPicUrl"]),
            ],
          ),
        ),
      ),
    );
  }
}