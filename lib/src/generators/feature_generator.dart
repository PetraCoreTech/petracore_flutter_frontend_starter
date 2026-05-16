import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/generated_region_writer.dart';
import 'package:recase/recase.dart';

class DataLayerConfig {
  final String entityName;
  final String serviceName;
  final String repositoryName;

  DataLayerConfig({
    required this.entityName,
    String? serviceName,
    String? repositoryName,
  })  : serviceName = serviceName ?? '${entityName}_service',
        repositoryName = repositoryName ?? '${entityName}_repository';

  String get pascalEntity => ReCase(entityName).pascalCase;
  String get camelEntity => ReCase(entityName).camelCase;
  String get snakeEntity => ReCase(entityName).snakeCase;
}

class FeatureConfig {
  final String featureName;
  final String projectRoot;
  final String featureRoot;
  final bool includeBloc;
  final bool includeRepository;
  final bool includeUseCases;
  final bool includeModels;
  final bool includeList;
  final ProjectConfig projectConfig;
  final DataLayerConfig? dataLayerConfig;

  FeatureConfig({
    required this.featureName,
    required this.projectRoot,
    required this.featureRoot,
    required this.projectConfig,
    this.includeBloc = true,
    this.includeRepository = true,
    this.includeUseCases = true,
    this.includeModels = true,
    this.includeList = false,
    this.dataLayerConfig,
  }) : assert(
          featureRoot.startsWith(projectRoot),
          'featureRoot must be inside projectRoot',
        );

  String get className => ReCase(featureName).pascalCase;
  String get camelCase => ReCase(featureName).camelCase;
  String get pascalCase => ReCase(featureName).pascalCase;

  /// The import path relative to project root, e.g. "features/profile" or "modules/profile"
  String get importRoot {
    final relativePath = path.relative(featureRoot, from: path.join(projectRoot, 'lib'));
    return relativePath;
  }

  String get entityName => dataLayerConfig?.entityName ?? featureName;
  String get pascalEntity => dataLayerConfig?.pascalEntity ?? pascalCase;
  String get camelEntity => dataLayerConfig?.camelEntity ?? camelCase;
  String get serviceName => dataLayerConfig?.serviceName ?? '${featureName}_service';
  String get repositoryName => dataLayerConfig?.repositoryName ?? '${featureName}_repository';
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
      await _updateSharedBlocProvider();
    }

    Logger.step('Registering route...');
    await _updateRouterWithFeatureRoutes();

    Logger.step('Generating presentation layer...');
    await _generatePresentationLayer();

    if (config.includeModels) {
      Logger.step('Generating data models...');
      await _generateDataModels();
    }

    Logger.verbose(
        'Feature generation completed. Run `dart run build_runner build` to generate code.');
  }

  Future<void> _createFeatureDirectories() async {
    final dirs = [
      config.featureRoot,
      path.join(config.featureRoot, 'data'),
      path.join(config.featureRoot, 'data', 'models'),
      path.join(config.featureRoot, 'data', 'remote'),
      path.join(config.featureRoot, 'data', 'remote', 'dto'),
      path.join(config.featureRoot, 'data', 'domain'),
      path.join(config.featureRoot, 'presentation'),
      path.join(config.featureRoot, 'presentation', 'controllers'),
      path.join(config.featureRoot, 'presentation', 'screens'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose('Created: ${path.relative(dir)}');
    }
  }

  Future<void> _generateFeatureIndex() async {
    final filePath =
        path.join(config.featureRoot, '${config.featureName}_index.dart');
    final progress = Logger.fileProgress('Feature index');
    progress.start(1);
    await FileUtils.writeFile(filePath, templates.featureIndex);
    progress.tick();
    progress.done();
  }

  Future<void> _generateDataModels() async {
    final files = {
      'data/models/${config.entityName}_model.dart': templates.dataModel,
    };

    final progress = Logger.fileProgress('Data models');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateRepository() async {
    final files = {
      'data/remote/${config.serviceName}.dart': templates.service,
      'data/remote/${config.repositoryName}.dart': templates.repository,
      'data/remote/dto/create_${config.entityName}_dto.dart':
          templates.createDto,
      'data/remote/dto/update_${config.entityName}_dto.dart':
          templates.updateDto,
      'data/remote/dto/${config.entityName}_params.dart': templates.params,
    };

    final progress = Logger.fileProgress('Repository');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateUseCases() async {
    final files = {
      'data/domain/${config.featureName}_use_cases.dart': templates.useCases,
    };

    final progress = Logger.fileProgress('Use cases');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
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

    final progress = Logger.fileProgress('BLoC');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generatePresentationLayer() async {
    final files = {
      'presentation/screens/${config.featureName}_screen.dart':
          templates.screen,
      if (config.includeList)
        'presentation/screens/${config.featureName}_list_screen.dart':
            templates.listScreen,
      'presentation/screens/${config.featureName}_screens_index.dart':
          templates.screensBarrel,
      'presentation/presentation.dart': templates.presentationBarrel,
    };

    final progress = Logger.fileProgress('Presentation');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.projectConfig.projectPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );

    final file = File(sharedPath);
    if (!await file.exists()) {
      Logger.verbose('Shared bloc_provider.dart not found, skipping update');
      return;
    }

    final importLine =
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/${config.featureName}_bloc_provider.dart';";

    var content = await file.readAsString();

    if (content.contains(importLine)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has import for ${config.featureName}');
    } else {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    final spreadEntry = '  ...${config.camelEntity}BlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for ${config.featureName}');
      return;
    }

    final existingRegion =
        await GeneratedRegionWriter.regionExists(
      filePath: sharedPath,
      regionName: 'bloc_providers',
    );

    if (existingRegion) {
      final regionContent = await _readRegionContent(
        sharedPath, 'bloc_providers',
      );
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
        'Updated shared bloc_provider.dart with ${config.featureName} provider');
  }

  Future<String> _readRegionContent(String filePath, String regionName) async {
    final file = File(filePath);
    final content = await file.readAsString();
    final startMarker = '// petracore:start:$regionName';
    final endMarker = '// petracore:end:$regionName';
    final startIndex = content.indexOf(startMarker) + startMarker.length;
    final endIndex = content.indexOf(endMarker);
    return content.substring(startIndex, endIndex).trim();
  }

  Future<void> _updateRouterWithFeatureRoutes() async {
    final projectRoot = config.projectConfig.projectPath;
    final routesDir = path.join(projectRoot, 'lib/navigation/routes');
    await Directory(routesDir).create(recursive: true);

    final featureRoutesContent = StringBuffer();
    featureRoutesContent.writeln(
        "import 'package:${config.projectConfig.packageName}/core/core.dart';");
    featureRoutesContent.writeln(
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/${config.featureName}_index.dart';");
    featureRoutesContent.writeln();
    featureRoutesContent.writeln(
        'final ${config.featureName}Routes = <GoRoute>[');
    featureRoutesContent.writeln('  GoRoute(');
    featureRoutesContent.writeln(
        '    path: AppRoutes.${config.featureName}.path,');
    featureRoutesContent.writeln(
        '    name: AppRoutes.${config.featureName}.name,');
    featureRoutesContent.writeln(
        '    builder: (context, state) => const ${config.pascalCase}Screen(),');
    featureRoutesContent.writeln('  ),');
    featureRoutesContent.writeln('];');

    final featureRoutesPath =
        path.join(routesDir, '${config.featureName}_routes.dart');
    await FileUtils.writeFile(
        featureRoutesPath, featureRoutesContent.toString());
    Logger.verbose(
        'Created lib/navigation/routes/${config.featureName}_routes.dart');

    final routesPath = path.join(projectRoot, 'lib/navigation/routes.dart');
    final routesFile = File(routesPath);
    if (await routesFile.exists()) {
      final constant =
          "  static const ${config.featureName} = AppRoute(path: '/${config.featureName}', name: '${config.featureName}');";
      final routesContent = await routesFile.readAsString();
      if (!routesContent.contains("static const ${config.featureName} =")) {
        if (await GeneratedRegionWriter.regionExists(
              filePath: routesPath,
              regionName: 'route_constants',
            )) {
          final regionContent = await _readRegionContent(
            routesPath, 'route_constants',
          );
          await GeneratedRegionWriter.replaceRegion(
            filePath: routesPath,
            regionName: 'route_constants',
            newContent: '$regionContent\n$constant',
          );
        } else {
          var updated = routesContent.replaceFirst(
            '  // petracore:start:route_constants',
            '  // petracore:start:route_constants\n$constant',
          );
          await FileUtils.writeFile(routesPath, updated);
        }
      }
      Logger.verbose('Updated routes.dart with ${config.featureName} constant');
    }

    final routerPath = path.join(projectRoot, 'lib/navigation/router.dart');
    final routerFile = File(routerPath);
    if (await routerFile.exists()) {
      var routerContent = await routerFile.readAsString();

      final importLine =
          "import 'package:${config.projectConfig.packageName}/navigation/routes/${config.featureName}_routes.dart';";
      if (!routerContent.contains(importLine)) {
        routerContent = routerContent.replaceFirst(
          "import 'package:${config.projectConfig.packageName}/core/core.dart';",
          "import 'package:${config.projectConfig.packageName}/core/core.dart';\n$importLine",
        );
        await FileUtils.writeFile(routerPath, routerContent);
      }

      final spreadEntry = '    ...${config.featureName}Routes,';
      if (!routerContent.contains(spreadEntry)) {
        if (await GeneratedRegionWriter.regionExists(
              filePath: routerPath,
              regionName: 'feature_routes',
            )) {
          final regionContent = await _readRegionContent(
            routerPath, 'feature_routes',
          );
          await GeneratedRegionWriter.replaceRegion(
            filePath: routerPath,
            regionName: 'feature_routes',
            newContent: '$regionContent\n$spreadEntry',
          );
        } else {
          routerContent = await File(routerPath).readAsString();
          routerContent = routerContent.replaceFirst(
            '    // petracore:start:feature_routes',
            '    // petracore:start:feature_routes\n$spreadEntry',
          );
          await FileUtils.writeFile(routerPath, routerContent);
        }
      }
      Logger.verbose('Updated router.dart with ${config.featureName} routes');
    }
  }
}
