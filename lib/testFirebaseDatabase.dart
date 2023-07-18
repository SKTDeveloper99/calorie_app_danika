import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';


class TestRealtimeDatabase extends StatefulWidget {
  const TestRealtimeDatabase({Key? key}) : super(key: key);

  @override
  _TestRealtimeDatabaseState createState() => _TestRealtimeDatabaseState();
}

class _TestRealtimeDatabaseState extends State<TestRealtimeDatabase> {
  int _counter = 0;
  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late DatabaseReference _foodfactsRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool _anchorToBottom = false;

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
    _counterRef = FirebaseDatabase.instance.ref('counter');

    final database = FirebaseDatabase.instance;

    _messagesRef = database.ref('messages');

    _foodfactsRef = database.ref('foodfacts');

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

    try {
      final counterSnapshot = await _counterRef.get();

      print(
        'Connected to directly configured database and read '
            '${counterSnapshot.value}',
      );
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
        print('Child added: ${event.snapshot.value}');
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
  }

  Future<void> _increment() async {
    await _counterRef.set(ServerValue.increment(1));

    await _messagesRef
        .push()
        .set(<String, String>{_kTestKey: '$_kTestValue $_counter'});
  }

  Future<void> _incrementAsTransaction() async {
    try {
      final transactionResult = await _counterRef.runTransaction((mutableData) {
        return Transaction.success((mutableData as int? ?? 0) + 1);
      });

      if (transactionResult.committed) {
        final newMessageRef = _messagesRef.push();
        await newMessageRef.set(<String, String>{
          _kTestKey: '$_kTestValue ${transactionResult.snapshot.value}'
        });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> _deleteMessage(DataSnapshot snapshot) async {
    final messageRef = _messagesRef.child(snapshot.key!);
    await messageRef.remove();
  }

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
        title: const Text('Food Facts'),
      ),
      body: Column(
        children: [
          // Flexible(
          //   child: Center(
          //     child: _error == null
          //         ? Text(
          //       'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
          //           'This includes all devices, ever.',
          //     )
          //         : Text(
          //       'Error retrieving button tap count:\n${_error!.message}',
          //     ),
          //   ),
          // ),
          ElevatedButton(
            onPressed: _incrementAsTransaction,
            child: const Text('Increment as transaction'),
          ),
          ListTile(
            leading: Checkbox(
              onChanged: _setAnchorToBottom,
              value: _anchorToBottom,
            ),
            title: const Text('Anchor to bottom'),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              key: ValueKey<bool>(_anchorToBottom),
              query: _foodfactsRef,
              reverse: _anchorToBottom,
              itemBuilder: (context, snapshot, animation, index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () => _deleteMessage(snapshot),
                      icon: const Icon(Icons.delete),
                    ),
                    title: Text('${snapshot.key}: ${snapshot.value}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}