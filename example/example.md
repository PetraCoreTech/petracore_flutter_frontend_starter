# PetraCore Flutter Frontend Starter - Examples

This file contains practical examples of using the PetraCore CLI tool.

## Creating a Complete Social Media App

```bash
# Create the main project
petracore init social_media_app \
  --org com.yourcompany \
  --description "A social media app with real-time features" \
  --firebase \
  --analytics \
  --messaging

cd social_media_app
flutter pub get

# Generate core features
petracore feature auth
petracore feature user_profile
petracore feature feed
petracore feature chat
petracore feature notifications

# Generate additional features
petracore feature search
petracore feature settings --no-bloc --no-repository
petracore feature media_upload

# Generate code for models
flutter packages pub run build_runner build

# Run the app
flutter run
```

## Creating a Business App

```bash
# Create business app without Firebase
petracore init business_app \
  --org com.businesscorp \
  --description "A business management application" \
  --no-firebase

cd business_app
flutter pub get

# Generate business-specific features
petracore feature dashboard
petracore feature customers
petracore feature inventory
petracore feature reports
petracore feature analytics
```

## Creating a Simple Utility App

```bash
# Create minimal app
petracore init calculator_app \
  --org com.utilities \
  --description "A simple calculator app" \
  --no-firebase \
  --no-analytics \
  --no-messaging

cd calculator_app
flutter pub get

# Generate minimal features
petracore feature calculator --no-repository --no-use-cases
petracore feature history --no-bloc
petracore feature settings --no-bloc --no-repository --no-use-cases
```

## Working with Generated Features

### Adding a Feature to BLoC Providers

After generating a feature, add it to your main BLoC provider:

```dart
// lib/features/shared/presentation/controllers/bloc_provider.dart
import 'package:provider/single_child_widget.dart';
import 'package:your_app/features/auth/auth_index.dart';
import 'package:your_app/features/profile/profile_index.dart';

final List<SingleChildWidget> blocProviders = [
  // Auth providers
  ...authBlocProvider,
  
  // Profile providers  
  ...profileBlocProvider,
  
  // Add more feature providers here
];
```

### Adding Navigation Routes

Update your router configuration:

```dart
// lib/navigation/router.dart
import 'package:your_app/core/core.dart';
import 'package:your_app/features/home/home_index.dart';
import 'package:your_app/features/auth/auth_index.dart';
import 'package:your_app/features/profile/profile_index.dart';

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
```

## Tips and Best Practices

### 1. Start with Core Features
Generate essential features first:
```bash
petracore feature auth
petracore feature user_profile
petracore feature home
```

### 2. Use Descriptive Names
```bash
# Good
petracore feature user_authentication
petracore feature payment_processing
petracore feature real_time_chat

# Avoid
petracore feature auth_stuff
petracore feature thing
petracore feature temp
```

### 3. Organize Complex Apps
For large apps, use output directories:
```bash
petracore feature user_auth --output lib/modules/auth
petracore feature admin_panel --output lib/modules/admin
petracore feature customer_support --output lib/modules/support
```

### 4. Testing Your Generated Features
```bash
# After generating features, always run:
flutter packages pub run build_runner build
flutter test
flutter analyze
```

### 5. Environment Configuration
Update your `.env` file with real configuration:
```env
# .env
API_BASE_URL=https://your-api.com/v1
API_TIMEOUT=30000
STRIPE_PUBLISHABLE_KEY=pk_live_your_key
GOOGLE_MAPS_API_KEY=your_maps_key
```

## Common Workflows

### Daily Development
```bash
# Generate a new feature
petracore feature new_feature

# Generate code for models
flutter packages pub run build_runner build

# Run tests
flutter test

# Run app
flutter run
```

### Production Preparation
```bash
# Build for release
flutter build apk --release
flutter build ios --release
flutter build web --release

# Analyze code quality
flutter analyze
dart format .
```

This completes the examples for using PetraCore Flutter Frontend Starter!
