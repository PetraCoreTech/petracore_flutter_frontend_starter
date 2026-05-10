import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaTypeExtensionTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';

extension FileTypeExtension on MediaType {
  bool get isVideo => this == MediaType.mp4 || this == MediaType.mkv;
  bool get isImage =>
      this == MediaType.jpeg ||
      this == MediaType.jpg ||
      this == MediaType.png ||
      this == MediaType.svg;
  double maxSize() {
    switch (this) {
      case MediaType.jpeg:
      case MediaType.jpg:
      case MediaType.png:
        return 5;
      case MediaType.mp4:
        return 100;
      case MediaType.mp3:
        return 20;
      default:
        return 10;
    }
  }
}

extension MediaTypeStringExt on String {
  String mediaMimeType() => split('.').last;
  MediaType get mediaType {
    final ext = split('.').last.toLowerCase();
    switch (ext) {
      case 'mp3':
        return MediaType.mp3;
      case 'mp4':
        return MediaType.mp4;
      case 'jpeg':
        return MediaType.jpeg;
      case 'jpg':
        return MediaType.jpg;
      case 'pdf':
        return MediaType.pdf;
      case 'png':
        return MediaType.png;
      case 'html':
        return MediaType.html;
      case 'zip':
        return MediaType.zip;
      case 'json':
        return MediaType.json;
      case 'dmg':
        return MediaType.dmg;
      case 'exe':
        return MediaType.exe;
      case 'mkv':
        return MediaType.mkv;
      case 'svg':
        return MediaType.svg;
      default:
        return MediaType.text;
    }
  }
}
''';
