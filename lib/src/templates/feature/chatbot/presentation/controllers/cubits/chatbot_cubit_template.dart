String chatbotCubitTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chatbot/chatbot_index.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatbotState {
  ChatbotState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.error,
    this.conversationId,
  });

  final List<ChatMessage> messages;
  final ChatStatus status;
  final String? error;
  final String? conversationId;

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    String? error,
    String? conversationId,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      error: error,
      conversationId: conversationId ?? this.conversationId,
    );
  }
}

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotState());

  void sendMessage(String text) {
    final userMessage = ChatMessage(text: text, role: ChatRole.user);
    final updated = state.copyWith(
      messages: [...state.messages, userMessage],
      status: ChatStatus.loading,
      error: null,
    );
    emit(updated);

    chatbotRepository.sendMessage(text: text).then((result) {
      result.fold(
        (reply) => emit(state.copyWith(
          messages: [...state.messages, reply],
          status: ChatStatus.loaded,
        )),
        (error) => emit(state.copyWith(
          status: ChatStatus.error,
          error: error.message,
        )),
      );
    });
  }

  void loadHistory() async {
    emit(state.copyWith(status: ChatStatus.loading));
    final result = await chatbotRepository.getHistory();
    result.fold(
      (messages) => emit(state.copyWith(
        messages: messages,
        status: ChatStatus.loaded,
      )),
      (error) => emit(state.copyWith(
        status: ChatStatus.error,
        error: error.message,
      )),
    );
  }

  void clearChat() {
    emit(ChatbotState());
  }
}
''';
