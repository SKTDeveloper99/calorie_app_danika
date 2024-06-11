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
  @override
  Widget build(BuildContext context) {
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
                // SearchBar(), // TODO: implement search bar in an update
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
                    // SizedBox(
                    //   height: SizeConfig.blockSizeVertical! * 10,
                    //   child: ElevatedButton(
                    //       onPressed: () {},
                    //       child: const Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Icon(CupertinoIcons.barcode),
                    //           Text("Scan a barcode"),
                    //         ],
                    //       )),
                    // ),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Recently Added"),
                //     DropdownButton<String>(
                //       value: dropdownValue,
                //       icon: const Icon(Icons.arrow_downward),
                //       elevation: 16,
                //       style: const TextStyle(color: Colors.deepPurple),
                //       underline: Container(
                //         height: 2,
                //         color: Colors.deepPurpleAccent,
                //       ),
                //       onChanged: (String? value) {
                //         // This is called when the user selects an item.
                //         setState(() {
                //           dropdownValue = value!;
                //         });
                //       },
                //       items: mealOptions
                //           .map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     )
                //   ],
                // ),
                // FoodEntry(),
                // FoodEntry(),
                // FoodEntry(),
                // TextButton(onPressed: () {}, child: Text("Show more options")),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [Text("Other")],
                // ),
                // FoodEntry()
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class FoodEntry extends StatelessWidget {
  const FoodEntry({super.key});

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
                  children: [Text("Cereal"), Text("99 cups, 1000 cal")],
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
