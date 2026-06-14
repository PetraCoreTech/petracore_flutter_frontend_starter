import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mapSetupGuideTemplate(ProjectConfig config) => '''# Map Feature Setup Guide

## 1. Environment Variables
Add to your \`.env\` file:
\`\`\`
google_api_key=YOUR_GOOGLE_MAPS_API_KEY
\`\`\`

## 2. Android Configuration

### minSdk
In \`android/app/build.gradle\`, set \`minSdk\` to 23 or higher:
\`\`\`groovy
defaultConfig {
    minSdk = 23
}
\`\`\`

### API Key
In \`android/app/src/main/AndroidManifest.xml\`, add inside the \`<application>\` tag:
\`\`\`xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="\@string/google_maps_key" />
\`\`\`

### API Key Resource
In \`android/app/src/main/res/values/strings.xml\`, add:
\`\`\`xml
<string name="google_maps_key">YOUR_GOOGLE_MAPS_API_KEY</string>
\`\`\`

## 3. iOS Configuration
In \`ios/Runner/AppDelegate.swift\`:
\`\`\`swift
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
\`\`\`

## 4. Register Bloc Provider
The import and provider spread should have been added automatically to \`lib/app/shared/bloc_provider.dart\`.
If not, manually add:
\`\`\`dart
import 'package:${config.packageName}/features/map/presentation/controllers/map_bloc_provider.dart';
\`\`\`
And add \`...mapBlocProvider,\` inside your providers list.

## 5. Register Bloc Listener
In your main screen, add \`locationBlocListener\` to your \`BlocListener\` list:
\`\`\`dart
locationBlocListener,
\`\`\`

## 6. Run Build Runner
\`\`\`bash
dart run build_runner build
\`\`\`
''';
