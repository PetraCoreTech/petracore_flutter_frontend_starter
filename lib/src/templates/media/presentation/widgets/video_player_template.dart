import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String videoPlayerTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({required this.url, super.key});
  final String url;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
''';
