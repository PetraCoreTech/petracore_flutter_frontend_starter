import '../../generators/project_generator.dart';

String readmeTemplate(ProjectConfig config) => '''
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

### Installation

1. Clone this repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

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
