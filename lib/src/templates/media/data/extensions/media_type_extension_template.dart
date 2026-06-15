import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaTypeExtensionTemplate(ProjectConfig config) => '''
extension FileExtensionToMime on String {
  String? get mimeType {
    final ext = split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      case 'mp4':
        return 'video/mp4';
      case 'mkv':
        return 'video/x-matroska';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'pdf':
        return 'application/pdf';
      case 'zip':
        return 'application/zip';
      case 'rar':
        return 'application/vnd.rar';
      case 'json':
        return 'application/json';
      case 'html':
        return 'text/html';
      case 'dmg':
        return 'application/x-apple-diskimage';
      case 'exe':
        return 'application/x-msdownload';
      default:
        return 'application/octet-stream';
    }
  }
}

extension MimeTypeChecks on String? {
  bool get isVideo => this?.startsWith('video/') == true;
  bool get isImage => this?.startsWith('image/') == true;
  bool get isAudio => this?.startsWith('audio/') == true;
}
''';
