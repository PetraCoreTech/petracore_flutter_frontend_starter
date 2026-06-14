String chatCubitTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/chat/data/models/chat_model.dart';

class ChatCubit extends Cubit<Chat?> {
  ChatCubit() : super(null);

  void setChat(Chat? chat) => emit(chat);
  void clear() => emit(null);
}
''';
