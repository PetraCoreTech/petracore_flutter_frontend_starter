String chatIndexTemplate(String projectName) => '''
/* Data */
export 'data/models/chat_model.dart';
export 'data/models/message_model.dart';
export 'data/remote/dtos/chat_dto.dart';
export 'data/remote/dtos/mark_chat_read_dto.dart';
export 'data/remote/dtos/message_dto.dart';
export 'data/remote/dtos/send_message_dto.dart';
export 'data/remote/fire_store_chat_service.dart';
export 'data/use_cases/chat_use_cases.dart';
/* Presentation */
export 'presentation/controllers/chat_controller_index.dart';
export 'presentation/entities/chat_entity.dart';
export 'presentation/entities/saved_chat.dart';
export 'presentation/helpers/chat_helper.dart';
export 'presentation/widgets/chat_bubble.dart';
export 'presentation/widgets/chat_builder.dart';
export 'presentation/widgets/chat_search_user_builder.dart';
export 'presentation/widgets/chat_tile.dart';
export 'presentation/widgets/compose_message.dart';
export 'presentation/widgets/message_builder.dart';
export 'presentation/widgets/search_user_display.dart';
''';
