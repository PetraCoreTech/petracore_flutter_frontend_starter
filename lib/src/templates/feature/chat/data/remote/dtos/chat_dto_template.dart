String chatDtoTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/data/models/message_model.dart';

class CreateChatDto {
  CreateChatDto({
    required this.users,
    required this.unreadMessages,
    this.lastMessage,
  });
  final List<Map<String, dynamic>> users;
  final Map<String, int> unreadMessages;
  final Message? lastMessage;

  Json toJson() => {
    'users': users,
    'unreadMessages': unreadMessages,
    if (lastMessage != null) 'lastMessage': lastMessage!.toJson(),
  };
}

class UpdateChatDto {
  UpdateChatDto({
    this.unreadMessages,
    this.lastMessage,
  });
  final Map<String, int>? unreadMessages;
  final Message? lastMessage;

  Json toJson() => {
    if (unreadMessages != null) 'unreadMessages': unreadMessages,
    if (lastMessage != null) 'lastMessage': lastMessage!.toJson(),
  };
}
''';
