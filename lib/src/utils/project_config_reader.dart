import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import '../design_presets/design_preset.dart';
import '../generators/project_generator.dart';
import 'logger.dart';

/// Reads [ProjectConfig] from an existing Flutter project directory by
/// parsing `pubspec.yaml` and detecting the organization and design preset.
class ProjectConfigReader {
  /// Reads the project configuration from the directory at [rootPath].
  /// Returns `null` if `pubspec.yaml` is missing or the project name cannot be
  /// determined.
  static Future<ProjectConfig?> readFromDirectory(String rootPath) async {
    try {
      final normalized = path.normalize(path.absolute(rootPath));
      final pubspecFile = File(path.join(normalized, 'pubspec.yaml'));
      if (!await pubspecFile.exists()) {
        Logger.verbose('pubspec.yaml not found in $normalized');
        return null;
      }

      final pubspecContent = await pubspecFile.readAsString();
      final pubspecYaml = loadYaml(pubspecContent) as Map;

      final projectName = pubspecYaml['name'] as String?;
      if (projectName == null) {
        Logger.verbose('Project name not found in pubspec.yaml');
        return null;
      }

      final organization = await _detectOrganization(normalized);

      final description = pubspecYaml['description'] as String? ??
          'A Flutter project built with PetraCore architecture.';

      final designPreset = await _detectDesignPreset(normalized);

      final config = ProjectConfig(
        projectName: projectName,
        organization: organization,
        description: description,
        projectPath: normalized,
        designPreset: designPreset,
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

  /// Creates a [ProjectConfig] with default values. If [projectName] or
  /// [projectPath] are omitted, sensible defaults are used.
  static ProjectConfig createDefaultConfig({
    String? projectName,
    String? projectPath,
  }) {
    final defaultName = projectName ?? 'petracore_app';
    final defaultPath = projectPath ?? Directory.current.path;

    return ProjectConfig(
      projectName: defaultName,
      organization: 'com.petracore',
      description: 'A Flutter project built with PetraCore architecture.',
      projectPath: defaultPath,
    );
  }

  static Future<DesignPresetId> _detectDesignPreset(String rootPath) async {
    final petracoreConfig = File(
      path.join(rootPath, 'petracore.config.json'),
    );
    if (await petracoreConfig.exists()) {
      try {
        final content = await petracoreConfig.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        final presetStr = json['designPreset'] as String?;
        if (presetStr != null) {
          return DesignPresetId.values.firstWhere(
            (e) => e.name == presetStr,
            orElse: () => DesignPresetId.defaultPreset,
          );
        }
      } catch (_) {
        // ignore parse errors
      }
    }
    return DesignPresetId.defaultPreset;
  }

  /// Tries to read the project config from [projectPath]; falls back to
  /// [createDefaultConfig] if reading fails.
  static Future<ProjectConfig> readOrDefault({
    String? projectName,
    String? projectPath,
  }) async {
    final targetPath = projectPath ?? Directory.current.path;
    final config = await readFromDirectory(targetPath);
    return config ??
        createDefaultConfig(
          projectName: projectName,
          projectPath: targetPath,
        );
  }
}
