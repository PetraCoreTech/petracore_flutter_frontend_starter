String chatHelperTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatHelper {
  static void searchUser(String query) {
    // Can be extended to call repository for user search
  }

  static void chatWithUser(Map<String, dynamic> user) {
    final chatDto = CreateChatDto(
      users: [user],
      unreadMessages: {},
    );
    createChatUseCase.call(chatDto);
  }

  static void markChatRead(String chatId, String userId) {
    chatActionBloc.add(MarkChatRead(dto: MarkChatReadDto(
      chatId: chatId,
      userId: userId,
    )));
  }

  static void deleteChat(String chatId) {
    chatActionBloc.add(DeleteChat(chatId: chatId));
  }

  static void createGroupChat(
    String groupName,
    List<Map<String, dynamic>> users,
  ) {
    final chatDto = CreateChatDto(
      users: users,
      unreadMessages: {},
    );
    createChatUseCase.call(chatDto);
  }

  static void startVoiceCall(String calleeName, String? calleeAvatar) {
    // Navigate to voice call screen
  }

  static void startVideoCall(String calleeName, String? calleeAvatar) {
    // Navigate to video call screen
  }
}
''';
