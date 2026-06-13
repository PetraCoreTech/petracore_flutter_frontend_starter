import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaDisplayTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/media_index.dart';


class MediaDisplay extends StatefulWidget {
  const MediaDisplay({
    super.key,
    this.attachedMedia,
    this.media,
    this.index = 0,
  });
  final List<AttachedMedia>? attachedMedia;
  final List<String>? media;
  final int index;

  @override
  State<MediaDisplay> createState() => _MediaDisplayState();
}

class _MediaDisplayState extends State<MediaDisplay> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.attachedMedia ?? [];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item.mediaType.isVideo) {
            return VideoPlayer(url: item.url ?? '');
          }
          return InteractiveViewer(
            child: Center(
              child: PhotoDisplay(
                url: item.url,
                path: item.path,
                fileBytes: item.fileBytes,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
''';
