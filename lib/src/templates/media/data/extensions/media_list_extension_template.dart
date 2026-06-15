import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaListExtensionTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';

extension MediaListExtension<T extends Object> on List<T> {
  List<T> checkForMaxSizedMedia() {
    final oversized = <T>[];
    for (final item in this) {
      if (item is Map<String, dynamic>) {
        final size = item['size'];
        final mime = item['mimeType'] as String?;
        if (size != null && mime != null) {
          if ((size as num).toDouble() > _maxSizeForMime(mime)) {
            oversized.add(item);
          }
        }
      }
    }
    return oversized;
  }

  double _maxSizeForMime(String mime) {
    if (mime.startsWith('image/')) return 5;
    if (mime.startsWith('video/')) return 100;
    if (mime.startsWith('audio/')) return 20;
    return 10;
  }
}
''';
