String notificationRepositoryTemplate(String projectName) => '''
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/notification/notification_index.dart';

final notificationRepository = NotificationRepository();

mixin NotificationRepositoryInterface {
  Future<Either<String, ErrorResponse>> generateToken();
  Future<Either<SuccessResponse, ErrorResponse>> deleteNotification(String id);
  Future<Either<NotificationItem, ErrorResponse>> getNotification(String id);
  Future<Either<List<NotificationItem>, ErrorResponse>> getNotifications(
    NotificationParams? params,
  );
  Future<Either<SuccessResponse, ErrorResponse>> markNotificationAsRead(
    String id,
  );
}

class NotificationRepository implements NotificationRepositoryInterface {
  @override
  Future<Either<String, ErrorResponse>> generateToken() async {
    try {
      final response = await FCMNotificationService.generateToken();
      if (response != null) {
        return Left(response);
      }
      return Right(ErrorResponse(message: 'No token!'));
    } on FirebaseException catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<SuccessResponse, ErrorResponse>> deleteNotification(
    String id,
  ) async {
    try {
      await notificationService.deleteNotification(id);
      return Left(SuccessResponse(message: 'Deleted Successfully'));
    } on DioException catch (e) {
      return Right(ApiError.handleError(e));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<NotificationItem, ErrorResponse>> getNotification(
    String id,
  ) async {
    try {
      final response =
          await notificationService.getNotification(isSingle: true, id: id);
      final json = response.data as Json;
      return Left(NotificationItem.fromJson(json));
    } on DioException catch (e) {
      return Right(ApiError.handleError(e));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<List<NotificationItem>, ErrorResponse>> getNotifications(
    NotificationParams? params,
  ) async {
    try {
      final response = await notificationService.getNotification(
        queryParams: params?.toJson(),
      );
      final json = response.data as List<dynamic>;
      final dataResponse =
          json.map((e) => NotificationItem.fromJson(e as Json)).toList();
      return Left(dataResponse);
    } on DioException catch (e) {
      return Right(ApiError.handleError(e));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<SuccessResponse, ErrorResponse>> markNotificationAsRead(
    String id,
  ) async {
    try {
      await notificationService.markNotificationAsRead(id);
      return Left(SuccessResponse(message: 'Marked as read!'));
    } on DioException catch (e) {
      return Right(ApiError.handleError(e));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
