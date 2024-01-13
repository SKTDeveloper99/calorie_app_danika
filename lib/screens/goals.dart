import 'package:flutter/material.dart';
import '../size_config.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Summary"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Week")),
              ElevatedButton(onPressed: () {}, child: Text("Month"))
            ],
          ),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 90,
              height: SizeConfig.blockSizeHorizontal! * 70,
              child: Card()),
        ],
      ),
    );
  }
}
