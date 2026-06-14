import 'package:petracore_flutter_frontend_starter/src/utils/file_utils.dart';

/// Generates a markdown instruction guide file within the project root.
///
/// Accepts template content and a file name, and writes the guide file.
/// The caller should log a message directing the user to the generated file.
class InstructionGuideGenerator {
  final String projectPath;
  final String fileName;
  final String content;

  InstructionGuideGenerator({
    required this.projectPath,
    required this.fileName,
    required this.content,
  });

  Future<void> generate() async {
    final filePath = '$projectPath/$fileName';
    await FileUtils.writeFile(filePath, content);
  }
}
