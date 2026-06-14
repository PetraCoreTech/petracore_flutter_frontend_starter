String chatSearchUserBuilderTemplate(String projectName) => '''
import 'package:flutter/material.dart';

class ChatSearchUserBuilder extends StatelessWidget {
  const ChatSearchUserBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text('Search results will appear here'),
    );
  }
}
''';
