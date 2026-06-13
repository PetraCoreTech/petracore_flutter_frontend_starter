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
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'notification_cubit'),
      path.join(config.featureRoot, 'presentation', 'entities'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
    ];
    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateFiles() async {
    final files = {
      'notification_index.dart': templates.notificationIndex,
      'presentation/controllers/cubits/notification_cubit/notification_cubit.dart': templates.notificationCubit,
      'presentation/controllers/notification_bloc_provider.dart': templates.notificationBlocProvider,
      'presentation/controllers/notification_controller_index.dart': templates.notificationControllerIndex,
      'presentation/entities/notification_item_entity.dart': templates.notificationItemEntity,
      'presentation/entities/notification_type_entity.dart': templates.notificationTypeEntity,
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
}
