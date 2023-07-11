import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
const Bird({
super.key,
this.color = const Color(0xFFFFE306),
this.child,
});

final Color color;
final Widget? child;

@override
State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
//DatabaseReference ref = FirebaseDatabase.instance.ref();

DatabaseReference ref = FirebaseDatabase.instance.ref("foodfacts");
double _size = 1.0;

void grow() {
setState(() { _size += 0.1; });
}

Future<void> push() async {
await ref.set({
"Banana": 100,
"Chocolate Chip Cookie": 300,
"Oatmeal": 200,
"Cereal": 100,
"Apple": 94,
"Strawberry": 12,
});
}

@override
Widget build(BuildContext context) {
push();
return Container(
color: widget.color,
transform: Matrix4.diagonal3Values(_size, _size, 1.0),
child: widget.child,
);

// await ref.set({
//   "name": "John",
//   "age": 18,
//   "address": {
//     "line1": "100 Mountain View"
//   }
// });
}
}