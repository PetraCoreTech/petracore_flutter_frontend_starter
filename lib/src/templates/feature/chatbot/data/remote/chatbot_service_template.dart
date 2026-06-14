String chatbotServiceTemplate(String projectName) => '''
import 'package:dio/dio.dart';
import 'package:$projectName/core/core.dart';

final chatbotService = ChatbotService(apiClient);

abstract class ChatbotServiceInterface {
  Future<Response<dynamic>> sendMessage({
    required String message,
    String? conversationId,
  });

  Future<Response<dynamic>> getHistory({String? conversationId});

  Future<Response<dynamic>> deleteConversation(String conversationId);
}

class ChatbotService implements ChatbotServiceInterface {
  ChatbotService(this.apiClient);
  final ApiClient apiClient;

  @override
  Future<Response> sendMessage({
    required String message,
    String? conversationId,
  }) async {
    return apiClient.post(
      '/chat/completions',
      data: {
        'message': message,
        if (conversationId != null) 'conversation_id': conversationId,
      },
      reqToken: true,
    );
  }

  @override
  Future<Response> getHistory({String? conversationId}) async {
    return apiClient.get(
      '/chat/history',
      queryParams: {
        if (conversationId != null) 'conversation_id': conversationId,
      },
      reqToken: true,
    );
  }

  @override
  Future<Response> deleteConversation(String conversationId) async {
    return apiClient.delete(
      '/chat/conversations/\$conversationId',
      reqToken: true,
    );
  }
}
''';
