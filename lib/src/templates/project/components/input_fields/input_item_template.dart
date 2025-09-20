import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String inputItemTemplate(ProjectConfig config) => '''
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InputItem<T> extends Equatable {
  const InputItem({
    required this.value,
    required this.title,
    this.subtitle,
    this.iconData,
    this.icon,
  });
  final T value;
  final String title;
  final String? subtitle;
  final IconData? iconData;
  final String? icon;

  @override
  List<Object?> get props => [value];
}
''';
