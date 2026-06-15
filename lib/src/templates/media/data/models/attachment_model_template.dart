import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String attachmentModelTemplate(ProjectConfig config) => '''
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Attachment extends Equatable {
  const Attachment({
    required this.name,
    this.publicId,
    this.size,
    this.url,
    this.mimeType,
    this.date,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _\$AttachmentFromJson(json);

  final String name;
  final String? publicId;
  final double? size;
  final String? url;
  final String? mimeType;
  final DateTime? date;

  Map<String, dynamic> toJson() => _\$AttachmentToJson(this);

  @override
  List<Object?> get props => [name, publicId, size, url, mimeType, date];
}
''';
