String chatUseCasesTemplate(String projectName) => '''
import 'package:dartz/dartz.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

final chatUseCase = ChatUseCase();
final chatsUseCase = ChatsUseCase();
final createChatUseCase = CreateChatUseCase();
final updateChatUseCase = UpdateChatUseCase();
final deleteChatUseCase = DeleteChatUseCase();
final markChatReadUseCase = MarkChatReadUseCase();

class ChatUseCase extends UseCase<Chat?, String> {
  @override
  Future<Either<Chat?, ErrorResponse>> call(String params) async {
    try {
      final chat = await fireStoreChatService.getChat(params);
      return Left(chat);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class ChatsUseCase extends UseCase<List<Chat>, String> {
  @override
  Future<Either<List<Chat>, ErrorResponse>> call(String params) async {
    try {
      final chats = await fireStoreChatService.getChatsForUser(params);
      return Left(chats);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Stream<List<Chat>> stream(String params) =>
      fireStoreChatService.streamChatsForUser(params);
}

class CreateChatUseCase extends UseCase<String, CreateChatDto> {
  @override
  Future<Either<String, ErrorResponse>> call(CreateChatDto params) async {
    try {
      final id = await fireStoreChatService.createChat(params);
      return Left(id);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class UpdateChatUseCase extends UseCase<SuccessResponse, Map<String, dynamic>> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(Map<String, dynamic> params) async {
    try {
      final chatId = params['chatId'] as String;
      final dto = params['dto'] as UpdateChatDto;
      await fireStoreChatService.updateChat(chatId, dto);
      return Left(SuccessResponse(message: 'Chat updated'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class DeleteChatUseCase extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    try {
      await fireStoreChatService.deleteChat(params);
      return Left(SuccessResponse(message: 'Chat deleted'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class MarkChatReadUseCase extends UseCase<SuccessResponse, MarkChatReadDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(MarkChatReadDto params) async {
    try {
      final dto = UpdateChatDto(unreadMessages: {params.userId: 0});
      await fireStoreChatService.updateChat(params.chatId, dto);
      return Left(SuccessResponse(message: 'Chat marked as read'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

final messageUseCase = MessageUseCase();
final sendMessageUseCase = SendMessageUseCase();
final updateMessageUseCase = UpdateMessageUseCase();
final deleteMessageUseCase = DeleteMessageUseCase();
final markMessageReadUseCase = MarkMessageReadUseCase();

class MessageUseCase extends UseCase<List<Message>, String> {
  @override
  Future<Either<List<Message>, ErrorResponse>> call(String params) async {
    try {
      final messages = await fireStoreChatService.getMessages(params);
      return Left(messages);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Stream<List<Message>> stream(String params) =>
      fireStoreChatService.streamMessages(params);
}

class SendMessageUseCase extends UseCase<String, SendMessageDto> {
  @override
  Future<Either<String, ErrorResponse>> call(SendMessageDto params) async {
    try {
      final chatId = await fireStoreChatService.createChat(params.chat);
      final messageId = await fireStoreChatService.createMessage(
        chatId,
        params.message,
      );
      return Left(messageId);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class UpdateMessageUseCase extends UseCase<SuccessResponse, UpdateMessageDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(UpdateMessageDto params) async {
    try {
      await fireStoreChatService.updateMessage(
        params.chatId,
        params.messageId,
        params,
      );
      return Left(SuccessResponse(message: 'Message updated'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class DeleteMessageUseCase extends UseCase<SuccessResponse, DeleteMessageDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(DeleteMessageDto params) async {
    try {
      await fireStoreChatService.deleteMessage(params.chatId, params.messageId);
      return Left(SuccessResponse(message: 'Message deleted'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}

class MarkMessageReadUseCase extends UseCase<SuccessResponse, MarkMessageReadDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(MarkMessageReadDto params) async {
    try {
      final dto = UpdateMessageDto(
        chatId: params.chatId,
        messageId: params.messageId,
        read: {params.userId: true},
      );
      await fireStoreChatService.updateMessage(
        params.chatId,
        params.messageId,
        dto,
      );
      return Left(SuccessResponse(message: 'Message marked as read'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
