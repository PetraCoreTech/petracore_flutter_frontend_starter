String chatConversationEntityTemplate(String projectName) => '''
class ChatConversation {
  ChatConversation({
    required this.id,
    required this.title,
    this.messages = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final String title;
  final List<dynamic> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
}
''';
