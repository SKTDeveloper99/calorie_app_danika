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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SearchBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: Text("Scan a food item")),
                  ElevatedButton(
                      onPressed: () {}, child: Text("Scan a barcode"))
                ],
              ),
              const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
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
              FoodEntry(),
              FoodEntry(),
              FoodEntry(),
              TextButton(onPressed: () {}, child: Text("Show more options")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("Other")],
              ),
              FoodEntry()
            ],
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
                IconButton(icon: const Icon(Icons.volume_up), onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
