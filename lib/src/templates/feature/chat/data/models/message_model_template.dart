String messageModelTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/core/core.dart';

part 'message_model.g.dart';

enum MediaType { image, video, file, audio, none }

@JsonSerializable()
class Message extends BaseModel {
  Message({
    required super.id,
    required this.sender,
    super.dateCreated,
    super.lastUpdated,
    this.text,
    this.mediaUrl,
    this.mediaType = MediaType.none,
    this.read,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _\$MessageFromJson(json);

  final String sender;
  final String? text;
  final String? mediaUrl;
  final MediaType mediaType;
  final Map<String, bool>? read;

  bool get hasMedia => mediaUrl != null && mediaType != MediaType.none;
  bool get isImage => mediaType == MediaType.image;
  bool get isVideo => mediaType == MediaType.video;
  bool get isFile => mediaType == MediaType.file;

  Map<String, dynamic> toJson() => _\$MessageToJson(this);
}
''';
