String searchUserDisplayTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class SearchUserDisplay extends StatefulWidget {
  const SearchUserDisplay({super.key});

  @override
  State<SearchUserDisplay> createState() => _SearchUserDisplayState();
}

class _SearchUserDisplayState extends State<SearchUserDisplay> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search users...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              ChatHelper.searchUser(value);
            },
          ),
        ),
        const ChatSearchUserBuilder(),
      ],
    );
  }
}
''';
