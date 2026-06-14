String notificationUseCasesTemplate(String projectName) => '''
import 'package:dartz/dartz.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/notification/notification_index.dart';

final singleNotificationUseCase = SingleNotificationUseCase();

class SingleNotificationUseCase
    extends UseCase<NotificationItem, String> {
  @override
  Future<Either<NotificationItem, ErrorResponse>> call(String params) async {
    final res = await notificationRepository.getNotification(params);
    return res.fold(Left.new, Right.new);
  }
}

final multipleNotificationUseCase = MultipleNotificationUseCase();

class MultipleNotificationUseCase
    extends UseCase<List<NotificationItem>, NotificationParams?> {
  @override
  Future<Either<List<NotificationItem>, ErrorResponse>> call(
    NotificationParams? params,
  ) async {
    final res = await notificationRepository.getNotifications(params);
    return res.fold(Left.new, Right.new);
  }
}

final deleteNotificationUseCase = DeleteNotificationUseCase();

class DeleteNotificationUseCase
    extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    final res = await notificationRepository.deleteNotification(params);
    return res.fold(Left.new, Right.new);
  }
}

final markNotificationReadUseCase = MarkNotificationReadUseCase();

class MarkNotificationReadUseCase
    extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    final res = await notificationRepository.markNotificationAsRead(params);
    return res.fold(Left.new, Right.new);
  }
}

final fcmTokenUseCase = FCMTokenUseCase();

class FCMTokenUseCase extends UseCase<String, void> {
  @override
  Future<Either<String, ErrorResponse>> call(void params) async {
    final res = await notificationRepository.generateToken();
    return res.fold(Left.new, Right.new);
  }
}
''';
