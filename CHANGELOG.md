# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-06-15

### Added
- 💬 **Complete Chat Feature**: `petracore feature chat` generates full chat with real-time Firestore messaging, Cloudinary CDN upload for file sharing, call screens (voice/video), group chat, and `AttachmentSheet` (gallery, camera, video, document, audio)
- 📁 **`flutter_slidable` Integration**: Chat tiles now support swipe-to-delete via `Slidable`
- 📂 **`file_picker` + `open_filex`**: File picking with `AttachmentSheet` and tap-to-open file preview in chat bubbles
- ☁️ **Cloudinary Upload in ComposeMessage**: Picked files are uploaded to Cloudinary before sending; upload progress indicator shown
- 📞 **Call Screens**: Voice and video call screens with calling mode toggle, participant cards, and call log
- 👥 **Group Chat**: Create group screen, group info screen, and group member tile
- 🔧 **`_updatePubspec()` in ChatFlowGenerator**: New dependencies (`flutter_slidable`, `file_picker`, `open_filex`, `image_picker`, `cloud_firestore`) are automatically injected into the generated project's `pubspec.yaml`
- ⚡ **`runPubGet` After Chat Generation**: `flutter pub get` now runs automatically after chat feature generation (was missing, broke generated projects)

### Changed
- 🗑️ **`MediaType` Enum Removed**: Replaced with `String? mimeType` across chat (`Message`, `CreateMessageDto`) and media (`FileUploadDto`, `AttachedMedia`, `Attachment`) features — eliminates type conflicts and aligns with standard MIME type conventions
- ♻️ **`FileUploadDto.fileType` → `mimeType`**: Media feature's Cloudinary DTO now uses `String? mimeType` instead of `MediaType` enum
- ♻️ **`media_type_extension_template.dart` Rewritten**: Now provides `FileExtensionToMime` (file ext → MIME string) and `MimeTypeChecks` (`.isVideo`, `.isImage`, `.isAudio`) extensions instead of `MediaType`-based extensions
- ♻️ **`media_type_parser_template.dart`**: Replaced `MediaTypeParser` with `MimeTypeConverter` (identity converter)
- ♻️ **`upload_action_bloc_template.dart`**: Uses `mimeType` instead of `fileType`/`mediaType`
- ♻️ **Media index exports cleaned**: Removed `media_type.dart` export (empty file no longer generated)

### Fixed
- 🐛 **`Set<dynamic>` Type Error**: Fixed in `create_group_screen_template.dart` — explicit `<String>` cast on `_selectedUsers.map`
- 🐛 **Stray `'''` in `chat_flow_generator.dart`**: Removed dangling triple-quote that broke compilation
- ✂️ **Missing `image_picker` Import**: Added `import 'package:image_picker/image_picker.dart'` to `compose_message_template.dart`
- 📐 **`int` → `double` Cast**: `file.length()` returns `int` but `FileUploadDto.size` expects `double` — fixed with `.toDouble()`
- 🔗 **`response.url` Null Safety**: `CloudinaryResponse.url` is nullable — added `?? throw Exception(...)` 
- 🔄 **`runPubGet` Missing in Chat Handler**: `_handleChatKeyword` now passes `runPubGet: true` to `runPostGenerationSteps`, matching media/map/notification handlers

## [1.0.9+1] - 2026-06-13

### Changed
- ♻️ **Design Preset Simplification**: Removed the entire local `DesignPresetId` enum, `DesignPreset`/`DesignPresetColors`/`DesignPresetTypography`/`DesignPresetRadius` classes, `DesignPresetRegistry`, and all 12 individual preset files
- ♻️ **`ProjectConfig.designPreset`**: Now a plain `String` instead of `DesignPresetId`. The `resolvedDesignPreset` getter and all `DesignPresetRegistry` imports removed
- ♻️ **`init_command.dart`**: `_parseDesignPreset` validates against a hardcoded string list; `_promptForDesignPreset` uses inline `(name, displayName, description)` tuples instead of `DesignPresetRegistry`
- ♻️ **`bootstrap_template.dart`**: Accepts `String presetName`; maps `"default"` → `"baseline"` for `AppUiKitPreset`, other names pass through directly
- ♻️ **`project_config_reader.dart`**: `_detectDesignPreset` returns `String` directly from `petracore.config.json`
- ♻️ **`app_constants_template.dart`**: Font family hardcoded to `'Plus Jakarta Sans'` (removed `resolvedDesignPreset` dependency)
- ♻️ **Preset storage in `petracore.config.json`**: Stores the preset name string directly (no `.name` call needed)

### Removed
- 🗑️ **Entire `lib/src/design_presets/` directory**: 14 files deleted (enum, 4 classes, registry, 12 preset definitions)
- 🗑️ **Design preset exports** from `petracore_flutter_frontend_starter.dart`

## [1.0.9] - 2026-06-11

### Added
- 🏗️ **`--include-auth` Init Flag**: `petracore init` now accepts `--include-auth` to generate the full auth feature alongside the project in one step. Prompts interactively if not specified. Replaces the need for a separate `petracore auth` run
- 🎨 **`--design-preset` Init Flag**: Replaces the old `--theme` flag. Choose from `default`, `vercel`, `airbnb`, or `apple` design presets (all backed by `app_ui_kit`)
- 🧩 **`app_ui_kit` Theming**: All theme and component generation removed locally — everything comes from the `app_ui_kit: ^0.0.1` package (`AppScaffold`, `AppUiKit.themes`, etc.)

### Fixed
- 🐛 **AnimatedSplashLogo Widget**: `AnimatedSplashLogo` is now correctly written to disk when splash screen is included (was previously never wired into generation)
- 🔁 **Route Constant Duplication**: `_updateAppRoutes()` in `auth_flow_generator.dart` now parses existing region content and skips constants that already exist — safe to rerun
- 📁 **Auth Generation Path Bug**: `AuthFlowGenerator.generate()` sets `Directory.current = config.outputPath` so relative paths resolve correctly when called from `init`
- 🐍 **Escaped Quotes in Templates**: Fixed `Didn\'t` → `Didn\\'t` in `verify_otp_screen_template.dart` and `forgot_password_verify_screen_template.dart` so generated files contain valid Dart
- 🧱 **`ScaffoldV1` → `AppScaffold`**: All templates now use `AppScaffold` from `app_ui_kit` (replaces the non-existent `ScaffoldV1`)
- 🔍 **OTP Test Grep**: `test_local.sh` now greps for `static const verifyOtp` instead of `static const otp`

### Changed
- ♻️ **Screen Template Consolidation**: Moved 9 material screen templates from subdirectories to a flat `screens/` directory. Functions renamed to drop `material_` prefix. Old non-material (mix) templates deleted. Empty material subdirectories removed
- ♻️ **Theme Generation Removed**: Deleted `material_theme_template.dart`, `material_theme_barrel_template.dart`, theme directories, and all theme file generation. All theming delegated to `app_ui_kit`
- 🗑️ **Dead Template Files Removed**: Deleted unused `app_entry_screen_template.dart` and `dashboard_screen_template.dart` (non-material versions, never referenced) and their stale exports
- 📋 **test_local.sh Updated**: Added `--include-auth` to init test, SplashScreen checks, auth file/route checks, corrected config preset to `"designPreset": "apple"` and `"themeType": "material"`

---

## [1.0.7] - 2026-05-10

### Added
- 📄 **Pagination Feature Generation**: Pagination feature is now auto-generated during `petracore init`
  - 6 files generated: `pagination_index.dart`, `pagination_bloc.dart`, `pagination_event.dart`, `pagination_state.dart`, `paginated_list_builder.dart`, `paginated_list_view.dart`
  - Uses `UseCase` abstraction from core layer for data fetching
  - `PaginationBloc` with `FetchPaginatedResult` event and `PaginationResultLoaded`/`PaginationError` states
  - `PaginatedListBuilder` widget for easy integration with any feature
  - `PaginatedListView` scroll-detecting widget with auto-load at bottom
- 📖 **Guide Document**: `agent-docs/pagination_feature_generator_guide.md` created documenting the pagination feature architecture

### Fixed
- 📧 **Email Controller Re-enabled**: `EmailController` is now generated when `includeForgotPassword` is true (was previously only generated for the removed get-started screen) — fixes missing `EmailController` in forgot password screens
- 🐛 **Route Model Conflict**: Renamed `Route` → `AppRoute` to eliminate compilation errors in generated projects caused by naming collision with `package:flutter/widgets.dart`

---

## [1.0.6] - 2026-05-10

### Added
- 🏠 **Main App Feature**: `main_app` feature with `DashboardScreen` is now auto-generated during `petracore init`
  - `AppRoutes.dashboard` route constant pre-defined in `routes_template.dart`
  - GoRouter entry for `DashboardScreen` pre-wired in `router_template.dart`
  - `mainAppBlocProvider` pre-registered in shared `bloc_provider.dart`
  - Feature barrel, presentation barrel, and controller index all auto-generated
  - Dashboard directory structure created in `_createAdditionalDirectories()`
- 🔗 **Login-to-Signup Navigation**: Login screen includes "Don't have an account? Sign up" link navigating via `context.goNamed(AppRoutes.signup.name)`
- 🔗 **Signup-to-Login Navigation**: Signup screen includes "Already have an account? Log in" link navigating via `context.goNamed(AppRoutes.login.name)`
- 📖 **Guide Document**: `agent-docs/MAIN_APP_FEATURE_SETUP.md` created documenting the main_app feature architecture

### Changed
- 🗺️ **Splash Screen Navigation**: Logged-out users now navigate to `AppRoutes.login` instead of the old get-started path
- 🗺️ **Welcome Screen Navigation**: "Get Started" button now navigates to `AppRoutes.login` instead of `AppRoutes.getStarted`
- 🏷️ **Route Model Renamed**: `Route` class renamed to `AppRoute` to avoid conflict with Flutter's built-in `Route` class — all references updated in `routes_template.dart`, `auth_flow_generator.dart`, and `feature_generator.dart`
- ❌ **Get Started Screen Disabled**: `includeGetStartedScreen` defaults to `false`. Interactive prompt removed. All generator references (screens, controllers, routes, constants) cleaned up
- ♻️ **`projectBlocProviderTemplate`**: Now accepts `ProjectConfig` parameter to support package name interpolation in imports

### Fixed
- 📧 **Email Controller Re-enabled**: `EmailController` is now generated when `includeForgotPassword` is true (was previously only generated for the removed get-started screen) — fixes missing `EmailController` in forgot password screens
- 🐛 **Route Model Conflict**: Renamed `Route` → `AppRoute` to eliminate compilation errors in generated projects caused by naming collision with `package:flutter/widgets.dart`

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

## [1.0.5] - 2026-05-10

### Added
- 🎨 **Interactive Theme Selection**: `petracore init` now prompts users to choose between Mix and Material themes when `--theme` is not explicitly passed
  - `--no-interactive` flag added for CI/scripting use
- 📷 **Media Feature (`petracore feature media`)**: Full Cloudinary-backed media feature auto-detected on the "media" keyword (like auth)
  - 36 template files: enums, extensions, parsers, models, DTOs, Cloudinary service, 3 repositories, 5 use cases, 5 widgets, 2 BLoCs (Upload + Download), helpers
  - Interactive prompt: basic or complete media setup
  - Dependencies auto-added: `image_picker`, `cloudinary_sdk`, `cloudinary`, `file_saver`, `share_plus`, `webview_flutter`
  - BLoC provider auto-registered in shared `bloc_provider.dart`
- 🛣️ **Layered Navigation Architecture**: Routes now follow a 5-layer pattern
  - Route constants use the `Route(path:, name:)` data class from `route_model.dart`
  - Per-feature route list files in `lib/navigation/routes/*_routes.dart`
  - Incremental marker-based insertion (no more destructive regex replacement)
- 🚀 **Feature Route Registration**: `FeatureGenerator` now registers routes — creates route list file, adds `Route` constant to `routes.dart`, and updates `router.dart`

### Fixed
- 🐛 **NDK Version**: Updated from `27.3.13750724` to `27.0.12077973` (latest fully installed). Regex also updated from `ndkVersion\s*=\s*"[^"]*"` to `ndkVersion\s*=\s*\S+` to correctly match `ndkVersion = flutter.ndkVersion` format
- 🗺️ **Auth Route Addition**: Replaced destructive regex replacement of entire `routes: [...]` block with incremental insertion before marker comment — preserves existing routes from other generators or manual edits
- 🗺️ **Auth Route Constants**: Replaced destructive `AppRoutes` class body replacement with incremental `Route` constant addition

### Changed
- ♻️ **`routes_template.dart`**: Now uses `Route(path:, name:)` data class with `AppRoutes._()` private constructor and marker comment for additions
- ♻️ **`router_template.dart`**: Now references `AppRoutes.splash.path` / `AppRoutes.splash.name` constants with marker comment for additions
- 📖 **Updated Documentation**: README.md and CHANGELOG.md updated for all v1.0.5 improvements

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
