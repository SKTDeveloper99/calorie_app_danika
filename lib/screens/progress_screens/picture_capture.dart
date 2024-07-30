import 'dart:io';
import 'package:calorie_app_danika/services/singleton.dart';
import 'package:calorie_app_danika/size_config.dart';
import 'package:calorie_app_danika/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

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

class PictureCaptureScreen extends StatefulWidget {
  const PictureCaptureScreen({super.key});

  @override
  State<PictureCaptureScreen> createState() => _PictureCaptureScreenState();
}

class _PictureCaptureScreenState extends State<PictureCaptureScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  File? imageFile;
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
        appBar: AppBar(
          forceMaterialTransparency: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, "/galleryScreen");
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            _cameraPreviewWidget(),
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
                            imageFile = File(file.path);
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

class PhotoPreview extends StatelessWidget {
  final File imageFile;
  final Size mediaSize;
  final double scale;
  PhotoPreview(
      {super.key,
      required this.imageFile,
      required this.mediaSize,
      required this.scale});

  final Singleton _singleton = Singleton();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Stack(
      children: [
        ClipRect(
            clipper: _MediaSizeClipper(mediaSize),
            child: Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: Image.file(File(imageFile.path)))),
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
                          String uid = user!.uid;
                          String date = DateTime.now().toString();
                          final ref = _storage
                              .ref()
                              .child('Users')
                              .child(uid)
                              .child('progress$date.jpg');
                          await ref.putFile(imageFile);
                          String imageUrl = await ref.getDownloadURL();

                          // Add to URL in RTDB at users/uid/account_info/progressPictures array
                          final event = await _database
                              .ref('users/$uid/account_info')
                              .once();
                          Map<Object?, Object?> accountInfo =
                              event.snapshot.value as Map<Object?, Object?>;

                          if (accountInfo['progressPictures'] == null) {
                            accountInfo['progressPictures'] =
                                <Map<String, dynamic>>[];
                          }

                          List<dynamic> progressPictures = List<dynamic>.from(
                              accountInfo['progressPictures'] as List<dynamic>);

                          progressPictures.add({'date': date, 'url': imageUrl});
                          accountInfo['progressPictures'] = progressPictures;

                          await _database
                              .ref('users/$uid/account_info')
                              .set(accountInfo)
                              .then(
                            (value) {
                              // print('Uploaded to RTDB');
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: const Icon(Icons.check)))
              ],
            ),
          ),
        )
      ],
    );
  }
}
