import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import '../generators/feature_generator.dart';
import '../utils/command_utils.dart';
import '../utils/file_utils.dart';
import '../utils/generated_region_writer.dart';
import '../utils/logger.dart';
import '../utils/post_generation_options.dart';
import '../utils/project_config_reader.dart';
import '../utils/validation.dart';
import '../templates/feature_templates.dart';
import 'base_command.dart';

ArgParser serviceCommandParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for service command',
      negatable: false,
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enable verbose output',
      negatable: false,
    );
}

class ServiceCommand extends BaseCommand {
  bool autoRunPostGeneration = true;

  @override
  String get name => 'service';

  @override
  String get description =>
      'Bootstrap a new service within an existing feature';

  Future<void> runPostGenerationSteps(PostGenerationOptions options) async {
    if (!autoRunPostGeneration) return;
    final projectRoot = path.normalize(path.absolute(Directory.current.path));

    if (options.runPubGet) {
      if (options.dryRun) {
        Logger.info('[dry-run] Would run: flutter pub get');
      } else {
        Logger.step('Running flutter pub get...');
        await CommandUtils.runFlutterCommand(
          ['pub', 'get'],
          workingDirectory: projectRoot,
          showOutput: true,
          throwOnError: false,
        );
      }
    }

    if (options.runDartFix) {
      if (options.dryRun) {
        Logger.info('[dry-run] Would run: dart fix --apply');
      } else {
        Logger.step('Running dart fix --apply...');
        await CommandUtils.runDartCommand(
          ['fix', '--apply'],
          workingDirectory: projectRoot,
          showOutput: true,
          throwOnError: false,
        );
      }
    }
  }

  @override
  Future<void> run(ArgResults results) async {
    if (results['help'] == true) {
      _printHelp();
      return;
    }

    final serviceName =
        results.rest.isNotEmpty ? results.rest.first : null;
    if (serviceName == null) {
      Logger.error('Service name is required');
      _printHelp();
      exit(1);
    }

    if (!Validation.isValidFeatureName(serviceName)) {
      Logger.error('Invalid service name: $serviceName');
      Logger.info(
          'Service name must be lowercase with underscores (snake_case)');
      exit(1);
    }

    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final projectRoot = path.normalize(path.absolute(Directory.current.path));

    Logger.section('Feature Selection');
    Logger.info(
        'Enter the existing feature where this service will be added.');
    stdout.write('Feature name: ');
    final featureName = stdin.readLineSync()?.trim() ?? '';
    if (featureName.isEmpty) {
      Logger.error('Feature name is required');
      exit(1);
    }
    if (!Validation.isValidFeatureName(featureName)) {
      Logger.error('Invalid feature name: $featureName');
      exit(1);
    }

    final featurePath = path.join(projectRoot, 'lib/features', featureName);
    if (!Directory(featurePath).existsSync()) {
      Logger.error('Feature "$featureName" does not exist at $featurePath');
      exit(1);
    }

    Logger.header('Bootstrapping Service: $serviceName in "$featureName"');

    Logger.step('Reading project configuration...');
    final projectConfig =
        await ProjectConfigReader.readOrDefault(projectPath: projectRoot);

    Logger.section('Model');
    stdout.write('Create a model for this service? (y/N): ');
    final createModel = _yesNo(false);
    String entityName = serviceName;
    if (createModel) {
      stdout.write('Model name (snake_case, default: $serviceName): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      entityName = input.isNotEmpty ? input : serviceName;
      if (!Validation.isValidFeatureName(entityName)) {
        Logger.error('Invalid model name: $entityName');
        exit(1);
      }
    }

    Logger.section('Repository');
    stdout.write('Create a repository for this service? (Y/n): ');
    final createRepository = _yesNo(true);
    String? repositoryName;
    if (createRepository) {
      final defaultRepo = '${serviceName}_repository';
      stdout.write('Repository name (default: $defaultRepo): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      repositoryName = input.isNotEmpty ? input : defaultRepo;
      if (!Validation.isValidFeatureName(repositoryName)) {
        Logger.error('Invalid repository name: $repositoryName');
        exit(1);
      }
    }

    Logger.section('Use Cases');
    stdout.write('Create use cases for this service? (Y/n): ');
    final createUseCases = _yesNo(true);
    String? useCasesFileName;
    String? useCasesName;
    if (createUseCases) {
      final defaultUc = '${serviceName}_use_cases';
      stdout.write('Use cases file name (default: $defaultUc): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      useCasesName = input.isNotEmpty ? input : defaultUc;
      if (!Validation.isValidFeatureName(useCasesName)) {
        Logger.error('Invalid use cases name: $useCasesName');
        exit(1);
      }
      useCasesFileName = '$useCasesName.dart';
    }

    Logger.section('BLoC / Cubit');
    stdout.write('Create BLoC/Cubit for this service? (Y/n): ');
    final createBlocs = _yesNo(true);
    String? blocsName;
    if (createBlocs) {
      final defaultBloc = entityName;
      stdout.write('BLoC prefix name (default: $defaultBloc): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      blocsName = input.isNotEmpty ? input : defaultBloc;
      if (!Validation.isValidFeatureName(blocsName)) {
        Logger.error('Invalid BLoC name: $blocsName');
        exit(1);
      }
    }

    final config = FeatureConfig(
      featureName: featureName,
      projectRoot: projectRoot,
      featureRoot: featurePath,
      projectConfig: projectConfig,
      includeBloc: createBlocs,
      includeRepository: createRepository,
      includeUseCases: createUseCases,
      includeModels: createModel,
      includeList: false,
      dataLayerConfig: DataLayerConfig(
        entityName: entityName,
        serviceName: '${serviceName}_service',
        repositoryName: repositoryName,
      ),
    );

    final templates = FeatureTemplates(config);

    try {
      Logger.step('Generating service...');
      await FileUtils.writeFile(
        path.join(
            featurePath, 'data/remote/${config.serviceName}.dart'),
        templates.service,
      );

      if (createRepository) {
        Logger.step('Generating repository...');
        await FileUtils.writeFile(
          path.join(featurePath,
              'data/remote/${config.repositoryName}.dart'),
          templates.repository,
        );
      }

      if (createModel) {
        Logger.step('Generating model and DTOs...');
        await FileUtils.writeFile(
          path.join(featurePath,
              'data/models/${config.entityName}_model.dart'),
          templates.dataModel,
        );
        await FileUtils.writeFile(
          path.join(
              featurePath, 'data/remote/dto/create_${config.entityName}_dto.dart'),
          templates.createDto,
        );
        await FileUtils.writeFile(
          path.join(
              featurePath, 'data/remote/dto/update_${config.entityName}_dto.dart'),
          templates.updateDto,
        );
        await FileUtils.writeFile(
          path.join(featurePath,
              'data/remote/dto/${config.entityName}_params.dart'),
          templates.params,
        );
      }

      if (createUseCases) {
        Logger.step('Generating use cases...');
        await FileUtils.writeFile(
          path.join(featurePath, 'data/domain', useCasesFileName!),
          templates.useCases,
        );
      }

      if (createBlocs) {
        Logger.step('Generating BLoC/Cubit...');
        await _generateBlocFiles(
            featurePath, config, templates, blocsName!);
      }

      Logger.step('Updating feature index...');
      await _updateFeatureIndex(
        featurePath,
        featureName,
        config,
        createModel,
        createRepository,
        createUseCases,
        useCasesFileName,
        createBlocs,
        blocsName,
      );

      if (createBlocs) {
        Logger.step('Updating presentation barrel...');
        await _updatePresentationBarrel(
            featurePath, blocsName!);
      }

      if (createBlocs) {
        Logger.step('Updating shared BlocProvider...');
        await _updateSharedBlocProvider(config, blocsName!);
      }

      Logger.success(
          'Service "$serviceName" bootstrapped successfully in feature "$featureName"!');

      Logger.section('Generated files');
      Logger.item(
          'lib/features/$featureName/data/remote/${config.serviceName}.dart');
      if (createRepository) {
        Logger.item(
            'lib/features/$featureName/data/remote/${config.repositoryName}.dart');
      }
      if (createModel) {
        Logger.item(
            'lib/features/$featureName/data/models/${config.entityName}_model.dart');
      }
      if (createUseCases) {
        Logger.item(
            'lib/features/$featureName/data/domain/$useCasesFileName');
      }
      if (createBlocs) {
        Logger.item(
            'lib/features/$featureName/presentation/controllers/ (blocs, cubit, provider)');
      }

      await runPostGenerationSteps(
        const PostGenerationOptions(runDartFix: true),
      );
    } catch (e) {
      Logger.error('Failed to bootstrap service: $e');
      exit(1);
    }
  }

  bool _yesNo(bool defaultValue) {
    final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
    if (input.isEmpty) return defaultValue;
    return input == 'y' || input == 'yes';
  }

  Future<void> _generateBlocFiles(
    String featurePath,
    FeatureConfig config,
    FeatureTemplates templates,
    String blocsName,
  ) async {
    String fixParts(String content) {
      return content
          .replaceAll(
            "part '${config.featureName}_action_event.dart';",
            "part '${blocsName}_action_event.dart';",
          )
          .replaceAll(
            "part '${config.featureName}_action_state.dart';",
            "part '${blocsName}_action_state.dart';",
          )
          .replaceAll(
            "part 'multiple_${config.featureName}_event.dart';",
            "part 'multiple_${blocsName}_event.dart';",
          )
          .replaceAll(
            "part 'multiple_${config.featureName}_state.dart';",
            "part 'multiple_${blocsName}_state.dart';",
          );
    }

    String fixPartOf(String content) {
      return content
          .replaceAll(
            "part of '${config.featureName}_action_bloc.dart';",
            "part of '${blocsName}_action_bloc.dart';",
          )
          .replaceAll(
            "part of 'multiple_${config.featureName}_bloc.dart';",
            "part of 'multiple_${blocsName}_bloc.dart';",
          );
    }

    final blocFiles = <String, String>{
      'presentation/controllers/cubits/${blocsName}_cubit.dart':
          fixPartOf(templates.cubit),
      'presentation/controllers/blocs/multiple_${blocsName}_bloc/multiple_${blocsName}_bloc.dart':
          fixParts(fixPartOf(templates.dataBloc)),
      'presentation/controllers/blocs/multiple_${blocsName}_bloc/multiple_${blocsName}_event.dart':
          fixPartOf(templates.dataBlocEvent),
      'presentation/controllers/blocs/multiple_${blocsName}_bloc/multiple_${blocsName}_state.dart':
          fixPartOf(templates.dataBlocState),
      'presentation/controllers/blocs/${blocsName}_action_bloc/${blocsName}_action_bloc.dart':
          fixParts(templates.actionBloc),
      'presentation/controllers/blocs/${blocsName}_action_bloc/${blocsName}_action_event.dart':
          fixPartOf(templates.actionBlocEvent),
      'presentation/controllers/blocs/${blocsName}_action_bloc/${blocsName}_action_state.dart':
          fixPartOf(templates.actionBlocState),
    };

    final blocProviderContent =
        _generateBlocProviderContent(config, blocsName);
    final controllerIndexContent =
        _generateControllerIndexContent(blocsName);

    final progress = Logger.fileProgress('BLoC');
    progress.start(blocFiles.length + 2);
    for (final entry in blocFiles.entries) {
      await FileUtils.writeFile(
          path.join(featurePath, entry.key), entry.value);
      progress.tick();
    }
    await FileUtils.writeFile(
      path.join(featurePath,
          'presentation/controllers/${blocsName}_bloc_provider.dart'),
      blocProviderContent,
    );
    progress.tick();
    await FileUtils.writeFile(
      path.join(featurePath,
          'presentation/controllers/${blocsName}_controller_index.dart'),
      controllerIndexContent,
    );
    progress.tick();
    progress.done();
  }

  String _generateBlocProviderContent(
      FeatureConfig config, String blocsName) {
    final pascal = config.pascalEntity;
    final camel = config.camelEntity;
    return '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/${blocsName}_controller_index.dart';

final List<BlocProvider> ${camel}BlocProvider = [
  BlocProvider<${pascal}ActionBloc>(create: (context) => ${camel}ActionBloc),
  BlocProvider<Multiple${pascal}Bloc>(create: (context) => multiple${pascal}Bloc),
  BlocProvider<${pascal}Cubit>(create: (context) => ${camel}Cubit),
];
''';
  }

  String _generateControllerIndexContent(String blocsName) {
    return '''
export 'cubits/${blocsName}_cubit.dart';
export 'blocs/${blocsName}_action_bloc/${blocsName}_action_bloc.dart';
export 'blocs/multiple_${blocsName}_bloc/multiple_${blocsName}_bloc.dart';
export '${blocsName}_bloc_provider.dart';
''';
  }

  Future<void> _updateFeatureIndex(
    String featurePath,
    String featureName,
    FeatureConfig config,
    bool createModel,
    bool createRepository,
    bool createUseCases,
    String? useCasesFileName,
    bool createBlocs,
    String? blocsName,
  ) async {
    final indexPath = path.join(featurePath, '${featureName}_index.dart');
    final indexFile = File(indexPath);
    if (!await indexFile.exists()) {
      Logger.verbose('Feature index not found, creating');
      await FileUtils.writeFile(indexPath, '');
    }

    var content = await indexFile.readAsString();
    final lines = content.split('\n');
    final existingExports =
        lines.map((l) => l.trim()).where((l) => l.startsWith("export '")).toSet();

    final newExports = <String>[];
    if (createModel) {
      newExports
          .add("export 'data/models/${config.entityName}_model.dart';");
      newExports.add(
          "export 'data/remote/dto/create_${config.entityName}_dto.dart';");
      newExports.add(
          "export 'data/remote/dto/update_${config.entityName}_dto.dart';");
      newExports.add(
          "export 'data/remote/dto/${config.entityName}_params.dart';");
    }
    newExports.add(
        "export 'data/remote/${config.serviceName}.dart';");
    if (createRepository) {
      newExports.add(
          "export 'data/remote/${config.repositoryName}.dart';");
    }
    if (createUseCases && useCasesFileName != null) {
      newExports.add("export 'data/domain/$useCasesFileName';");
    }

    final exportsToAdd =
        newExports.where((e) => !existingExports.contains(e)).toList();

    if (exportsToAdd.isEmpty) return;

    final lastDataExportIndex = _findLastDataExportOr(lines, [
      "export 'presentation/",
    ]);
    if (lastDataExportIndex >= 0) {
      lines.insertAll(lastDataExportIndex, exportsToAdd);
    } else {
      lines.addAll(exportsToAdd);
    }

    await FileUtils.writeFile(indexPath, lines.join('\n'));
    Logger.verbose(
        'Updated feature index with ${exportsToAdd.length} new exports');
  }

  int _findLastDataExportOr(
      List<String> lines, List<String> markers) {
    for (int i = 0; i < lines.length; i++) {
      for (final marker in markers) {
        if (lines[i].trim().contains(marker)) return i;
      }
    }
    return -1;
  }

  Future<void> _updatePresentationBarrel(
    String featurePath,
    String blocsName,
  ) async {
    final barrelPath =
        path.join(featurePath, 'presentation', 'presentation.dart');
    final barrelFile = File(barrelPath);
    if (!await barrelFile.exists()) {
      await FileUtils.writeFile(
          barrelPath,
          "export 'controllers/${blocsName}_controller_index.dart';\n");
      return;
    }

    var content = await barrelFile.readAsString();
    final exportLine =
        "export 'controllers/${blocsName}_controller_index.dart';";
    if (content.contains(exportLine)) return;

    content = content.trimRight();
    if (content.endsWith(';')) {
      content = '$content\n$exportLine\n';
    } else {
      content = '$content\n$exportLine\n';
    }
    await FileUtils.writeFile(barrelPath, content);
  }

  Future<void> _updateSharedBlocProvider(
    FeatureConfig config, String blocsName) async {
    final sharedPath = path.join(
      config.projectConfig.projectPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );

    final file = File(sharedPath);
    if (!await file.exists()) {
      Logger.verbose('Shared bloc_provider.dart not found, skipping update');
      return;
    }

    final camel = config.camelEntity;
    final importLine =
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/${blocsName}_bloc_provider.dart';";

    var content = await file.readAsString();

    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    final spreadEntry = '  ...${camel}BlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for $blocsName');
      return;
    }

    if (await GeneratedRegionWriter.regionExists(
          filePath: sharedPath,
          regionName: 'bloc_providers',
        )) {
      final regionContent =
          await _readRegionContent(sharedPath, 'bloc_providers');
      final updated = '$regionContent\n$spreadEntry';
      await GeneratedRegionWriter.replaceRegion(
        filePath: sharedPath,
        regionName: 'bloc_providers',
        newContent: updated.trim(),
      );
    } else {
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    Logger.verbose(
        'Updated shared bloc_provider.dart with $blocsName provider');
  }

  Future<String> _readRegionContent(
      String filePath, String regionName) async {
    final file = File(filePath);
    final content = await file.readAsString();
    final startMarker = '// petracore:start:$regionName';
    final endMarker = '// petracore:end:$regionName';
    final startIndex =
        content.indexOf(startMarker) + startMarker.length;
    final endIndex = content.indexOf(endMarker);
    return content.substring(startIndex, endIndex).trim();
  }

  void _printHelp() {
    print('''
Bootstrap a new service within an existing feature.

Usage: petracore service <service_name> [options]

The command interactively guides you through bootstrapping:
  - Service file (always created)
  - Model, DTOs, and Params (optional)
  - Repository (optional)
  - Use Cases (optional)
  - BLoC / Cubit (optional)

Options:
  --help, -h  Show this help

Examples:
  petracore service payment
  petracore service notification
''');
  }
}
