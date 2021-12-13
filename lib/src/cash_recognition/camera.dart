import 'package:project_vision/src/utils/camera.dart';
import 'package:project_vision/src/object_recognition/camera.dart';
import 'package:project_vision/src/cash_recognition/classifier.dart';

class CashRecognitionCameraApp extends CameraApp {
  /// Camera Widget for Cash Recognition component inheriting from CameraApp
  @override
  _CashRecognitionCameraState createState() => _CashRecognitionCameraState();
}

class _CashRecognitionCameraState extends ObjectRecognitionCameraState {
  /// Camera Widget for Cash Recognition component inheriting from
  /// ObjectRecognitionCameraState
  @override
  Future<void> captureAndClassify() async {
    /// Capture an image and classify the currency note
    try {
      String path = await captureImage();
      classifyImage(path);
    } catch (e) {
      print(e);
    }
  }
}
