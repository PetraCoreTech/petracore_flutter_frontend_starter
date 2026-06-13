import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaListExtensionTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';

extension MediaListExtension<T extends Object> on List<T> {
  List<T> checkForMaxSizedMedia() {
    final oversized = <T>[];
    for (final item in this) {
      if (item is Map<String, dynamic>) {
        final size = item['size'];
        final type = item['mediaType'];
        if (size != null && type is MediaType) {
          if ((size as num).toDouble() > type.maxSize()) {
            oversized.add(item);
          }
        }
      }
    }
    return oversized;
  }
}
''';
