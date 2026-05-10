import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String selectedMediaItemTemplate(ProjectConfig config) => '''
import 'dart:io';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/presentation/widgets/photo_display.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';

class SelectedMediaItem extends StatelessWidget {
  final String? url;
  final String? path;
  final File? file;
  final Uint8List? fileBytes;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double radius;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  const SelectedMediaItem({
    super.key,
    this.url,
    this.path,
    this.file,
    this.fileBytes,
    this.height,
    this.width,
    this.fit,
    this.radius = 8,
    this.onTap,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = _isVideo();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: _buildContent(isVideo),
          ),
        ),
        if (onCancel != null)
          Positioned(
            right: -6,
            top: -6,
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
        if (isVideo)
          Positioned.fill(
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(bool isVideo) {
    if (fileBytes != null) {
      return Image.memory(fileBytes!, height: height, width: width, fit: fit ?? BoxFit.cover);
    }
    if (file != null) {
      return Image.file(file!, height: height, width: width, fit: fit ?? BoxFit.cover);
    }
    if (path != null) {
      return Image.file(File(path!), height: height, width: width, fit: fit ?? BoxFit.cover);
    }
    if (url != null && url!.isNotEmpty) {
      return PhotoDisplay(url: url, height: height, width: width, fit: fit);
    }
    return Container(
      height: height ?? 80,
      width: width ?? 80,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image),
    );
  }

  bool _isVideo() {
    final name = url ?? path ?? '';
    return name.mediaType.isVideo;
  }
}
''';
