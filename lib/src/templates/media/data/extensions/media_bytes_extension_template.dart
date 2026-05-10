import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaBytesExtensionTemplate(ProjectConfig config) => '''
import 'dart:typed_data';

extension FileBytesExtension on Uint8List {
  String getMimeTypeFromBytes() {
    if (length < 4) return 'application/octet-stream';
    if (this[0] == 0x89 && this[1] == 0x50 && this[2] == 0x4E && this[3] == 0x47) {
      return 'image/png';
    }
    if (this[0] == 0xFF && this[1] == 0xD8 && this[2] == 0xFF) {
      return 'image/jpeg';
    }
    if (this[0] == 0x52 && this[1] == 0x49 && this[2] == 0x46 && this[3] == 0x46) {
      return 'image/webp';
    }
    if (this[0] == 0x47 && this[1] == 0x49 && this[2] == 0x46) {
      return 'image/gif';
    }
    if (this[0] == 0x25 && this[1] == 0x50 && this[2] == 0x44 && this[3] == 0x46) {
      return 'application/pdf';
    }
    if (this[0] == 0x50 && this[1] == 0x4B) {
      return 'application/zip';
    }
    return 'application/octet-stream';
  }
}
''';
