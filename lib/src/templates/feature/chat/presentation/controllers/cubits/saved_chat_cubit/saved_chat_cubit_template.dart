String savedChatCubitTemplate(String projectName) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:$projectName/features/chat/presentation/entities/saved_chat.dart';

class SavedChatCubit extends HydratedCubit<List<SavedChat>> {
  SavedChatCubit() : super([]);

  void addChat(SavedChat chat) => emit([chat, ...state]);
  void removeChat(String id) =>
      emit(state.where((c) => c.id != id).toList());
  void updateChat(SavedChat chat) {
    final list = [...state];
    final index = list.indexWhere((c) => c.id == chat.id);
    if (index != -1) list[index] = chat;
    emit(list);
  }

  @override
  List<SavedChat>? fromJson(Map<String, dynamic> json) {
    final list = json['chats'] as List<dynamic>?;
    return list?.map((e) => SavedChat.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Map<String, dynamic>? toJson(List<SavedChat> state) {
    return {'chats': state.map((c) => c.toJson()).toList()};
  }
}
''';
