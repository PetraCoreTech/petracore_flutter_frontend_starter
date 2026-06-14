String notificationServiceTemplate(String projectName) => '''
import 'package:dio/dio.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/notification/notification_index.dart';

final notificationService = NotificationService();

abstract class NotificationServiceInterface {
  Future<Response<dynamic>> getNotification({
    bool isSingle,
    String? id,
    Json? queryParams,
  });  Future<Response<dynamic>> deleteNotification(String id);
  Future<Response<dynamic>> markNotificationAsRead(String id);
  Future<void> notifyUsers(NotifyDto data);
}

class NotificationService implements NotificationServiceInterface {
  @override
  Future<Response> getNotification({
    bool isSingle = false,
    String? id,
    Json? queryParams,
  }) async {
    final pathParam = isSingle ? '/\$id' : '';
    final response = await apiClient.makeRequest(
      '/notifications\$pathParam',
      RequestMethod.get,
      reqToken: true,
      queryParams: queryParams,
    );
    return response;
  }

  @override
  Future<Response> markNotificationAsRead(String id) async {
    final response = await apiClient.makeRequest(
      '/notifications/\$id/mark_as_read',
      RequestMethod.post,
      reqToken: true,
    );
    return response;
  }

  @override
  Future<void> notifyUsers(NotifyDto data) async {
    await apiClient.makeRequest(
      '/notifications/send_push_notification',
      RequestMethod.post,
      data: data.toJson(),
      reqToken: true,
    );
  }

  @override
  Future<Response> deleteNotification(String id) async {
    final response = await apiClient.makeRequest(
      '/notifications/\$id',
      RequestMethod.delete,
      reqToken: true,
    );
    return response;
  }
}
''';
