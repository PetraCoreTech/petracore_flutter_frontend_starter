String notifyDtoTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';

class NotifyDto {
  NotifyDto({
    required this.senderId,
    required this.recipients,
    this.message,
  });
  final String senderId;
  final List<String> recipients;
  final String? message;

  Json toJson() {
    final json = Json();
    json['recipients'] = recipients;
    json['message'] = message;
    json['title'] = 'Notification from user';
    return json;
  }
}
''';
