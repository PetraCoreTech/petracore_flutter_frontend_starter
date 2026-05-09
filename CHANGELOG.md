# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-09-03

### Added
- 🎉 Initial release of PetraCore Flutter Frontend Starter
- 🏗️ Project initialization command (`petracore init`)
- 🚀 Feature generation command (`petracore feature`)
- 🔥 Firebase integration support (Firestore, Analytics, Cloud Messaging)
- 🧩 BLoC pattern implementation with Hydrated BLoC
- 📱 Responsive design with ScreenUtil
- 🎨 Comprehensive UI component library
- 🔐 Secure storage and environment variable support
- 🛣️ Declarative navigation with GoRouter
- 📦 Clean Architecture implementation
- 🧪 Testing infrastructure setup
- 📝 Comprehensive linting rules
- 🔧 VS Code configuration
- 📚 Detailed documentation and examples

### Features
- **Project Generation**: Complete Flutter project with clean architecture
- **Feature Generation**: Modular feature creation with data/presentation layers
- **Firebase Setup**: Pre-configured Firebase integration
- **State Management**: BLoC/Cubit with state persistence
- **UI Components**: Reusable buttons, inputs, scaffolds, loading states
- **Network Layer**: Dio HTTP client with logging and error handling
- **Code Generation**: Freezed models and JSON serialization
- **Extensions**: Useful string, context, and utility extensions
- **Validation**: Input validation and form handling patterns

### Supported Platforms
- ✅ iOS
- ✅ Android  
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

### Dependencies
- flutter_bloc ^8.1.3
- hydrated_bloc ^9.1.5
- go_router ^10.0.0
- flutter_screenutil ^5.4.0
- dio ^5.3.3
- firebase_core ^3.12.1
- cloud_firestore ^5.6.5
- And many more carefully selected packages

## [1.0.1] - 2024-09-16

### Added
- 🎨 **AppBarV1 Component**: Comprehensive app bar component with theming support
  - Full integration with design tokens and theme system
  - Multiple variants: `AppBarV1`, `AppBarV1Transparent`, `AppBarV1Secondary`
  - Customizable properties: title, actions, colors, elevation, center title
  - PreferredSizeWidget implementation for proper sizing
- 📑 **TabBarV1 Component**: Feature-rich tab bar component with theming
  - Multiple variants: `TabBarV1`, `TabBarV1Scrollable`, `TabBarV1Minimal`
  - Comprehensive customization: colors, text styles, indicators, padding
  - Built-in hover and pressed state handling
  - Scrollable support with proper physics
- 🏗️ **App Bars Directory**: Added `app_bars/` folder structure to project generation
- 🔧 **Project Generator Updates**: Updated to include app bar components in generated projects
- 📱 **Sample Integration**: Updated sample home screen to demonstrate AppBarV1 usage
- 🎨 **Design System Integration**: All components fully integrated with the app's design tokens

### Improved
- Enhanced project structure with proper app bar component organization
- Better component documentation and usage examples
- More consistent theming across all generated components

## [1.0.3] - 2024-09-22

### Fixed
- **Build Runner Execution**: Fixed duplicate build_runner commands during auth flow generation
  - Resolved command execution format issues in FeatureGenerator and AuthFlowGenerator
  - Commands now properly split into command and arguments arrays
  - Eliminated redundant build_runner calls when generating auth features
- **Template Syntax Errors**: Fixed syntax error in verify_dto template
  - Corrected `Json Map<String, dynamic>toJson()` to `Map<String, dynamic> toJson()`
  - Resolved build_runner compilation errors in auth flow generation

### Improved
- **Logging System**: Complete overhaul of CLI logging for better readability and spacing
  - Removed emoji-heavy logging in favor of clean, professional symbols
  - Added proper visual hierarchy with box drawing characters and bullets
  - Implemented consistent spacing and indentation throughout
  - Added new logging methods: `spacer()`, `section()`, `item()`, `keyValue()`
  - Replaced `mason_logger` dependency with lightweight custom implementation
  - Enhanced header formatting with bordered boxes
  - Improved step indicators with arrow symbols (→)
  - Added success checkmarks (✓), warning symbols (⚠), and error marks (✗)
- **Code Generation Logic**: Enhanced conditional DTO generation in AuthFlowGenerator
  - `request_otp_dto.dart` now properly generates when `--otp` flag is enabled
  - Improved feature flag handling for auth flow components
  - Better separation of concerns between FeatureGenerator and AuthFlowGenerator

### Enhanced
- **Test Suite**: Expanded test coverage for auth flow generation
  - Added comprehensive auth flow testing with both basic and complete options
  - Enhanced test script with better command-line options and validation
  - Added separate tests for OTP functionality and email verification
  - Improved error reporting and test result validation
- **CLI Output Formatting**: Significantly improved user experience
  - Consistent formatting across all commands (init, feature, auth)
  - Better structured success messages and next steps
  - Enhanced selected features display with bullet points
  - Improved file generation progress reporting
  - Professional, clean appearance without visual clutter

### Technical Improvements
- **Command Architecture**: Refined command execution patterns
  - Better error handling in CommandUtils.runCommand
  - Improved working directory management
  - Enhanced verbose logging for debugging
- **Project Configuration**: Better project detection and configuration reading
  - Improved ProjectConfigReader with fallback mechanisms
  - Enhanced directory structure validation
- **Code Quality**: Removed deprecated dependencies and cleaned up imports
  - Eliminated unused mason_logger dependency
  - Streamlined logging implementation
  - Better separation of concerns in generator classes

## [1.0.4] - 2026-05-09

### Added
- 🎨 **Material 3 Theme Support**: Full Material Design 3 theme support alongside existing Mix theme
  - `--theme material` flag for project initialization
  - Structured theme files: `theme.dart` barrels `material_theme.dart`
  - Theme type auto-detection in `ProjectConfigReader`
- 📱 **Material Auth Screens**: 11 material variant auth screen/widget templates
  - Login, Signup, Splash, Welcome, Get Started, Verify OTP
  - Forgot Password, Forgot Password Verify, Reset Password
  - Resend Code Display, Resend Code Text
  - Uses `Theme.of(context)` (no Mix `$token` / `colors.*` references)
  - `AuthTemplates` class with theme-aware `_isMaterial` branching
- 🔌 **Material Core Components**: Material variants for 6 core components
  - IconFrame, PasswordField, SearchInputField, LoadingIndicator
  - PasswordStrengthChecker, InfoDisplay
- 🔄 **Automatic BLoC Provider Registration**: Features auto-register their BLoC providers
  - `_updateSharedBlocProvider()` in both `FeatureGenerator` and `AuthFlowGenerator`
  - Appends feature BLoC provider import + spread entry to shared `bloc_provider.dart`
- 🛣️ **Automatic Route Registration**: Auth screens auto-register in router
  - `_updateRouterWithAuthRoutes()` inserts GoRoute entries into `router.dart`
  - `_updateAppRoutes()` inserts route name constants into `routes.dart` `AppRoutes` class
  - Conditional routes matching enabled auth feature flags
  - Idempotent regex-based replacement for re-runs

### Fixed
- 🗑️ **Removed Redundant Models Barrel**: Eliminated duplicate `data/models/models.dart` generation
  - Removed `models_barrel_template.dart` and `models_template.dart`
  - Feature index (`feature_name_index.dart`) already exports models directly
  - Dead code cleanup from `template_index.dart` and generators
- 🐛 **Ambiguous Extension Members**: Fixed duplicate `capitalize()` and `stringOrNull()` methods
  - Removed `StringExt` from `context_extensions_template.dart`
  - Eliminated all `ambiguous_extension_member_access` errors
- 🎯 **Template Syntax Fixes**: Various template corrections
  - Added `AppConstants` import to `material_theme_template.dart`
  - Fixed `progressBarTheme` → `progressIndicatorTheme`
  - Added `List<BlocProvider>` type annotation to `auth_bloc_provider_template.dart`
  - Conditional `package:mix/mix.dart` exclusion in `core_barrel_template.dart` for material theme
  - `dart fix --apply` at end of `AuthFlowGenerator.generate()`
- 📖 **Updated Documentation**: README.md and CHANGELOG.md updated for all improvements

### Changed
- ♻️ **Refactored Generators**: Both `FeatureGenerator` and `AuthFlowGenerator` now read actual project config instead of hardcoded defaults
- 🧹 **Code Organization**: Cleaner separation between feature-level and project-level concerns

## [Unreleased]

### Planned
- 📱 Additional UI components (date pickers, modals, etc.)
- 🔧 Custom theme generator
- 🧪 Enhanced testing templates
- 🚀 CI/CD workflow templates
- 📱 Platform-specific optimizations
- 🎨 Design system generator
- 🔌 Plugin integration templates
- 📊 Analytics dashboard template
- 🔐 Advanced authentication patterns
- 🌐 Internationalization setup
