import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String pubspecYamlTemplate(ProjectConfig config) {
  return '''
name: ${config.packageName}
description: ${config.description}

publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Architecture & State Management
  flutter_bloc: ^8.1.3
  hydrated_bloc: ^9.1.5
  equatable: ^2.0.5

  # Navigation
  go_router: ^10.0.0

  # UI & Design
  flextras: ^1.0.0
  flutter_screenutil: ^5.4.0
  flutter_hooks: ^0.21.3
  animations: ^2.0.7
  gap: ^3.0.1
  lottie: ^3.1.3

  # Network & API
  dio: ^5.3.3
  pretty_dio_logger: ^1.4.0

  # Security & Storage
  flutter_secure_storage: ^9.0.0
  flutter_dotenv: ^5.0.2

  # Utilities
  intl: ^0.20.2
  uuid: ^4.3.3
  path: ^1.8.2
  path_provider: ^2.1.4

  # Code Generation
  json_annotation: ^4.8.0

  # Functional Programming
  dartz: ^0.10.1

  # UI Components
  cupertino_icons: ^1.0.6

  # App UI Kit
  app_ui_kit: ^0.0.1+4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

  # Code Generation
  build_runner: ^2.4.11
  json_serializable: ^6.8.0

flutter:
  uses-material-design: true

  generate: true

  assets:
    - assets/images/
    - assets/svg/
    - assets/lottie/
    - env.json
''';
}
