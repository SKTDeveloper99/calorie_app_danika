import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';

class DailyLogScreen extends StatefulWidget {
  final entryList = ["BREAKFAST", "LUNCH", "DINNER", "SNACKS", "EXERCISE"];
  final List<Widget> subtitleList;

  DailyLogScreen({super.key, required this.subtitleList});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  late PageController _pageController;
  // late TabController _tabController;

  List<Entry> entries = [
    const Entry(name: "Cereal", quantity: "99 cups", calories: 1000),
  ];

  // int _currentPageIndex = 0;
  Map<Object?, Object?> pageData = {};
  List<dynamic> pageList = [];

  final Singleton _singleton = Singleton();

  @override
  void initState() {
    super.initState();

    // _tabController = TabController(length: 5, vsync: this);
    if (_singleton.userdata?["daily_log"] != null) {
      // print(_singleton.userdata?["daily_log"]);
      pageData = _singleton.userdata?["daily_log"];
      pageList = pageData.keys.toList();

      // Reverse the list so that the most recent date is first
      pageList = pageList.reversed.toList();

      if (kDebugMode) print(pageList);
    }
    _pageController = PageController(initialPage: pageList.length - 1);
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
          // _currentPageIndex = index;
        });
      },
      itemCount: pageList.length,
      itemBuilder: (context, index) {
        return DailyLogPage(
          date: pageList[index],
          pageController: _pageController,
        );
      },
    ));
  }
}

class EntryCard extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final List<Entry> entries;

  const EntryCard(
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
  final String name;
  final String quantity;
  final int calories;
  final String mealtype;

  const Entry(
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
  final String date;
  final PageController pageController;
  final entryList = ["BREAKFAST", "LUNCH", "DINNER", "SNACKS", "EXERCISE"];
  final List<Widget> subtitleList = [
    const Text("600 Calories Recommended", style: TextStyle(fontSize: 15)),
    const Text("900 Calories Recommended", style: TextStyle(fontSize: 15)),
    const Text("900 Calories Recommended", style: TextStyle(fontSize: 15)),
    const Text("100 Calories Recommended", style: TextStyle(fontSize: 15)),
    const Text("Setup Automatic Tracking", style: TextStyle(fontSize: 15)),
  ];

  DailyLogPage({super.key, required this.date, required this.pageController});

  @override
  State<DailyLogPage> createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  final Singleton _singleton = Singleton();
  List<List<Entry>> entries = [];
  double calorieLimit = 0.5;

  double caloriesConsumed = 0;
  double calorieBudget = 0;

  List<Entry> breakfastEntries = [];
  List<Entry> lunchEntries = [];
  List<Entry> dinnerEntries = [];
  List<Entry> snackEntries = [];
  List<Entry> exerciseEntries = [];

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
    if (kDebugMode) print(collection);
    if (collection == null) {
      return;
    }
    for (var entry in collection.keys) {
      var name = entry;
      entry = collection[entry];
      if (kDebugMode) print("TESTING");
      if (kDebugMode) print(entry);
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
      breakfastEntries,
      lunchEntries,
      dinnerEntries,
      snackEntries,
      exerciseEntries
    ];
    if (_singleton.userdata?["daily_log"] != null) {
      if (kDebugMode) print("DOWN HERE");
      Map<Object?, Object?> dailyLog =
          _singleton.userdata?["daily_log"][widget.date];
      // print(dailyLog);

      if (kDebugMode) print(widget.date);
      if (kDebugMode) print(widget.date.runtimeType);

      populateEntryList(dailyLog["breakfast"], breakfastEntries);
      populateEntryList(dailyLog["lunch"], lunchEntries);
      populateEntryList(dailyLog["dinner"], dinnerEntries);
      populateEntryList(dailyLog["snack"], snackEntries);
      populateEntryList(dailyLog["exercise"], exerciseEntries);

      calorieBudget = double.parse(dailyLog["calorie_budget"].toString());

      // go through each entry and add the calories to the total
      caloriesConsumed = 0;
      for (int i = 0; i < entries.length - 1; i++) {
        var entry = entries[i];
        for (var food in entry) {
          caloriesConsumed += food.calories;
        }
      }

      // subtrack the calories from the last entry group
      for (var exercise in entries[4]) {
        caloriesConsumed -= exercise.calories;
      }

      print("Calories for date: $caloriesConsumed" + " out of $calorieBudget");
      calorieLimit = caloriesConsumed / calorieBudget;
    }
    print("ENTRIES: $entries");
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
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              ),
              Text((convertTimestampToDateString(widget.date)),
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.arrow_right_rounded, size: 50),
                onPressed: () {
                  widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
            child: Container(
              decoration: const BoxDecoration(
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
                        (calorieBudget >= caloriesConsumed)
                            ? LinearGradient(colors: const [
                                Color.fromARGB(255, 125, 176, 142),
                                Color.fromARGB(255, 146, 235, 114),
                                Colors.grey,
                              ], stops: [
                                calorieLimit / 2,
                                calorieLimit,
                                calorieLimit,
                              ])
                            : LinearGradient(colors: const [
                                Color.fromARGB(255, 176, 125, 125),
                                Color.fromARGB(255, 235, 114, 114),
                                Colors.grey,
                              ], stops: [
                                calorieLimit / 2,
                                calorieLimit,
                                calorieLimit,
                              ])),
                child: SizedBox(height: SizeConfig.blockSizeVertical! * 4),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 90,
            child: Text(
              "${(calorieBudget - caloriesConsumed).floor()} Calories Left",
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
