String pageControllerExtTemplate() => """
import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {
  static const duration = Duration(milliseconds: 300);

  Future<void> next({Curve? curve}) {
    final a = this;
    return a.nextPage(duration: duration, curve: curve ?? Curves.ease);
  }

  Future<void> previous({Curve? curve}) {
    final a = this;
    return a.previousPage(duration: duration, curve: curve ?? Curves.ease);
  }

  Future<void> go(int page, {Curve? curve}) {
    final a = this;
    return a.animateToPage(
      page,
      duration: duration,
      curve: curve ?? Curves.ease,
    );
  }
}
""";
