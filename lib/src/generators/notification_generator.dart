import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';

class NotificationGenerator {
  NotificationGenerator(this.config);

  final FeatureConfig config;
  FeatureTemplates get templates => FeatureTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating notification directory structure...');
    await _createDirectories();

    Logger.step('Generating notification feature files...');
    await _generateFiles();

    Logger.step('Updating bloc providers...');
    await _updateSharedBlocProvider();

    Logger.step('Adding notification dependencies...');
    await _updatePubspec();
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join(config.featureRoot, 'data', 'enums'),
      path.join(config.featureRoot, 'data', 'extensions'),
      path.join(config.featureRoot, 'data', 'models'),
      path.join(config.featureRoot, 'data', 'parsers'),
      path.join(config.featureRoot, 'data', 'remote', 'dtos'),
      path.join(config.featureRoot, 'data', 'use_cases'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'notification_cubit'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
    ];
    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateFiles() async {
    final files = {
      'notification_index.dart': templates.notificationIndex,
      // Data layer
      'data/enums/notification_type.dart': templates.notificationTypeEnum,
      'data/extensions/remote_message_extension.dart': templates.remoteMessageExtension,
      'data/models/notification_model.dart': templates.notificationModel,
      'data/parsers/notification_type_converter.dart': templates.notificationTypeConverter,
      'data/remote/dtos/notification_params.dart': templates.notificationParams,
      'data/remote/dtos/notify_dto.dart': templates.notifyDto,
      'data/remote/notification_service.dart': templates.notificationService,
      'data/remote/fcm_notification_service.dart': templates.fcmNotificationService,
      'data/remote/notification_repository.dart': templates.notificationRepository,
      'data/use_cases/notification_use_cases.dart': templates.notificationUseCases,
      // Presentation layer
      'presentation/controllers/cubits/notification_cubit/notification_cubit.dart': templates.notificationCubit,
      'presentation/controllers/notification_bloc_provider.dart': templates.notificationBlocProvider,
      'presentation/controllers/notification_controller_index.dart': templates.notificationControllerIndex,
      'presentation/widgets/notification_badge.dart': templates.notificationBadge,
      'presentation/widgets/notification_card.dart': templates.notificationCard,
      'presentation/widgets/notification_list.dart': templates.notificationList,
      'presentation/widgets/notification_tile.dart': templates.notificationTile,
    };
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
    }
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.projectConfig.projectPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );
    final file = File(sharedPath);
    if (!await file.exists()) return;

    final importLine =
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/notification_bloc_provider.dart';";
    var content = await file.readAsString();

    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
    }

    final spreadEntry = '  ...notificationBlocProvider,';
    if (!content.contains(spreadEntry)) {
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
    }
    await FileUtils.writeFile(sharedPath, content);
  }

  Future<void> _updatePubspec() async {
    final pubspecPath = path.join(
      config.projectConfig.projectPath,
      'pubspec.yaml',
    );
    final file = File(pubspecPath);
    if (!await file.exists()) return;

    var content = await file.readAsString();

    final deps = [
      '  dio: ^5.3.0',
      '  fpdart: ^1.0.0',
      '  json_annotation: ^4.8.1',
      '  firebase_messaging: ^14.7.0',
      '  flutter_local_notifications: ^16.0.0',
      '  flutter_dotenv: ^5.1.0',
      '  cloud_firestore: ^4.13.0',
    ];

    for (final dep in deps) {
      final depName = dep.split(':').first.trim();
      if (content.contains(depName)) continue;
      content = content.replaceFirst(
        'dependencies:',
        'dependencies:\n$dep',
      );
    }

    final devDeps = [
      '  build_runner: ^2.4.6',
      '  json_serializable: ^6.7.1',
    ];

    for (final dep in devDeps) {
      final depName = dep.split(':').first.trim();
      if (content.contains(depName)) continue;
      content = content.replaceFirst(
        'dev_dependencies:',
        'dev_dependencies:\n$dep',
      );
    }

    await FileUtils.writeFile(pubspecPath, content);
  }
}
