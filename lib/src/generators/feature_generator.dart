import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

import '../templates/feature_templates.dart';
import '../utils/file_utils.dart';
import '../utils/logger.dart';

class FeatureConfig {
  final String featureName;
  final String outputPath;
  final bool includeBloc;
  final bool includeRepository;
  final bool includeUseCases;
  final bool includeModels;

  FeatureConfig({
    required this.featureName,
    required this.outputPath,
    required this.includeBloc,
    required this.includeRepository,
    required this.includeUseCases,
    required this.includeModels,
  });

  String get className => ReCase(featureName).pascalCase;
  String get camelCase => ReCase(featureName).camelCase;
  String get pascalCase => ReCase(featureName).pascalCase;
}

class FeatureGenerator {
  final FeatureConfig config;
  final FeatureTemplates templates;

  FeatureGenerator(this.config) : templates = FeatureTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating feature directory structure...');
    await _createFeatureDirectories();

    Logger.step('Generating feature index...');
    await _generateFeatureIndex();

    if (config.includeModels) {
      Logger.step('Generating data models...');
      await _generateDataModels();
    }

    if (config.includeRepository) {
      Logger.step('Generating repository layer...');
      await _generateRepository();
    }

    if (config.includeUseCases) {
      Logger.step('Generating use cases...');
      await _generateUseCases();
    }

    if (config.includeBloc) {
      Logger.step('Generating BLoC/Cubit...');
      await _generateBloc();
    }

    Logger.step('Generating presentation layer...');
    await _generatePresentationLayer();

    Logger.verbose('Feature generation completed');
  }

  Future<void> _createFeatureDirectories() async {
    final dirs = [
      config.outputPath,
      path.join(config.outputPath, 'data'),
      path.join(config.outputPath, 'data', 'models'),
      path.join(config.outputPath, 'data', 'remote'),
      path.join(config.outputPath, 'data', 'remote', 'dto'),
      path.join(config.outputPath, 'data', 'use_cases'),
      path.join(config.outputPath, 'presentation'),
      path.join(config.outputPath, 'presentation', 'controllers'),
      path.join(config.outputPath, 'presentation', 'screens'),
      path.join(config.outputPath, 'presentation', 'widgets'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose('Created: ${path.relative(dir)}');
    }
  }

  Future<void> _generateFeatureIndex() async {
    final filePath =
        path.join(config.outputPath, '${config.featureName}_index.dart');
    await FileUtils.writeFile(filePath, templates.featureIndex);
    Logger.verbose('Generated: ${path.basename(filePath)}');
  }

  Future<void> _generateDataModels() async {
    final files = {
      'data/models/${config.featureName}_model.dart': templates.dataModel,
      'data/models/models.dart': templates.modelsBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateRepository() async {
    final files = {
      'data/remote/${config.featureName}_repository.dart': templates.repository,
      'data/remote/${config.featureName}_service.dart': templates.service,
      'data/remote/dto/${config.featureName}_dto.dart': templates.dto,
      'data/remote/dto/dto.dart': templates.dtoBarrel,
      'data/remote/remote.dart': templates.remoteBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateUseCases() async {
    final files = {
      'data/use_cases/get_${config.featureName}_use_case.dart':
          templates.getUseCase,
      'data/use_cases/use_cases.dart': templates.useCasesBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateBloc() async {
    final files = {
      'presentation/controllers/${config.featureName}_cubit.dart':
          templates.cubit,
      'presentation/controllers/${config.featureName}_state.dart':
          templates.state,
      'presentation/controllers/${config.featureName}_bloc_provider.dart':
          templates.blocProvider,
      'presentation/controllers/controllers.dart': templates.controllersBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generatePresentationLayer() async {
    final files = {
      'presentation/screens/${config.featureName}_screen.dart':
          templates.screen,
      'presentation/widgets/${config.featureName}_widget.dart':
          templates.widget,
      'presentation/screens/screens.dart': templates.screensBarrel,
      'presentation/widgets/widgets.dart': templates.widgetsBarrel,
      'presentation/presentation.dart': templates.presentationBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }
}
