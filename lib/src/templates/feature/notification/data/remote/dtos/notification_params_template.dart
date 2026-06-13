String notificationParamsTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';

class NotificationParams {
  NotificationParams({this.category});
  final String? category;

  Json toJson() {
    final json = Json();
    if (category != null) json['category'] = category;
    return json;
  }
}
''';
