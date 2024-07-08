import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calorie_app_danika/screens/progress_screens/enlarge.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> images = <String>[
    "https://t4.ftcdn.net/jpg/00/59/96/75/360_F_59967553_9g2bvhTZf18zCmEVWcKigEoevGzFqXzq.jpg",
    "https://t3.ftcdn.net/jpg/01/76/97/96/360_F_176979696_hqfioFYq7pX13dmiu9ENrpsHZy1yM3Dt.jpg",
    "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?cs=srgb&dl=pexels-mali-102104.jpg&fm=jpg",
    "https://www.shutterstock.com/shutterstock/photos/1727544364/display_1500/stock-photo-red-apple-isolated-on-white-background-clipping-path-full-depth-of-field-1727544364.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // body: const Placeholder(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ImageCard(image: images[index]);
            },
          ),
        ));
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnlargedScreen(image: image)));
          },
          child: Image.network(image, fit: BoxFit.cover)),
    );
  }
}
