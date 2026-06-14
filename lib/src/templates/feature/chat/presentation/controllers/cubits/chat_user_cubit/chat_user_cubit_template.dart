String chatUserCubitTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUserCubit extends Cubit<Map<String, dynamic>?> {
  ChatUserCubit() : super(null);

  void setUser(Map<String, dynamic>? user) => emit(user);
  void clear() => emit(null);
}
''';
