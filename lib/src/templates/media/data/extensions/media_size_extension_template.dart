import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaSizeExtensionTemplate(ProjectConfig config) => '''
enum MediaSizeUnits { bytes, kb, mb, gb, tb }

extension FileSizeDoubleExtension on double {
  String memString() {
    if (this >= 1099511627776) {
      return '\${(this / 1099511627776).toStringAsFixed(2)} TB';
    } else if (this >= 1073741824) {
      return '\${(this / 1073741824).toStringAsFixed(2)} GB';
    } else if (this >= 1048576) {
      return '\${(this / 1048576).toStringAsFixed(2)} MB';
    } else if (this >= 1024) {
      return '\${(this / 1024).toStringAsFixed(2)} KB';
    }
    return '\${toStringAsFixed(0)} B';
  }

  double memSize(MediaSizeUnits unit) {
    switch (unit) {
      case MediaSizeUnits.bytes:
        return this;
      case MediaSizeUnits.kb:
        return this / 1024;
      case MediaSizeUnits.mb:
        return this / 1048576;
      case MediaSizeUnits.gb:
        return this / 1073741824;
      case MediaSizeUnits.tb:
        return this / 1099511627776;
    }
  }
}

class FileSizeCalculator {
  static String formatBytes(int bytes) {
    if (bytes >= 1099511627776) {
      return '\${(bytes / 1099511627776).toStringAsFixed(2)} TB';
    } else if (bytes >= 1073741824) {
      return '\${(bytes / 1073741824).toStringAsFixed(2)} GB';
    } else if (bytes >= 1048576) {
      return '\${(bytes / 1048576).toStringAsFixed(2)} MB';
    } else if (bytes >= 1024) {
      return '\${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '\$bytes B';
  }
}
''';
