String notificationTypeEntityTemplate(String projectName) => '''
enum NotificationType {
  general,
  announcement,
  assignment,
  quiz,
  message,
  system,
}
''';
