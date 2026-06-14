String chatMessageEntityTemplate(String projectName) => '''
enum ChatRole { user, assistant, system }

class ChatMessage {
  ChatMessage({
    this.id = '',
    required this.text,
    required this.role,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String id;
  final String text;
  final ChatRole role;
  final DateTime timestamp;

  ChatMessage copyWith({
    String? id,
    String? text,
    ChatRole? role,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  bool get isUser => role == ChatRole.user;
  bool get isAssistant => role == ChatRole.assistant;
}
''';
