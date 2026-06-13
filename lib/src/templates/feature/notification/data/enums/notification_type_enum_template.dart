String notificationTypeEnumTemplate(String projectName) => '''
enum NotificationType {
  journal,
  friendRequest,
  friends,
  chat,
}

extension NotificationTypeExt on NotificationType {
  String notificationTypeJson() {
    return switch (this) {
      NotificationType.journal => 'journal',
      NotificationType.chat => 'chat',
      NotificationType.friendRequest => 'friend_request',
      NotificationType.friends => 'friends',
    };
  }
}

extension NotificationTypeStrExt on String {
  NotificationType toNotificationType() {
    return switch (this) {
      'journal' => NotificationType.journal,
      'chat' => NotificationType.chat,
      'friend_request' => NotificationType.friendRequest,
      'friends' => NotificationType.friends,
      String() => NotificationType.journal,
    };
  }
}
''';
