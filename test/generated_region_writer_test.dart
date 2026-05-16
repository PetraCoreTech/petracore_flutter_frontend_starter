import 'dart:io';

import 'package:petracore_flutter_frontend_starter/src/utils/generated_region_writer.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('region_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group('GeneratedRegionWriter', () {
    test('replaceRegion throws if file does not exist', () async {
      await expectLater(
        GeneratedRegionWriter.replaceRegion(
          filePath: '/nonexistent/file.dart',
          regionName: 'test',
          newContent: 'content',
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('replaceRegion throws if region markers are missing', () async {
      final file = File('${tempDir.path}/test.dart');
      await file.writeAsString('class Foo {}');

      await expectLater(
        GeneratedRegionWriter.replaceRegion(
          filePath: file.path,
          regionName: 'missing_region',
          newContent: 'content',
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('replaceRegion replaces content inside region markers', () async {
      final file = File('${tempDir.path}/test.dart');
      await file.writeAsString('''
// petracore:start:my_region
old content
// petracore:end:my_region
''');

      await GeneratedRegionWriter.replaceRegion(
        filePath: file.path,
        regionName: 'my_region',
        newContent: 'new content here',
      );

      final content = await file.readAsString();
      expect(content, contains('// petracore:start:my_region'));
      expect(content, contains('// petracore:end:my_region'));
      expect(content, contains('new content here'));
      expect(content, isNot(contains('old content')));
    });

    test('regionExists returns true when markers present', () async {
      final file = File('${tempDir.path}/test.dart');
      await file.writeAsString('''
// petracore:start:exists
content
// petracore:end:exists
''');

      final exists = await GeneratedRegionWriter.regionExists(
        filePath: file.path,
        regionName: 'exists',
      );
      expect(exists, isTrue);
    });

    test('regionExists returns false when markers missing', () async {
      final file = File('${tempDir.path}/test.dart');
      await file.writeAsString('no markers here');

      final exists = await GeneratedRegionWriter.regionExists(
        filePath: file.path,
        regionName: 'missing',
      );
      expect(exists, isFalse);
    });

    test('regionExists returns false when file missing', () async {
      final exists = await GeneratedRegionWriter.regionExists(
        filePath: '/nonexistent/file.dart',
        regionName: 'test',
      );
      expect(exists, isFalse);
    });

    test('ensureRegion creates file with region if file missing', () async {
      final filePath = '${tempDir.path}/new_file.dart';
      await GeneratedRegionWriter.ensureRegion(
        filePath: filePath,
        regionName: 'test_region',
        defaultContent: '  // default entry',
      );

      final content = await File(filePath).readAsString();
      expect(content, contains('// petracore:start:test_region'));
      expect(content, contains('// petracore:end:test_region'));
      expect(content, contains('default entry'));
    });
  });
}
