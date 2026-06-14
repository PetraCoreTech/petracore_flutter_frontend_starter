/// Configuration for post-generation steps to run after scaffolding.
class PostGenerationOptions {
  /// Whether to run `flutter pub get` after generation.
  final bool runPubGet;

  /// Whether to run `dart run build_runner build` after generation.
  final bool runBuildRunner;

  /// Whether to run `dart fix --apply` after generation.
  final bool runDartFix;

  /// When `true`, steps are logged but not executed.
  final bool dryRun;

  /// Creates a [PostGenerationOptions] with all options disabled by default.
  const PostGenerationOptions({
    this.runPubGet = false,
    this.runBuildRunner = false,
    this.runDartFix = false,
    this.dryRun = false,
  });

  /// No post-generation steps will run.
  static const PostGenerationOptions none = PostGenerationOptions();

  /// Only `flutter pub get` will run after generation.
  static const PostGenerationOptions pubGetOnly = PostGenerationOptions(
    runPubGet: true,
  );

  /// Only `dart fix --apply` will run after generation.
  static const PostGenerationOptions dartFixOnly = PostGenerationOptions(
    runDartFix: true,
  );

  /// `flutter pub get` and `dart fix --apply` will run after generation.
  static const PostGenerationOptions pubGetAndDartFix = PostGenerationOptions(
    runPubGet: true,
    runDartFix: true,
  );

  /// All post-generation steps (`pub get`, `build_runner`, `dart fix`) will run.
  static const PostGenerationOptions all = PostGenerationOptions(
    runPubGet: true,
    runBuildRunner: true,
    runDartFix: true,
  );
}
