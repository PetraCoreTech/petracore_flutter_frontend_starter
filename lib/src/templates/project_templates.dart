import '../generators/project_generator.dart';

class ProjectTemplates {
  final ProjectConfig config;

  ProjectTemplates(this.config);

  String get pubspecYaml => '''
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
  freezed_annotation: ^2.2.0
  json_annotation: ^4.8.0
  
  # Functional Programming
  dartz: ^0.10.1
${config.includeFirebase ? _firebaseDependencies : ''}
  
  # UI Components
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
  # Code Generation
  build_runner: ^2.4.11
  freezed: ^2.3.2
  json_serializable: ^6.8.0

flutter:
  uses-material-design: true
  
  generate: true

  assets:
    - assets/images/
    - assets/svg/
    - assets/lottie/
    - .env

  fonts:
    - family: Inter
      fonts:
        - asset: fonts/Inter-Regular.ttf
''';

  String get _firebaseDependencies => '''
  
  # Firebase
  firebase_core: ^3.12.1
  cloud_firestore: ^5.6.5${config.includeAnalytics ? '\n  firebase_analytics: ^11.4.4' : ''}${config.includeMessaging ? '\n  firebase_messaging: ^15.2.4\n  flutter_local_notifications: ^19.0.0' : ''}''';

  String get mainDart => '''
import 'package:${config.packageName}/app/app.dart';
import 'package:${config.packageName}/bootstrap.dart';

void main() {
  bootstrap(() => const App());
}
''';

  String get bootstrap => '''
import 'dart:async';
import 'dart:developer';

${config.includeFirebase ? "import 'package:firebase_core/firebase_core.dart';" : ''}
${config.includeFirebase ? "import 'package:cloud_firestore/cloud_firestore.dart';" : ''}
${config.includeMessaging ? "import 'package:firebase_messaging/firebase_messaging.dart';" : ''}
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
${config.includeFirebase ? "import 'package:${config.packageName}/firebase_options.dart';" : ''}
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(\${bloc.runtimeType}, \$change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(\${bloc.runtimeType}, \$error, \$stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  /// Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();

${config.includeFirebase ? _firebaseBootstrap : ''}

  await dotenv.load();

  /// Hydrated bloc initialization
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

${config.includeMessaging ? _messagingBootstrap : ''}

  runApp(await builder());
}
''';

  String get _firebaseBootstrap => '''
  /// Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
''';

  String get _messagingBootstrap => '''
  /// Firebase Messaging setup would go here
  /// Add your notification service initialization
''';

  String get appView => '''
import 'package:flutter/material.dart';
import 'package:${config.packageName}/app/app.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/shared/presentation/controllers/bloc_provider.dart';
import 'package:${config.packageName}/navigation/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtil.builder(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(
            title: AppConstants.appName,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: AppConstants.fontFamily,
            ),
          ),
        );
      },
    );
  }
}
''';

  String get appConstants => '''
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = '${config.className}';
  
  static const String fontFamily = 'Inter';

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

  String get coreBarrel => '''
export 'package:flutter/material.dart' hide Route;
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:gap/gap.dart';
export 'package:go_router/go_router.dart';
export 'package:${config.packageName}/navigation/navigation_index.dart';

export 'components/components_index.dart';
export 'data/data_index.dart';
export 'utils/utils_index.dart';
''';

  String get router => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/home/home_index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
''';

  String get analysisOptions => '''
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    avoid_print: false
    prefer_single_quotes: true
    always_declare_return_types: true
    always_put_required_named_parameters_first: true
    always_use_package_imports: true
    annotate_overrides: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    require_trailing_commas: true
    sort_child_properties_last: true
    sort_constructors_first: true
    lines_longer_than_80_chars: false
''';

  String get gitignore => '''
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Environmental variables
.env

# Web related
lib/generated_plugin_registrant.dart

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release
''';

  String get readme => '''
# ${config.className}

${config.description}

Generated with **PetraCore Flutter Frontend Starter** - A powerful CLI tool for creating Flutter projects with clean architecture and best practices.

## Architecture

This project follows Clean Architecture principles with:

- **Feature-based modular structure**: Each feature is self-contained in `/lib/features/`
- **BLoC pattern**: For predictable state management
- **Repository pattern**: For data layer abstraction  
- **Use cases**: For business logic separation
- **Dependency injection**: Using Provider for clean separation of concerns

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
${config.includeFirebase ? '- Firebase CLI (for Firebase setup)' : ''}

### Installation

1. Clone this repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
${config.includeFirebase ? _firebaseSetupInstructions : ''}

3. Run the app:
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── app/                    # App-level configuration
├── core/                   # Shared utilities and components
│   ├── components/         # Reusable UI components
│   ├── data/              # Core data services
│   └── utils/             # Utility functions and extensions
├── features/              # Feature modules
│   ├── home/              # Sample home feature
│   └── shared/            # Shared feature components
└── navigation/            # App navigation and routing

```

### Adding New Features

Use the PetraCore CLI to generate new features:

```bash
petracore feature my_feature
```

This generates a complete feature module with:
- Data layer (models, repositories, use cases)
- Presentation layer (screens, widgets, controllers)
- Proper barrel exports

### Available Scripts

- `flutter run` - Run the app in development mode
- `flutter test` - Run tests
- `flutter pub run build_runner build` - Generate code
- `flutter pub run build_runner watch` - Watch for changes and generate code

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `flutter test`
5. Submit a pull request

## License

This project is licensed under the MIT License.
''';

  String get _firebaseSetupInstructions => '''
3. Setup Firebase:
   - Create a Firebase project at https://console.firebase.google.com
   - Add your iOS and Android apps to the project
   - Download `google-services.json` and place in `android/app/`
   - Download `GoogleService-Info.plist` and place in `ios/Runner/`
   - Update `lib/firebase_options.dart` with your configuration
''';

  // Add other template getters...
  String get appBarrel => '''
export 'app/constants/app_constants.dart';
export 'app/view/app.dart';
export 'theme/theme.dart';
''';

  String get themeBarrel => '''
// Theme exports will go here
// export 'themes/light_theme.dart';
// export 'themes/dark_theme.dart';
''';

  String get componentsIndex => '''
// Buttons
export 'buttons/app_button.dart';

// Input Fields  
export 'input_fields/base_text_field.dart';

// Scaffolds
export 'scaffolds/base_scaffold.dart';

// States
export 'states/loading_indicator.dart';
''';

  String get dataIndex => '''
// Models
// export 'models/models.dart';

// Services
export 'services/network/network_service.dart';

// Domain
export 'domain/use_case.dart';
''';

  String get domainUseCase => '''
import 'package:dartz/dartz.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<String, Type>> call(Params params);
}

/// Use case with no parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<String, Type>> call();
}

/// Parameters base class
abstract class Params {
  const Params();
}

/// No parameters class
class NoParams extends Params {
  const NoParams();
}
''';

  String get utilsIndex => '''
// Extensions
export 'extensions/string_extensions.dart';
export 'extensions/context_extensions.dart';
''';

  String get navigationIndex => '''
export 'router.dart';
export 'routes.dart';
''';

  String get routes => '''
class NavigatorRoutes {
  static const String home = '/';
  
  // Add more route constants here
}
''';

  String get blocProvider => '''
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> blocProviders = [
  // Add your BLoC providers here
  // Example:
  // BlocProvider<AuthCubit>(
  //   create: (_) => AuthCubit(),
  // ),
];
''';

  String get stringExtensions => '''
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }

  String get camelCase {
    return split('_')
        .map((word) => word.isEmpty ? '' : word.capitalize)
        .join()
        .replaceFirst(this[0], this[0].toLowerCase());
  }

  bool get isValidEmail {
    return RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$').hasMatch(this);
  }
}
''';

  String get contextExtensions => '''
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  
  TextTheme get textTheme => theme.textTheme;
  
  ColorScheme get colorScheme => theme.colorScheme;
  
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  
  Size get screenSize => mediaQuery.size;
  
  double get screenHeight => screenSize.height;
  
  double get screenWidth => screenSize.width;
  
  EdgeInsets get padding => mediaQuery.padding;
  
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
''';

  String get networkService => '''
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  late final Dio _dio;
  
  NetworkService() {
    _dio = Dio();
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }
  
  Dio get dio => _dio;
  
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
''';

  String get appButton => '''
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return _buildOutlinedButton(context);
    }
    return _buildElevatedButton(context);
  }

  Widget _buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(
            color: backgroundColor ?? Theme.of(context).primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
''';

  String get baseTextField => '''
import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final bool enabled;

  const BaseTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
''';

  String get baseScaffold => '''
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;

  const BaseScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
    );
  }
}
''';

  String get loadingIndicator => '''
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;

  const LoadingIndicator({
    super.key,
    this.message,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: color ?? Theme.of(context).primaryColor,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
''';

  String get sampleHomeScreen => '''
import 'package:${config.packageName}/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: Text('${config.className}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: context.colorScheme.primary,
            ),
            const Gap(24),
            Text(
              'Welcome to ${config.className}',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Text(
              'Built with PetraCore Flutter Frontend Starter',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            AppButton(
              text: 'Get Started',
              onPressed: () {
                context.showSnackBar('Ready to build amazing features!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
''';

  String get sampleFeatureIndex => '''
export 'presentation/screens/home_screen.dart';
''';

  String get devtoolsOptions => '''
extensions:
''';

  String get vscodeSettings => '''
{
    "java.configuration.updateBuildConfiguration": "interactive",
    "cmake.configureOnOpen": false
}
''';

  String get vscodeLaunch => '''
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "${config.packageName}",
            "request": "launch",
            "type": "dart"
        },
        {
            "name": "${config.packageName} (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "${config.packageName} (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}
''';

  String get firebaseConfig => '''
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  }
}
''';

  String get firebaserc => '''
{
  "projects": {
    "default": "your-firebase-project-id"
  }
}
''';

  String get firestoreRules => '''
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read/write access on all documents to any user signed in to the application
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
''';

  String get firestoreIndexes => '''
{
  "indexes": [],
  "fieldOverrides": []
}
''';

  String get firebaseOptions => '''
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-web-api-key',
    appId: 'your-web-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-android-api-key',
    appId: 'your-android-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    iosClientId: 'your-ios-client-id',
    iosBundleId: '${config.organization}.${config.packageName}',
  );
}
''';

  String get envFile => '''
# Environment Variables
# Add your environment-specific variables here

# API Configuration
API_BASE_URL=https://api.example.com
API_TIMEOUT=30000

# App Configuration
APP_ENV=development
DEBUG_MODE=true

# Third-party Keys (Replace with your actual keys)
# GOOGLE_MAPS_API_KEY=your_google_maps_key
# STRIPE_PUBLISHABLE_KEY=your_stripe_key

${config.includeFirebase ? '# Firebase Configuration\n# FIREBASE_PROJECT_ID=your_project_id' : ''}
''';
}
