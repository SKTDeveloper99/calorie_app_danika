import 'package:flutter/material.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';

class DailyLogScreen extends StatefulWidget {
  final entryList = ["BREAKFAST", "LUNCH", "DINNER", "SNACKS", "EXERCISE"];
  var subtitleList;
  List<Entry> entries = [
    Entry(name: "Cereal", quantity: "99 cups", calories: 1000),
  ];
  DailyLogScreen({super.key, required this.subtitleList});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  late PageController _pageController;
  // late TabController _tabController;
  int _currentPageIndex = 0;
  Map<Object?, Object?> pageData = {};
  List<dynamic> pageList = [];

  final Singleton _singleton = Singleton();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // _tabController = TabController(length: 5, vsync: this);
    if (_singleton.userdata?["daily_log"] != null) {
      // print(_singleton.userdata?["daily_log"]);
      pageData = _singleton.userdata?["daily_log"];
      pageList = pageData.keys.toList();
      print(pageList);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: _pageController,
      onPageChanged: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      itemCount: pageList.length,
      itemBuilder: (context, index) {
        return DailyLogPage(
          date: pageList[index],
          pageController: _pageController,
        );
      },
      // child: SafeArea(
      //       child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // children: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_left_rounded, size: 50),
      //         onPressed: () {},
      //       ),
      //       Text("MONDAY, JAN 1",
      //           style:
      //               TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
      //       IconButton(
      //         icon: const Icon(Icons.arrow_right_rounded, size: 50),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
      //     child: Container(
      //         decoration: BoxDecoration(
      //             // border: Border.all(
      //             //   color: Colors.red[500],
      //             // ),
      //             borderRadius: BorderRadius.all(Radius.circular(20))),
      //         child: LinearProgressIndicator(
      //           borderRadius: BorderRadius.circular(15.0),
      //           color: const Color.fromARGB(255, 146, 235, 114),
      //           backgroundColor: const Color.fromARGB(255, 159, 159, 159),
      //           minHeight: SizeConfig.blockSizeVertical! * 5,
      //         )),
      //   ),
      //   SizedBox(
      //     width: SizeConfig.blockSizeHorizontal! * 90,
      //     child: Text(
      //       "500 Calories Left",
      //       textAlign: TextAlign.end,
      //     ),
      //   ),
      //   Expanded(
      //     child: Consumer<Singleton>(
      //       builder: (context, singleton, child) {
      //         List<Entry> entries = [];
      //         // if (singleton.userdata?["daily_log"] != null) {
      //         //   for (var entry in singleton.userdata?["daily_log"]) {
      //         //     entries.add(Entry(
      //         //         name: entry["name"],
      //         //         quantity: entry["quantity"],
      //         //         calories: entry["calories"]));
      //         //   }
      //         // }

      //         return ListView.builder(
      //             itemCount: 5,
      //             itemBuilder: (_, int index) {
      //               return EntryCard(
      //                 title: widget.entryList[index],
      //                 subtitle: widget.subtitleList[index],
      //                 entries: widget.entries,
      //               );
      //             });
      //       },
      //       // child: ListView.builder(
      //       //     itemCount: 5,
      //       //     itemBuilder: (_, int index) {
      //       //       return EntryCard(
      //       //         title: widget.entryList[index],
      //       //         subtitle: widget.subtitleList[index],
      //       //         entries: widget.entries,
      //       //       );
      //       //     }),
      //     ),
      //   )
      // ],
      //       ),
      //     ),
    ));
  }
}

class EntryCard extends StatefulWidget {
  String title;
  Widget subtitle;
  List<Entry> entries;

  EntryCard(
      {super.key,
      this.title = "Meal",
      this.subtitle = const Text("100 Calories Recommended",
          style: TextStyle(fontSize: 15)),
      required this.entries});

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! *
            (25 + (widget.entries.length - 1) * 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                widget.subtitle,
                const SizedBox(height: 10),
                Expanded(
                    child: ListView.builder(
                        itemCount: widget.entries.length,
                        itemBuilder: (_, int index) {
                          return widget.entries[index];
                        })),
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
  String name;
  String quantity;
  int calories;
  String mealtype;

  Entry(
      {super.key,
      this.name = "",
      this.quantity = "",
      this.calories = 0,
      this.mealtype = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 17)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(quantity), Text(calories.toString())],
        )
      ],
    );
  }
}

class DailyLogPage extends StatefulWidget {
  String date;
  PageController pageController;
  final entryList = ["BREAKFAST", "LUNCH", "DINNER", "SNACKS", "EXERCISE"];
  var subtitleList = [
    Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
    Text("200 Calories Recommended", style: TextStyle(fontSize: 15)),
    Text("300 Calories Recommended", style: TextStyle(fontSize: 15)),
    Text("400 Calories Recommended", style: TextStyle(fontSize: 15)),
    Text("Setup Automatic Tracking", style: TextStyle(fontSize: 15)),
  ];
  List<Entry> breakfastEntries = [];
  List<Entry> lunchEntries = [];
  List<Entry> dinnerEntries = [];
  List<Entry> snackEntries = [];
  List<Entry> exerciseEntries = [];

  DailyLogPage({super.key, required this.date, required this.pageController});

  @override
  State<DailyLogPage> createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  final Singleton _singleton = Singleton();
  List<List<Entry>> entries = [];
  double calorieBudget = 0.5;

  String convertTimestampToDateString(String timestamp) {
    int numTimestamp = int.parse(timestamp);
    var date = DateTime.fromMillisecondsSinceEpoch(numTimestamp);

    // figure out which day of the week it is
    String dayOfWeek = date.weekday == 1
        ? "MONDAY"
        : date.weekday == 2
            ? "TUESDAY"
            : date.weekday == 3
                ? "WEDNESDAY"
                : date.weekday == 4
                    ? "THURSDAY"
                    : date.weekday == 5
                        ? "FRIDAY"
                        : date.weekday == 6
                            ? "SATURDAY"
                            : "SUNDAY";

    // figure out which month it is
    String month = date.month == 1
        ? "JAN"
        : date.month == 2
            ? "FEB"
            : date.month == 3
                ? "MAR"
                : date.month == 4
                    ? "APR"
                    : date.month == 5
                        ? "MAY"
                        : date.month == 6
                            ? "JUN"
                            : date.month == 7
                                ? "JUL"
                                : date.month == 8
                                    ? "AUG"
                                    : date.month == 9
                                        ? "SEP"
                                        : date.month == 10
                                            ? "OCT"
                                            : date.month == 11
                                                ? "NOV"
                                                : "DEC";

    // figure out which day of the month it is
    String dayOfMonth = date.day.toString();

    return "$dayOfWeek, $month $dayOfMonth";
  }

  void populateEntryList(collection, entryList) {
    print(collection);
    if (collection == null) {
      return;
    }
    for (var entry in collection.keys) {
      var name = entry;
      entry = collection[entry];
      print("TESTING");
      print(entry);
      entryList.add(Entry(
          name: name,
          quantity: entry["quantity"],
          calories: entry["calories"]));
    }
  }

  @override
  void initState() {
    super.initState();
    entries = [
      widget.breakfastEntries,
      widget.lunchEntries,
      widget.dinnerEntries,
      widget.snackEntries,
      widget.exerciseEntries
    ];
    if (_singleton.userdata?["daily_log"] != null) {
      print("DOWN HERE");
      // Map<String, dynamic> dailyLog =
      //     _singleton.userdata?["daily_log"][widget.date];
      // print(dailyLog);

      print(widget.date);
      print(widget.date.runtimeType);

      populateEntryList(
          _singleton.userdata?["daily_log"][widget.date]["breakfast"],
          widget.breakfastEntries);
      populateEntryList(_singleton.userdata?["daily_log"][widget.date]["lunch"],
          widget.breakfastEntries);
      populateEntryList(
          _singleton.userdata?["daily_log"][widget.date]["dinner"],
          widget.breakfastEntries);
      populateEntryList(_singleton.userdata?["daily_log"][widget.date]["snack"],
          widget.breakfastEntries);
      populateEntryList(
          _singleton.userdata?["daily_log"][widget.date]["exercise"],
          widget.breakfastEntries);

      // for (var entry in _singleton.userdata?["daily_log"][widget.date]) {
      //   if (entry.key == "breakfast") {
      //     populateEntryList(entry.value, widget.breakfastEntries);
      //   } else if (entry.key == "lunch") {
      //     populateEntryList(entry.value, widget.lunchEntries);
      //   } else if (entry.key == "dinner") {
      //     populateEntryList(entry.value, widget.dinnerEntries);
      //   } else if (entry.key == "snacks") {
      //     populateEntryList(entry.value, widget.snackEntries);
      //   } else if (entry.key == "exercise") {
      //     populateEntryList(entry.value, widget.exerciseEntries);
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left_rounded, size: 50),
                onPressed: () {
                  widget.pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              ),
              Text((convertTimestampToDateString(widget.date)),
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.arrow_right_rounded, size: 50),
                onPressed: () {
                  widget.pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
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
              // child: LinearProgressIndicator(
              //   borderRadius: BorderRadius.circular(15.0),
              //   color: const Color.fromARGB(255, 146, 235, 114),
              //   backgroundColor: const Color.fromARGB(255, 159, 159, 159),
              //   minHeight: SizeConfig.blockSizeVertical! * 5,
              // )
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: // TODO: make the colored interior rounded
                        LinearGradient(colors: const [
                      Color.fromARGB(255, 125, 176, 142),
                      Color.fromARGB(255, 146, 235, 114),
                      Colors.grey,
                    ], stops: [
                      calorieBudget / 2,
                      calorieBudget,
                      calorieBudget,
                    ])),
                child: SizedBox(height: SizeConfig.blockSizeVertical! * 4),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 90,
            child: Text(
              "500 Calories Left",
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: Consumer<Singleton>(
              builder: (context, singleton, child) {
                // List<Entry> entries = [];
                // if (singleton.userdata?["daily_log"] != null) {
                //   for (var entry in singleton.userdata?["daily_log"]) {
                //     entries.add(Entry(
                //         name: entry["name"],
                //         quantity: entry["quantity"],
                //         calories: entry["calories"]));
                //   }
                // }

                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (_, int index) {
                      return EntryCard(
                        title: widget.entryList[index],
                        subtitle: widget.subtitleList[index],
                        entries: entries[index],
                      );
                    });
              },
              // child: ListView.builder(
              //     itemCount: 5,
              //     itemBuilder: (_, int index) {
              //       return EntryCard(
              //         title: widget.entryList[index],
              //         subtitle: widget.subtitleList[index],
              //         entries: widget.entries,
              //       );
              //     }),
            ),
          )
        ],
      ),
    );
  }
}
