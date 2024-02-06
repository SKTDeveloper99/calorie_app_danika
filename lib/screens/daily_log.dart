import 'package:flutter/material.dart';
import '../size_config.dart';

class DailyLogScreen extends StatefulWidget {
  final entryList = ["BREAKFAST", "LUNCH", "DINNER", "SNACKS", "EXERCISE"];
  var subtitleList;
  DailyLogScreen({super.key, required this.subtitleList});

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
            padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
            child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red[500],
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(255, 146, 235, 114),
                  backgroundColor: const Color.fromARGB(255, 159, 159, 159),
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
                  return EntryCard(
                    title: widget.entryList[index],
                    subtitle: widget.subtitleList[index],
                  );
                }),
          )
        ],
      ),
    ));
  }
}

class EntryCard extends StatefulWidget {
  String title;
  Widget subtitle;
  var entries;

  EntryCard(
      {super.key,
      this.title = "Meal",
      this.subtitle = const Text("100 Calories Recommended",
          style: TextStyle(fontSize: 15)),
      this.entries});

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
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
                  widget.title,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                widget.subtitle,
                SizedBox(height: 10),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 5,
                  child: Entry(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                            "ADD${(widget.title != 'EXERCISE') ? ' ${widget.title}' : " WORKOUT"}")),
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

class Entry extends StatelessWidget {
  var name;
  var quantity;
  var calories;

  Entry({super.key, this.name, this.quantity, this.calories});

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
