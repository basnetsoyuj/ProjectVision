import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:project_vision/src/utils/colors.dart';

Future<bool> checkConnectivity() async {
  /// Check if Phone is connected to the internet
  var result = await Connectivity().checkConnectivity();
  return ConnectivityResult.none != result;
}

class MenuBarButton extends StatelessWidget {
  /// A stateless widget called MenuBarButton to create History & Instructions button
  const MenuBarButton({
    Key? key,
    required this.toolTip,
    required this.icon,
    required this.alignment,
    required this.onPressed,
  }) : super(key: key);

  final String toolTip;
  final IconData icon;
  final AlignmentGeometry alignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerSize = size.width * 0.16;
    final containerMarginTop = MediaQuery.of(context).padding.top +
        size.height * 0.01;
    final containerMarginSymmetric = size.width * 0.03;
    final iconSize = size.width * 0.1;

    return Align(
      alignment: alignment,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: iconShadowColor,
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: iconsBorderColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(50),
          color: iconsBorderColor,
        ),
        margin: EdgeInsets.only(
          top: containerMarginTop,
          left: containerMarginSymmetric,
          right: containerMarginSymmetric,
        ),
        child: IconButton(
          tooltip: toolTip,
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}