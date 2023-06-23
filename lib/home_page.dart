// import 'package:calorie_app_danika/newpage.dart';
// import 'package:calorie_app_danika/profile_page.dart';
// import 'package:calorie_app_danika/profile_page_1.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             ElevatedButton(
//               onPressed: _incrementCounter,
//               child: const Icon(Icons.add),
//             ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ProfileScreen1(),
//               ),
//             );
//           },
//           child: const Icon(Icons.add_circle),
//         ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => InternetExample(),
//                   ),
//                 );
//               },
//               child: const Icon(Icons.add_circle),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => const ProfilePage(),
//             ),
//           );
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add_circle),
//       ),
//     );
//   }
// }