String notificationModelTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/features/notification/data/enums/notification_type.dart';
import 'package:$projectName/features/notification/data/parsers/notification_type_converter.dart';

part 'notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationItem {
  NotificationItem({
    required this.title,
    required this.body,
    required this.type,
    this.id,
    this.isRead,
    this.typeId,
    this.data,
    this.imageUrl,
    this.dateCreated,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _\$NotificationItemFromJson(json);

  @JsonKey(name: 'pk')
  final String? id;
  final String? typeId;
  @JsonKey(name: 'subject')
  final String title;
  final String body;
  bool? isRead;
  @NotificationTypeConverter()
  final NotificationType type;
  final Map<String, dynamic>? data;
  final String? imageUrl;
  final DateTime? dateCreated;

  Map<String, dynamic> toJson() => _\$NotificationItemToJson(this);

  static NotificationItem? maybeFromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return NotificationItem.fromJson(json);
    }
    return null;
  }
}
''';
