import 'package:petracore_flutter_frontend_starter/src/commands/feature_command.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/post_generation_options.dart';
import 'package:test/test.dart';

void main() {
  group('FeatureCommand post-generation', () {
    late FeatureCommand command;

    setUp(() {
      command = FeatureCommand();
    });

    test('wasPostGenerationCalled is initially false', () {
      expect(command.wasPostGenerationCalled, isFalse);
    });

    test('runPostGenerationSteps sets wasPostGenerationCalled when autoRunPostGeneration is disabled', () async {
      command.autoRunPostGeneration = false;
      expect(command.wasPostGenerationCalled, isFalse);

      await command.runPostGenerationSteps(
        const PostGenerationOptions(runDartFix: true),
      );

      expect(command.wasPostGenerationCalled, isTrue);
    });

    test('runPostGenerationSteps sets wasPostGenerationCalled with all options disabled', () async {
      command.autoRunPostGeneration = false;
      expect(command.wasPostGenerationCalled, isFalse);

      await command.runPostGenerationSteps(PostGenerationOptions.none);

      expect(command.wasPostGenerationCalled, isTrue);
    });

    test('runPostGenerationSteps does not throw when autoRunPostGeneration is false', () async {
      command.autoRunPostGeneration = false;

      await expectLater(
        () => command.runPostGenerationSteps(
          const PostGenerationOptions(
            runPubGet: true,
            runDartFix: true,
            runBuildRunner: true,
          ),
        ),
        returnsNormally,
      );
    });

    test('autoRunPostGeneration is true by default', () {
      expect(command.autoRunPostGeneration, isTrue);
    });
  });
}
