String messageModelTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/core/core.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Message extends BaseModel {
  Message({
    required super.id,
    required this.sender,
    super.dateCreated,
    super.lastUpdated,
    this.text,
    this.mediaUrl,
    this.mimeType,
    this.read,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _\$MessageFromJson(json);

  final String sender;
  final String? text;
  final String? mediaUrl;
  final String? mimeType;
  final Map<String, bool>? read;

  bool get hasMedia => mediaUrl != null && mimeType != null;
  bool get isImage => mimeType?.startsWith('image/') == true;
  bool get isVideo => mimeType?.startsWith('video/') == true;
  bool get isFile => mimeType != null && !mimeType!.startsWith('image/') && !mimeType!.startsWith('video/');

  Map<String, dynamic> toJson() => _\$MessageToJson(this);
}
''';
