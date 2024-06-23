import 'package:flutter/material.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import 'package:calorie_app_danika/size_config.dart';

class ConfirmResultsScreen extends StatefulWidget {
  final String identifiedObject;
  const ConfirmResultsScreen({super.key, required this.identifiedObject});

  @override
  State<ConfirmResultsScreen> createState() => _ConfirmResultsScreenState();
}

class _ConfirmResultsScreenState extends State<ConfirmResultsScreen> {
  final Singleton _singleton = Singleton();

  String dropdownValue = 'Breakfast';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: make the back button more obvious
        appBar: AppBar(),
        body: Center(
            child: SizedBox(
          height: SizeConfig.blockSizeVertical! * 60,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Identified Food: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.identifiedObject,
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Calories per ${widget.identifiedObject}: ",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                            (_singleton.calorieReference
                                    .containsKey(widget.identifiedObject))
                                ? "${_singleton.calorieReference[widget.identifiedObject]} kcal"
                                : "N/A",
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Quantity: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              quantity = int.parse(value);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter quantity',
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Meal Type: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: <String>[
                            'Breakfast',
                            'Lunch',
                            'Dinner',
                            'Snack'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/addScreen");
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
