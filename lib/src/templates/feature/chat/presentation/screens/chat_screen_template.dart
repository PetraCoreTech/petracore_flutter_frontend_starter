String chatScreenTemplate(String projectName) => '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Chat chat) {
    final theme = Theme.of(context);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.primaryContainer,
            backgroundImage: chat.displayImage.isNotEmpty
                ? NetworkImage(chat.displayImage)
                : null,
            child: chat.displayImage.isEmpty
                ? Text(
                    chat.displayName.isNotEmpty ? chat.displayName[0] : '?',
                    style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.displayName,
                style: theme.textTheme.titleSmall,
              ),
              if (chat.isGroup)
                Text(
                  '\${chat.users.length} participants',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: [
        if (chat.isGroup)
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {}, // Group info
          ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {}, // More options
        ),
      ],
    );
  }

  void _onSend({String? text, XFile? media}) {
    // Sends message using the available chat context
    final chat = context.read<ChatCubit>().state;
    if (chat == null) return;
    if (text != null) {
      final messageDto = CreateMessageDto(sender: 'currentUser', text: text);
      fireStoreChatService.createMessage(chat.id, messageDto);
    }
    if (media != null) {
      // Upload media, then create message with mediaUrl
      final messageDto = CreateMessageDto(
        sender: 'currentUser',
        text: text,
        media: media.path,
      );
      fireStoreChatService.createMessage(chat.id, messageDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, Chat?>(
      builder: (context, chat) {
        return Scaffold(
          appBar: chat != null ? _buildAppBar(context, chat) : AppBar(title: const Text('Chat')),
          body: Column(
            children: [
              Expanded(
                child: chat == null
                    ? const Center(child: Text('No chat selected'))
                    : MessageBuilder(chatId: chat.id),
              ),
              ComposeMessage(
                controller: _controller,
                onSend: _onSend,
              ),
            ],
          ),
        );
      },
    );
  }
}
''';
