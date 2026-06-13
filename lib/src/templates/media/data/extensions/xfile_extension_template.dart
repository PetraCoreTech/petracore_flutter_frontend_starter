import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String xfileExtensionTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';
import 'package:image_picker/image_picker.dart';

class MediaSize {
  MediaSize({
    required this.name,
    required this.size,
    required this.type,
    required this.path,
  });
  final String name;
  final double size;
  final MediaType type;
  final String path;
}

extension XFileExtension on Iterable<XFile> {
  List<MediaSize> fileSizeList() {
    return map((file) {
      final fileType = file.name.mediaType;
      return MediaSize(
        name: file.name,
        size: 0,
        type: fileType,
        path: file.path,
      );
    }).toList();
  }
}
''';
