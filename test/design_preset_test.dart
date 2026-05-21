import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/project/app/theme/color_values_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/project/app/theme/base_theme_template.dart';
import 'package:test/test.dart';

void main() {
  group('DesignPresetRegistry', () {
    test('resolves all presets without throwing', () {
      for (final id in DesignPresetId.values) {
        expect(
          () => DesignPresetRegistry.resolve(id),
          returnsNormally,
        );
      }
    });

    test('default preset returns expected values', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.defaultPreset);
      expect(preset.displayName, contains('Default'));
      expect(preset.typography.fontFamily, 'Times New Roman');
      expect(preset.radius.small, 4);
      expect(preset.radius.medium, 8);
      expect(preset.radius.large, 100);
    });

    test('vercel preset returns expected values', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.vercel);
      expect(preset.displayName, contains('Vercel'));
      expect(preset.typography.fontFamily, 'Inter');
      expect(preset.radius.small, 2);
      expect(preset.radius.medium, 4);
      expect(preset.radius.large, 6);
    });

    test('airbnb preset returns expected values', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.airbnb);
      expect(preset.displayName, contains('Airbnb'));
      expect(preset.typography.fontFamily, 'Circular');
      expect(preset.radius.small, 8);
      expect(preset.radius.medium, 12);
      expect(preset.radius.large, 16);
    });

    test('apple preset returns expected values', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.apple);
      expect(preset.displayName, contains('Apple'));
      expect(preset.typography.fontFamily, 'SF Pro Display');
      expect(preset.radius.small, 6);
      expect(preset.radius.medium, 10);
      expect(preset.radius.large, 14);
    });

    test('all presets return all required color keys', () {
      final requiredKeys = [
        'white',
        'black',
        'primary',
        'primaryGrading',
        'neutral50',
        'neutral100',
        'neutral200',
        'neutral300',
        'neutral400',
        'neutral500',
        'neutral600',
        'surface001',
        'warning',
        'error',
        'shimmer',
      ];
      for (final id in DesignPresetId.values) {
        final preset = DesignPresetRegistry.resolve(id);
        for (final key in requiredKeys) {
          expect(
            preset.colors.values.containsKey(key),
            isTrue,
            reason: 'Preset ${id.name} missing color: $key',
          );
        }
      }
    });

    test('throws for unknown preset ID', () {
      expect(
        () => DesignPresetRegistry.resolve(DesignPresetId.defaultPreset),
        returnsNormally,
      );
    });

    test('registry exposes all presets', () {
      expect(DesignPresetRegistry.all.length, DesignPresetId.values.length);
    });
  });

  group('ProjectConfig.designPreset', () {
    test('default config uses default preset', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
      );
      expect(config.designPreset, DesignPresetId.defaultPreset);
    });

    test('resolvedDesignPreset matches configured id', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
        designPreset: DesignPresetId.vercel,
      );
      expect(config.resolvedDesignPreset.id, DesignPresetId.vercel);
      expect(config.resolvedDesignPreset.typography.fontFamily, 'Inter');
    });
  });

  group('colorValuesTemplate preset-awareness', () {
    test('generates default colors correctly', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.defaultPreset);
      final output = colorValuesTemplate(preset.colors);
      expect(output, contains('class AppColors'));
      expect(output, contains('primary = Color(0xff33FF9C)'));
      expect(output, contains('Colors.black'));
    });

    test('generates vercel colors correctly', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.vercel);
      final output = colorValuesTemplate(preset.colors);
      expect(output, contains('class AppColors'));
      expect(output, contains('primary = Color(0xff000000)'));
      expect(output, contains('Colors.black'));
    });

    test('generates apple colors correctly', () {
      final preset = DesignPresetRegistry.resolve(DesignPresetId.apple);
      final output = colorValuesTemplate(preset.colors);
      expect(output, contains('class AppColors'));
      expect(output, contains('primary = Color(0xff007AFF)'));
    });
  });

  group('baseThemeTemplate preset-awareness', () {
    test('includes font family from preset', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
        designPreset: DesignPresetId.vercel,
      );
      final preset = config.resolvedDesignPreset;
      final output = baseThemeTemplate(config, preset.typography, preset.radius);
      expect(output, contains("fontFamily: 'Inter'"));
      expect(output, contains('Radius.circular(2)'));
      expect(output, contains('Radius.circular(4)'));
      expect(output, contains('Radius.circular(6)'));
    });

    test('default preset uses Times New Roman', () {
      final config = ProjectConfig(
        projectName: 'test_app',
        organization: 'com.test',
        description: 'test',
        projectPath: '/tmp/test',
      );
      final preset = config.resolvedDesignPreset;
      final output = baseThemeTemplate(config, preset.typography, preset.radius);
      expect(output, contains("fontFamily: 'Times New Roman'"));
      expect(output, contains('Radius.circular(4)'));
      expect(output, contains('Radius.circular(8)'));
    });
  });
}
