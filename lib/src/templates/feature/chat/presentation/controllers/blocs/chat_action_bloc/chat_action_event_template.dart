String chatActionEventTemplate(String projectName) => '''
import 'package:$projectName/features/chat/data/remote/dtos/send_message_dto.dart';
import 'package:$projectName/features/chat/data/remote/dtos/message_dto.dart';
import 'package:$projectName/features/chat/data/remote/dtos/chat_dto.dart';
import 'package:$projectName/features/chat/data/remote/dtos/mark_chat_read_dto.dart';

sealed class ChatActionEvent {}

final class SendMessage extends ChatActionEvent {
  SendMessage({required this.dto});
  final SendMessageDto dto;
}

final class UpdateMessage extends ChatActionEvent {
  UpdateMessage({
    required this.chatId,
    required this.messageId,
    required this.dto,
  });
  final String chatId;
  final String messageId;
  final UpdateMessageDto dto;
}

final class DeleteMessage extends ChatActionEvent {
  DeleteMessage({required this.dto});
  final DeleteMessageDto dto;
}

final class DeleteChat extends ChatActionEvent {
  DeleteChat({required this.chatId});
  final String chatId;
}

final class MarkChatRead extends ChatActionEvent {
  MarkChatRead({required this.dto});
  final MarkChatReadDto dto;
}

final class MarkMessageRead extends ChatActionEvent {
  MarkMessageRead({required this.dto});
  final MarkMessageReadDto dto;
}
''';
