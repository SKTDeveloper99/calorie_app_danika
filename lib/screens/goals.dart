import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../size_config.dart';

enum Calendar { week, month }

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final List<ChartData> chartData = [
    ChartData(1, 35),
    ChartData(8, 28),
    ChartData(15, 34),
  ];

  Calendar calendarView = Calendar.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.amberAccent,
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
                height: SizeConfig.blockSizeHorizontal! * 80,
                child: Card(
                    // TODO: make chart look exactly like figma
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("WEIGHT",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SfCartesianChart(
                          plotAreaBorderColor: Colors.transparent,
                          primaryXAxis: CategoryAxis(),
                          series: <CartesianSeries>[
                            // Renders line chart
                            LineSeries<ChartData, int>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),
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
                    onPressed: () {},
                    child: Text(
                      "UPDATE WEIGHT",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
            SizedBox(height: 10),
            SizedBox(
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
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
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
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                          Column(
                            children: [
                              Text("Left"),
                              Text("43 lbs",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                          Column(
                            children: [
                              Text("Target"),
                              Text("115 lbs",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.red[500],
                              // ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromARGB(255, 146, 235, 114),
                            backgroundColor:
                                const Color.fromARGB(255, 159, 159, 159),
                            minHeight: SizeConfig.blockSizeVertical! * 4,
                          ))
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
                  onPressed: () {},
                  child: Text(
                    "ADD PROGRESS PICTURES",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
