import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/media/media_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/generated_region_writer.dart';

/// Generates a complete media feature within a PetraCore Flutter project,
/// including Cloudinary-backed upload/download, image picker integration,
/// media display widgets, upload/download BLoCs with progress, file
/// size/type extensions, and all required dependencies.
class MediaFlowGenerator {
  /// Creates a [MediaFlowGenerator] with the given [config].
  MediaFlowGenerator(this.config);

  /// The configuration driving media feature generation.
  final MediaConfig config;

  /// The resolved project config, initialized during [generate].
  late final ProjectConfig projectConfig;

  /// The templates instance used to render media source files.
  late final MediaTemplates templates;

  /// Executes the full media feature generation pipeline.
  ///
  /// Creates directory structure, generates enums, extensions, parsers,
  /// models, DTOs, params, Cloudinary service, repositories, use cases,
  /// presentation entities, BLoCs, widgets, helpers, index files, and
  /// updates the shared BlocProvider and pubspec dependencies.
  Future<void> generate() async {
    projectConfig = await ProjectConfigReader.readOrDefault(
      projectName: config.projectName,
      projectPath: config.outputPath,
    );
    templates = MediaTemplates(projectConfig);

    Logger.step('Creating media directories...');
    await _createDirectories();

    Logger.step('Generating media enums...');
    await _generateEnums();

    Logger.step('Generating media extensions...');
    await _generateExtensions();

    Logger.step('Generating media parsers...');
    await _generateParsers();

    Logger.step('Generating media models...');
    await _generateModels();

    Logger.step('Generating media DTOs...');
    await _generateDtos();

    Logger.step('Generating media params...');
    await _generateParams();

    Logger.step('Generating Cloudinary service...');
    await _generateCloudinaryService();

    Logger.step('Generating repositories...');
    await _generateRepositories();

    Logger.step('Generating use cases...');
    await _generateUseCases();

    Logger.step('Generating presentation entities...');
    await _generateEntities();

    Logger.step('Generating BLoCs...');
    await _generateBlocs();
    await _updateSharedBlocProvider();

    Logger.step('Generating widgets...');
    await _generateWidgets();

    Logger.step('Generating media helper...');
    await _generateHelper();

    Logger.step('Generating index files...');
    await _generateIndexFiles();

    Logger.step('Adding media dependencies...');
    await _updatePubspec();

    Logger.verbose('Media flow generation completed.');
    Logger.info('Run `flutter pub get` then `dart run build_runner build` to finish setup.');
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join('lib', 'features', 'media'),
      path.join('lib', 'features', 'media', 'data'),
      path.join('lib', 'features', 'media', 'data', 'enums'),
      path.join('lib', 'features', 'media', 'data', 'extensions'),
      path.join('lib', 'features', 'media', 'data', 'parsers'),
      path.join('lib', 'features', 'media', 'data', 'models'),
      path.join('lib', 'features', 'media', 'data', 'domain'),
      path.join('lib', 'features', 'media', 'data', 'remote'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'cloudinary',
          'dtos'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'upload',
          'params'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'download',
          'dtos'),
      path.join('lib', 'features', 'media', 'presentation'),
      path.join('lib', 'features', 'media', 'presentation', 'controllers'),
      path.join('lib', 'features', 'media', 'presentation', 'entities'),
      path.join('lib', 'features', 'media', 'presentation', 'helpers'),
      path.join('lib', 'features', 'media', 'presentation', 'widgets'),
      path.join('lib', 'features', 'media', 'presentation', 'controllers',
          'blocs', 'upload_action_bloc'),
      path.join('lib', 'features', 'media', 'presentation', 'controllers',
          'blocs', 'download_action_bloc'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateEnums() async {
    final progress = Logger.fileProgress('Media enums');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/data/enums/media_actions.dart',
      templates.mediaActions,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateExtensions() async {
    final files = {
      'lib/features/media/data/extensions/media_type_extension.dart':
          templates.mediaTypeExtension,
      'lib/features/media/data/extensions/media_bytes_extension.dart':
          templates.mediaBytesExtension,
      'lib/features/media/data/extensions/media_size_extension.dart':
          templates.mediaSizeExtension,
      'lib/features/media/data/extensions/media_list_extension.dart':
          templates.mediaListExtension,
      'lib/features/media/data/extensions/xfile_extension.dart':
          templates.xfileExtension,
    };

    final progress = Logger.fileProgress('Media extensions');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateParsers() async {
    final progress = Logger.fileProgress('Media parsers');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/data/parsers/media_type_parser.dart',
      templates.mediaTypeParser,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateModels() async {
    final files = {
      'lib/features/media/data/models/attachment_model.dart':
          templates.attachmentModel,
      'lib/features/media/data/models/attached_media_model.dart':
          templates.attachedMediaModel,
      'lib/features/media/data/models/uint8_list_converter.dart':
          templates.uint8ListConverter,
    };

    final progress = Logger.fileProgress('Media models');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateDtos() async {
    final files = {
      'lib/features/media/data/remote/cloudinary/dtos/file_upload_dto.dart':
          templates.fileUploadDto,
      'lib/features/media/data/remote/cloudinary/dtos/delete_upload_dto.dart':
          templates.deleteUploadDto,
      'lib/features/media/data/remote/download/dtos/download_dto.dart':
          templates.downloadDto,
    };

    final progress = Logger.fileProgress('Media DTOs');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateParams() async {
    final progress = Logger.fileProgress('Media params');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/data/remote/upload/params/upload_params.dart',
      templates.uploadParams,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateCloudinaryService() async {
    final progress = Logger.fileProgress('Cloudinary service');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/data/remote/cloudinary/cloudinary_service.dart',
      templates.cloudinaryService,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateRepositories() async {
    final files = {
      'lib/features/media/data/remote/media_repository.dart':
          templates.mediaRepository,
      'lib/features/media/data/remote/upload/upload_repository.dart':
          templates.uploadRepository,
      'lib/features/media/data/remote/download/download_repository.dart':
          templates.downloadRepository,
    };

    final progress = Logger.fileProgress('Media repositories');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateUseCases() async {
    final files = {
      'lib/features/media/data/domain/upload_use_cases.dart':
          templates.uploadUseCases,
      'lib/features/media/data/domain/download_use_cases.dart':
          templates.downloadUseCases,
    };

    final progress = Logger.fileProgress('Media use cases');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateEntities() async {
    final progress = Logger.fileProgress('Media entities');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/presentation/entities/download_entity.dart',
      templates.downloadEntity,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateBlocs() async {
    final files = {
      'lib/features/media/presentation/controllers/blocs/upload_action_bloc/upload_action_bloc.dart':
          templates.uploadActionBloc,
      'lib/features/media/presentation/controllers/blocs/upload_action_bloc/upload_action_event.dart':
          templates.uploadActionEvent,
      'lib/features/media/presentation/controllers/blocs/upload_action_bloc/upload_action_state.dart':
          templates.uploadActionState,
      'lib/features/media/presentation/controllers/blocs/download_action_bloc/download_action_bloc.dart':
          templates.downloadActionBloc,
      'lib/features/media/presentation/controllers/blocs/download_action_bloc/download_action_event.dart':
          templates.downloadActionEvent,
      'lib/features/media/presentation/controllers/blocs/download_action_bloc/download_action_state.dart':
          templates.downloadActionState,
      'lib/features/media/presentation/controllers/media_controller_index.dart':
          templates.mediaControllerIndex,
      'lib/features/media/presentation/controllers/media_bloc_provider.dart':
          templates.mediaBlocProvider,
    };

    final progress = Logger.fileProgress('Media BLoCs');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateWidgets() async {
    final files = {
      'lib/features/media/presentation/widgets/photo_display.dart':
          templates.photoDisplay,
      'lib/features/media/presentation/widgets/media_display.dart':
          templates.mediaDisplay,
      'lib/features/media/presentation/widgets/video_player.dart':
          templates.videoPlayer,
      'lib/features/media/presentation/widgets/media_picker_field.dart':
          templates.mediaPickerField,
      'lib/features/media/presentation/widgets/selected_media_item.dart':
          templates.selectedMediaItem,
    };

    final progress = Logger.fileProgress('Media widgets');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateHelper() async {
    final progress = Logger.fileProgress('Media helper');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/presentation/helpers/media_helper.dart',
      templates.mediaHelper,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _generateIndexFiles() async {
    final progress = Logger.fileProgress('Media index');
    progress.start(1);
    await FileUtils.writeFile(
      'lib/features/media/media_index.dart',
      templates.mediaIndex,
    );
    progress.tick();
    progress.done();
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.outputPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );

    final file = File(sharedPath);
    if (!await file.exists()) {
      Logger.verbose('Shared bloc_provider.dart not found, skipping update');
      return;
    }

    final importLine =
        "import 'package:${projectConfig.packageName}/features/media/presentation/controllers/media_bloc_provider.dart';";

    var content = await file.readAsString();
    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    const spreadEntry = '  ...mediaBlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for media');
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
        'Updated shared bloc_provider.dart with media provider');
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

    final mediaDeps = [
      '  image_picker: ^1.1.2',
      '  cloudinary_sdk: ^5.0.0+1',
      '  cloudinary: ^1.2.0',
      '  file_saver: ^0.2.14',
      '  share_plus: ^12.0.1',
      '  webview_flutter: ^4.8.0',
    ];

    for (final dep in mediaDeps) {
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
    Logger.verbose('Added media dependencies to pubspec.yaml');
  }

}

/// Configuration for generating a media feature, specifying the target
/// project name and output root directory.
class MediaConfig {
  /// The name of the project being generated into.
  final String projectName;

  /// The absolute path to the project root where files will be created.
  final String outputPath;

  /// Creates a [MediaConfig] with the given [projectName] and [outputPath].
  MediaConfig({
    required this.projectName,
    required this.outputPath,
  });
}
