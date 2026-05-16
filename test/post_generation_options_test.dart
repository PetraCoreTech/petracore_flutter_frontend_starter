import 'package:petracore_flutter_frontend_starter/src/utils/post_generation_options.dart';
import 'package:test/test.dart';

void main() {
  group('PostGenerationOptions', () {
    test('none has all flags false', () {
      expect(PostGenerationOptions.none.runPubGet, isFalse);
      expect(PostGenerationOptions.none.runBuildRunner, isFalse);
      expect(PostGenerationOptions.none.runDartFix, isFalse);
    });

    test('pubGetOnly has only pubGet true', () {
      expect(PostGenerationOptions.pubGetOnly.runPubGet, isTrue);
      expect(PostGenerationOptions.pubGetOnly.runBuildRunner, isFalse);
      expect(PostGenerationOptions.pubGetOnly.runDartFix, isFalse);
    });

    test('all has all flags true', () {
      expect(PostGenerationOptions.all.runPubGet, isTrue);
      expect(PostGenerationOptions.all.runBuildRunner, isTrue);
      expect(PostGenerationOptions.all.runDartFix, isTrue);
    });

    test('custom options work correctly', () {
      final opts = PostGenerationOptions(
        runPubGet: true,
        runBuildRunner: false,
        runDartFix: true,
      );
      expect(opts.runPubGet, isTrue);
      expect(opts.runBuildRunner, isFalse);
      expect(opts.runDartFix, isTrue);
    });
  });
}
