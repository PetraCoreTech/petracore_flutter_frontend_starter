String intExtensionTemplate() => """
extension IntExtensions on int {
  String get alphabet {
    if (this < 0) {
      throw ArgumentError('Integer must be positive');
    }
    // Determine the alphabet range (1-26 for A-Z, 27-52 for a-z, etc.)
    final adjustedValue = this; // Adjust to zero-based index
    const alphabetSize = 26;

    // Calculate which cycle of the alphabet the number falls into
    final cycle = adjustedValue ~/ alphabetSize;
    final position = adjustedValue % alphabetSize;

    if (cycle.isEven) {
      // Even cycles use uppercase letters
      return String.fromCharCode(65 + position); // 65 is ASCII for 'A'
    } else {
      // Odd cycles use lowercase letters
      return String.fromCharCode(97 + position); // 97 is ASCII for 'a'
    }
  }

  String ordinal() {
    final day = this;
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
""";
