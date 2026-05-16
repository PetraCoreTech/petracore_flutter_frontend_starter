class PostGenerationOptions {
  final bool runPubGet;
  final bool runBuildRunner;
  final bool runDartFix;

  const PostGenerationOptions({
    this.runPubGet = false,
    this.runBuildRunner = false,
    this.runDartFix = false,
  });

  static const PostGenerationOptions none = PostGenerationOptions();
  static const PostGenerationOptions pubGetOnly = PostGenerationOptions(
    runPubGet: true,
  );
  static const PostGenerationOptions all = PostGenerationOptions(
    runPubGet: true,
    runBuildRunner: true,
    runDartFix: true,
  );
}
