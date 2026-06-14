String chatsScreenTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showNewChatDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          height: 400,
          child: const SearchUserDisplay(),
        ),
      ),
    );
  }

  void _openCreateGroup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateGroupScreen()),
    );
  }

  void _openCallLog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CallLogScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search conversations...',
                  border: InputBorder.none,
                ),
                onChanged: (_) => setState(() {}),
              )
            : const Text('Chats'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) _searchController.clear();
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching && _searchController.text.isNotEmpty)
            _buildSearchResults(),
          Expanded(
            child: ChatBuilder(
              searchQuery: _isSearching ? _searchController.text : null,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'call_log',
            onPressed: _openCallLog,
            child: const Icon(Icons.history),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'new_group',
            onPressed: _openCreateGroup,
            child: const Icon(Icons.group_add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'new_chat',
            onPressed: _showNewChatDialog,
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('Searching for "\${_searchController.text}"...'),
    );
  }
}
''';
