# PetraCore Flutter Frontend Starter

[![Pub Version](https://img.shields.io/badge/version-1.0.8-blue.svg)](https://pub.dev/packages/petracore_flutter_frontend_starter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful CLI tool and package for generating Flutter projects with **clean architecture**, **Firebase integration**, and **industry best practices**. Based on proven patterns from production applications.

## ✨ Features

- 🏗️ **Clean Architecture**: Feature-based modular structure with clear separation of concerns
- 🔥 **Firebase Integration**: Pre-configured Firestore, Analytics, and Cloud Messaging
- 🎨 **Dual Theme System**: Choose between Material 3 or custom Mix design tokens
- 🎨 **Modern UI**: Responsive design and comprehensive component library  
- 🧩 **BLoC Pattern**: Predictable state management with Hydrated BLoC
- 🚀 **CLI Tools**: Generate projects and features instantly
- 🔐 **Complete Authentication**: Full auth flow with login, signup, OTP, email verification
- 📱 **Multi-platform**: iOS, Android, Web, macOS, Windows, Linux support
- 🔐 **Security**: Secure storage, environment variables, and authentication patterns
- 🎯 **Best Practices**: Linting rules, code generation, and project structure
- 📦 **Rich Packages**: Carefully selected and battle-tested dependencies
- ✨ **Enhanced CLI**: Beautiful, professional logging with levels (debug, info, warning, error, success) and colored output for improved user experience

## 🆕 Recent Improvements (v1.0.8)

- **Nested Auth Routes**: Auth routes are now generated as a nested hierarchy rather than a flat list. `WelcomeScreen` is the parent route, with `LoginScreen` (containing forgot-password children), `SignupScreen`, and `VerifyOtpScreen` as child routes — matching GoRouter best practices for shared UI and proper URL scoping
- **Login Screen "Forgot Password?" Navigation**: The "Forgot Password?" link on the login screen now correctly navigates to `AppRoutes.forgotPassword` via `context.goNamed()` — no longer a no-op
- **Fixed Route Name**: Material forgot-password-verify screen now uses `AppRoutes.forgotPasswordVerify` (was incorrectly using `AppRoutes.fpVerify`)
- **Fixed Email Validation**: Email validator in `InputFieldValidator` now correctly returns "Email is invalid" when `input.isEmail()` is `false` (previously had a negated condition that passed invalid emails)
- **ToastHelper Offset Fixed**: Toast position offset changed from `-8` to `8` to display properly on screen
- **Env JSON Keys Standardized**: Template keys changed from `snake_case` to `UPPER_CASE` convention (`API_BASE_URL`, `APP_NAME`, etc.)

## 📋 What You Get

### Project Structure
```
your_project/
├── lib/
│   ├── app/                    # App-level configuration
│   │   ├── constants/          # App constants and string values
│   │   ├── view/               # Main app widget
│   │   └── theme/              # Theming configuration
│   │       ├── color_values.dart # Shared brand color palette (always generated)
│   │       ├── theme.dart        # Material 3 theme (if --theme material)
│   │       ├── design_tokens/    # Mix design tokens (if --theme mix)
│   │       └── themes/           # Mix theme files (if --theme mix)
│   ├── core/                   # Shared utilities and components
│   │   ├── components/        # Reusable UI components
│   │   ├── data/              # Core data services and domain logic
│   │   └── utils/             # Utility functions and extensions
│   ├── features/              # Feature modules (clean architecture)
│   │   ├── main_app/           # Dashboard screen (auto-generated)
│   │   └── shared/            # Shared feature components
│   ├── navigation/            # App navigation and routing
│   └── main.dart              # Entry point
├── assets/                     # Images, SVGs, Lottie files
├── fonts/                      # Custom fonts
├── firebase.json              # Firebase configuration
└── analysis_options.yaml     # Comprehensive linting rules
```

### Key Components
- **Bootstrap Pattern**: Centralized app initialization with error handling
- **Repository Pattern**: Data layer abstraction for testability
- **Use Cases**: Business logic separation following Clean Architecture
- **BLoC/Cubit**: State management with persistence
- **Custom Components**: Buttons, text fields, scaffolds, loading states
- **Navigation**: Declarative routing with GoRouter
- **Extensions**: Handy utilities for strings, context, and more

## 🚀 Installation

### Global Installation (Recommended)

```bash
dart pub global activate petracore_flutter_frontend_starter
```

### Local Installation

```bash
dart pub add petracore_flutter_frontend_starter
```

## 📖 Usage

### Create a New Project

```bash
# Interactive theme selection (you'll be prompted to choose Mix or Material)
petracore init my_awesome_app

# With Material 3 theme (skips interactive prompt)
petracore init my_material_app --theme material

# With custom organization
petracore init my_app --org com.mycompany

# Without Firebase (coming soon)
# petracore init simple_app --no-firebase

# With custom description
petracore init my_app --description "My amazing Flutter application"

# Force overwrite existing directory
petracore init existing_app --force

# Skip all interactive prompts (uses defaults)
petracore init my_app --no-interactive
```

### Generate Features

```bash
# Generate a complete feature with all components (BLoC provider auto-registered)
petracore feature user_profile

# Generate feature without BLoC
petracore feature simple_feature --no-bloc

# Generate feature with custom output directory
petracore feature profile --output lib/modules

# Generate feature without models
petracore feature ui_feature --no-models

# Alternative syntax
petracore generate feature chat
```

> **Note**: When generating features with BLoC enabled, the CLI automatically registers the feature's BLoC provider in `lib/features/shared/presentation/controllers/bloc_provider.dart`. No manual editing needed.

### Generate Complete Authentication Flow

```bash
# Interactive mode - guided setup
petracore auth

# Non-interactive with specific features
petracore auth --no-interactive --login --signup --forgot-password --otp

# Full auth flow with all features
petracore auth --login --signup --email-verification --forgot-password --phone-verification --otp --social-auth --device-token

# Basic auth setup
petracore auth --no-interactive --login --signup

### Generate Complete Media Feature

```bash
# Interactive mode - choose full media or basic feature
petracore feature media

# Full media feature with Cloudinary, image picker, BLoCs, and widgets
# Auto-detected "media" keyword prompts for complete setup
```

### Available Options

#### Init Command Options
- `--theme`: Theme type - `mix` (default) or `material`. If omitted, you'll be prompted interactively
- `--no-interactive`: Skip interactive prompts and use defaults
- `--org`: Organization identifier (default: com.petracore)
- `--description`: Project description
- `--force`: Force creation even if directory exists
- `--verbose`: Enable detailed output

#### Feature Command Options  
- `--bloc` / `--no-bloc`: Include BLoC/Cubit (default: true)
- `--repository` / `--no-repository`: Include repository pattern (default: true)
- `--use-cases` / `--no-use-cases`: Include use cases (default: true)
- `--models` / `--no-models`: Include data models (default: true)
- `--list`: Include a list screen for the feature (default: false)
- `--output`: Custom output directory (default: lib/features)

#### Auth Command Options
- `--login` / `--no-login`: Include login functionality (default: true)
- `--signup` / `--no-signup`: Include signup functionality (default: true)
- `--email-verification`: Include email verification (default: false)
- `--forgot-password`: Include forgot password functionality (default: false)
- `--phone-verification`: Include phone verification (default: false)
- `--otp`: Include OTP (One-Time Password) functionality (default: false)
- `--social-auth`: Include social authentication placeholders (default: false)
- `--device-token`: Include device token support for push notifications (default: false)
- `--interactive` / `--no-interactive`: Use interactive mode (default: true)
- `--output`: Output directory (default: current directory)

## 🔧 Generated Architecture

### Feature Structure
Each generated feature follows this structure:

```
features/your_feature/
├── your_feature_index.dart           # Barrel export file (exports models directly)
├── data/
│   ├── models/
│   │   └── your_feature_model.dart   # Data models with JSON serialization
│   ├── remote/
│   │   ├── your_feature_service.dart     # API service
│   │   ├── your_feature_repository.dart  # Repository interface & implementation
│   │   └── dto/
│   │       ├── create_your_feature_dto.dart
│   │       ├── update_your_feature_dto.dart
│   │       └── your_feature_params.dart
│   └── domain/
│       └── your_feature_use_cases.dart   # Business logic use cases
└── presentation/
    ├── controllers/
    │   ├── cubits/
    │   │   └── your_feature_cubit.dart   # Cubit state management
    │   ├── blocs/
    │   │   ├── multiple_your_feature_bloc/  # Data BLoC (multi-state)
    │   │   │   ├── multiple_your_feature_bloc.dart
    │   │   │   ├── multiple_your_feature_event.dart
    │   │   │   └── multiple_your_feature_state.dart
    │   │   └── your_feature_action_bloc/   # Action BLoC (single-state)
    │   │       ├── your_feature_action_bloc.dart
    │   │       ├── your_feature_action_event.dart
    │   │       └── your_feature_action_state.dart
    │   ├── your_feature_bloc_provider.dart  # BLoC provider (auto-registered)
    │   └── your_feature_controller_index.dart
    ├── screens/
    │   ├── your_feature_screen.dart  # Main feature screen
    │   └── your_feature_screens_index.dart
    ├── widgets/
    └── presentation.dart             # Presentation barrel export
```

### Core Packages Included

```yaml
# Architecture & State Management
flutter_bloc: ^8.1.3           # Predictable state management
hydrated_bloc: ^9.1.5          # State persistence
provider: ^6.0.2               # Dependency injection
equatable: ^2.0.5              # Value equality

# Navigation
go_router: ^10.0.0             # Declarative routing

# UI & Design  
flutter_screenutil: ^5.4.0     # Responsive design
flutter_hooks: ^0.18.6         # React-like hooks
animations: ^2.0.7             # Rich animations
gap: ^3.0.1                    # Spacing widgets
google_fonts: ^4.0.4           # Custom fonts
cached_network_image: ^3.2.3   # Optimized image loading
lottie: ^2.2.0                 # Lottie animations

# Network & API
dio: ^5.3.3                    # HTTP client
pretty_dio_logger: ^1.4.0      # Request/response logging

# Security & Storage  
flutter_secure_storage: ^9.0.0 # Secure key-value storage
flutter_dotenv: ^5.0.2         # Environment variables

# Code Generation
json_serializable: ^6.8.0      # JSON serialization
build_runner: ^2.4.11          # Code generation runner

# Functional Programming
dartz: ^0.10.1                 # Functional programming utilities

# Firebase (optional)
firebase_core: ^3.12.1         # Firebase core
cloud_firestore: ^5.6.5        # Cloud Firestore
firebase_analytics: ^11.4.4    # Analytics
firebase_messaging: ^15.2.4    # Cloud Messaging
```

## 🛠️ Development Workflow

### After Creating a Project

1. **Navigate to your project**:
   ```bash
   cd your_project_name
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code** (for models):
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run your app**:
   ```bash
   flutter run
   ```

### Adding New Features

1. **Generate the feature**:
   ```bash
   petracore feature user_profile
   ```

2. **BLoC provider auto-registered**: The CLI automatically adds the feature's BLoC provider to `lib/features/shared/presentation/controllers/bloc_provider.dart` - no manual step needed.

3. **Generate code** (if using models):
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Navigation routes are auto-registered**: Both auth and feature generators automatically register routes in `lib/navigation/routes.dart` (using the `Route` data class), create a per-feature route list in `lib/navigation/routes/<feature>_routes.dart`, and update `router.dart` — no manual editing needed.

## 🎨 Dual Theme System

PetraCore supports two theme architectures:

### Material 3 Theme
Pure Flutter Material 3 implementation using standard `ThemeData`:
- Generated files: `lib/app/theme/theme.dart`
- Uses `AppColors` from `color_values.dart` for all color references
- Components use `Theme.of(context)` for styling
- No external dependencies beyond Flutter Material

### Mix Theme
Petracore's custom design token system:
- Generated files: `lib/app/theme/design_tokens/` and `lib/app/theme/themes/`
- Uses `$token.color` for accessing design tokens
- Components use Mix design system patterns
- Full design token architecture with color, radius, and text style tokens

### Shared: Color Values
`color_values.dart` is generated for **both** theme types as the source of truth for brand colors:
- Primary, secondary, technical colors
- Neutral palette (50-600 scale)
- Error, success, warning, info states
- Surface colors (white, black, overlays)

### Theme Customization
- **Material**: Modify `AppColors` in `color_values.dart` - all theme colors derive from these values
- **Mix**: Modify design tokens in `design_tokens/` and theme files in `themes/`
- **Both**: Update `AppConstants.fontFamily` for typography changes

## 🎨 Customization

### Themes and Design
- Modify `lib/app/theme/` for custom themes
- Update `lib/app/constants/app_constants.dart` for design tokens
- Add custom fonts to `fonts/` directory

### Components
- Extend components in `lib/core/components/`
- Add new utilities in `lib/core/utils/`
- Create custom extensions in `lib/core/utils/extensions/`

### Configuration
- Environment variables in `env.json`
- App-level config in `lib/app/app/constants/`

## 🧪 Testing

The generated project includes:

- Unit test structure in `test/`
- Widget test examples
- BLoC testing patterns
- Repository testing with mocks

Run tests:
```bash
flutter test
```

## 📚 Examples

### Creating a Complete App

```bash
# Create a full-featured app
petracore init social_media_app \
  --org com.yourcompany \
  --description "A social media application with real-time features" \

cd social_media_app
flutter pub get

# Generate core features
petracore feature auth
petracore feature user_profile  
petracore feature feed
petracore feature chat

# Generate code and run
flutter packages pub run build_runner build
flutter run
```

### Authentication Flow Examples

```bash
# Complete authentication flow (interactive)
petracore auth

# Full-featured auth with all options
petracore auth --no-interactive \
  --login --signup --email-verification \
  --forgot-password --otp --social-auth

# Basic login/signup only
petracore auth --no-interactive --login --signup

# Auth with OTP verification
petracore auth --no-interactive --login --signup --otp
```

### Feature Generation Examples

```bash
# Basic feature generation
petracore feature user_profile

# Simple UI-only feature  
petracore feature settings --no-bloc --no-repository --no-use-cases

# Complex feature with custom location
petracore feature payment \
  --output lib/modules \
  --bloc \
  --repository \
  --use-cases \
  --models
```

## 🔍 Advanced Usage

### Custom Templates
You can extend the CLI by creating your own templates in the `templates/` directory.

### Integration with Existing Projects
The feature generator works with any Flutter project that follows similar conventions.

### CI/CD Integration
The generated projects include:
- GitHub Actions workflows (coming soon)
- Proper linting configuration
- Testing setup
- Build configuration

### Development Setup

```bash
git clone https://github.com/yourusername/petracore_flutter_frontend_starter.git
cd petracore_flutter_frontend_starter
dart pub get

# Run tests
dart test

# Test CLI locally
dart run bin/main.dart --help
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with inspiration from clean architecture principles
- Based on patterns from production Flutter applications  
- Incorporates Flutter community best practices

## 🆘 Support

[//]: # (- 📧 Email: support@petracore.com)
- 🐛 Issues: [GitHub Issues](https://github.com/PetraCoreTech/petracore_flutter_frontend_starter/issues)
---

**Made with ❤️ by the PetraCore Team**
