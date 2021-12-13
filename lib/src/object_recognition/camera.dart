import 'package:flutter/material.dart';
import 'package:project_vision/src/utils/camera.dart';
import 'package:project_vision/src/object_recognition/classifier.dart';

class ObjectRecognitionCamera extends CameraApp {
  /// Camera Widget for Object Recognition component inheriting from CameraApp
  @override
  ObjectRecognitionCameraState createState() => ObjectRecognitionCameraState();
}

class ObjectRecognitionCameraState extends CameraAppState {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          /// GestureDetector wraps entire Camera Widget and classifies on tap
          return GestureDetector(
              excludeFromSemantics: true,
              child: Tooltip(
                  // add Tooltip for screen readers
                  message: "Double Tap to Identify Object",
                  child: cameraWidget(context)),
              onTap: captureAndClassify);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> captureAndClassify() async {
    /// Capture an image and classify
    try {
      String path = await captureImage();
      classifyImage(path);
    } catch (e) {
      print(e);
    }
  }
}
