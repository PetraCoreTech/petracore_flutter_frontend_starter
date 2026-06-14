String chatbotScreenTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chatbot/chatbot_index.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (context, state) {
                return ConversationList(
                  messages: state.messages,
                  isLoading: state.status == ChatStatus.loading,
                );
              },
            ),
          ),
          BlocBuilder<ChatbotCubit, ChatbotState>(
            builder: (context, state) {
              return ChatInputField(
                onSend: (text) =>
                    context.read<ChatbotCubit>().sendMessage(text),
                enabled: state.status != ChatStatus.loading,
              );
            },
          ),
        ],
      ),
    );
  }
}
''';
