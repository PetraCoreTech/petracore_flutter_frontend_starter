String boolExtensionTemplate() => """
extension BoolExtensions on bool {
  String polarString() {
    return switch (this) {
      true => 'Yes',
      false => 'No',
    };
  }
}
""";
