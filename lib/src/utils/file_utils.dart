import 'dart:io';

import 'package:path/path.dart' as path;

class FileUtils {
  static Future<void> writeFile(String filePath, String content) async {
    final file = File(filePath);
    final directory = Directory(path.dirname(filePath));

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    await file.writeAsString(content);
  }

  static Future<String> readFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileSystemException('File not found', filePath);
    }
    return await file.readAsString();
  }

  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  static Future<bool> directoryExists(String dirPath) async {
    return await Directory(dirPath).exists();
  }

  static Future<void> createDirectory(String dirPath) async {
    await Directory(dirPath).create(recursive: true);
  }

  static Future<void> copyFile(String sourcePath, String targetPath) async {
    final sourceFile = File(sourcePath);

    final targetDirectory = Directory(path.dirname(targetPath));
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    await sourceFile.copy(targetPath);
  }

  static String sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[^\w\-.]'), '_');
  }

  static String getRelativePath(String filePath, String basePath) {
    return path.relative(filePath, from: basePath);
  }
}
