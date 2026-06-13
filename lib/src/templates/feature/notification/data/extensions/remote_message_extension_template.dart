String remoteMessageExtensionTemplate(String projectName) => '''
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:$projectName/features/notification/data/models/notification_model.dart';

extension RemoteMessageExtension on RemoteMessage {
  NotificationItem toNotification() {
    final json = <String, dynamic>{...data};
    final title = notification?.title;
    if (title != null) json['subject'] = title;
    final body = notification?.body;
    if (body != null) json['body'] = body;
    return NotificationItem.fromJson(json);
  }
}
''';
