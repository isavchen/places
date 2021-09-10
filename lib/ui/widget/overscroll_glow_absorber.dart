import 'package:flutter/material.dart';

class OverscrollGlowAbsorber extends StatelessWidget {
  final Widget child;
  const OverscrollGlowAbsorber({ Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: (notification) {
        if (notification is OverscrollIndicatorNotification) {
          notification.disallowGlow();
        }
        return false;
      },
    );
  }
}