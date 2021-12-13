import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  /// A TextToSpeech Widget that can be reused for different components
  ///
  /// To add more features for a component, inherit and override this class
  static final FlutterTts _ttsModel = FlutterTts();
  static bool state=false;

  // set text to speech voice features
  static Future setSettings() async{
    await _ttsModel.setLanguage("en-US");
    await _ttsModel.setSpeechRate(1.0);
    await _ttsModel.setVolume(1.0);
    await _ttsModel.setPitch(1.0);
  }

  // static method to call the speak method of Flutter Tts object
  static Future speak(String text) async {
    if (state) stop();
    var result = await _ttsModel.speak(text);
    if (result == 1) state = true;
  }

  // static method to call the stop method of Flutter Tts object
  static Future stop() async{
    var result = await _ttsModel.stop();
    if (result == 1) state = false;
  }
}