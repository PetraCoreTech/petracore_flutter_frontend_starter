String messageDtoTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';

class CreateMessageDto {
  CreateMessageDto({
    required this.sender,
    this.text,
    this.mediaUrl,
    this.mimeType,
    this.read,
  });
  final String sender;
  final String? text;
  final String? mediaUrl;
  final String? mimeType;
  final Map<String, bool>? read;

  Json toJson() => {
    'sender': sender,
    if (text != null) 'text': text,
    if (mediaUrl != null) 'mediaUrl': mediaUrl,
    if (mimeType != null) 'mimeType': mimeType,
    if (read != null) 'read': read,
  };
}

class UpdateMessageDto {
  UpdateMessageDto({
    required this.chatId,
    required this.messageId,
    this.text,
    this.read,
  });
  final String chatId;
  final String messageId;
  final String? text;
  final Map<String, bool>? read;

  Json toJson() => {
    if (text != null) 'text': text,
    if (read != null) 'read': read,
  };
}

class DeleteMessageDto {
  DeleteMessageDto({required this.chatId, required this.messageId});
  final String chatId;
  final String messageId;
}
''';
