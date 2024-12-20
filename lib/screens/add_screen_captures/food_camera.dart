import "dart:io";
import 'dart:convert';
import "package:calorie_app_danika/services/singleton.dart";
import "package:calorie_app_danika/size_config.dart";
import "package:camera/camera.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "package:syncfusion_flutter_charts/charts.dart";
import 'package:calorie_app_danika/utils/utils.dart';
// import 'package:image/image.dart' as imglib;
import 'package:calorie_app_danika/screens/add_screen_captures/results.dart';

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class FoodCamera extends StatefulWidget {
  const FoodCamera({super.key});

  @override
  State<FoodCamera> createState() => _FoodCameraState();
}

class _FoodCameraState extends State<FoodCamera> with WidgetsBindingObserver {
  CameraController? controller;
  XFile? imageFile;
  double scale = 1.0;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    controller = CameraController(firstCamera, ResolutionPreset.medium);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    await controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
  }

  @override
  void initState() {
    super.initState();

    initCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    if (controller != null) {
      scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
    }
    return Scaffold(
        // appBar: AppBar(
        //   forceMaterialTransparency: true,
        //   shadowColor: Colors.transparent,
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: Stack(
      children: [
        _cameraPreviewWidget(),
        Positioned(
          top: SizeConfig.blockSizeVertical! * 5,
          left: SizeConfig.blockSizeHorizontal! * 5,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: SizeConfig.blockSizeHorizontal! * 10,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: SizeConfig.blockSizeHorizontal! * 25,
                color: Colors.white,
                icon: const Icon(Icons.camera),
                onPressed: () {
                  controller!.takePicture().then((XFile file) {
                    if (mounted) {
                      setState(() {
                        imageFile = file;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhotoPreview(
                                      imageFile: imageFile!,
                                      mediaSize: mediaSize,
                                      scale: scale,
                                    )));
                      });
                    }
                  });
                },
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 10),
            ],
          ),
        )
      ],
    ));
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    final mediaSize = MediaQuery.of(context).size;
    var scale = 1.0;

    if (controller != null) {
      scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
    }

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return ClipRect(
        clipper: _MediaSizeClipper(mediaSize),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: CameraPreview(cameraController),
        ),
      );
    }
  }
}

class PhotoPreview extends StatefulWidget {
  final XFile imageFile;
  final Size mediaSize;
  final double scale;

  const PhotoPreview(
      {super.key,
      required this.imageFile,
      required this.mediaSize,
      required this.scale});

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  final Singleton _singleton = Singleton();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
            clipper: _MediaSizeClipper(widget.mediaSize),
            child: Transform.scale(
                scale: widget.scale,
                alignment: Alignment.topCenter,
                child: Image.file(File(widget.imageFile.path)))),
        Positioned(
          top: SizeConfig.blockSizeVertical! * 80,
          left: 0,
          right: 0,
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 18,
                  height: SizeConfig.blockSizeHorizontal! * 18,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                ),
                SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 18,
                    height: SizeConfig.blockSizeHorizontal! * 18,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          await convertXFileToImageColor(widget.imageFile)
                              .then((value) {
                            if (value != null) {
                              if (kDebugMode) {
                                print(
                                    "Sending image to server at ${_singleton.serverURL}");
                              }
                              sendImageToServer(_singleton.serverURL, value)
                                  .then((value) {
                                if (kDebugMode) {
                                  print("Response: ${value.body}");
                                }
                                Map valueMap = json.decode(value.body);
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                              identifiedObject:
                                                  valueMap["identified"],
                                            )));
                              });
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          });
                        },
                        child: const Icon(Icons.check)))
              ],
            ),
          ),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
