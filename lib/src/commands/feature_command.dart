import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

import '../generators/auth_flow_generator.dart';
import '../generators/feature_generator.dart';
import '../generators/media_flow_generator.dart';
import '../generators/notification_generator.dart';
import '../generators/survey_generator.dart';
import '../templates/feature/pagination/pagination_index_template.dart';
import '../templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_event_template.dart';
import '../templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_state_template.dart';
import '../templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_bloc_template.dart';
import '../templates/feature/pagination/presentation/widgets/paginated_list_view_template.dart';
import '../templates/feature/pagination/presentation/widgets/paginated_list_builder_template.dart';
import '../utils/file_utils.dart';
import '../utils/logger.dart';
import '../utils/project_config_reader.dart';
import '../utils/validation.dart';
import 'base_command.dart';

/// Builds the [ArgParser] for the `feature` command, defining options for
/// BLoC, repository, use cases, models, list screen, entity/service/repo
/// naming, output directory, and non-interactive mode.
ArgParser featureCommandParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for feature command',
      negatable: false,
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enable verbose output',
      negatable: false,
    )
    ..addFlag(
      'bloc',
      help: 'Include BLoC/Cubit for state management',
      defaultsTo: true,
    )
    ..addFlag(
      'repository',
      help: 'Include repository pattern',
      defaultsTo: true,
    )
    ..addFlag(
      'use-cases',
      help: 'Include use cases for business logic',
      defaultsTo: true,
    )
    ..addFlag(
      'models',
      help: 'Include data models with JSON serialization',
      defaultsTo: true,
    )
    ..addFlag(
      'list',
      help: 'Include a list screen for the feature',
      defaultsTo: false,
    )
    ..addFlag(
      'no-interactive',
      help: 'Skip prompts and use feature name for data layer',
      defaultsTo: false,
      negatable: false,
    )
    ..addOption(
      'entity',
      help: 'Data entity name (snake_case). Skips interactive prompt.',
    )
    ..addOption(
      'service',
      help: 'Service file name (e.g., blog_service). Skips interactive prompt.',
    )
    ..addOption(
      'repository-name',
      help: 'Repository file name (e.g., blog_repository). Skips interactive prompt.',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Output directory (default: lib/features)',
    );
}

/// Builds the [ArgParser] for the top-level `generate` command, which
/// delegates to the `feature` subcommand via [featureCommandParser].
ArgParser generateCommandParser() {
    final parser = ArgParser()
      ..addFlag(
        'help',
        abbr: 'h',
        help: 'Show help for generate command',
        negatable: false,
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        help: 'Enable verbose output',
        negatable: false,
      );

  parser.addCommand('feature', featureCommandParser());
  return parser;
}

/// Configuration for generating a pagination feature, specifying the
/// target project name and output root directory.
class PaginationConfig {
  /// The name of the project being generated into.
  final String projectName;

  /// The absolute path to the project root where files will be created.
  final String outputPath;

  /// Creates a [PaginationConfig] with the given [projectName] and [outputPath].
  PaginationConfig({
    required this.projectName,
    required this.outputPath,
  });
}

/// Generates a reusable pagination feature inside an existing Flutter
/// project, including BLoC (event/state/bloc), a list view, and a list
/// builder widget.
class PaginationFeatureGenerator {
  /// The configuration driving this generation.
  final PaginationConfig config;

  /// Creates a [PaginationFeatureGenerator] with the given [config].
  PaginationFeatureGenerator(this.config);

  /// Generates the full pagination feature directory tree and all source files.
  Future<void> generate() async {
    await _createPaginationDirectories();
    await _generatePaginationFiles();
  }

  Future<void> _createPaginationDirectories() async {
    final dirs = [
      path.join(config.outputPath, 'lib', 'features', 'pagination'),
      path.join(config.outputPath, 'lib', 'features', 'pagination', 'presentation'),
      path.join(config.outputPath, 'lib', 'features', 'pagination', 'presentation', 'controllers'),
      path.join(config.outputPath, 'lib', 'features', 'pagination', 'presentation', 'controllers', 'pagination_bloc'),
      path.join(config.outputPath, 'lib', 'features', 'pagination', 'presentation', 'widgets'),
    ];

    for (final String dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generatePaginationFiles() async {
    final featurePath = path.join(config.outputPath, 'lib', 'features', 'pagination');

    // Generate pagination_index.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'pagination_index.dart'),
      paginationIndexTemplate(config.projectName),
    );

    // Generate pagination_event.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_event.dart'),
      paginationEventTemplate(config.projectName),
    );

    // Generate pagination_state.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_state.dart'),
      paginationStateTemplate(config.projectName),
    );

    // Generate pagination_bloc.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_bloc.dart'),
      paginationBlocTemplate(config.projectName),
    );

    // Generate paginated_list_view.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'widgets', 'paginated_list_view.dart'),
      paginatedListViewTemplate(config.projectName),
    );

    // Generate paginated_list_builder.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'widgets', 'paginated_list_builder.dart'),
      paginatedListBuilderTemplate(config.projectName),
    );
  }
}

/// Command that generates a new feature module with clean architecture.
///
/// Supports special keyword detection: generating `auth` triggers the full
/// auth flow, `media` triggers the complete media feature, and `pagination`
/// generates a reusable pagination feature.
class FeatureCommand extends BaseCommand {
  @override
  String get name => 'feature';

  @override
  String get description =>
      'Generate a new feature module with clean architecture';

  @override
  Future<void> run(ArgResults results) async {
    if (results['help'] == true) {
      _printHelp();
      return;
    }

    // Handle both 'feature <name>' and 'generate feature <name>' patterns
    String? featureName;
    ArgResults? featureResults = results;

    if (results.command?.name == 'feature') {
      // Called as 'generate feature <name>'
      featureResults = results.command!;
      featureName =
          featureResults.rest.isNotEmpty ? featureResults.rest.first : null;
    } else {
      // Called as 'feature <name>'
      featureName = results.rest.isNotEmpty ? results.rest.first : null;
    }

    if (featureName == null) {
      Logger.error('Feature name is required');
      _printHelp();
      exit(1);
    }

    if (!Validation.isValidFeatureName(featureName)) {
      Logger.error('Invalid feature name: $featureName');
      Logger.info(
          'Feature name must be lowercase with underscores (snake_case)');
      exit(1);
    }

    // 🔐 AUTH KEYWORD ANALYSIS - Check if user wants full auth flow
    if (featureName.toLowerCase() == 'auth') {
      await _handleAuthKeyword();
      return;
    }

    // 📷 MEDIA KEYWORD ANALYSIS - Check if user wants full media feature
    if (featureName.toLowerCase() == 'media') {
      await _handleMediaKeyword();
      return;
    }
    
    // 📄 PAGINATION KEYWORD ANALYSIS - Check if user wants pagination feature
    if (featureName.toLowerCase() == 'pagination') {
      await _handlePaginationKeyword();
      return;
    }

    // 🔔 NOTIFICATION KEYWORD ANALYSIS
    if (featureName.toLowerCase() == 'notification') {
      await _handleNotificationKeyword();
      return;
    }

    // 📋 SURVEY KEYWORD ANALYSIS
    if (featureName.toLowerCase() == 'survey') {
      await _handleSurveyKeyword();
      return;
    }

    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final outputDir = featureResults['output'] as String? ?? 'lib/features';
    final projectRoot = path.normalize(path.absolute(Directory.current.path));
    final featurePath = path.join(projectRoot, outputDir, featureName);

    if (Directory(featurePath).existsSync()) {
      Logger.error('Feature $featureName already exists in $featurePath');
      exit(1);
    }

    Logger.header('Generating Feature: $featureName');

    Logger.step('Reading project configuration...');
    final projectConfig = await ProjectConfigReader.readOrDefault(
      projectPath: projectRoot,
    );

    // Determine data layer config
    final noInteractive = featureResults['no-interactive'] as bool;
    final entityOpt = featureResults['entity'] as String?;
    final serviceOpt = featureResults['service'] as String?;
    final repoOpt = featureResults['repository-name'] as String?;

    final hasExplicitDataFlags = entityOpt != null || serviceOpt != null || repoOpt != null;
    final shouldPrompt = !noInteractive && !hasExplicitDataFlags;
    final dataLayerConfig = shouldPrompt
        ? _promptForDataLayer(featureName)
        : _buildDataLayerFromArgs(featureName, entityOpt, serviceOpt, repoOpt);

    final config = FeatureConfig(
      featureName: featureName,
      projectRoot: projectRoot,
      featureRoot: featurePath,
      includeBloc: featureResults['bloc'] as bool,
      includeRepository: featureResults['repository'] as bool,
      includeUseCases: featureResults['use-cases'] as bool,
      includeModels: featureResults['models'] as bool,
      includeList: featureResults['list'] as bool,
      projectConfig: projectConfig,
      dataLayerConfig: dataLayerConfig,
    );

    final generator = FeatureGenerator(config);

    try {
      await generator.generate();

      Logger.success('Feature $featureName created successfully!');

      Logger.section('Generated files');
      Logger.item('$featurePath/');
      Logger.item('${featureName}_index.dart');
      Logger.item('data/ (models, repositories, use cases)');
      Logger.item('presentation/ (screens, controllers)');

      if (dataLayerConfig != null) {
        Logger.spacer();
        Logger.info('Data layer entity: ${dataLayerConfig.entityName}');
        Logger.info('Service: ${dataLayerConfig.serviceName}.dart');
        Logger.info('Repository: ${dataLayerConfig.repositoryName}.dart');
      }

      Logger.section('Next steps');
      Logger.item('1. Add the feature to your main bloc provider');
      Logger.item('2. Update your navigation routes');
      Logger.item('3. Run: flutter packages pub run build_runner build');
    } catch (e) {
      Logger.error('Failed to generate feature: $e');
      exit(1);
    }
  }

  DataLayerConfig? _buildDataLayerFromArgs(
    String featureName,
    String? entityOpt,
    String? serviceOpt,
    String? repoOpt,
  ) {
    final entity = entityOpt ?? featureName;
    if (!Validation.isValidFeatureName(entity)) {
      Logger.error('Invalid entity name: $entity');
      Logger.info('Entity name must be lowercase with underscores (snake_case)');
      exit(1);
    }
    if (serviceOpt != null && !Validation.isValidFeatureName(serviceOpt)) {
      Logger.error('Invalid service name: $serviceOpt');
      exit(1);
    }
    if (repoOpt != null && !Validation.isValidFeatureName(repoOpt)) {
      Logger.error('Invalid repository name: $repoOpt');
      exit(1);
    }
    return DataLayerConfig(entityName: entity, serviceName: serviceOpt, repositoryName: repoOpt);
  }

  DataLayerConfig? _promptForDataLayer(String featureName) {
    Logger.section('Data Layer Configuration');
    Logger.info(
        'Define the data entity for this feature, or press Enter to use defaults.');
    Logger.spacer();

    stdout.write('Entity name (snake_case, default: $featureName): ');
    final entityInput = stdin.readLineSync()?.trim() ?? '';
    final entity = entityInput.isNotEmpty ? entityInput : featureName;

    if (!Validation.isValidFeatureName(entity)) {
      Logger.error('Invalid entity name: $entity');
      Logger.info('Entity name must be lowercase with underscores (snake_case)');
      exit(1);
    }

    final defaultService = '${entity}_service';
    stdout.write('Service name (default: $defaultService): ');
    final serviceInput = stdin.readLineSync()?.trim() ?? '';
    final serviceName = serviceInput.isNotEmpty ? serviceInput : defaultService;

    final defaultRepo = '${entity}_repository';
    stdout.write('Repository name (default: $defaultRepo): ');
    final repoInput = stdin.readLineSync()?.trim() ?? '';
    final repoName = repoInput.isNotEmpty ? repoInput : defaultRepo;

    Logger.spacer();
    Logger.info('Data layer will use:');
    Logger.item('Model: ${ReCase(entity).pascalCase} -> data/models/${entity}_model.dart');
    Logger.item('Service: ${ReCase(serviceName).pascalCase} -> data/remote/$serviceName.dart');
    Logger.item('Repository: ${ReCase(repoName).pascalCase} -> data/remote/$repoName.dart');
    Logger.item('CreateDto: Create${ReCase(entity).pascalCase}Dto');
    Logger.item('UpdateDto: Update${ReCase(entity).pascalCase}Dto');
    Logger.item('Params: ${ReCase(entity).pascalCase}Params');
    Logger.spacer();

    return DataLayerConfig(
      entityName: entity,
      serviceName: serviceName,
      repositoryName: repoName,
    );
  }

  /// Handle the 'media' keyword specially - offer full media feature
  Future<void> _handleMediaKeyword() async {
    Logger.header('Media Feature Detected!');

    Logger.info('I detected you want to generate a "media" feature.');
    Logger.info('Would you like to:');
    Logger.spacer();

    Logger.item(
        '1. Generate a basic media feature (standard feature structure)');
    Logger.item('2. Bootstrap complete media feature (recommended)');
    Logger.item('   • Cloudinary-backed upload/download/delete', indent: 6);
    Logger.item('   • Image picker integration', indent: 6);
    Logger.item('   • Media display, video player, picker widgets', indent: 6);
    Logger.item('   • Upload & Download BLoCs with progress', indent: 6);
    Logger.item('   • File size & type extensions', indent: 6);
    Logger.item('   • All required dependencies added', indent: 6);
    Logger.spacer();

    stdout.write('Choose option (1 or 2, default: 2): ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input == '1') {
      Logger.info('\nGenerating basic media feature...');
      await _generateBasicFeature('media');
    } else {
      Logger.info('\nGreat choice! Let\'s set up a complete media feature.');
      Logger.info('');
      await _generateFullMediaFeature();
    }
  }

  Future<void> _generateFullMediaFeature() async {
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final currentDir = path.normalize(path.absolute(Directory.current.path));
    final projectName = path.basename(currentDir);

    final config = MediaConfig(
      projectName: projectName,
      outputPath: currentDir,
    );

    Logger.header('Generating Complete Media Feature');
    final generator = MediaFlowGenerator(config);

    try {
      await generator.generate();

      Logger.success('Complete media feature created successfully!');
      Logger.section('Generated files');
      Logger.item('lib/features/media/');
      Logger.item('  ├── data/enums/          (MediaType, MediaActions)');
      Logger.item('  ├── data/extensions/     (type, bytes, size, list, xfile)');
      Logger.item('  ├── data/parsers/        (MediaTypeParser)');
      Logger.item('  ├── data/models/         (Attachment, AttachedMedia)');
      Logger.item('  ├── data/domain/         (upload & download use cases)');
      Logger.item('  ├── data/remote/         (repositories + Cloudinary)');
      Logger.item('  └── presentation/');
      Logger.item('      ├── entities/        (DownloadEntity)');
      Logger.item('      ├── helpers/         (MediaHelper)');
      Logger.item('      ├── widgets/         (5 media widgets)');
      Logger.item('      └── controllers/     (Upload & Download BLoCs)');

      Logger.section('Next steps');
      Logger.item('1. Add Cloudinary env vars to your build:');
      Logger.item('   --dart-define=CLOUD_NAME=your_cloud');
      Logger.item('   --dart-define=CLOUDINARY_API_KEY=your_key');
      Logger.item('   --dart-define=CLOUDINARY_SECRET_KEY=your_secret');
      Logger.item('2. Run: flutter pub get');
      Logger.item('3. Run: flutter packages pub run build_runner build');
      Logger.item('4. Use MediaHelper to pick and display media');
    } catch (e) {
      Logger.error('Failed to generate media feature: $e');
      exit(1);
    }
  }

  /// Handle the 'auth' keyword specially - offer full auth flow
  Future<void> _handleAuthKeyword() async {
    Logger.header('Auth Feature Detected!');

    Logger.info('I detected you want to generate an "auth" feature.');
    Logger.info('Would you like to:');
    Logger.spacer();

    Logger.item(
        '1. Generate a basic auth feature (standard feature structure)');
    Logger.item('2. Bootstrap complete authentication flow (recommended)');
    Logger.item('   • Login & Signup screens', indent: 6);
    Logger.item('   • BLoC state management', indent: 6);
    Logger.item('   • Repository & Use Cases', indent: 6);
    Logger.item('   • DTOs & Models', indent: 6);
    Logger.item('   • Token storage & refresh', indent: 6);
    Logger.item('   • Network service integration', indent: 6);
    Logger.item('   • Optional: Email verification, OTP, etc.', indent: 6);
    Logger.spacer();

    stdout.write('Choose option (1 or 2, default: 2): ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input == '1') {
      Logger.info('\nGenerating basic auth feature...');
      await _generateBasicAuthFeature();
    } else {
      Logger.info('\nGreat choice! Let\'s set up a complete auth flow.');
      Logger.info('');
      await _generateFullAuthFlow();
    }
  }

  /// Generate a basic auth feature using the standard feature generator
  Future<void> _generateBasicAuthFeature() async {
    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final outputDir = 'lib/features';
    final featurePath = path.join(outputDir, 'auth');

    if (Directory(featurePath).existsSync()) {
      Logger.error('Feature auth already exists in $featurePath');
      exit(1);
    }

    Logger.header('Generating Basic Auth Feature');

    // Read project configuration
    Logger.step('Reading project configuration...');
    final projectConfig = await ProjectConfigReader.readOrDefault();

    final projectRoot = path.normalize(path.absolute(Directory.current.path));
    final config = FeatureConfig(
      featureName: 'auth',
      projectRoot: projectRoot,
      featureRoot: path.join(projectRoot, featurePath),
      includeBloc: true,
      includeRepository: true,
      includeUseCases: true,
      includeModels: true,
      projectConfig: projectConfig,
    );

    final generator = FeatureGenerator(config);

    try {
      await generator.generate();

      Logger.success('Basic auth feature created successfully!');

      Logger.section('Generated files');
      Logger.item('$featurePath/');
      Logger.item('auth_index.dart');
      Logger.item('data/ (models, repositories, use cases)');
      Logger.item('presentation/ (screens, controllers)');

      Logger.section('Next steps');
      Logger.item('1. Add the feature to your main bloc provider');
      Logger.item('2. Update your navigation routes');
      Logger.item('3. Run: flutter packages pub run build_runner build');

      Logger.section('Pro tip');
      Logger.info('Run "petracore auth" for a complete auth flow with');
      Logger.info('login/signup screens, token management, and more!');
    } catch (e) {
      Logger.error('Failed to generate basic auth feature: $e');
      exit(1);
    }
  }

    /// Handle the 'pagination' keyword specially - offer pagination feature
    Future<void> _handlePaginationKeyword() async {
      if (!File('pubspec.yaml').existsSync()) {
        Logger.error('Not in a Flutter project directory');
        Logger.info('Run this command from the root of your Flutter project');
        exit(1);
      }

      final currentDir = path.normalize(path.absolute(Directory.current.path));
      final projectName = path.basename(currentDir);

      final config = PaginationConfig(
        projectName: projectName,
        outputPath: currentDir,
      );

      Logger.header('Generating Pagination Feature');
      final generator = PaginationFeatureGenerator(config);

      try {
        await generator.generate();

        Logger.success('Pagination feature created successfully!');
        Logger.section('Generated files');
        Logger.item('lib/features/pagination/');
        Logger.item('  ├── pagination_index.dart');
        Logger.item('  └── presentation/');
        Logger.item('      ├── controllers/');
        Logger.item('      │   └── pagination_bloc/');
        Logger.item('      │       ├── pagination_bloc.dart');
        Logger.item('      │       ├── pagination_event.dart');
        Logger.item('      │       └── pagination_state.dart');
        Logger.item('      └── widgets/');
        Logger.item('          ├── paginated_list_builder.dart');
        Logger.item('          └── paginated_list_view.dart');

        Logger.section('Next steps');
        Logger.item('1. Run: flutter pub get');
        Logger.item('2. Run: flutter packages pub run build_runner build');
        Logger.item('3. Use PaginatedListBuilder in your features that need pagination');
      } catch (e) {
        Logger.error('Failed to generate pagination feature: $e');
        exit(1);
      }
    }

    /// Handle the 'notification' keyword
    Future<void> _handleNotificationKeyword() async {
      if (!File('pubspec.yaml').existsSync()) {
        Logger.error('Not in a Flutter project directory');
        Logger.info('Run this command from the root of your Flutter project');
        exit(1);
      }

      final currentDir = path.normalize(path.absolute(Directory.current.path));
      final projectConfig = await ProjectConfigReader.readOrDefault(projectPath: currentDir);

      final config = FeatureConfig(
        featureName: 'notification',
        projectRoot: currentDir,
        featureRoot: path.join(currentDir, 'lib/features/notification'),
        projectConfig: projectConfig,
      );

      Logger.header('Generating Notification Feature');
      final generator = NotificationGenerator(config);

      try {
        await generator.generate();
        Logger.success('Notification feature created successfully!');
        Logger.section('Generated files');
        Logger.item('lib/features/notification/');
        Logger.item('  ├── notification_index.dart');
        Logger.item('  └── presentation/');
        Logger.item('      ├── controllers/');
        Logger.item('      │   └── cubits/notification_cubit/');
        Logger.item('      ├── entities/');
        Logger.item('      └── widgets/');
        Logger.section('Next steps');
        Logger.item('1. Run: flutter pub get');
        Logger.item('2. Import notification_index.dart in your app');
        Logger.item('3. Use NotificationBadge and NotificationList widgets');
      } catch (e) {
        Logger.error('Failed to generate notification feature: $e');
        exit(1);
      }
    }

    /// Handle the 'survey' keyword
    Future<void> _handleSurveyKeyword() async {
      if (!File('pubspec.yaml').existsSync()) {
        Logger.error('Not in a Flutter project directory');
        Logger.info('Run this command from the root of your Flutter project');
        exit(1);
      }

      final currentDir = path.normalize(path.absolute(Directory.current.path));
      final projectConfig = await ProjectConfigReader.readOrDefault(projectPath: currentDir);

      final config = FeatureConfig(
        featureName: 'survey',
        projectRoot: currentDir,
        featureRoot: path.join(currentDir, 'lib/features/survey'),
        projectConfig: projectConfig,
      );

      Logger.header('Generating Survey Feature');
      final generator = SurveyGenerator(config);

      try {
        await generator.generate();
        Logger.success('Survey feature created successfully!');
        Logger.section('Generated files');
        Logger.item('lib/features/survey/');
        Logger.item('  ├── survey_index.dart');
        Logger.item('  └── presentation/');
        Logger.item('      ├── controllers/');
        Logger.item('      │   └── cubits/survey_mode_cubit/');
        Logger.item('      ├── entities/');
        Logger.item('      ├── enums/');
        Logger.item('      └── widgets/');
        Logger.section('Next steps');
        Logger.item('1. Run: flutter pub get');
        Logger.item('2. Import survey_index.dart in your app');
        Logger.item('3. Use SurveyBuilder widget for quizzes and forms');
      } catch (e) {
        Logger.error('Failed to generate survey feature: $e');
        exit(1);
      }
    }

    /// Generate a basic feature for a given feature name
    Future<void> _generateBasicFeature(String featureName) async {
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final outputDir = 'lib/features';
    final featurePath = path.join(outputDir, featureName);

    if (Directory(featurePath).existsSync()) {
      Logger.error('Feature $featureName already exists in $featurePath');
      exit(1);
    }

    Logger.header('Generating Basic $featureName Feature');

    Logger.step('Reading project configuration...');
    final projectConfig = await ProjectConfigReader.readOrDefault();

    final projectRoot = path.normalize(path.absolute(Directory.current.path));
    final config = FeatureConfig(
      featureName: featureName,
      projectRoot: projectRoot,
      featureRoot: path.join(projectRoot, featurePath),
      includeBloc: true,
      includeRepository: true,
      includeUseCases: true,
      includeModels: true,
      projectConfig: projectConfig,
    );

    final generator = FeatureGenerator(config);

    try {
      await generator.generate();

      Logger.success('Basic $featureName feature created successfully!');

      Logger.section('Generated files');
      Logger.item('$featurePath/');
      Logger.item('${featureName}_index.dart');
      Logger.item('data/ (models, repositories, use cases)');
      Logger.item('presentation/ (screens, controllers)');

      Logger.section('Next steps');
      Logger.item('1. Add the feature to your main bloc provider');
      Logger.item('2. Update your navigation routes');
      Logger.item('3. Run: flutter packages pub run build_runner build');
    } catch (e) {
      Logger.error('Failed to generate basic $featureName feature: $e');
      exit(1);
    }
  }

  /// Generate the full authentication flow
  Future<void> _generateFullAuthFlow() async {
    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final currentDir = path.normalize(path.absolute(Directory.current.path));

    // Check if auth feature already exists
    final authPath = path.join(currentDir, 'lib', 'features', 'auth');
    if (Directory(authPath).existsSync()) {
      Logger.warning('Auth feature already exists in $authPath');
      stdout.write('Do you want to overwrite it? (y/N): ');
      final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
      if (input != 'y' && input != 'yes') {
        Logger.info('Operation cancelled');
        exit(0);
      }
    }

    // Use the interactive config from AuthFlowGenerator
    final config = await AuthFlowGenerator.createInteractiveConfig(currentDir);

    Logger.header('Generating Complete Auth Flow');
    _logSelectedFeatures(config);

    final generator = AuthFlowGenerator(config);

    try {
      await generator.generate();

      Logger.success('Complete authentication flow created successfully!');
      _printAuthFlowPostInstructions(config);
    } catch (e) {
      Logger.error('Failed to generate auth flow: $e');
      exit(1);
    }
  }

  void _logSelectedFeatures(AuthFlowConfig config) {
    Logger.section('Selected features');
    if (config.includeLogin) Logger.item('Login');
    if (config.includeSignup) Logger.item('Signup');
    if (config.includeForgotPassword) Logger.item('Forgot Password');
    if (config.includeOtp) Logger.item('OTP functionality');
    if (config.includeSocialAuth) Logger.item('Social Auth placeholders');
    if (config.includeDeviceToken) Logger.item('Device Token support');
    Logger.spacer();
  }

  void _printAuthFlowPostInstructions(AuthFlowConfig config) {
    Logger.info('');
    Logger.info('📁 Generated complete auth flow:');
    Logger.info('  lib/features/auth/');
    Logger.info('  ├── data/');
    Logger.info('  │   ├── models/          (User model)');
    Logger.info('  │   ├── remote/          (Repository, Service, DTOs)');
    Logger.info('  │   ├── use_case/        (Auth use cases)');
    Logger.info('  │   └── enums/           (Auth enums)');
    Logger.info('  └── presentation/');
    Logger.info('      ├── controllers/     (AuthBloc)');
    Logger.info('      ├── screens/         (Login/Signup screens)');
    Logger.info('      └── helpers/         (Controllers)');
    Logger.info('');

    Logger.info('🔧 Required dependencies:');
    Logger.info('  Add these to pubspec.yaml:');
    Logger.info('  dependencies:');
    Logger.info('    flutter_bloc: ^8.1.3');
    Logger.info('    dartz: ^0.10.1');
    Logger.info('    dio: ^5.3.0');
    Logger.info('    flutter_secure_storage: ^9.0.0');
    Logger.info('    json_annotation: ^4.8.1');
    Logger.info('');
    Logger.info('  dev_dependencies:');
    Logger.info('    build_runner: ^2.4.6');
    Logger.info('    json_serializable: ^6.7.1');
    Logger.info('');
    Logger.info('🚀 Next steps:');
    Logger.info('  1. Run: flutter pub get');
    Logger.info('  2. Run: flutter packages pub run build_runner build');
    Logger.info('  3. Add AuthBloc to your main BlocProvider');
    Logger.info('  4. Add auth routes to your navigation');
    Logger.info('  5. Configure API base URL in environment variables');
    Logger.info('');
    Logger.info('🎉 Your authentication system is ready to use!');
  }

  void _printHelp() {
    print('''
Generate a new feature module with clean architecture

Usage: 
  petracore feature <feature_name> [options]
  petracore generate feature <feature_name> [options]

Options:
  --bloc              Include BLoC/Cubit for state management (default: true)
  --repository        Include repository pattern (default: true)
  --use-cases         Include use cases for business logic (default: true)
  --models            Include data models with JSON serialization (default: true)
  --list              Include a list screen for the feature (default: false)
  --no-interactive    Skip interactive prompts for data layer naming
  --entity <name>     Data entity name in snake_case (skips prompt)
  --service <name>    Service file name (skips prompt)
  --repository-name <name> Repository file name (skips prompt)
  --output, -o <dir>  Output directory (default: lib/features)
  --help, -h          Show this help

Data Layer Naming:
  By default, you will be prompted to customize the data layer:
  - Entity name determines the model, DTOs, and Params classes
  - Service and repository file names can be set independently

  Use --no-interactive or explicit --entity/--service/--repository flags
  to skip prompts and use the feature name as the entity name.

Examples:
  petracore feature auth                       # Detects auth and offers full flow
  petracore feature user_profile --no-bloc
  petracore generate feature chat --output lib/modules
  petracore feature profile --entity user --service auth_service
  petracore feature blog --no-interactive      # Uses "blog" for everything

Special Keywords:
  auth    - Offers to generate complete authentication flow
''');
  }
}
