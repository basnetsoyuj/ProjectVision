import 'package:project_vision/src/cash_recognition/history.dart';
import 'package:project_vision/src/cash_recognition/instructions.dart' as cash;
import 'package:project_vision/src/object_recognition/instructions.dart' as object;
import 'package:project_vision/src/home/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/cash/history':
        return MaterialPageRoute(builder: (context) => HistoryScreen());
      case '/cash/instructions':
        return MaterialPageRoute(builder: (context) => cash.InstructionPage());
      case '/object/instructions':
        return MaterialPageRoute(builder: (context) => object.InstructionPage());
      default:
        return _errorRoute();
    }
  }

  static _errorRoute() => MaterialPageRoute(
        builder: (context) => const Material(
          child: Center(
            child: Text("404 Not Found!"),
          ),
        ),
      );
}
