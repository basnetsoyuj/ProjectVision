import 'package:flutter/material.dart';
import 'package:project_vision/src/cash_recognition/camera.dart';
import 'package:project_vision/src/utils/utils.dart';

/// class to Render the main screen for Cash Recognition component
class CashRecognitionMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CashRecognitionCameraApp(),
          MenuBarButton(
            toolTip: "Instructions",
            icon: Icons.info_outline,
            alignment: Alignment.topLeft,
            onPressed: () {
              Navigator.of(context).pushNamed('/cash/instructions');
            },
          ),
          MenuBarButton(
            toolTip: "History",
            icon: Icons.history,
            alignment: Alignment.topRight,
            onPressed: () {
              Navigator.of(context).pushNamed('/cash/history');
            },
          ),
        ],
      ),
    );
  }
}