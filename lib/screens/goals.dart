import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../size_config.dart';
import 'package:calorie_app_danika/services/database.dart';
import 'package:calorie_app_danika/services/singleton.dart';

enum Calendar { week, month }

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final List<ChartData> chartData = [
    // ChartData(DateTime.now(), 35),
    // ChartData(DateTime.now(), 28),
    // ChartData(DateTime.now(), 34),
  ];

  Calendar calendarView = Calendar.week;
  Singleton _singleton = Singleton();

  double originalWeight = 201;
  double currentWeight = 158;
  double targetWeight = 115;

  List<double> updateChartData() {
    double lowestWeight = 1000;
    double highestWeight = 0;
    if (_singleton.userdata?['account_info']['weight_history'] != null) {
      var weightHistory =
          _singleton.userdata?['account_info']['weight_history'];

      // print("THING: $weightHistory");
      chartData.clear();

      for (var key in weightHistory.keys) {
        print("Key: $key Value: ${weightHistory[key]}");

        // convert the key to a DateTime object
        DateTime time =
            DateTime.fromMillisecondsSinceEpoch(int.parse(key) * 1000);

        print(time);

        if (weightHistory[key] < lowestWeight) {
          lowestWeight = weightHistory[key] * 1.0;
        }

        if (weightHistory[key] > highestWeight) {
          highestWeight = weightHistory[key] * 1.0;
        }

        chartData.add(ChartData(time, weightHistory[key] * 1.0));
      }

      print(chartData);
    }
    return [lowestWeight, highestWeight];
  }

  @override
  Widget build(BuildContext context) {
    double weightProgress =
        (currentWeight - targetWeight) / (originalWeight - targetWeight);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: ThemeData.dark().colorScheme.primary,
          title: Text("My Summary"),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 20.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    // TODO: the alignment of the text in the segment button is...wrong pls fix
                    width: SizeConfig.blockSizeHorizontal! * 40,
                    height: SizeConfig.blockSizeHorizontal! * 10,
                    child: SegmentedButton<Calendar>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment<Calendar>(
                            value: Calendar.week, label: Text('Week')),
                        ButtonSegment<Calendar>(
                            value: Calendar.month, label: Text('Month'))
                      ],
                      selected: <Calendar>{calendarView},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          // By default there is only a single segment that can be
                          // selected at one time, so its value is always the first
                          // item in the selected set.
                          calendarView = newSelection.first;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: 10),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 90,
                height: SizeConfig.blockSizeHorizontal! * 87,
                child: Card(
                    // TODO: make chart look exactly like figma
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("WEIGHT",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Consumer(
                        builder: (context, Singleton singleton, child) {
                          var weightRange = updateChartData();
                          return SfCartesianChart(
                              primaryYAxis: NumericAxis(
                                minimum: weightRange[0] - 10,
                                maximum: weightRange[1] + 10,
                                interval: 50,
                                // labelFormat: '{value} lbs'
                              ),
                              plotAreaBorderColor: Colors.transparent,
                              primaryXAxis: CategoryAxis(),
                              series: <CartesianSeries>[
                                // Renders line chart
                                LineSeries<ChartData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                              ]);
                        },
                      ),
                    ],
                  ),
                ))),
            SizedBox(height: 10),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 90,
                height: SizeConfig.blockSizeVertical! * 7,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => UpdateWeightPopup(),
                      );
                    },
                    child: Text(
                      "UPDATE WEIGHT",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
            SizedBox(height: 10),
            Consumer(builder: (context, Singleton singleton, child) {
              return SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 90,
                  height: SizeConfig.blockSizeHorizontal! * 45,
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MY PROGRESS",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        // title: const Text('AlertDialog Title'),
                                        content: const TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter a search term',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'DONE'),
                                            child: const Text('DONE'),
                                          ),
                                        ],
                                      ),
                                    ),
                                child: Text("Edit"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("Current"),
                                Text("158 lbs",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: [
                                Text("Left"),
                                Text("43 lbs",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: [
                                Text("Target"),
                                Text(
                                    "${_singleton.userdata?['account_info']['weight_target']} lbs",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                                    weightProgress / 2,
                                    weightProgress,
                                    weightProgress,
                                  ])),
                              child: SizedBox(
                                  height: SizeConfig.blockSizeVertical! * 4),
                            ),
                          ),
                        ),
                        // Container(
                        //     decoration: BoxDecoration(
                        //         // border: Border.all(
                        //         //   color: Colors.red[500],
                        //         // ),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(20))),
                        //     child: LinearProgressIndicator(
                        //       borderRadius: BorderRadius.circular(15.0),
                        //       color: const Color.fromARGB(255, 146, 235, 114),
                        //       backgroundColor:
                        //           const Color.fromARGB(255, 159, 159, 159),
                        //       minHeight: SizeConfig.blockSizeVertical! * 4,
                        //     ))
                      ],
                    ),
                  )));
            }),
            SizedBox(height: 10),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 90,
              height: SizeConfig.blockSizeVertical! * 7,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                  onPressed: () {},
                  child: Text(
                    "ADD PROGRESS PICTURES",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateWeightPopup extends StatefulWidget {
  UpdateWeightPopup({super.key});

  TextEditingController weightController = TextEditingController();

  @override
  State<UpdateWeightPopup> createState() => _UpdateWeightPopupState();
}

class _UpdateWeightPopupState extends State<UpdateWeightPopup> {
  // check if string only has numbers and decimal
  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // insetPadding: EdgeInsets.all(1.0),
      // title: const Text('AlertDialog Title'),
      content: SizedBox(
        width: SizeConfig.blockSizeHorizontal! * 90,
        child: TextField(
          controller: widget.weightController,
          // keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintText: 'Enter New Target Weight',
          ),
          onChanged: (value) => setState(() {}),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: (isNumeric(widget.weightController.text))
              ? () async {
                  await Database().updateWeightTarget(
                      double.parse(widget.weightController.text));
                  Navigator.pop(context, 'DONE');
                }
              : null,
          child: const Text('DONE'),
        ),
      ],
    );
  }
}
