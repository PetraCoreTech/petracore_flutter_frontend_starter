import 'dart:io';

import 'logger.dart';

/// Manages `// petracore:start:` / `// petracore:end:` marker regions in
/// generated files, allowing safe re-generation of specific sections.
class GeneratedRegionWriter {
  /// Replaces the content between `// petracore:start:[regionName]` and
  /// `// petracore:end:[regionName]` markers in [filePath] with [newContent].
  /// Throws [StateError] if the file or markers are not found.
  static Future<void> replaceRegion({
    required String filePath,
    required String regionName,
    required String newContent,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw StateError(
        'Cannot update region `$regionName`: file not found at $filePath.\n'
        'Run the init command first to generate the required files.',
      );
    }

    var content = await file.readAsString();

    final startMarker = '// petracore:start:$regionName';
    final endMarker = '// petracore:end:$regionName';

    final startIndex = content.indexOf(startMarker);
    final endIndex = content.indexOf(endMarker);

    if (startIndex == -1 || endIndex == -1) {
      throw StateError(
        'Cannot find managed region `$regionName` in $filePath.\n'
        'Expected to find:\n'
        '  $startMarker\n'
        '  $endMarker\n'
        'Run `petracore repair navigation` or re-run init to restore the managed regions.',
      );
    }

    final regionStart = startIndex + startMarker.length;
    final beforeRegion = content.substring(0, regionStart);
    final afterRegion = content.substring(endIndex);

    final updated = '$beforeRegion\n$newContent\n$afterRegion';

    await file.writeAsString(updated);
    Logger.verbose('Updated region `$regionName` in $filePath');
  }

  /// Returns `true` if both `start` and `end` markers for [regionName] exist
  /// in [filePath].
  static Future<bool> regionExists({
    required String filePath,
    required String regionName,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    return content.contains('// petracore:start:$regionName') &&
        content.contains('// petracore:end:$regionName');
  }

  /// Ensures a managed region exists in [filePath]. Creates the file with
  /// markers and [defaultContent] if missing, or migrates an old-style marker
  /// if found.
  static Future<void> ensureRegion({
    required String filePath,
    required String regionName,
    required String defaultContent,
  }) async {
    if (await regionExists(filePath: filePath, regionName: regionName)) return;

    final file = File(filePath);
    if (!await file.exists()) {
      await file.writeAsString('''
// petracore:start:$regionName
$defaultContent
// petracore:end:$regionName
''');
      Logger.verbose('Created $filePath with region `$regionName`');
      return;
    }

    var content = await file.readAsString();
    final marker = '// Add your feature routes here';
    if (content.contains(marker)) {
      content = content.replaceFirst(
        marker,
        '// petracore:start:$regionName\n$defaultContent\n// petracore:end:$regionName',
      );
      await file.writeAsString(content);
      Logger.verbose('Migrated marker to managed region `$regionName` in $filePath');
    }
  }
}
