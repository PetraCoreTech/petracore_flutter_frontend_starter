import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';

class ChatbotFlowGenerator {
  ChatbotFlowGenerator(this.config);

  final FeatureConfig config;
  FeatureTemplates get templates => FeatureTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating chatbot directory structure...');
    await _createDirectories();

    Logger.step('Generating chatbot feature files...');
    await _generateFiles();

    Logger.step('Updating bloc providers...');
    await _updateSharedBlocProvider();
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join(config.featureRoot, 'data', 'models'),
      path.join(config.featureRoot, 'data', 'remote'),
      path.join(config.featureRoot, 'data', 'domain'),
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits'),
      path.join(config.featureRoot, 'presentation', 'entities'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
      path.join(config.featureRoot, 'presentation', 'screens'),
    ];
    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateFiles() async {
    final files = {
      'chatbot_index.dart': templates.chatbotIndex,
      // Data layer
      'data/models/chat_message_model.dart': templates.chatMessageModel,
      'data/remote/chatbot_service.dart': templates.chatbotService,
      'data/remote/chatbot_repository.dart': templates.chatbotRepository,
      'data/domain/chatbot_use_cases.dart': templates.chatbotUseCases,
      // Presentation
      'presentation/controllers/cubits/chatbot_cubit.dart': templates.chatbotCubit,
      'presentation/controllers/chatbot_bloc_provider.dart': templates.chatbotBlocProvider,
      'presentation/controllers/chatbot_controller_index.dart': templates.chatbotControllerIndex,
      'presentation/entities/chat_message_entity.dart': templates.chatMessageEntity,
      'presentation/entities/chat_conversation_entity.dart': templates.chatConversationEntity,
      'presentation/widgets/message_bubble.dart': templates.messageBubble,
      'presentation/widgets/chat_input_field.dart': templates.chatInputField,
      'presentation/widgets/typing_indicator.dart': templates.typingIndicator,
      'presentation/widgets/conversation_list.dart': templates.conversationList,
      'presentation/screens/chatbot_screen.dart': templates.chatbotScreen,
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
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/chatbot_bloc_provider.dart';";
    var content = await file.readAsString();

    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
    }

    final spreadEntry = '  ...chatbotBlocProvider,';
    if (!content.contains(spreadEntry)) {
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
    }
    await FileUtils.writeFile(sharedPath, content);
  }
}
