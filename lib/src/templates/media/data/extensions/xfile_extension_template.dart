import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String xfileExtensionTemplate(ProjectConfig config) => '''
import 'package:image_picker/image_picker.dart';
import 'package:${config.packageName}/features/media/media_index.dart';

class MediaSize {
  MediaSize({
    required this.name,
    required this.size,
    required this.path,
    this.mimeType,
  });
  final String name;
  final double size;
  final String? mimeType;
  final String path;
}

extension XFileExtension on Iterable<XFile> {
  List<MediaSize> fileSizeList() {
    return map((file) {
      return MediaSize(
        name: file.name,
        size: 0,
        mimeType: file.mimeType,
        path: file.path,
      );
    }).toList();
  }
}
''';
