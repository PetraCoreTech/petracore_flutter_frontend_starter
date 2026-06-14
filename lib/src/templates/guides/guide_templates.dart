String authGuideTemplate(String packageName) => '''# Auth Feature Setup Guide

## 1. Add Dependencies

Add these to your \`pubspec.yaml\`:

\`\`\`yaml
dependencies:
  flutter_bloc: ^8.1.3
  dartz: ^0.10.1
  dio: ^5.3.0
  flutter_secure_storage: ^9.0.0
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.6
  json_serializable: ^6.7.1
\`\`\`

Then run:
\`\`\`bash
flutter pub get
\`\`\`

## 2. Register Bloc Provider

In \`lib/features/shared/presentation/controllers/bloc_provider.dart\`:

\`\`\`dart
import 'package:$packageName/features/auth/presentation/controllers/auth_controller_index.dart';
\`\`\`

Add \`...authBlocProvider,\` inside the providers list.

## 3. Add Routes

In your router configuration, add the auth routes:

\`\`\`dart
import 'package:$packageName/features/auth/presentation/screens/auth_routes.dart';
\`\`\`

Then add \`authRoutes\` to your route list.

## 4. Configure API Base URL

Set your API base URL in \`env.json\`:
\`\`\`json
{
  "base_url": "https://your-api.com/api/v1"
}
\`\`\`

## 5. Run Build Runner

\`\`\`bash
dart run build_runner build
\`\`\`

## 6. Verify Integration

- Check that the auth routes are accessible
- Test login and signup flows
- Verify token storage is working
''';

String mediaGuideTemplate() => '''# Media Feature Setup Guide

## 1. Environment Variables

Add Cloudinary credentials to your build command or \`env.json\`:

\`\`\`json
{
  "cloud_name": "your_cloud_name",
  "cloudinary_api_key": "your_api_key",
  "cloudinary_api_secret": "your_api_secret"
}
\`\`\`

Or pass via \`--dart-define\`:
\`\`\`bash
flutter run --dart-define=CLOUD_NAME=your_cloud \\
           --dart-define=CLOUDINARY_API_KEY=your_key \\
           --dart-define=CLOUDINARY_SECRET_KEY=your_secret
\`\`\`

## 2. Run Build Runner

\`\`\`bash
dart run build_runner build
\`\`\`

## 3. Usage

Use \`MediaHelper\` to pick and display media throughout your app:

\`\`\`dart
final helper = MediaHelper();
await helper.pickImage();
await helper.pickVideo();
\`\`\`

## 4. Verify Integration

- Test image picking from gallery and camera
- Test video playback
- Verify upload progress indicators work
''';

String mapGuideTemplate() => '''# Map Feature Setup Guide

## 1. Environment Variables

Add your Google Maps API key to \`.env\` or \`env.json\`:

\`\`\`json
{
  "google_api_key": "YOUR_GOOGLE_MAPS_API_KEY"
}
\`\`\`

## 2. Android Configuration

### minSdk
In \`android/app/build.gradle.kts\`, set \`minSdk\` to 23 or higher:
\`\`\`kotlin
android {
    defaultConfig {
        minSdk = 23
    }
}
\`\`\`

### API Key in AndroidManifest
In \`android/app/src/main/AndroidManifest.xml\`, inside the \`<application>\` tag:
\`\`\`xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="@string/google_maps_key" />
\`\`\`

### API Key Resource
In \`android/app/src/main/res/values/strings.xml\`:
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

The import and provider spread should have been added automatically to \`lib/features/shared/presentation/controllers/bloc_provider.dart\`.
If not, add:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/map/presentation/controllers/map_bloc_provider.dart';
\`\`\`

And add \`...mapBlocProvider,\` inside the providers list.

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

String notificationGuideTemplate() => '''# Notification Feature Setup Guide

## 1. Import in Your App

Import the notification index in your main app file:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/notification/notification_index.dart';
\`\`\`

## 2. Usage

### Notification Badge
Display an unread notification count badge:
\`\`\`dart
NotificationBadge(count: unreadCount)
\`\`\`

### Notification List
Display a scrollable list of notifications:
\`\`\`dart
NotificationList(notifications: notifications)
\`\`\`

### Notification Tile
Use individual notification tiles:
\`\`\`dart
NotificationTile(notification: notification)
\`\`\`

## 3. Firebase Cloud Messaging

The FCM service is set up in \`lib/features/notification/presentation/services/\`. Configure your \`google-services.json\` (Android) and \`GoogleService-Info.plist\` (iOS) for push notifications to work.
''';

String surveyGuideTemplate() => '''# Survey Feature Setup Guide

## 1. Import in Your App

Import the survey index in your main app file:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/survey/survey_index.dart';
\`\`\`

## 2. Usage

### Survey Builder
The \`SurveyBuilder\` widget renders interactive quizzes and forms:
\`\`\`dart
SurveyBuilder(
  questions: questions,
  onComplete: (answers) {
    // Handle completed survey
  },
)
\`\`\`

### Survey Mode Cubit
Control edit/view modes:
\`\`\`dart
context.read<SurveyModeCubit>().setMode(SurveyMode.edit);
\`\`\`

### Available Widgets
- \`SurveyBuilder\` - Main survey rendering widget
- \`QuestionDisplay\` - Individual question display
- \`OptionSelector\` - Answer option selection
''';

String paginationGuideTemplate() => '''# Pagination Feature Setup Guide

## 1. Usage

Import the pagination feature and use \`PaginatedListBuilder\` in any feature that needs pagination:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/pagination/pagination_index.dart';
\`\`\`

### Paginated List Builder

\`\`\`dart
PaginatedListBuilder<T>(
  fetchItems: (page) => myRepository.fetchItems(page: page),
  itemBuilder: (context, item, index) => ListTile(title: Text(item.name)),
)
\`\`\`

### Paginated List View

\`\`\`dart
PaginatedListView(
  items: myItems,
  hasMore: hasMore,
  onLoadMore: () => loadMore(),
  itemBuilder: (context, index) => ListTile(title: Text(myItems[index].name)),
)
\`\`\`

## 2. Pagination BLoC

The pagination BLoC manages loading states, error handling, and infinite scroll logic. Use it directly for custom implementations:

\`\`\`dart
PaginationBloc<T>()
  ..add(PaginationStarted());
  ..add(PaginationLoadMore());
\`\`\`
''';

String chatbotGuideTemplate() => '''# Chatbot Feature Setup Guide

## 1. Register Bloc Provider

In \`lib/features/shared/presentation/controllers/bloc_provider.dart\`:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/chatbot/presentation/controllers/chatbot_bloc_provider.dart';
\`\`\`

Add \`...chatbotBlocProvider,\` inside the providers list.

## 2. Add Route

In \`lib/navigation/routes.dart\`:

\`\`\`dart
static const chatbot = AppRoute(path: '/chatbot', name: 'chatbot');
\`\`\`

## 3. Run Build Runner

\`\`\`bash
dart run build_runner build
\`\`\`
''';

String basicFeatureGuideTemplate(String featureName) => '''# $featureName Feature Setup Guide

## 1. Register Bloc Provider

In \`lib/features/shared/presentation/controllers/bloc_provider.dart\`:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/$featureName/presentation/controllers/${featureName}_controller_index.dart';
\`\`\`

Add the feature's bloc provider spread inside the providers list.

## 2. Update Navigation Routes

In your router configuration, add the feature's routes:

\`\`\`dart
import 'package:YOUR_PACKAGE_NAME/features/$featureName/presentation/screens/${featureName}_routes.dart';
\`\`\`

Add the routes to your route list.

## 3. Run Build Runner

\`\`\`bash
dart run build_runner build
\`\`\`

## 4. Verify Integration

- Check that the feature's screens are accessible
- Test data flow from UI through BLoC to repository
- Verify models serialize/deserialize correctly
''';
