String stringExtensionsTemplate() => '''
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }

  String get camelCase {
    return split('_')
        .map((word) => word.isEmpty ? '' : word.capitalize)
        .join()
        .replaceFirst(this[0], this[0].toLowerCase());
  }

  bool get isValidEmail {
    return RegExp(r'^[\w-\.@]+([\w-]+\.)+[\w-]{2,4}\$').hasMatch(this);
  }
}
''';
