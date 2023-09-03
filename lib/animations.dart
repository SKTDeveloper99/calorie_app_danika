import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
});

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: width,
        child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                photo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    }
  }

  class HeroAnimation extends StatelessWidget {
    const HeroAnimation({super.key});

    @override
    Widget build(BuildContext context) {
      timeDilation = 10.0;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Basic Hero Animation'),
        ),
        body: Center(
          child: PhotoHero(
            photo: 'assets/flippers-alpha.png',
            width: 300,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute<void>(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: Container(
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: PhotoHero(
                      photo: 'assets/flippers-alpha.png',
                      width: 100,
                      onTap: () {
                        Navigator.of(context).pop();
                      }
                    ),
                  ),
                );
              })
              );}
          )
        )
      );
    }
  }