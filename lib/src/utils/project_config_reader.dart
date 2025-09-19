import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import '../generators/project_generator.dart';
import 'logger.dart';

class ProjectConfigReader {
  /// Reads project configuration from the current directory
  /// Returns a ProjectConfig if successful, null otherwise
  static Future<ProjectConfig?> readFromCurrentDirectory() async {
    try {
      final pubspecFile = File('pubspec.yaml');
      if (!await pubspecFile.exists()) {
        Logger.verbose('pubspec.yaml not found in current directory');
        return null;
      }

      final pubspecContent = await pubspecFile.readAsString();
      final pubspecYaml = loadYaml(pubspecContent) as Map;

      final projectName = pubspecYaml['name'] as String?;
      if (projectName == null) {
        Logger.verbose('Project name not found in pubspec.yaml');
        return null;
      }

      /// Try to detect organization from package name or use default
      String organization = 'com.petracore';

      /// Look for organization in android/app/build.gradle
      final androidBuildGradle =
          File(path.join('android', 'app', 'build.gradle'));
      if (await androidBuildGradle.exists()) {
        final buildGradleContent = await androidBuildGradle.readAsString();
        final applicationIdMatch = RegExp('applicationId\s*["\']([^"\']+)["\']')
            .firstMatch(buildGradleContent);
        if (applicationIdMatch != null) {
          final applicationId = applicationIdMatch.group(1)!;

          /// Extract organization from application ID (e.g., "com.example.app" -> "com.example")
          final parts = applicationId.split('.');
          if (parts.length >= 2) {
            organization = parts.take(parts.length - 1).join('.');
          }
        }
      }

      // /Try to get description from pubspec.yaml
      final description = pubspecYaml['description'] as String? ??
          'A Flutter project built with PetraCore architecture.';

      final projectPath = Directory.current.path;

      final config = ProjectConfig(
        projectName: projectName,
        organization: organization,
        description: description,
        projectPath: projectPath,
      );

      Logger.verbose('Detected project config:');
      Logger.verbose('  Project: ${config.projectName}');
      Logger.verbose('  Organization: ${config.organization}');
      Logger.verbose('  Description: ${config.description}');

      return config;
    } catch (e) {
      Logger.verbose('Failed to read project config: $e');
      return null;
    }
  }

  /// Creates a default project config when detection fails
  static ProjectConfig createDefaultConfig({
    String? projectName,
    String? projectPath,
  }) {
    final defaultName = projectName ?? path.basename(Directory.current.path);
    final defaultPath = projectPath ?? Directory.current.path;

    return ProjectConfig(
      projectName: defaultName,
      organization: 'com.petracore',
      description: 'A Flutter project built with PetraCore architecture.',
      projectPath: defaultPath,
    );
  }

  /// Reads project config with fallback to default
  static Future<ProjectConfig> readOrDefault({
    String? projectName,
    String? projectPath,
  }) async {
    final config = await readFromCurrentDirectory();
    return config ??
        createDefaultConfig(
          projectName: projectName,
          projectPath: projectPath,
        );
  }
}
