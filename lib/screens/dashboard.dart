import 'package:calorie_app_danika/services/singleton.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:calorie_app_danika/utils/utils.dart';
import 'package:calorie_app_danika/services/health.dart';
import '../size_config.dart';
import 'dart:io' show Platform;
import 'dart:ui' as ui;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ChartData> chartData = [
    ChartData("asdf", 0),
    ChartData("asdf", 100),
  ];

  List<Color> colors = <Color>[
    const Color.fromRGBO(168, 215, 139, 1),
    const Color.fromRGBO(125, 176, 142, 1),
  ];

  List<double> stops = <double>[0.2, 1];

  double stepsProgress = 0.85;

  int totalCalories = 0;
  int burnedCalories = 0;
  int calorieBudget = 1700;
  int steps = 12345;
  int activeCalories = 0;
  int exerciseMinutes = 0;
  int standHours = 24;

  final HealthDataUtil _healthDataUtil = HealthDataUtil();

  List<double> getWeeklySummary() {
    // get the daily_log from the singleton userdata
    Singleton singleton = Singleton();
    // check if key 'daily_log' exists
    if (singleton.userdata!["daily_log"] != null) {
      List<double> result = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

      // get the daily_log
      Map<Object?, Object?> dailyLog = singleton.userdata!["daily_log"];

      // get the keys of the daily_log
      List<String> keys = dailyLog.keys.map((key) => key.toString()).toList();

      // check the current date from datetime.now()
      DateTime now = DateTime.now();
      //get rid of the hours, minutes, and seconds
      DateTime currentDay = DateTime(now.year, now.month, now.day);
      // convert to timestamp
      int currentDayTimestamp = currentDay.millisecondsSinceEpoch;
      // check which day of the week it is
      int currentDayOfWeek = now.weekday;

      // iterate through the timestamp keys
      for (int i = 0; i < ((keys.length < 7) ? keys.length : 7); i++) {
        print(keys[i]);

        // check if key is within the last 7 days
        if (int.parse(keys[i]) > currentDayTimestamp - 604800000) {
          // get the day of the week for the key
          DateTime day =
              DateTime.fromMillisecondsSinceEpoch(int.parse(keys[i]));
          int dayOfWeek = day.weekday;
          // print("Checking day: $dayOfWeek on date $day");

          if ((dayOfWeek <= currentDayOfWeek || dayOfWeek == 7) &&
              result[dayOfWeek - 1] == 0.0) {
            // get the daily log for that day
            Map<Object?, Object?> dailyLogForDay =
                dailyLog[keys[i]] as Map<Object?, Object?>;

            double calorieBudget =
                double.parse(dailyLogForDay["calorie_budget"].toString());
            double caloriesBurned =
                double.parse(dailyLogForDay["burned_calories"].toString());
            double caloriesConsumed = 0.0;

            // go through the meals to calculate the total calories consumed
            for (int j = 0; j < dailyLogForDay.length; j++) {
              // check key is not calorie_budget or calories_burned
              if (dailyLogForDay.keys.elementAt(j) != "calorie_budget" &&
                  dailyLogForDay.keys.elementAt(j) != "burned_calories" &&
                  dailyLogForDay.keys.elementAt(j) != "exercise") {
                // print(
                //     "THING: ${dailyLogForDay[dailyLogForDay.keys.elementAt(j)]}");
                // get the meal
                Map<Object?, Object?> meal =
                    dailyLogForDay[dailyLogForDay.keys.elementAt(j)]
                        as Map<Object?, Object?>;
                // get the keys of the meal
                List<String> mealKeys =
                    meal.keys.map((key) => key.toString()).toList();
                // iterate through the meal keys
                for (int k = 0; k < mealKeys.length; k++) {
                  // get the food
                  Map<Object?, Object?> food =
                      meal[mealKeys[k]] as Map<Object?, Object?>;
                  // get the keys of the food
                  // List<String> foodKeys =
                  //     food.keys.map((key) => key.toString()).toList();
                  // print("Food keys: $foodKeys");

                  double calories = double.parse(food["calories"].toString());
                  caloriesConsumed += calories.toInt();
                  // iterate through the food keys
                  // for (int l = 0; l < foodKeys.length; l++) {
                  //   print("A: ${food[foodKeys[l]]}");
                  //   // get the food item
                  //   Map<Object?, Object?> foodItem =
                  //       food[foodKeys[l]] as Map<Object?, Object?>;
                  //   // get the calories
                  //   double calories = double.parse(foodItem["calories"].toString());
                  //   // add to the total calories consumed
                  //   calories_consumed += calories.toInt();
                  // }
                }
              }
            }

            // print("Calories consumed: $caloriesConsumed");
            // print(
            //     "For day $dayOfWeek: ${((caloriesConsumed - caloriesBurned) / calorieBudget) * 100}");
            result[dayOfWeek - 1] =
                ((caloriesConsumed - caloriesBurned) / calorieBudget) * 100;

            // calculate the percentage
            // if (calorieBudget > caloriesConsumed) {
            //   print(
            //       "For day $dayOfWeek: ${((caloriesConsumed - caloriesBurned) / calorieBudget) * 100}");
            //   result[dayOfWeek - 1] =
            //       ((caloriesConsumed - caloriesBurned) / calorieBudget) * 100;
            // } else {
            //   print("For day $dayOfWeek: 100");
            //   result[dayOfWeek - 1] = 100;
            // }
          }
        }
      }

      // return the percentage for each day of the week
      // print("RESULT: $result");
      return result;
    } else {
      return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHealthData();
  }

  int doubleToInt(double value) {
    return value.round();
  }

  Future<void> _fetchHealthData() async {
    bool authorized = await _healthDataUtil.authorize();
    if (authorized) {
      List<HealthDataPoint> healthData = await _healthDataUtil.fetchData();
      int steps = await _healthDataUtil.fetchStepData();

      // Process and update the state with fetched data
      setState(() {
        this.steps = steps;
        stepsProgress = steps / 10000;
        for (var point in healthData) {
          switch (point.type) {
            case HealthDataType.ACTIVE_ENERGY_BURNED:
              // print(
              //     "Active calories: ${point.value.toString().substring(35, point.value.toString().length)}");
              activeCalories += doubleToInt(double.parse(point.value
                  .toString()
                  .substring(35, point.value.toString().length)));
              break;
            case HealthDataType.BASAL_ENERGY_BURNED:
              // print(
              //     "Basal calories: ${point.value.toString().substring(35, point.value.toString().length)}");
              burnedCalories += doubleToInt(double.parse(point.value
                  .toString()
                  .substring(35, point.value.toString().length)));
              break;
            case HealthDataType.STEPS:
              // print("Steps: ${point.value}");
              // steps += point.value.round();
              break;
            case HealthDataType.EXERCISE_TIME:
              // print(
              //     "Exercise minutes: ${point.value.toString().substring(35, point.value.toString().length)}");
              exerciseMinutes += doubleToInt(double.parse(point.value
                  .toString()
                  .substring(35, point.value.toString().length)));
              break;
            // case HealthDataType.STAND_HOURS:
            //   standHours += point.value.round();
            //   break;
            // Add more cases as needed
            default:
              break;
          }
        }
        // Assuming some logic to calculate totalCalories and calorieBudget
        totalCalories = activeCalories + burnedCalories;
        calorieBudget = 2000; // example value

        // Update chartData
        if (totalCalories - burnedCalories > calorieBudget) {
          chartData = [
            ChartData("asdf", calorieBudget.toDouble()),
          ];
        } else {
          chartData = [
            ChartData("asdf", (totalCalories - burnedCalories).toDouble()),
          ];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int dayOfWeek = getCurrentDayOfWeek();
    List<double> weeklySummary = getWeeklySummary();
    Singleton singleton = Singleton();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: AppBar(
            backgroundColor: singleton.alternateColorScheme.primary,
            // TODO: reenable in an update
            // leading: Padding(
            //   padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Image.asset(
            //       "assets/empty_icon 1.png",
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            title: const Text("Dashboard"),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const Text("Weekly Summary", style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 10),
                    DailyRing(
                      day: "S",
                      percentage: weeklySummary[6],
                    ),
                    DailyRing(
                      day: "M",
                      percentage: (dayOfWeek > 0) ? weeklySummary[0] : 0,
                    ),
                    DailyRing(
                      day: "T",
                      percentage: (dayOfWeek > 1) ? weeklySummary[1] : 0,
                    ),
                    DailyRing(
                      day: "W",
                      percentage: (dayOfWeek > 2) ? weeklySummary[2] : 0,
                    ),
                    DailyRing(
                      day: "T",
                      percentage: (dayOfWeek > 3) ? weeklySummary[3] : 0,
                    ),
                    DailyRing(
                      day: "F",
                      percentage: (dayOfWeek > 4) ? weeklySummary[4] : 0,
                    ),
                    DailyRing(
                      day: "S",
                      percentage: (dayOfWeek > 5) ? weeklySummary[5] : 0,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    child: Card(
                        // color: Colors.amberAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              width: SizeConfig.blockSizeHorizontal! * 55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 0.0, 0.0),
                                    child: Text(getToday(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child:
                                        Text("Calorie Budget: $calorieBudget",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                // color: Colors.white,
                                                fontSize: 15.0)),
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            60,
                                        height:
                                            SizeConfig.blockSizeHorizontal! *
                                                60,
                                        child: SfCircularChart(
                                            palette: const [Colors.grey],
                                            margin: const EdgeInsets.all(0.0),
                                            series: <CircularSeries>[
                                              // Renders radial bar chart
                                              DoughnutSeries<ChartData, String>(
                                                  innerRadius: "65%",
                                                  animationDuration: 0,
                                                  strokeColor: Colors.grey,
                                                  strokeWidth: 8.0,
                                                  dataSource: [
                                                    ChartData("asdf", 100),
                                                  ],
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y)
                                            ]),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            60,
                                        height:
                                            SizeConfig.blockSizeHorizontal! *
                                                60,
                                        child: SfCircularChart(
                                            onCreateShader: (ChartShaderDetails
                                                chartShaderDetails) {
                                              return ui.Gradient.linear(
                                                  chartShaderDetails
                                                      .outerRect.topCenter,
                                                  chartShaderDetails
                                                      .outerRect.bottomCenter,
                                                  colors,
                                                  stops);
                                            },
                                            palette: const [
                                              Color.fromARGB(
                                                  255, 146, 235, 114),
                                              Colors.grey
                                            ],
                                            margin: const EdgeInsets.all(0.0),
                                            series: <CircularSeries>[
                                              // Renders radial bar chart
                                              RadialBarSeries<ChartData,
                                                      String>(
                                                  maximumValue:
                                                      calorieBudget.toDouble(),
                                                  trackColor: Colors.grey,
                                                  innerRadius: "65%",
                                                  strokeColor: Colors.grey,
                                                  cornerStyle: (calorieBudget >
                                                          (totalCalories -
                                                              burnedCalories))
                                                      ? CornerStyle.bothCurve
                                                      : CornerStyle.bothFlat,
                                                  strokeWidth: 8.0,
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
                                            "${totalCalories - burnedCalories}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                          Text(
                                            (calorieBudget >
                                                    (totalCalories -
                                                        burnedCalories))
                                                ? "UNDER"
                                                : "OVER",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 134, 185, 142),
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: SizeConfig.blockSizeHorizontal! * 30,
                              height: SizeConfig.blockSizeVertical! * 38,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 8.0, 8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Net Calories:",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)),
                                    Text("${totalCalories - burnedCalories}",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 42.0)),
                                    const Text("kcal",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    const Text("Total:",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0)),
                                    Text("$totalCalories",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36.0)),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    const Text("Burned:",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0)),
                                    Text("$burnedCalories",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36.0)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))),
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 43,
                      height: SizeConfig.blockSizeHorizontal! * 43,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          // color: Colors.amberAccent,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                const Text("Steps",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.white,
                                        fontSize: 30.0)),
                                Row(
                                  children: [
                                    const Icon(Icons.run_circle),
                                    Text("$steps steps",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                            fontSize: 18.0))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.local_fire_department_outlined),
                                    Text("$activeCalories cal",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                            fontSize: 18.0))
                                  ],
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(
                                      //   color: Colors.red[500],
                                      // ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  // child: LinearProgressIndicator(
                                  //   borderRadius:
                                  //       BorderRadius.circular(15.0),
                                  //   color: const Color.fromARGB(
                                  //       255, 146, 235, 114),
                                  //   backgroundColor: const Color.fromARGB(
                                  //       255, 159, 159, 159),
                                  //   minHeight:
                                  //       SizeConfig.blockSizeVertical! * 4,
                                  // )
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
                                          stepsProgress / 2,
                                          stepsProgress,
                                          stepsProgress,
                                        ])),
                                    child: SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 4),
                                  ),
                                )
                              ])))),
                  SizedBox(width: SizeConfig.blockSizeHorizontal! * 4),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 43,
                      height: SizeConfig.blockSizeHorizontal! * 43,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          // color: Colors.amberAccent,
                          child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Move",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.white,
                                                  fontSize: 18.0)),
                                          Text("$activeCalories cal",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.white,
                                                  fontSize: 18.0)),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Exercise",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white,
                                                fontSize: 18.0)),
                                        Text("$exerciseMinutes min",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white,
                                                fontSize: 18.0))
                                      ],
                                    ),
                                    (Platform.isIOS)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Stand",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // color: Colors.white,
                                                      fontSize: 18.0)),
                                              Text("$standHours hrs",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // color: Colors.white,
                                                      fontSize: 18.0))
                                            ],
                                          )
                                        : Container()
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

// ignore: must_be_immutable
class DailyRing extends StatelessWidget {
  DailyRing({super.key, required this.day, required this.percentage});
  String day;
  double percentage = 0.0;
  List<ChartData> chartData = [];

  @override
  Widget build(BuildContext context) {
    if (percentage < 100) {
      chartData = [
        ChartData("asdf", percentage),
      ];
    } else {
      chartData = [
        ChartData("asdf", 100),
      ];
    }

    // print("MY PERCENTAGE IS: $percentage");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          Stack(
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 45,
                height: 45,
                child: SfCircularChart(
                    palette: const [Colors.grey],
                    margin: const EdgeInsets.all(0.0),
                    series: <CircularSeries>[
                      // Renders radial bar chart
                      DoughnutSeries<ChartData, String>(
                          // cornerStyle: CornerStyle.bothCurve,
                          innerRadius: "75%",
                          strokeColor: Colors.grey,
                          strokeWidth: 6.0,
                          dataSource: [
                            ChartData("asdf", 100),
                          ],
                          animationDuration: 0,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]),
              ),
              SizedBox(
                // color: Colors.amber,
                width: 45,
                height: 45,
                child: SfCircularChart(
                    palette: [
                      (percentage <= 100
                          ? const Color.fromARGB(255, 146, 235, 114)
                          : const Color.fromARGB(255, 255, 96, 96)),
                      Colors.grey
                    ],
                    margin: const EdgeInsets.all(0.0),
                    series: <CircularSeries>[
                      // Renders radial bar chart
                      RadialBarSeries<ChartData, String>(
                          maximumValue: 100,
                          trackColor: Colors.grey,
                          cornerStyle: (percentage < 100)
                              ? CornerStyle.bothCurve
                              : CornerStyle.bothFlat,
                          // strokeColor: Colors.green,
                          innerRadius: "75%",
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
