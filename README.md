# 🏗️ PetraCore Flutter Frontend Starter

[![Pub Version](https://img.shields.io/pub/v/petracore_flutter_frontend_starter)](https://pub.dev/packages/petracore_flutter_frontend_starter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful CLI tool and package for generating Flutter projects with **clean architecture**, **Firebase integration**, and **industry best practices**. Based on proven patterns from production applications.

## ✨ Features

- 🏗️ **Clean Architecture**: Feature-based modular structure with clear separation of concerns
- 🔥 **Firebase Integration**: Pre-configured Firestore, Analytics, and Cloud Messaging
- 🎨 **Modern UI**: Material 3, responsive design, and comprehensive component library  
- 🧩 **BLoC Pattern**: Predictable state management with Hydrated BLoC
- 🚀 **CLI Tools**: Generate projects and features instantly
- 📱 **Multi-platform**: iOS, Android, Web, macOS, Windows, Linux support
- 🔐 **Security**: Secure storage, environment variables, and authentication patterns
- 🎯 **Best Practices**: Linting rules, code generation, and project structure
- 📦 **Rich Packages**: Carefully selected and battle-tested dependencies

## 📋 What You Get

### Project Structure
```
your_project/
├── lib/
│   ├── app/                    # App-level configuration
│   │   ├── app/               # App constants and main app widget
│   │   └── theme/             # Theming configuration
│   ├── core/                   # Shared utilities and components
│   │   ├── components/        # Reusable UI components
│   │   ├── data/              # Core data services and domain logic
│   │   └── utils/             # Utility functions and extensions
│   ├── features/              # Feature modules (clean architecture)
│   │   ├── home/              # Sample home feature
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
# Basic project
petracore init my_awesome_app

# With custom organization
petracore init my_app --org com.mycompany

# Without Firebase
petracore init simple_app --no-firebase

# With custom description
petracore init my_app --description "My amazing Flutter application"

# Force overwrite existing directory
petracore init existing_app --force
```

### Generate Features

```bash
# Generate a complete feature with all components
petracore feature auth

# Generate feature without BLoC
petracore feature simple_feature --no-bloc

# Generate feature with custom output directory
petracore feature profile --output lib/modules

# Generate feature without models
petracore feature ui_feature --no-models

# Alternative syntax
petracore generate feature chat
```

### Available Options

#### Init Command Options
- `--firebase` / `--no-firebase`: Include Firebase setup (default: true)
- `--analytics` / `--no-analytics`: Include Firebase Analytics (default: true)
- `--messaging` / `--no-messaging`: Include Firebase Cloud Messaging (default: true)
- `--org`: Organization identifier (default: com.petracore)
- `--description`: Project description
- `--force`: Force creation even if directory exists
- `--verbose`: Enable detailed output

#### Feature Command Options  
- `--bloc` / `--no-bloc`: Include BLoC/Cubit (default: true)
- `--repository` / `--no-repository`: Include repository pattern (default: true)
- `--use-cases` / `--no-use-cases`: Include use cases (default: true)
- `--models` / `--no-models`: Include data models (default: true)
- `--output`: Custom output directory (default: lib/features)

## 🔧 Generated Architecture

### Feature Structure
Each generated feature follows this structure:

```
features/your_feature/
├── your_feature_index.dart           # Barrel export file
├── data/
│   ├── models/
│   │   ├── your_feature_model.dart   # Data models with JSON serialization
│   │   └── models.dart               # Models barrel export
│   ├── repositories/
│   │   ├── your_feature_repository.dart  # Repository interface & implementation
│   │   └── repositories.dart         # Repositories barrel export
│   └── use_cases/
│       ├── get_your_feature_use_case.dart  # Business logic use cases
│       └── use_cases.dart            # Use cases barrel export
└── presentation/
    ├── controllers/
    │   ├── your_feature_cubit.dart   # State management
    │   ├── your_feature_state.dart   # State definitions
    │   ├── your_feature_bloc_provider.dart  # BLoC provider
    │   └── controllers.dart          # Controllers barrel export
    ├── screens/
    │   ├── your_feature_screen.dart  # Main feature screen
    │   └── screens.dart              # Screens barrel export
    ├── widgets/
    │   ├── your_feature_widget.dart  # Feature-specific widgets
    │   └── widgets.dart              # Widgets barrel export
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
freezed: ^2.3.2                # Immutable data classes
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

3. **Configure Firebase** (if included):
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add your iOS/Android apps
   - Download and add configuration files:
     - `google-services.json` → `android/app/`
     - `GoogleService-Info.plist` → `ios/Runner/`
   - Update `lib/firebase_options.dart` with your configuration

4. **Generate code** (for models/freezed):
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run your app**:
   ```bash
   flutter run
   ```

### Adding New Features

1. **Generate the feature**:
   ```bash
   petracore feature user_profile
   ```

2. **Add to BLoC providers**:
   Update `lib/features/shared/presentation/controllers/bloc_provider.dart`:
   ```dart
   final List<SingleChildWidget> blocProviders = [
     // Add your new feature provider
     ...userProfileBlocProvider,
     // existing providers...
   ];
   ```

3. **Add navigation routes**:
   Update `lib/navigation/router.dart` with new routes.

4. **Generate code** (if using models):
   ```bash
   flutter packages pub run build_runner build
   ```

## 🎨 Customization

### Themes and Design
- Modify `lib/app/theme/` for custom themes
- Update `lib/app/app/constants/app_constants.dart` for design tokens
- Add custom fonts to `fonts/` directory

### Components
- Extend components in `lib/core/components/`
- Add new utilities in `lib/core/utils/`
- Create custom extensions in `lib/core/utils/extensions/`

### Configuration
- Environment variables in `.env`
- App-level config in `lib/app/app/constants/`
- Firebase settings in `firebase.json`

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

# Generate code and run
flutter packages pub run build_runner build
flutter run
```

### Feature Generation Examples

```bash
# Authentication feature with full architecture
petracore feature auth

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

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

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

- 📧 Email: support@petracore.com
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/petracore_flutter_frontend_starter/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/yourusername/petracore_flutter_frontend_starter/discussions)

---

**Made with ❤️ by the PetraCore Team**
