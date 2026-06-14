String businessStatusTemplate() => '''
enum BusinessStatus { operational, closedTemporarily, closedPermanently }

extension BusinessStatusStringExt on String {
  BusinessStatus fromJsonString() {
    return switch (this) {
      'OPERATIONAL' => BusinessStatus.operational,
      'CLOSED_TEMPORARILY' => BusinessStatus.closedTemporarily,
      'CLOSED_PERMANENTLY' => BusinessStatus.closedPermanently,
      _ => BusinessStatus.closedPermanently,
    };
  }
}

extension BusinessStatusExt on BusinessStatus {
  String toJsonString() {
    return switch (this) {
      BusinessStatus.operational => 'OPERATIONAL',
      BusinessStatus.closedTemporarily => 'CLOSED_TEMPORARILY',
      BusinessStatus.closedPermanently => 'CLOSED_PERMANENTLY',
    };
  }
}
''';
