import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:test/test.dart';

void main() {
  group('ProjectConfig.designPreset', () {
    test('default config uses default preset', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
      );
      expect(config.designPreset, 'default');
    });

    test('accepts known preset names', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
        designPreset: 'vercel',
      );
      expect(config.designPreset, 'vercel');
    });

    test('accepts all known preset names', () {
      final known = [
        'default',
        'vercel',
        'airbnb',
        'apple',
        'spotify',
        'vibrant',
        'highContrast',
        'starbucks',
        'linear',
        'notion',
        'mongodb',
        'raycast',
      ];
      for (final name in known) {
        final config = ProjectConfig(
          projectName: 'test_app',
          organization: 'com.test',
          description: 'test',
          projectPath: '/tmp/test',
          designPreset: name,
        );
        expect(config.designPreset, name);
      }
    });
  });
}
