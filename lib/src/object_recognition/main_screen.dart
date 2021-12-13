import 'package:flutter/material.dart';
import 'package:project_vision/src/object_recognition/camera.dart';
import 'package:project_vision/src/utils/utils.dart';

class ObjectRecognitionMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ObjectRecognitionCamera(),
          MenuBarButton(
            toolTip: "Instructions",
            icon: Icons.info_outline,
            alignment: Alignment.topLeft,
            onPressed: () {
              Navigator.of(context).pushNamed('/object/instructions');
            },
          ),
        ],
      ),
    );
  }
}
