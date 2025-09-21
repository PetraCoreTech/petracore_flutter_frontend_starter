import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/command_utils.dart';
import 'package:recase/recase.dart';

class FeatureConfig {
  final String featureName;
  final String outputPath;
  final bool includeBloc;
  final bool includeRepository;
  final bool includeUseCases;
  final bool includeModels;
  final ProjectConfig projectConfig;

  FeatureConfig({
    required this.featureName,
    required this.outputPath,
    required this.projectConfig,
    this.includeBloc = true,
    this.includeRepository = true,
    this.includeUseCases = true,
    this.includeModels = true,
  });

  String get className => ReCase(featureName).pascalCase;
  String get camelCase => ReCase(featureName).camelCase;
  String get pascalCase => ReCase(featureName).pascalCase;
}

class FeatureGenerator {
  FeatureGenerator(this.config) : templates = FeatureTemplates(config);
  final FeatureConfig config;

  final FeatureTemplates templates;

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

    if (config.includeModels) {
      await CommandUtils.runCommand(
        'dart',
        ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        workingDirectory: config.projectConfig.projectPath,
      );
    }

    await CommandUtils.runCommand(
      'dart',
      ['fix', '--apply'],
      workingDirectory: config.projectConfig.projectPath,
    );

    Logger.verbose('Feature generation completed');
  }

  Future<void> _createFeatureDirectories() async {
    final dirs = [
      config.outputPath,
      path.join(config.outputPath, 'data'),
      path.join(config.outputPath, 'data', 'models'),
      path.join(config.outputPath, 'data', 'remote'),
      path.join(config.outputPath, 'data', 'remote', 'dto'),
      path.join(config.outputPath, 'data', 'domain'),
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
      'data/remote/${config.featureName}_service.dart': templates.service,
      'data/remote/${config.featureName}_repository.dart': templates.repository,
      'data/remote/dto/create_${config.featureName}_dto.dart':
          templates.createDto,
      'data/remote/dto/update_${config.featureName}_dto.dart':
          templates.updateDto,
      'data/remote/dto/${config.featureName}_params.dart': templates.params,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateUseCases() async {
    final files = {
      'data/domain/${config.featureName}_use_cases.dart': templates.useCases,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateBloc() async {
    final files = {
      'presentation/controllers/cubits/${config.featureName}_cubit.dart':
          templates.cubit,
      'presentation/controllers/blocs/multiple_${config.featureName}_bloc/multiple_${config.featureName}_bloc.dart':
          templates.dataBloc,
      'presentation/controllers/blocs/multiple_${config.featureName}_bloc/multiple_${config.featureName}_event.dart':
          templates.dataBlocEvent,
      'presentation/controllers/blocs/multiple_${config.featureName}_bloc/multiple_${config.featureName}_state.dart':
          templates.dataBlocState,
      'presentation/controllers/blocs/${config.featureName}_action_bloc/${config.featureName}_action_bloc.dart':
          templates.actionBloc,
      'presentation/controllers/blocs/${config.featureName}_action_bloc/${config.featureName}_action_event.dart':
          templates.actionBlocEvent,
      'presentation/controllers/blocs/${config.featureName}_action_bloc/${config.featureName}_action_state.dart':
          templates.actionBlocState,
      'presentation/controllers/${config.featureName}_bloc_provider.dart':
          templates.blocProvider,
      'presentation/controllers/${config.featureName}_controller_index.dart':
          templates.controllersBarrel,
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
      'presentation/screens/${config.featureName}_screens_index.dart':
          templates.screensBarrel,
      'presentation/presentation.dart': templates.presentationBarrel,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.outputPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }
}
