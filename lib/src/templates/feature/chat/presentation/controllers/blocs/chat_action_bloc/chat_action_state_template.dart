String chatActionStateTemplate(String projectName) => '''
import 'package:$projectName/features/chat/data/models/message_model.dart';

sealed class ChatActionState {}

final class ChatActionInitial extends ChatActionState {}

final class ChatActionLoading extends ChatActionState {}

final class MessageSent extends ChatActionState {
  MessageSent({required this.messageId});
  final String messageId;
}

final class MessageUpdated extends ChatActionState {}

final class MessageDeleted extends ChatActionState {}

final class ChatDeleted extends ChatActionState {}

final class ChatRead extends ChatActionState {}

final class MessageRead extends ChatActionState {}

final class ChatActionError extends ChatActionState {
  ChatActionError({required this.message});
  final String message;
}
''';
