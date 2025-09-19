String listExtensionTemplate() => """
extension ListExtensions<T extends Comparable<dynamic>> on List<T> {
  bool equals(List<T> list) {
    final a = this;

    // Check the lengths of  both lists
    if (a.length != list.length) {
      return false;
    }

    // check the content of both lists
    for (var i = 0; i < a.length; i++) {
      if (a[i] != list[i]) {
        return false;
      }
    }
    return true;
  }

  T? min() {
    final a = this;
    var minValue = a.first;

    for (final value in this) {
      if (value.compareTo(minValue) < 0) {
        minValue = value;
      }
    }
    return minValue;
  }

  T? max() {
    final a = this;
    var maxValue = a.first;

    for (final value in this) {
      if (value.compareTo(maxValue) > 0) {
        maxValue = value;
      }
    }
    return maxValue;
  }
}
""";
