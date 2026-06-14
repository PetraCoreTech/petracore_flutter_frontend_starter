String markChatReadDtoTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';

class MarkChatReadDto {
  MarkChatReadDto({
    required this.chatId,
    required this.userId,
  });
  final String chatId;
  final String userId;

  Json toJson() => {'userId': userId};
}

class MarkMessageReadDto {
  MarkMessageReadDto({
    required this.chatId,
    required this.messageId,
    required this.userId,
  });
  final String chatId;
  final String messageId;
  final String userId;

  Json toJson() => {
    'messageId': messageId,
    'userId': userId,
  };
}
''';
