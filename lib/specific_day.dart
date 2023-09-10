import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Text(
                  'Total Calorie Input: ${widget.info["caloriesInput"]}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              Text(
                  'Amount of Calories Burned: ${widget.info["caloriesExercises"]}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              Text(
                  'Date: ${widget.date}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Text(
                  'Breakfast: ${widget.info["breakfast"]}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              Image.network(widget.info["breakfastPicUrl"]),
              Text(
                  'Lunch: ${widget.info["lunch"]}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              Image.network(widget.info["lunchPicUrl"]),
              Text(
                  'Dinner: ${widget.info["dinner"]}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:25,
                  ),
                ),
              ),
              Image.network(widget.info["dinnerPicUrl"]),
            ],
          ),
        ),
      ),
    );
  }
}