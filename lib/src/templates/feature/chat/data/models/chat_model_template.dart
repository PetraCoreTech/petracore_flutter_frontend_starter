String chatModelTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/data/models/message_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat extends BaseModel {
  Chat({
    required super.id,
    required this.users,
    required this.unreadMessages,
    super.dateCreated,
    super.lastUpdated,
    this.lastMessage,
    this.isGroup = false,
    this.groupName,
    this.groupImage,
    this.adminUsers,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _\$ChatFromJson(json);

  final List<Map<String, dynamic>> users;
  final Map<String, int> unreadMessages;
  final Message? lastMessage;
  final bool isGroup;
  final String? groupName;
  final String? groupImage;
  final List<String>? adminUsers;

  bool get isAdmin => true; // override with actual user check

  String get displayName {
    if (isGroup && groupName != null) return groupName!;
    return users.first['firstName']?.toString() ?? 'Unknown';
  }

  String get displayImage {
    if (isGroup && groupImage != null) return groupImage!;
    return users.first['image']?.toString() ?? '';
  }

  String get subtitle {
    if (isGroup) return '\${users.length} participants';
    return lastMessage?.text ?? 'No messages yet';
  }

  Map<String, dynamic> toJson() => _\$ChatToJson(this);
}
''';
