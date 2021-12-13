import 'package:tflite/tflite.dart';
import 'dart:async';
import 'package:project_vision/src/utils/haptic_feedback.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:project_vision/src/cash_recognition/models/note_model.dart';
import 'package:project_vision/src/database/database_helper.dart';
import 'package:project_vision/src/utils/tts.dart';

String _modelPath = "assets/cash_recognition/models/uae_model/model.tflite";
String _labelPath = "assets/cash_recognition/models/uae_model/labels.txt";

Future<void> classifyImage(String imagePath) async {
  /// Classify the given image
  // load the tflite model
  await Tflite.loadModel(model: _modelPath, labels: _labelPath);
  // Run the model on image
  // High threshold for better accuracy
  List<dynamic>? output = await (Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2,
      threshold: 0.9,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true));
  // Add classified note to database and play the corresponding audio feedback
  if (output != null && output.isNotEmpty) {
    String result = output[0]["label"];
    String note = result.substring(2);
    Note noteObj = Note(label: note);
    await DatabaseHelper.instance.insert(noteObj);
    if(HapticFeedback.canVibrate){
      TextToSpeech.speak(note);
      Vibrate.feedback(FeedbackType.success);
    }
  }
  // else notify that it couldn't detect
  else {
    if(HapticFeedback.canVibrate){
      TextToSpeech.speak("Try again!");
      Vibrate.feedback(FeedbackType.error);
    }
  }
}