import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import '../generators/project_generator.dart';

/// Resolves a [ProjectConfig] from a Flutter project root directory by
/// parsing `pubspec.yaml` and detecting the Android application ID.
class ProjectContextResolver {
  /// Builds a [ProjectConfig] from the project at [rootPath].
  /// Throws [StateError] if `pubspec.yaml` is missing or has no `name` field.
  static Future<ProjectConfig> fromProjectRoot(String rootPath) async {
    final normalized = path.normalize(path.absolute(rootPath));

    final pubspecFile = File(path.join(normalized, 'pubspec.yaml'));
    if (!await pubspecFile.exists()) {
      throw StateError(
        'No pubspec.yaml found at $normalized. Ensure you are in a valid Flutter project.',
      );
    }

    final pubspecContent = await pubspecFile.readAsString();
    final pubspecYaml = loadYaml(pubspecContent) as Map;

    final projectName = pubspecYaml['name'] as String?;
    if (projectName == null) {
      throw StateError('Project name not found in pubspec.yaml at $normalized');
    }

    final organization = await _detectOrganization(normalized);

    final description = pubspecYaml['description'] as String? ??
        'A Flutter project built with PetraCore architecture.';

    return ProjectConfig(
      projectName: projectName,
      organization: organization,
      description: description,
      projectPath: normalized,
    );
  }

  static Future<String> _detectOrganization(String rootPath) async {
    final androidBuildGradle = File(
      path.join(rootPath, 'android', 'app', 'build.gradle'),
    );
    if (await androidBuildGradle.exists()) {
      final content = await androidBuildGradle.readAsString();
      final match = RegExp("""applicationId\\s*["']([^"']+)["']""")
          .firstMatch(content);
      if (match != null) {
        final parts = match.group(1)!.split('.');
        if (parts.length >= 2) {
          return parts.take(parts.length - 1).join('.');
        }
      }
    }
    return 'com.petracore';
  }

}
