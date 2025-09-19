String boolExtensionTemplate() => """
extension BoolExtensions on String {
    String polarString() {
    return switch (this) {
      true => 'Yes',
      false => 'No',
    };
  }
""";
