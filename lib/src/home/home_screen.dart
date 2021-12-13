import 'package:flutter/material.dart';
import 'package:project_vision/src/cash_recognition/main_screen.dart';
import 'package:project_vision/src/object_recognition/main_screen.dart';
import 'package:project_vision/src/home/component_list.dart';

class HomeScreen extends StatelessWidget {
  /// specify components of Project Vision
  final components = [
    {
      'name': 'OBJECT\nRECOGNITION',
      'viewScreen': ObjectRecognitionMainScreen(),
      'color': const Color(0xffff0000),
      'imagePath': 'assets/object_recognition/images/key.png'
    },
    {
      'name': 'CASH\nRECOGNITION',
      'viewScreen': CashRecognitionMainScreen(),
      'color': const Color(0xff23bd52),
      'imagePath': 'assets/cash_recognition/images/note.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    /// if more than one component, show component list view page
    /// else, directly switch to the only view screen available
    return components.length > 1
        ? ComponentList(components)
        : components[0]['viewScreen'] as Widget;
  }
}
