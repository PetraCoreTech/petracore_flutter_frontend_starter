String chatControllerIndexTemplate(String projectName) => '''
export 'blocs/chat_action_bloc/chat_action_bloc.dart';
export 'blocs/chat_action_bloc/chat_action_event.dart';
export 'blocs/chat_action_bloc/chat_action_state.dart';
export 'cubits/chat_cubit/chat_cubit.dart';
export 'cubits/chat_user_cubit/chat_user_cubit.dart';
export 'cubits/saved_chat_cubit/saved_chat_cubit.dart';
export 'chat_bloc_provider.dart';
''';
