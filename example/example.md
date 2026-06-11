# PetraCore Flutter Frontend Starter - Examples

This file contains practical examples of using the PetraCore CLI tool.

## Creating a Complete Social Media App

```bash
# Create the main project with auth included
petracore init social_media_app \
  --org com.yourcompany \
  --description "A social media app with real-time features" \
  --include-auth

cd social_media_app
flutter pub get

# Generate core features
petracore feature user_profile
petracore feature feed
petracore feature chat
petracore feature notifications

# Generate additional features
petracore feature search
petracore feature settings --no-bloc --no-repository
petracore feature media

# Generate code for models
flutter packages pub run build_runner build

# Run the app
flutter run
```

## Creating a Business App

```bash
# Create business app with Vercel-inspired design
petracore init business_app \
  --org com.businesscorp \
  --description "A business management application" \
  --design-preset vercel

cd business_app
flutter pub get

# Generate business-specific features
petracore feature dashboard
petracore feature customers
petracore feature inventory --list
petracore feature reports
petracore feature analytics
```

## Creating a Simple Utility App

```bash
# Create minimal app (non-interactive, skips all prompts)
petracore init calculator_app \
  --org com.utilities \
  --description "A simple calculator app" \
  --no-interactive

cd calculator_app
flutter pub get

# Generate minimal features
petracore feature calculator --no-bloc --no-repository --no-use-cases
petracore feature history --no-bloc
petracore feature settings --no-bloc --no-repository --no-use-cases
```

## Generating a Complete Authentication Flow

```bash
# Option 1: Generate auth alongside the project (recommended)
petracore init my_app --include-auth

# Option 2: Standalone auth generation (interactive)
petracore auth

# Option 3: Non-interactive with specific features
petracore auth --no-interactive --login --signup --forgot-password --otp

# Option 4: Full auth flow with all features
petracore auth --login --signup --email-verification --forgot-password --phone-verification --otp --social-auth --device-token

# Option 5: Via the feature command (interactive prompt)
petracore feature auth
```

## Generating a Complete Media Feature

```bash
# Interactive mode - choose full media or basic feature
petracore feature media

# The full media feature includes:
# - Cloudinary integration (upload/download/delete)
# - Image picker
# - Upload & Download BLoCs with progress tracking
# - Media display, video player, and picker widgets
# - File size & type utilities
```

## Working with Generated Features

### Advanced Feature Options

```bash
# Generate a feature with a list screen
petracore feature products --list

# Custom data layer naming
petracore feature payment \
  --entity transaction \
  --service payment_service \
  --repository-name payment_repo

# Generate feature in a custom directory
petracore feature admin_panel --output lib/modules/admin

# Alternative syntax
petracore generate feature chat
```

### BLoC Providers (Auto-Registered)

After generating a feature, the CLI automatically registers its BLoC provider in the shared provider file:

```dart
// lib/features/shared/presentation/controllers/bloc_provider.dart
//
// The CLI adds entries between petracore:start:bloc_providers and petracore:end:bloc_providers
// markers. No manual editing needed.

import 'package:provider/single_child_widget.dart';
import 'package:your_app/features/auth/auth_index.dart';
import 'package:your_app/features/profile/profile_index.dart';

final List<SingleChildWidget> blocProviders = [
  // petracore:start:bloc_providers
  ...authBlocProvider,
  ...profileBlocProvider,
  // petracore:end:bloc_providers
];
```

### Navigation Routes (Auto-Registered)

Routes are auto-registered using a 5-layer navigation architecture:

1. **Route constants** - `lib/navigation/routes.dart` defines `AppRoute` data class instances
2. **Per-feature route lists** - `lib/navigation/routes/<feature>_routes.dart`
3. **Router** - `lib/navigation/router.dart` spreads feature routes via `...featureRoutes`

```dart
// lib/navigation/routes.dart
//
// Route constants are added between petracore:start:route_constants
// and petracore:end:route_constants markers. No manual editing needed.

import 'package:core/core.dart';

// petracore:start:route_constants
const authRoute = AppRoute(path: '/auth', name: 'auth');
const homeRoute = AppRoute(path: '/', name: 'home');
const profileRoute = AppRoute(path: '/profile', name: 'profile');
// petracore:end:route_constants
```

```dart
// lib/navigation/router.dart
import 'package:core/core.dart';
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
    // petracore:start:feature_routes
    ...authRoutes,
    ...profileRoutes,
    // petracore:end:feature_routes
  ],
);
```

## Design Presets

Choose a design language when creating a project:

```bash
# Default PetraCore design (green accents, Times New Roman)
petracore init my_app --design-preset default

# Vercel-inspired (monochrome, Inter font, tight radii)
petracore init my_app --design-preset vercel

# Airbnb-inspired (warm accent, Circular font, friendly radii)
petracore init my_app --design-preset airbnb

# Apple-inspired (blue accent, SF Pro Display, precise radii)
petracore init my_app --design-preset apple
```

## Tips and Best Practices

### 1. Start with Core Features
Generate essential features first:
```bash
petracore init my_app --include-auth
petracore feature home
petracore feature user_profile
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
Update your `env.json` file with real configuration:
```json
{
  "env": {
    "API_BASE_URL": "https://your-api.com/v1",
    "API_TIMEOUT": 30000,
    "STRIPE_PUBLISHABLE_KEY": "pk_live_your_key",
    "GOOGLE_MAPS_API_KEY": "your_maps_key"
  }
}
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
