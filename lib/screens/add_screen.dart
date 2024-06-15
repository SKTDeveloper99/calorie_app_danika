import 'package:calorie_app_danika/services/singleton.dart';
import 'package:calorie_app_danika/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> mealOptions = <String>[
  'Breakfast',
  'Lunch',
  'Dinner',
  'Snacks'
];

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String dropdownValue = mealOptions.first;
  final Singleton singleton = Singleton();
  bool showMore = false;

  List<FoodEntry> foodEntries = <FoodEntry>[];

  void addFoodEntries() {
    foodEntries.clear();
    Map<String, dynamic> data = singleton.calorieReference;

    data.forEach((key, value) {
      foodEntries.add(FoodEntry(foodName: key, calories: value));
    });

    print(foodEntries);
  }

  @override
  Widget build(BuildContext context) {
    addFoodEntries();
    print(showMore);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchBar(), // TODO: implement search bar in an update
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 10,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/foodCamera");
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt),
                              Text("Scan a food item"),
                            ],
                          )),
                    ),
                    // TODO: re-enable the barcode scanner in the next update
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 10,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.barcode),
                              Text("Scan a barcode"),
                            ],
                          )),
                    ),
                  ],
                ),
                // TODO: implement the tab bar and contents in an update
                // const TabBar(
                //   labelColor: Colors.red,
                //   indicatorColor: Colors.blue,
                //   tabs: [
                //     Tab(text: "All"),
                //     Tab(text: "My foods"),
                //     Tab(
                //       text: "My recipes",
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recently Added"),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: mealOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                // FoodEntry(),
                // FoodEntry(),
                // FoodEntry(),
                SizedBox(
                  height: (!showMore)
                      ? SizeConfig.blockSizeVertical! * 30
                      : SizeConfig.blockSizeVertical! * 10 * foodEntries.length,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: (!showMore && foodEntries.length >= 3)
                          ? 3
                          : foodEntries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return foodEntries[index];
                      }),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                        "Show more options")), // show more cards if applicable
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Other")],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                  child: Card(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Calories"),
                            IconButton(
                                icon: const Icon(Icons.add), onPressed: () {})
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class FoodEntry extends StatelessWidget {
  const FoodEntry({super.key, required this.foodName, required this.calories});
  final String foodName;
  final int calories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(foodName), Text("$calories kcal")],
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
