String chatHelperTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatHelper {
  static void searchUser(String query) {
  }

  static void chatWithUser(Map<String, dynamic> user) {
  }

  static void markChatRead(String chatId, String userId) {
    chatActionBloc.add(MarkChatRead(dto: MarkChatReadDto(userId: userId)));
  }

  static void deleteChat(String chatId) {
    chatActionBloc.add(DeleteChat(chatId: chatId));
  }
}
''';
