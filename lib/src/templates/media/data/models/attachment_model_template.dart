import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String attachmentModelTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/parsers/media_type_parser.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Attachment extends Equatable {
  final String name;
  final String? publicId;
  final double? size;
  final String? url;
  @JsonKey(
    fromJson: MediaTypeParser.typeFromJson,
    readValue: MediaTypeParser.readStatus,
  )
  final MediaType? mediaType;
  final DateTime? date;

  const Attachment({
    required this.name,
    this.publicId,
    this.size,
    this.url,
    this.mediaType,
    this.date,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _\$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _\$AttachmentToJson(this);

  @override
  List<Object?> get props => [name, publicId, size, url, mediaType, date];
}
''';
