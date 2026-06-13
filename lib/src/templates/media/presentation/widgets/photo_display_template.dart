import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String photoDisplayTemplate(ProjectConfig config) => '''
import 'dart:io';
import 'dart:typed_data';
import 'package:${config.packageName}/core/core.dart';

class PhotoDisplay extends StatelessWidget {
  const PhotoDisplay({
    super.key,
    this.url,
    this.path,
    this.fileBytes,
    this.height,
    this.width,
    this.fit,
    this.onTap,
    this.hasBorder = false,
  });
  final String? url;
  final String? path;
  final Uint8List? fileBytes;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final VoidCallback? onTap;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: hasBorder ? Border.all(color: Colors.grey.shade300) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (fileBytes != null) {
      return Image.memory(fileBytes!, fit: fit ?? BoxFit.cover);
    }
    if (path != null) {
      return Image.file(File(path!), fit: fit ?? BoxFit.cover);
    }
    if (url != null && url!.isNotEmpty) {
      return Image.network(
        url!,
        fit: fit ?? BoxFit.cover,
        loadingBuilder: (_, child, progress) =>
            progress == null ? child : const Center(child: CircularProgressIndicator()),
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }
    return const Center(child: Icon(Icons.image, size: 48));
  }
}
''';
