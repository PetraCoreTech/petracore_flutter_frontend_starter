String notificationCubitTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/notification/notification_index.dart';

class NotificationState {
  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
  });

  final List<NotificationItem> notifications;
  final int unreadCount;

  NotificationState copyWith({
    List<NotificationItem>? notifications,
    int? unreadCount,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  final List<NotificationItem> _allNotifications = [];

  List<NotificationItem> get notifications => _allNotifications;
  int get unreadCount => _allNotifications.where((n) => !(n.isRead ?? false)).length;

  void addNotification(NotificationItem notification) {
    _allNotifications.insert(0, notification);
    emit(state.copyWith(
      notifications: List.from(_allNotifications),
      unreadCount: unreadCount,
    ),);
  }

  void markAsRead(String id) {
    final index = _allNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _allNotifications[index].isRead = true;
      emit(state.copyWith(
        notifications: List.from(_allNotifications),
        unreadCount: unreadCount,
      ),);
    }
  }

  void markAllAsRead() {
    for (final n in _allNotifications) {
      n.isRead = true;
    }
    emit(state.copyWith(
      notifications: List.from(_allNotifications),
      unreadCount: 0,
    ),);
  }

  void removeNotification(String id) {
    _allNotifications.removeWhere((n) => n.id == id);
    emit(state.copyWith(
      notifications: List.from(_allNotifications),
      unreadCount: unreadCount,
    ),);
  }

  void clearAll() {
    _allNotifications.clear();
    emit(const NotificationState());
  }
}
''';
