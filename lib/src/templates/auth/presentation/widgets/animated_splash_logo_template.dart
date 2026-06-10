import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String animatedSplashLogoTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class AnimatedSplashLogo extends StatefulWidget {
  const AnimatedSplashLogo({
    required this.text,
    this.icon,
    this.iconData,
    this.duration = const Duration(milliseconds: 1500),
    this.iconSize,
    this.textStyle,
    super.key,
  }) : assert(
          icon != null || iconData != null,
          'Either icon or iconData must be provided',
        );

  final Widget? icon;
  final IconData? iconData;
  final String text;
  final Duration duration;
  final double? iconSize;
  final TextStyle? textStyle;

  @override
  State<AnimatedSplashLogo> createState() => _AnimatedSplashLogoState();
}

class _AnimatedSplashLogoState extends State<AnimatedSplashLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounceAnim;
  late final Animation<double> _fadeInAnim;
  late final Animation<double> _compressAnim;
  late final Animation<double> _textFadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _bounceAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
    );

    _fadeInAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    _compressAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.easeInOut),
      ),
    );

    _textFadeAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIcon() {
    if (widget.icon != null) return widget.icon!;
    return Icon(widget.iconData, size: widget.iconSize);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ??
        Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ) ??
        const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: _fadeInAnim.value,
              child: Transform.scale(
                scale: 0.3 + (_bounceAnim.value * 0.7),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(0.08)
                    ..rotateY(-0.08),
                  child: _buildIcon(),
                ),
              ),
            ),
            ClipRect(
              child: Align(
                heightFactor: _compressAnim.value,
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: _textFadeAnim.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(widget.text, style: textStyle),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
''';
