import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/media/media_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/project_config_reader.dart';

class MediaFlowGenerator {
  MediaFlowGenerator(this.config);

  final MediaConfig config;
  late final ProjectConfig projectConfig;
  late final MediaTemplates templates;

  Future<void> generate() async {
    projectConfig = await ProjectConfigReader.readOrDefault(
      projectName: config.projectName,
      projectPath: config.outputPath,
    );
    templates = MediaTemplates(projectConfig);

    Logger.step('Generating basic media feature structure...');
    await _generateBasicMediaFeature();

    Logger.step('Creating additional media-specific directories...');
    await _createMediaSpecificDirectories();

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

    Logger.step('Running flutter pub get...');
    await _runFlutterPubGet();

    Logger.step('Running build_runner build...');
    await _runBuildRunner();

    Logger.verbose('Media flow generation completed');
  }

  Future<void> _generateBasicMediaFeature() async {
    final mediaFeaturePath = path.join('lib', 'features', 'media');

    final featureConfig = FeatureConfig(
      featureName: 'media',
      outputPath: mediaFeaturePath,
      includeBloc: false,
      includeRepository: false,
      includeUseCases: false,
      includeModels: false,
      projectConfig: projectConfig,
    );

    final featureGenerator = FeatureGenerator(featureConfig);
    await featureGenerator.generate();

    Logger.verbose('Basic media feature structure created');
  }

  Future<void> _createMediaSpecificDirectories() async {
    final dirs = [
      path.join('lib', 'features', 'media', 'data', 'enums'),
      path.join('lib', 'features', 'media', 'data', 'extensions'),
      path.join('lib', 'features', 'media', 'data', 'parsers'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'cloudinary',
          'dtos'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'upload',
          'params'),
      path.join('lib', 'features', 'media', 'data', 'remote', 'download',
          'dtos'),
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
    final files = {
      'lib/features/media/data/enums/media_type.dart': templates.mediaType,
      'lib/features/media/data/enums/media_actions.dart': templates.mediaActions,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
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

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
  }

  Future<void> _generateParsers() async {
    await FileUtils.writeFile(
      'lib/features/media/data/parsers/media_type_parser.dart',
      templates.mediaTypeParser,
    );
  }

  Future<void> _generateModels() async {
    final files = {
      'lib/features/media/data/models/attachment_model.dart':
          templates.attachmentModel,
      'lib/features/media/data/models/attached_media_model.dart':
          templates.attachedMediaModel,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
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

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
  }

  Future<void> _generateParams() async {
    await FileUtils.writeFile(
      'lib/features/media/data/remote/upload/params/upload_params.dart',
      templates.uploadParams,
    );
  }

  Future<void> _generateCloudinaryService() async {
    await FileUtils.writeFile(
      'lib/features/media/data/remote/cloudinary/cloudinary_service.dart',
      templates.cloudinaryService,
    );
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

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
  }

  Future<void> _generateUseCases() async {
    final files = {
      'lib/features/media/data/domain/upload_use_cases.dart':
          templates.uploadUseCases,
      'lib/features/media/data/domain/download_use_cases.dart':
          templates.downloadUseCases,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
  }

  Future<void> _generateEntities() async {
    await FileUtils.writeFile(
      'lib/features/media/presentation/entities/download_entity.dart',
      templates.downloadEntity,
    );
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

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
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

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
    }
  }

  Future<void> _generateHelper() async {
    await FileUtils.writeFile(
      'lib/features/media/presentation/helpers/media_helper.dart',
      templates.mediaHelper,
    );
  }

  Future<void> _generateIndexFiles() async {
    await FileUtils.writeFile(
      'lib/features/media/media_index.dart',
      templates.mediaIndex,
    );
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

    var content = await file.readAsString();

    final importLine =
        "import 'package:${config.projectName}/features/media/presentation/controllers/media_bloc_provider.dart';";

    if (content.contains(importLine)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has import for media');
      return;
    }

    content = content.replaceFirst(
      "import 'package:flutter_bloc/flutter_bloc.dart';",
      "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
    );

    const spreadEntry = '  ...mediaBlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for media');
      await FileUtils.writeFile(sharedPath, content);
      return;
    }

    content = content.replaceFirst(
      '  // Add your feature BLoC providers here',
      '$spreadEntry\n  // Add your feature BLoC providers here',
    );

    await FileUtils.writeFile(sharedPath, content);
    Logger.verbose(
        'Updated shared bloc_provider.dart with media provider');
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

  Future<void> _runFlutterPubGet() async {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: config.outputPath,
    );
    if (result.exitCode != 0) {
      Logger.error('flutter pub get failed:\n${result.stderr}');
    } else {
      Logger.verbose('flutter pub get completed successfully');
    }
  }

  Future<void> _runBuildRunner() async {
    final result = await Process.run(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDirectory: config.outputPath,
    );
    if (result.exitCode != 0) {
      Logger.error('build_runner build failed:\n${result.stderr}');
    } else {
      Logger.verbose('build_runner build completed successfully');
    }
  }
}

class MediaConfig {
  final String projectName;
  final String outputPath;

  MediaConfig({
    required this.projectName,
    required this.outputPath,
  });
}
