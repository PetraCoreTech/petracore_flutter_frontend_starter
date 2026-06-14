String chatbotUseCasesTemplate(String projectName) => '''
import 'package:dartz/dartz.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chatbot/chatbot_index.dart';

final sendMessageUseCase = SendMessageUseCase();
final getChatHistoryUseCase = GetChatHistoryUseCase();

class SendMessageUseCase extends UseCase<ChatMessage, Map<String, dynamic>> {
  @override
  Future<Either<ChatMessage, ErrorResponse>> call(
    Map<String, dynamic> params,
  ) async {
    final res = await chatbotRepository.sendMessage(
      text: params['text'] as String,
      conversationId: params['conversationId'] as String?,
    );
    return res.fold(Left.new, Right.new);
  }
}

class GetChatHistoryUseCase extends UseCase<List<ChatMessage>, void> {
  @override
  Future<Either<List<ChatMessage>, ErrorResponse>> call(void params) async {
    final res = await chatbotRepository.getHistory();
    return res.fold(Left.new, Right.new);
  }
}
''';
