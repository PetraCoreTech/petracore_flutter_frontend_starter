String chatbotBlocProviderTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/chatbot/presentation/controllers/cubits/chatbot_cubit.dart';

final chatbotBlocProvider = <BlocProvider>[
  BlocProvider<ChatbotCubit>(
    create: (_) => ChatbotCubit(),
  ),
];
''';
