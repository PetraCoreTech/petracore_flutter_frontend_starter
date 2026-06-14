String chatActionBlocTemplate(String projectName) => '''
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/chat/chat_index.dart';

final chatActionBloc = ChatActionBloc();

class ChatActionBloc extends Bloc<ChatActionEvent, ChatActionState> {
  ChatActionBloc() : super(ChatActionInitial()) {
    on<SendMessage>(_onSendMessage);
    on<UpdateMessage>(_onUpdateMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<DeleteChat>(_onDeleteChat);
    on<MarkChatRead>(_onMarkChatRead);
    on<MarkMessageRead>(_onMarkMessageRead);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    final result = await sendMessageUseCase.call(event.dto);
    result.fold(
      (messageId) => emit(MessageSent(messageId: messageId)),
      (error) => emit(ChatActionError(message: error.message)),
    );
  }

  Future<void> _onUpdateMessage(
    UpdateMessage event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    emit(MessageUpdated());
  }

  Future<void> _onDeleteMessage(
    DeleteMessage event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    final result = await deleteMessageUseCase.call(event.dto);
    result.fold(
      (_) => emit(MessageDeleted()),
      (error) => emit(ChatActionError(message: error.message)),
    );
  }

  Future<void> _onDeleteChat(
    DeleteChat event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    final result = await deleteChatUseCase.call(event.chatId);
    result.fold(
      (_) => emit(ChatDeleted()),
      (error) => emit(ChatActionError(message: error.message)),
    );
  }

  Future<void> _onMarkChatRead(
    MarkChatRead event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    final result = await markChatReadUseCase.call(event.dto);
    result.fold(
      (_) => emit(ChatRead()),
      (error) => emit(ChatActionError(message: error.message)),
    );
  }

  Future<void> _onMarkMessageRead(
    MarkMessageRead event,
    Emitter<ChatActionState> emit,
  ) async {
    emit(ChatActionLoading());
    final result = await markMessageReadUseCase.call(event.dto);
    result.fold(
      (_) => emit(MessageRead()),
      (error) => emit(ChatActionError(message: error.message)),
    );
  }
}
''';
