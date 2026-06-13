import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appConstantsTemplate(ProjectConfig config) {
  return '''
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = '${config.className}';

  static const String fontFamily = 'Plus Jakarta Sans';

  static const int otpInput = 6;

  static const Size designSize = Size(390, 844);

  static const List<String> imageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'bmp',
    'gif',
    'heif',
  ];

  static const List<String> videoExtensions = [
    'mp4',
    'mkv',
    'avi',
    'mov',
    'wmv',
    'flv',
    'webm',
  ];

  static const List<String> mediaExtensions = [
    ...videoExtensions,
    ...imageExtensions,
  ];
}
''';
}
