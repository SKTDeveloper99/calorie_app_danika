import "package:camera/camera.dart";
import "package:flutter/material.dart";

class FoodCamera extends StatefulWidget {
  const FoodCamera({super.key});

  @override
  State<FoodCamera> createState() => _FoodCameraState();
}

class _FoodCameraState extends State<FoodCamera> with WidgetsBindingObserver {
  CameraController? controller;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Stack(
      children: [
        _cameraPreviewWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {},
            ),
          ],
        )
      ],
    ));
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

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
      return Container();
      // return Listener(
      //   onPointerDown: (_) => _pointers++,
      //   onPointerUp: (_) => _pointers--,
      //   child: CameraPreview(
      //     controller!,
      //     child: LayoutBuilder(
      //         builder: (BuildContext context, BoxConstraints constraints) {
      //       return GestureDetector(
      //         behavior: HitTestBehavior.opaque,
      //         onScaleStart: _handleScaleStart,
      //         onScaleUpdate: _handleScaleUpdate,
      //         onTapDown: (TapDownDetails details) =>
      //             onViewFinderTap(details, constraints),
      //       );
      //     }),
      //   ),
      // );
    }
  }
}
