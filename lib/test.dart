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

  DatabaseReference ref = FirebaseDatabase.instance.ref("foodfacts");
double _size = 1.0;

void grow() {
setState(() { _size += 0.1; });
}

Future<void> push() async {
  await ref.set({
    "Cereal": 113,
    "Milk": 77,
    "Taco": 156,
    "Hard_shell_taco": 63,
    "Beef": 142,
    "Cheese": 5,
    "Lettuce": 5,
    "Salmon": 118,
    "Rice": 200,
    "Romaine_lettuce": 216,
    "Croutons": 122,
    "Parmesan_cheese": 22,
    "Dressing": 156,
    "Pizza_crust": 50,
    "Margherita_sauce": 40,
    "Mozzarella": 26,
    "Pepperoni": 10,
    "Spaghetti": 411,
    "Meatballs": 324,
    "Pasta_sauce": 66,
    "Rotisserie_Chicken": 204,
    "Noodles": 166,
    "Chicken broth": 77,
    "Ice_cream": 137,
  }
  );
}
//   await ref.set({
//     "Breakfast": 1,
//     "Lunch": 2,
//     "Dinner": 3,
//   });
//   // await ref.set({
//   // "Banana": 100,
//   // "Chocolate Chip Cookie": 300,
//   // "Oatmeal": 200,
//   // "Cereal": 100,
//   // "Apple": 94,
//   // "Strawberry": 12,
//   // });
// }


// starCountRef.onValue.listen((DatabaseEvent event) {
// final data = event.snapshot.value;
// updateStarCount(data);
// });

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