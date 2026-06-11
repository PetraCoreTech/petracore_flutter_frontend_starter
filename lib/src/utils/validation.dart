/// Validators for Dart/Flutter naming conventions.
class Validation {
  static final RegExp _dartPackageNameRegex =
      RegExp(r'^[a-z][a-z0-9_]*[a-z0-9]$');
  static final RegExp _featureNameRegex = RegExp(r'^[a-z][a-z0-9_]*[a-z0-9]$');

  /// Returns `true` if [name] is a valid Dart package name (lowercase, no
  /// consecutive underscores, no reserved words, at least 2 characters).
  static bool isValidDartPackageName(String name) {
    if (name.isEmpty || name.length < 2) return false;
    if (name.startsWith('_') || name.endsWith('_')) return false;
    if (name.contains('__')) return false;

    // Check against Dart reserved words
    const reservedWords = {
      'abstract',
      'as',
      'assert',
      'async',
      'await',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'default',
      'deferred',
      'do',
      'dynamic',
      'else',
      'enum',
      'export',
      'external',
      'extends',
      'factory',
      'false',
      'final',
      'finally',
      'for',
      'function',
      'get',
      'hide',
      'if',
      'implements',
      'import',
      'in',
      'interface',
      'is',
      'late',
      'library',
      'mixin',
      'new',
      'null',
      'on',
      'operator',
      'part',
      'required',
      'rethrow',
      'return',
      'set',
      'show',
      'static',
      'super',
      'switch',
      'sync',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'var',
      'void',
      'while',
      'with',
      'yield'
    };

    if (reservedWords.contains(name)) return false;

    return _dartPackageNameRegex.hasMatch(name);
  }

  /// Returns `true` if [name] is a valid feature name (snake_case, no
  /// consecutive underscores, at least 2 characters).
  static bool isValidFeatureName(String name) {
    if (name.isEmpty || name.length < 2) return false;
    if (name.startsWith('_') || name.endsWith('_')) return false;
    if (name.contains('__')) return false;

    return _featureNameRegex.hasMatch(name);
  }

  /// Returns `true` if [name] is a valid Dart class name (PascalCase, starts
  /// with an uppercase letter).
  static bool isValidClassName(String name) {
    final classNameRegex = RegExp(r'^[A-Z][a-zA-Z0-9]*$');
    return classNameRegex.hasMatch(name);
  }

  /// Returns `true` if [name] is a valid Dart file name (snake_case with
  /// `.dart` extension).
  static bool isValidFileName(String name) {
    final fileNameRegex = RegExp(r'^[a-z][a-z0-9_]*\.dart$');
    return fileNameRegex.hasMatch(name);
  }
}
