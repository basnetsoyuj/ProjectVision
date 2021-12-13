import 'dart:convert';
import 'package:project_vision/src/utils/utils.dart';
import 'package:project_vision/src/utils/haptic_feedback.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'package:project_vision/src/utils/tts.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

String _modelPath = "assets/object_recognition/models/model.tflite";
String _labelPath = "assets/object_recognition/models/labels.txt";
double threshold = 0.9;

requestImage(String filename) async {
  var image = File(filename);
  final request = http.MultipartRequest("POST",
      Uri.parse("http://86f7-91-230-41-203.ngrok.io/run_object_inference"));
  final headers = {"content-type": "multipart/form-data"};

  request.files.add(http.MultipartFile(
      "image", image.readAsBytes().asStream(), image.lengthSync(),
      filename: image.path.split("/").last));
  request.headers.addAll(headers);

  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);
  final resJson = jsonDecode(res.body);
  return resJson['results'];
}

Future<void> classifyImage(String imagePath) async {
  List<dynamic>? output;

  // if (await checkConnectivity()) {
  if(false){
    output = await requestImage(imagePath);
  } else {
    /// Classify the given image
    // load the tflite model
    await Tflite.loadModel(model: _modelPath, labels: _labelPath);
    // Run the model on image
    // High threshold for better accuracy
    output = await (Tflite.runModelOnImage(
        path: imagePath,
        numResults: 2,
        threshold: 0.0,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true));
  }
  // Add classified note to database and play the corresponding audio feedback
  if (output != null && output.isNotEmpty ||
      output?[0]["confidence"] > threshold) {
    String result = output?[0]["label"];
    if (HapticFeedback.canVibrate) {
      TextToSpeech.speak(result);
      Vibrate.feedback(FeedbackType.success);
    }
  }
  // else play [wrong.mp3]
  else {
    if (HapticFeedback.canVibrate) {
      TextToSpeech.speak("Try again!");
      Vibrate.feedback(FeedbackType.error);
    }
  }
}
