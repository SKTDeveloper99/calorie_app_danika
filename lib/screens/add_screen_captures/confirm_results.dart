import 'package:flutter/material.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import 'package:calorie_app_danika/size_config.dart';

class ConfirmResultsScreen extends StatefulWidget {
  String identifiedObject;
  ConfirmResultsScreen({super.key, required this.identifiedObject});

  String dropdownValue = 'Breakfast';
  int quantity = 1;

  @override
  State<ConfirmResultsScreen> createState() => _ConfirmResultsScreenState();
}

class _ConfirmResultsScreenState extends State<ConfirmResultsScreen> {
  Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text('Identified Food: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.identifiedObject,
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Calories per ${widget.identifiedObject}: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                            (_singleton.calorieReference
                                    .containsKey(widget.identifiedObject))
                                ? "${_singleton.calorieReference[widget.identifiedObject]} kcal"
                                : "N/A",
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Quantity: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              widget.quantity = int.parse(value);
                            },
                            decoration: InputDecoration(
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
                        Text("Meal Type: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        DropdownButton<String>(
                          value: widget.dropdownValue,
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
                              widget.dropdownValue = value!;
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
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
