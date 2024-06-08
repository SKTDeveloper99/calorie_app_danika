import 'package:flutter/material.dart';
import 'package:calorie_app_danika/size_config.dart';
import 'package:calorie_app_danika/services/singleton.dart';
import 'package:calorie_app_danika/screens/add_screen_captures/confirm_results.dart';

class ResultScreen extends StatefulWidget {
  final String identifiedObject;
  const ResultScreen({super.key, required this.identifiedObject});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final Singleton _singleton = Singleton();

  TextEditingController foodController = TextEditingController();
  TextEditingController calorieController = TextEditingController();

  bool isCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      const Text("Calorie Estimation: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                          (_singleton.calorieReference
                                  .containsKey(widget.identifiedObject))
                              ? "${_singleton.calorieReference[widget.identifiedObject]} kcal"
                              : "N/A",
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2.5,
                  ),
                  const Text("Is the identified food correct?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 25,
                        child: ElevatedButton(
                            onPressed: () {
                              isCorrect = false;
                              setState(() {});
                            },
                            child: const Text('No')),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 25,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, "/homeScreen", (route) => false);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmResultsScreen(
                                              identifiedObject:
                                                  widget.identifiedObject)));
                            },
                            child: const Text('Yes')),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        (!isCorrect)
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                          "Enter the correct name of the food and the calorie amount:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: foodController,
                        decoration: const InputDecoration(hintText: 'Food:'),
                      ),
                      const TextField(
                        decoration:
                            InputDecoration(hintText: 'Calorie Amount:'),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 2.3,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 25,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Confirm')),
                      )
                    ],
                  ),
                )),
              )
            : Container(),
      ],
    ));
  }
}
