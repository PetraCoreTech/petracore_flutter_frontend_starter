import 'dart:io';

import 'package:path/path.dart' as path;

/// Utility class for common file system operations.
class FileUtils {
  /// Writes [content] to the file at [filePath], creating parent directories
  /// if they don't exist.
  static Future<void> writeFile(String filePath, String content) async {
    final file = File(filePath);
    final directory = Directory(path.dirname(filePath));

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    await file.writeAsString(content);
  }

  /// Reads and returns the contents of the file at [filePath].
  /// Throws [FileSystemException] if the file does not exist.
  static Future<String> readFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileSystemException('File not found', filePath);
    }
    return await file.readAsString();
  }

  /// Returns `true` if a file exists at [filePath].
  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  /// Returns `true` if a directory exists at [dirPath].
  static Future<bool> directoryExists(String dirPath) async {
    return await Directory(dirPath).exists();
  }

  /// Creates a directory at [dirPath] and all parent directories if needed.
  static Future<void> createDirectory(String dirPath) async {
    await Directory(dirPath).create(recursive: true);
  }

  /// Copies a file from [sourcePath] to [targetPath], creating parent
  /// directories of [targetPath] if they don't exist.
  static Future<void> copyFile(String sourcePath, String targetPath) async {
    final sourceFile = File(sourcePath);

    final targetDirectory = Directory(path.dirname(targetPath));
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    await sourceFile.copy(targetPath);
  }

  /// Replaces characters in [fileName] that are not word characters, hyphens,
  /// or dots with underscores. Returns the sanitized string safe for use as a
  /// file name.
  static String sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[^\w\-.]'), '_');
  }

  /// Returns the relative path of [filePath] relative to [basePath].
  static String getRelativePath(String filePath, String basePath) {
    return path.relative(filePath, from: basePath);
  }
}
