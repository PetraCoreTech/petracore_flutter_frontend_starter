String sendMessageDtoTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/data/remote/dtos/chat_dto.dart';
import 'package:$projectName/features/chat/data/remote/dtos/message_dto.dart';

class SendMessageDto {
  SendMessageDto({
    required this.chat,
    required this.message,
  });
  final CreateChatDto chat;
  final CreateMessageDto message;

  Json toJson() => {
    'chat': chat.toJson(),
    'message': message.toJson(),
  };
}
''';
