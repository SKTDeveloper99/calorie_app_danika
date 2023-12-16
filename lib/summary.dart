import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'size_config.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<ChartData> chartData = [
    ChartData("asdf", 123),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 34, 34, 34),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10),
                DailyRing(day: "S"),
                DailyRing(day: "M"),
                DailyRing(day: "T"),
                DailyRing(day: "W"),
                DailyRing(day: "T"),
                DailyRing(day: "F"),
                DailyRing(day: "S"),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 90,
                child: Card(
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("January 1, 2023",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30.0)),
                            Row(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 55,
                                      height:
                                          SizeConfig.blockSizeHorizontal! * 55,
                                      child: SfCircularChart(
                                          margin: EdgeInsets.all(0.0),
                                          series: <CircularSeries>[
                                            // Renders radial bar chart
                                            // TODO: make the doughnut thinner
                                            DoughnutSeries<ChartData, String>(
                                                dataSource: chartData,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y)
                                          ]),
                                    ),
                                    Text(
                                      "1000 Under",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Net Calories:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text("Total:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text("Burned:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18.0))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )))),
            SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 43,
                  height: SizeConfig.blockSizeHorizontal! * 43,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.amberAccent,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(children: [
                            Text("Steps",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30.0)),
                            Row(
                              children: [
                                Icon(Icons.run_circle),
                                Text("12,345 steps",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18.0))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.local_fire_department_outlined),
                                Text("200 cal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18.0))
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.red[500],
                                    // ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: LinearProgressIndicator(
                                  color:
                                      const Color.fromARGB(255, 146, 235, 114),
                                  backgroundColor:
                                      const Color.fromARGB(255, 195, 161, 72),
                                  minHeight: SizeConfig.blockSizeVertical! * 5,
                                ))
                          ])))),
              SizedBox(width: SizeConfig.blockSizeHorizontal! * 4),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 43,
                  height: SizeConfig.blockSizeHorizontal! * 43,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.amberAccent,
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Move",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0)),
                                      Text("150 cal",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0)),
                                    ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Exercise",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0)),
                                    Text("99 min",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Stand",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0)),
                                    Text("24 hrs",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0))
                                  ],
                                )
                              ]))))
            ])
          ],
        ),
      ),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class DailyRing extends StatelessWidget {
  DailyRing({super.key, required this.day});
  String day;
  List<ChartData> chartData = [
    ChartData("asdf", 75),
    ChartData("asdf", 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0)),
          Container(
            // color: Colors.amber,
            width: 45,
            height: 45,
            child: SfCircularChart(
                margin: EdgeInsets.all(0.0),
                series: <CircularSeries>[
                  // Renders radial bar chart
                  DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ]),
          )
        ],
      ),
    );
  }
}
