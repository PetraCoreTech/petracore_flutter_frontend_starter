String chatBlocProviderTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/chat/chat_index.dart';

final chatBlocProvider = <BlocProvider>[
  BlocProvider<ChatActionBloc>(create: (context) => chatActionBloc),
  BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
  BlocProvider<ChatUserCubit>(create: (context) => ChatUserCubit()),
  BlocProvider<SavedChatCubit>(create: (context) => SavedChatCubit()),
];
''';
