String createGroupScreenTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  final _searchController = TextEditingController();
  final _selectedUsers = <Map<String, dynamic>>[];

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleUser(Map<String, dynamic> user) {
    setState(() {
      final index = _selectedUsers.indexWhere(
        (u) => u['id'] == user['id'],
      );
      if (index >= 0) {
        _selectedUsers.removeAt(index);
      } else {
        _selectedUsers.add(user);
      }
    });
  }

  void _createGroup() {
    final name = _groupNameController.text.trim();
    if (name.isEmpty || _selectedUsers.length < 2) return;
    final chatDto = CreateChatDto(
      users: _selectedUsers,
      unreadMessages: {},
    );
    createChatUseCase.call(chatDto).then((result) {
      result.fold(
        (id) => Navigator.pop(context, id),
        (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canCreate = _groupNameController.text.trim().isNotEmpty &&
        _selectedUsers.length >= 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
        actions: [
          TextButton(
            onPressed: canCreate ? _createGroup : null,
            child: const Text('Create'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                hintText: 'Group name',
                prefixIcon: Icon(Icons.group),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (_selectedUsers.isNotEmpty)
            Container(
              height: 60,
              margin: const EdgeInsets.all(16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedUsers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final user = _selectedUsers[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          (user['firstName']?.toString() ?? '?')[0],
                          style: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user['firstName']?.toString() ?? '',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  );
                },
              ),
            ),
          Expanded(
            child: ChatSearchUserBuilder(
              onUserTap: _toggleUser,
              selectedIds: _selectedUsers.map<String>((u) => u['id'] as String).toSet(),
            ),
          ),
        ],
      ),
    );
  }
}
''';
