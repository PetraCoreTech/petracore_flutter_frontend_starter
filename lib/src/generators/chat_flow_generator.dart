import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';

class ChatFlowGenerator {
  ChatFlowGenerator(this.config);

  final FeatureConfig config;
  FeatureTemplates get templates => FeatureTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating chat directory structure...');
    await _createDirectories();

    Logger.step('Generating chat feature files...');
    await _generateFiles();

    Logger.step('Updating bloc providers...');
    await _updateSharedBlocProvider();
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join(config.featureRoot, 'data', 'models'),
      path.join(config.featureRoot, 'data', 'remote', 'dtos'),
      path.join(config.featureRoot, 'data', 'use_cases'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'blocs', 'chat_action_bloc'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'chat_cubit'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'chat_user_cubit'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'saved_chat_cubit'),
      path.join(config.featureRoot, 'presentation', 'entities'),
      path.join(config.featureRoot, 'presentation', 'helpers'),
      path.join(config.featureRoot, 'presentation', 'screens'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
    ];
    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateFiles() async {
    final files = {
      'chat_index.dart': templates.chatIndex,
      'data/models/chat_model.dart': templates.chatModel,
      'data/models/message_model.dart': templates.messageModel,
      'data/remote/dtos/chat_dto.dart': templates.chatDto,
      'data/remote/dtos/mark_chat_read_dto.dart': templates.markChatReadDto,
      'data/remote/dtos/message_dto.dart': templates.messageDto,
      'data/remote/dtos/send_message_dto.dart': templates.sendMessageDto,
      'data/remote/fire_store_chat_service.dart': templates.fireStoreChatService,
      'data/use_cases/chat_use_cases.dart': templates.chatUseCases,
      'presentation/controllers/blocs/chat_action_bloc/chat_action_bloc.dart': templates.chatActionBloc,
      'presentation/controllers/blocs/chat_action_bloc/chat_action_event.dart': templates.chatActionEvent,
      'presentation/controllers/blocs/chat_action_bloc/chat_action_state.dart': templates.chatActionState,
      'presentation/controllers/cubits/chat_cubit/chat_cubit.dart': templates.chatCubit,
      'presentation/controllers/cubits/chat_user_cubit/chat_user_cubit.dart': templates.chatUserCubit,
      'presentation/controllers/cubits/saved_chat_cubit/saved_chat_cubit.dart': templates.savedChatCubit,
      'presentation/controllers/chat_bloc_provider.dart': templates.chatBlocProvider,
      'presentation/controllers/chat_controller_index.dart': templates.chatControllerIndex,
      'presentation/entities/chat_entity.dart': templates.chatEntity,
      'presentation/entities/saved_chat.dart': templates.savedChat,
      'presentation/helpers/chat_helper.dart': templates.chatHelper,
      'presentation/screens/chat_screen.dart': templates.chatScreen,
      'presentation/screens/chats_screen.dart': templates.chatsScreen,
      'presentation/screens/chat_screen_index.dart': templates.chatScreenIndex,
      'presentation/widgets/chat_bubble.dart': templates.chatBubble,
      'presentation/widgets/chat_builder.dart': templates.chatBuilder,
      'presentation/widgets/chat_search_user_builder.dart': templates.chatSearchUserBuilder,
      'presentation/widgets/chat_tile.dart': templates.chatTile,
      'presentation/widgets/compose_message.dart': templates.composeMessage,
      'presentation/widgets/message_builder.dart': templates.messageBuilder,
      'presentation/widgets/search_user_display.dart': templates.searchUserDisplay,
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
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/chat_bloc_provider.dart';";
    var content = await file.readAsString();

    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
    }

    final spreadEntry = '  ...chatBlocProvider,';
    if (!content.contains(spreadEntry)) {
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
    }
    await FileUtils.writeFile(sharedPath, content);
  }
}
