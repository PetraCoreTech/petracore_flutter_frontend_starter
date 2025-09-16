import '../../generators/project_generator.dart';

String pubspecYamlTemplate(ProjectConfig config) => '''
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
  provider: ^6.0.2
  equatable: ^2.0.5
  
  # Navigation
  go_router: ^10.0.0
  
  # UI & Design
  flutter_screenutil: ^5.4.0
  flutter_svg: ^2.0.17
  flutter_hooks: ^0.18.6
  animations: ^2.0.7
  gap: ^3.0.1
  google_fonts: ^4.0.4
  cached_network_image: ^3.2.3
  lottie: ^2.2.0
  mix: ^1.4.5
  
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
  
  # Code Generation
  json_annotation: ^4.8.0
  
  # Functional Programming
  dartz: ^0.10.1
  
  # UI Components
  cupertino_icons: ^1.0.6

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

  fonts:
    - family: Inter
      fonts:
        - asset: fonts/Inter-Regular.ttf
''';
