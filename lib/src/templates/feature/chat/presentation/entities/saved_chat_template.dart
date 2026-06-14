String savedChatTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/data/models/chat_model.dart';
import 'package:$projectName/features/chat/data/models/message_model.dart';

part 'saved_chat.g.dart';

@JsonSerializable()
class SavedChat extends BaseModel {
  SavedChat({
    required super.id,
    required this.users,
    required this.unreadMessages,
    required this.lastMessage,
    required this.messages,
    super.dateCreated,
    super.lastUpdated,
  });

  factory SavedChat.fromJson(Map<String, dynamic> json) =>
      _\$SavedChatFromJson(json);

  final List<Map<String, dynamic>> users;
  final Map<String, int> unreadMessages;
  final Message lastMessage;
  final List<Message> messages;

  Map<String, dynamic> toJson() => _\$SavedChatToJson(this);
}
''';
