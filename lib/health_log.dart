import 'package:calorie_app_danika/result_page.dart';
import 'package:calorie_app_danika/test.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  LogScreen({ super.key });

  var imageUrl = "https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2Fcereal.jpg?alt=media&token=34e61286-d549-478c-89ed-f55981b9cc49";
  var imageUrl1 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2Ftaco.jpg?alt=media&token=8cbfa03a-c3cf-490e-bd72-c80e0f44ac77';
  var imageUrl2 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2Fsalmon%20rice.jpg?alt=media&token=1c402bad-8928-4853-9ef2-527524eecb49';
  var imageUrl3 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2Fsalad.jpg?alt=media&token=28fa36cb-45c8-44d6-acb8-986d8c7302b5';
  var imageUrl4 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2Fpizza.jpg?alt=media&token=b4071a72-d920-41c7-afe0-5e6aebc8fc78';
  var breakfast = "Cereal";
  var lunch = "Salmon Rice";
  var dinner = "Tacos";
  var date = "6/16/2023";
  var date2 = "6/17/2023";
  var date3 = "6/18/2023";
  var date4 = "6/19/2023";
  var date5 = "6/20/2023";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Log'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  child: BigCard(image: imageUrl,breakfast: breakfast, lunch: lunch, dinner: dinner, date: date),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(date: date),
                      ),
                    );
                  },
              ),
              GestureDetector(
                  child: BigCard(image: imageUrl1, breakfast: breakfast, lunch: lunch, dinner: dinner, date: date2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(date: date2),
                      ),
                    );
                  },
              ),
              GestureDetector(
                  child: BigCard(image: imageUrl2, breakfast: breakfast, lunch: lunch, dinner: dinner, date: date3),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(date: date3),
                      ),
                    );
                  },
              ),
              GestureDetector(
                  child: BigCard(image: imageUrl3, breakfast: breakfast, lunch: lunch, dinner: dinner, date: date4),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(date: date4),
                    ),
                  );
                },
              ),
              GestureDetector(
                  child: BigCard(image: imageUrl4, breakfast: breakfast, lunch: lunch, dinner: dinner, date: date5),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(date: date5),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(date: date),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.image,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.date,

  }) : super(key: key);

  final String image;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String date;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Column(
              children: [
                Image.network(image),
                Text(
                  breakfast,
                  style: style.copyWith(fontWeight: FontWeight.w200, fontSize: 45),
                ),
                Text(
                  lunch,
                  style: style.copyWith(fontWeight: FontWeight.w200, fontSize: 45),
                ),
                Text(
                  dinner,
                  style: style.copyWith(fontWeight: FontWeight.w200, fontSize: 45),
                ),
                Text(
                  date,
                  style: style.copyWith(fontWeight: FontWeight.w200, fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



