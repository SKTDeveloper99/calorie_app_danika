import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../size_config.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Summary"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Week")),
              ElevatedButton(onPressed: () {}, child: Text("Month"))
            ],
          ),
          SizedBox(height: 10),
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("MY PROGRESS"),
                        TextButton(onPressed: () {}, child: Text("Edit"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [Text("Current"), Text("158 lbs")],
                        ),
                        Column(
                          children: [Text("Left"), Text("43 lbs")],
                        ),
                        Column(
                          children: [Text("Target"), Text("115 lbs")],
                        ),
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
                child: Text("ADD PROGRESS PICTURES",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
