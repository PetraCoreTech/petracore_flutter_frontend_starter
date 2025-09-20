import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mainDartTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.packageName}/app/app.dart';
import 'package:${config.packageName}/bootstrap.dart';

void main() {
  bootstrap(() => const App());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
''';
