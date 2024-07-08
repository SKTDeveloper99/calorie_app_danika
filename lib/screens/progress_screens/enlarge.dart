import 'package:flutter/material.dart';

class EnlargedScreen extends StatelessWidget {
  const EnlargedScreen({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(image),
      ),
    );
  }
}
