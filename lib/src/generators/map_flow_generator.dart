import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/map/map_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/generated_region_writer.dart';

class MapFlowGenerator {
  MapFlowGenerator(this.config);

  final MapConfig config;
  late final ProjectConfig projectConfig;
  late final MapTemplates templates;

  Future<void> generate() async {
    projectConfig = await ProjectConfigReader.readOrDefault(
      projectName: config.projectName,
      projectPath: config.outputPath,
    );
    templates = MapTemplates(projectConfig);

    Logger.step('Creating map directories...');
    await _createDirectories();

    Logger.step('Generating map enums...');
    await _generateEnums();

    Logger.step('Generating map parsers...');
    await _generateParsers();

    Logger.step('Generating map models...');
    await _generateModels();

    Logger.step('Generating map DTOs...');
    await _generateDtos();

    Logger.step('Generating location service...');
    await _generateService();

    Logger.step('Generating location helper...');
    await _generateHelper();

    Logger.step('Generating location repository...');
    await _generateRepository();

    Logger.step('Generating map use cases...');
    await _generateUseCases();

    Logger.step('Generating BLoCs...');
    await _generateBlocs();

    Logger.step('Generating Cubits...');
    await _generateCubits();

    Logger.step('Generating bloc listener...');
    await _generateBlocListener();

    Logger.step('Updating shared bloc provider...');
    await _updateSharedBlocProvider();

    Logger.step('Generating map screen...');
    await _generateScreen();

    Logger.step('Generating index files...');
    await _generateIndexFiles();

    Logger.step('Adding map dependencies...');
    await _updatePubspec();
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join('lib', 'features', 'map'),
      path.join('lib', 'features', 'map', 'data'),
      path.join('lib', 'features', 'map', 'data', 'enums'),
      path.join('lib', 'features', 'map', 'data', 'parsers'),
      path.join('lib', 'features', 'map', 'data', 'models'),
      path.join('lib', 'features', 'map', 'data', 'remote'),
      path.join('lib', 'features', 'map', 'data', 'remote', 'dtos'),
      path.join('lib', 'features', 'map', 'data', 'helpers'),
      path.join('lib', 'features', 'map', 'data', 'use_cases'),
      path.join('lib', 'features', 'map', 'presentation'),
      path.join('lib', 'features', 'map', 'presentation', 'screens'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'blocs'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'blocs',
          'location_bloc'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'blocs',
          'nearby_places_bloc'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'cubits'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'cubits',
          'location_cubit'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers', 'cubits',
          'nearby_places_cubit'),
      path.join('lib', 'features', 'map', 'presentation', 'controllers',
          'bloc_listeners'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateEnums() async {
    final files = {
      'lib/features/map/data/enums/business_status.dart': templates.businessStatus,
    };

    final progress = Logger.fileProgress('Map enums');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateParsers() async {
    final files = {
      'lib/features/map/data/parsers/business_status_parser.dart':
          templates.businessStatusParser,
      'lib/features/map/data/parsers/location_parser.dart':
          templates.locationParser,
    };

    final progress = Logger.fileProgress('Map parsers');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateModels() async {
    final files = {
      'lib/features/map/data/models/user_location_model.dart':
          templates.userLocationModel,
      'lib/features/map/data/models/nearby_place_model.dart':
          templates.nearbyPlaceModel,
    };

    final progress = Logger.fileProgress('Map models');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateDtos() async {
    final files = {
      'lib/features/map/data/remote/dtos/place_params.dart':
          templates.placeParams,
    };

    final progress = Logger.fileProgress('Map DTOs');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateService() async {
    final files = {
      'lib/features/map/data/remote/location_service.dart':
          templates.locationService,
    };

    final progress = Logger.fileProgress('Location service');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateHelper() async {
    final files = {
      'lib/features/map/data/helpers/location_helper.dart':
          templates.locationHelper,
    };

    final progress = Logger.fileProgress('Location helper');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateRepository() async {
    final files = {
      'lib/features/map/data/remote/location_repository.dart':
          templates.locationRepository,
    };

    final progress = Logger.fileProgress('Location repository');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateUseCases() async {
    final files = {
      'lib/features/map/data/use_cases/map_use_cases.dart':
          templates.mapUseCases,
    };

    final progress = Logger.fileProgress('Map use cases');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateBlocs() async {
    final locationFiles = {
      'lib/features/map/presentation/controllers/blocs/location_bloc/location_event.dart':
          templates.locationEvent,
      'lib/features/map/presentation/controllers/blocs/location_bloc/location_state.dart':
          templates.locationState,
      'lib/features/map/presentation/controllers/blocs/location_bloc/location_bloc.dart':
          templates.locationBloc,
    };

    final nearbyFiles = {
      'lib/features/map/presentation/controllers/blocs/nearby_places_bloc/nearby_places_event.dart':
          templates.nearbyPlacesEvent,
      'lib/features/map/presentation/controllers/blocs/nearby_places_bloc/nearby_places_state.dart':
          templates.nearbyPlacesState,
      'lib/features/map/presentation/controllers/blocs/nearby_places_bloc/nearby_places_bloc.dart':
          templates.nearbyPlacesBloc,
    };

    final progress = Logger.fileProgress('Map BLoCs');
    progress.start(locationFiles.length + nearbyFiles.length);
    for (final entry in locationFiles.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    for (final entry in nearbyFiles.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateCubits() async {
    final files = {
      'lib/features/map/presentation/controllers/cubits/location_cubit/location_cubit.dart':
          templates.locationCubit,
      'lib/features/map/presentation/controllers/cubits/nearby_places_cubit/nearby_places_cubit.dart':
          templates.nearbyPlacesCubit,
    };

    final progress = Logger.fileProgress('Map Cubits');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateBlocListener() async {
    final files = {
      'lib/features/map/presentation/controllers/bloc_listeners/location_bloc_listener.dart':
          templates.locationBlocListener,
    };

    final progress = Logger.fileProgress('Bloc listener');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.outputPath,
      'lib',
      'app',
      'shared',
      'bloc_provider.dart',
    );

    final file = File(sharedPath);
    if (!await file.exists()) {
      Logger.verbose('shared bloc_provider.dart not found, skipping');
      return;
    }

    var content = await file.readAsString();

    final importLine =
        "import 'package:${projectConfig.packageName}/features/map/presentation/controllers/map_bloc_provider.dart';";
    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    const spreadEntry = '  ...mapBlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for map');
      return;
    }

    if (await GeneratedRegionWriter.regionExists(
          filePath: sharedPath,
          regionName: 'bloc_providers',
        )) {
      final existing = await _readRegionContent(
        sharedPath, 'bloc_providers',
      );
      await GeneratedRegionWriter.replaceRegion(
        filePath: sharedPath,
        regionName: 'bloc_providers',
        newContent: '$existing\n$spreadEntry',
      );
    } else {
      content = await file.readAsString();
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    Logger.verbose(
        'Updated shared bloc_provider.dart with map provider');
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

  Future<void> _generateScreen() async {
    final files = {
      'lib/features/map/presentation/screens/map_screen.dart':
          templates.mapScreen,
    };

    final progress = Logger.fileProgress('Map screen');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateIndexFiles() async {
    final files = {
      'lib/features/map/presentation/screens/map_screens_index.dart':
          templates.mapScreensIndex,
      'lib/features/map/presentation/controllers/map_controllers_index.dart':
          templates.mapControllersIndex,
      'lib/features/map/presentation/controllers/map_bloc_provider.dart':
          templates.mapBlocProvider,
      'lib/features/map/map_index.dart': templates.mapIndex,
    };

    final progress = Logger.fileProgress('Index files');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _updatePubspec() async {
    final pubspecPath = path.join(
      config.outputPath,
      'pubspec.yaml',
    );

    final file = File(pubspecPath);
    if (!await file.exists()) {
      Logger.verbose('pubspec.yaml not found, skipping dependency update');
      return;
    }

    var content = await file.readAsString();

    final mapDeps = [
      '  google_maps_flutter: ^2.9.0',
      '  google_maps_flutter_android: ^2.14.7',
      '  google_maps_flutter_platform_interface: any',
      '  location: ^5.0.1',
      '  geocoding: ^3.0.0',
      '  url_launcher: ^6.2.1',
    ];

    for (final dep in mapDeps) {
      final depName = dep.split(':').first.trim();
      if (content.contains(depName)) {
        Logger.verbose('$depName already in pubspec.yaml, skipping');
        continue;
      }
      content = content.replaceFirst(
        'dependencies:',
        'dependencies:\n$dep',
      );
    }

    await FileUtils.writeFile(pubspecPath, content);
    Logger.verbose('Added map dependencies to pubspec.yaml');
  }
}

class MapConfig {
  final String projectName;
  final String outputPath;

  MapConfig({
    required this.projectName,
    required this.outputPath,
  });
}
