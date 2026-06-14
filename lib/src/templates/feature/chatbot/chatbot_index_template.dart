String chatbotIndexTemplate(String projectName) => '''
export 'data/domain/chatbot_use_cases.dart';
export 'data/remote/chatbot_repository.dart';
export 'data/remote/chatbot_service.dart';
export 'presentation/controllers/chatbot_controller_index.dart';
export 'presentation/entities/chat_message_entity.dart';
export 'presentation/entities/chat_conversation_entity.dart';
export 'presentation/widgets/conversation_list.dart';
export 'presentation/widgets/message_bubble.dart';
export 'presentation/widgets/chat_input_field.dart';
export 'presentation/widgets/typing_indicator.dart';
export 'presentation/screens/chatbot_screen.dart';
''';
