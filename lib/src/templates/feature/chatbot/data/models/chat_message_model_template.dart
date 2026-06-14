String chatMessageModelTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  ChatMessageModel({
    required this.id,
    required this.text,
    required this.role,
    this.timestamp,
  });

  final String id;
  final String text;
  final String role;
  final DateTime? timestamp;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _\$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _\$ChatMessageModelToJson(this);
}
''';
