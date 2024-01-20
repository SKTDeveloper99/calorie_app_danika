import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../size_config.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ChartData> chartData = [
    ChartData("asdf", 123),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            leading: ElevatedButton(
                onPressed: () {},
                child: Image.asset("assets/empty_icon 1.png")),
            title: Text("Dashboard"),
            centerTitle: true,
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 34, 34, 34),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 35),
                Text("Weekly Summary",
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
                SizedBox(height: 10),
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
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("MONDAY, JAN 1",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 24.0)),
                                    Text("Calorie Budget: 1700",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0)),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal! *
                                                  50,
                                          height:
                                              SizeConfig.blockSizeHorizontal! *
                                                  50,
                                          child: SfCircularChart(
                                              margin: EdgeInsets.all(0.0),
                                              series: <CircularSeries>[
                                                // Renders radial bar chart
                                                // TODO: make the doughnut thinner
                                                DoughnutSeries<ChartData,
                                                        String>(
                                                    dataSource: chartData,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y)
                                              ]),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "1000",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            Text(
                                              "UNDER",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 134, 185, 142),
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 8.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Net Calories:",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18.0)),
                                        Text("1,500",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 42.0)),
                                        Text("kcal",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18.0)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text("Total:",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 15.0)),
                                        Text("1800",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 36.0)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text("Burned:",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 15.0)),
                                        Text("300",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 36.0)),
                                      ],
                                    ),
                                  ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: const Color.fromARGB(
                                          255, 146, 235, 114),
                                      backgroundColor: const Color.fromARGB(
                                          255, 159, 159, 159),
                                      minHeight:
                                          SizeConfig.blockSizeVertical! * 4,
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
                              padding: EdgeInsets.all(9.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
