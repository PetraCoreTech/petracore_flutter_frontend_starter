String notificationTypeConverterTemplate(String projectName) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/features/notification/data/enums/notification_type.dart';

class NotificationTypeConverter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeConverter();

  @override
  NotificationType fromJson(String json) => json.toNotificationType();

  @override
  String toJson(NotificationType object) => object.notificationTypeJson();
}
''';
