import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String attachedMediaModelTemplate(ProjectConfig config) => '''
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';

part 'attached_media_model.g.dart';

typedef Json = Map<String, dynamic>;

@JsonSerializable(fieldRename: FieldRename.snake)
class AttachedMedia {
  AttachedMedia({
    this.id,
    this.size = 0,
    this.name = '',
    this.author,
    this.date,
    this.path,
    this.url,
    this.publicId,
    this.fileBytes,
    this.mediaType = MediaType.text,
  });

  factory AttachedMedia.fromFilePicker(Json map) {
    final filePath = map['path'] as String? ?? '';
    return AttachedMedia(
      id: map['id'] as String?,
      size: (map['size'] as num?)?.toDouble() ?? 0,
      name: map['name'] as String? ?? filePath.split('/').last,
      author: map['author'] as String?,
      path: filePath,
      url: map['url'] as String?,
      publicId: map['publicId'] as String?,
      mediaType: filePath.mediaType,
    );
  }

  factory AttachedMedia.fromJson(Json json) =>
      _\$AttachedMediaFromJson(json);

  final String? id;
  final double size;
  final String name;
  final String? author;
  final DateTime? date;
  final String? path;
  final String? url;
  final String? publicId;
  final Uint8List? fileBytes;
  final MediaType mediaType;

  Json toJson() => _\$AttachedMediaToJson(this);
}
''';
