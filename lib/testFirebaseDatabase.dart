import 'dart:async';
import 'dart:math';

import 'package:calorie_app_danika/main.dart';
import 'package:calorie_app_danika/specific_day.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TestRealtimeDatabase extends StatefulWidget {
  const TestRealtimeDatabase({Key? key}) : super(key: key);

  @override
  _TestRealtimeDatabaseState createState() => _TestRealtimeDatabaseState();
}

class _TestRealtimeDatabaseState extends State<TestRealtimeDatabase> {
  late User user;
  int _counter = 0;
  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late DatabaseReference _foodfactsRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  late StreamSubscription<DatabaseEvent> _foodFactsSubscription;
  bool _anchorToBottom = true;
  late String pictureSelected;

  String _kTestKey = 'Hello';
  String _kTestValue = 'Danika!';
  FirebaseException? _error;
  bool initialized = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    user = auth.currentUser!;
    _counterRef = FirebaseDatabase.instance.ref('counter');

    final database = FirebaseDatabase.instance;

    _messagesRef = database.ref('messages');

    _foodfactsRef = database.ref('/users/${user.uid}/foodlogs/');

    database.setLoggingEnabled(false);

    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
    }

    if (!kIsWeb) {
      await _counterRef.keepSynced(true);
    }

    setState(() {
      initialized = true;
    });

    auth.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    try {
      final counterSnapshot = await _counterRef.get();
      // print(
      //   'Connected to directly configured database and read '
      //       '${counterSnapshot.value}',
      //);
    } catch (err) {
      print(err);
    }

    _counterSubscription = _counterRef.onValue.listen(
          (DatabaseEvent event) {
        setState(() {
          _error = null;
          _counter = (event.snapshot.value ?? 0) as int;
        });
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        setState(() {
          _error = error;
        });
      },
    );

    final messagesQuery = _messagesRef.limitToLast(10);

    _messagesSubscription = messagesQuery.onChildAdded.listen(
          (DatabaseEvent event) {
        // print('Child added: ${event.snapshot.value}');
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print('Error: ${error.code} ${error.message}');
      },
    );

    final foodfactsQuery = _foodfactsRef.limitToLast(20);

    _foodFactsSubscription = foodfactsQuery.onChildAdded.listen(
          (DatabaseEvent event) {
        // print('Child added: ${event.snapshot.value}');
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print('Error: ${error.code} ${error.message}');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
    _foodFactsSubscription.cancel();
  }

  // Future<void> _deleteMessage(DataSnapshot snapshot) async {
  //   final messageRef = _messagesRef.child(snapshot.key!);
  //   await messageRef.remove();
  // }

  void _setAnchorToBottom(bool? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _anchorToBottom = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) return Container();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Health Logs'),
      ),
      body: Column(
        children: [
          // ListTile(
          //   leading: Checkbox(
          //     onChanged: _setAnchorToBottom,
          //     value: _anchorToBottom,
          //   ),
          //   title: const Text('Anchor to bottom'),
          // ),
          Flexible(
            child: FirebaseAnimatedList(
              key: ValueKey<bool>(_anchorToBottom),
              query: _foodfactsRef,
              reverse: _anchorToBottom,
              itemBuilder: (context, snapshot, animation, index) {
                final healthList = snapshot.value! as Map;
                List<String>  love = ["breakfast","lunch","dinner"];
                final _random = Random();
                String superRandom = love[_random.nextInt(love.length)];
                int timeSkip = healthList["date"] ;
                final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(timeSkip);
                String formattedDate = DateFormat('yyyy-MM-dd').format(timeStamp);
                return SizeTransition(
                  sizeFactor: animation,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DayDetailScreen(info: healthList, date: formattedDate)),
                      );
                    },
                    child: BigCard(
                        image: healthList["${superRandom}PicUrl"],
                        meal: healthList[superRandom],
                        calories: healthList["caloriesInput"].toString(),
                        caloriesDeficit: (healthList["caloriesInput"] - healthList["caloriesExercises"]),
                        date: formattedDate,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.image,
    required this.meal,
    required this.calories,
    required this.date,
    required this.caloriesDeficit,

  }) : super(key: key);

  final String image;
  final String meal;
  final String calories;
  final String date;
  final int caloriesDeficit;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var color = Colors.yellow;
    if (caloriesDeficit > 0) {
        color = Colors.red;
    }
    if (caloriesDeficit <= 0) {
      color = Colors.green;
    }
    return Card(
      color: color,
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
                  meal,
                  style: style.copyWith(fontWeight: FontWeight.w200, fontSize: 45),
                ),
                Text(
                  caloriesDeficit.toString(),
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