import 'package:flutter/material.dart';
import '../size_config.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {},
              ),
              Text("MONDAY, JAN 1",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red[500],
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: LinearProgressIndicator(
                  color: const Color.fromARGB(255, 146, 235, 114),
                  backgroundColor: const Color.fromARGB(255, 195, 161, 72),
                  minHeight: SizeConfig.blockSizeVertical! * 5,
                )),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 90,
            child: Text(
              "500 Calories Left",
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, int index) {
                  return MealCard();
                }),
          )
        ],
      ),
    ));
  }
}

class MealCard extends StatefulWidget {
  const MealCard({super.key});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 22,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BREAKFAST",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Text("350 Calories Recommended",
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 5,
                  child: MealEntry(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: Text("ADD BREAKFAST")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MealEntry extends StatelessWidget {
  const MealEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cereal", style: TextStyle(fontSize: 17)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("99 cups"), Text("1000")],
        )
      ],
    );
  }
}
