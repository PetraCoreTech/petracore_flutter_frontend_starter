String chatbotRepositoryTemplate(String projectName) => '''
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chatbot/chatbot_index.dart';

final chatbotRepository = ChatbotRepository(chatbotService);

abstract class ChatbotRepositoryInterface {
  Future<Either<ChatMessage, ErrorResponse>> sendMessage({
    required String text,
    String? conversationId,
  });

  Future<Either<List<ChatMessage>, ErrorResponse>> getHistory();
}

class ChatbotRepository implements ChatbotRepositoryInterface {
  ChatbotRepository(this.chatbotService);
  final ChatbotService chatbotService;

  @override
  Future<Either<ChatMessage, ErrorResponse>> sendMessage({
    required String text,
    String? conversationId,
  }) async {
    try {
      final response = await chatbotService.sendMessage(
        message: text,
        conversationId: conversationId,
      );
      final json = response.data as Json;
      final message = ChatMessage(
        id: json['id'] ?? '',
        text: json['text'] ?? json['content'] ?? '',
        role: ChatRole.assistant,
        timestamp: DateTime.now(),
      );
      return Left(message);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<List<ChatMessage>, ErrorResponse>> getHistory() async {
    try {
      final response = await chatbotService.getHistory();
      final data = response.data as List<dynamic>;
      final messages = data.map((json) {
        final map = json as Json;
        return ChatMessage(
          id: map['id'] ?? '',
          text: map['text'] ?? map['content'] ?? '',
          role: map['role'] == 'user' ? ChatRole.user : ChatRole.assistant,
          timestamp: map['timestamp'] != null
              ? DateTime.parse(map['timestamp'])
              : DateTime.now(),
        );
      }).toList();
      return Left(messages);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }
}
''';
