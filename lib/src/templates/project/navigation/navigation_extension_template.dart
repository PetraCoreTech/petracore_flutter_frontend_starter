import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String navigationExtTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

extension RouterCtxExt on BuildContext {
  SlideTransition slideTransition(Animation<double> animation, Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  FadeTransition fadeTransition(Animation<double> animation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  ScaleTransition scaleTransition(Animation<double> animation, Widget child) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final scaleAnimation = animation.drive(tween);
    return ScaleTransition(scale: scaleAnimation, child: child);
  }
}
''';
