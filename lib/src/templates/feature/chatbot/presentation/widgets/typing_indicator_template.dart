String typingIndicatorTemplate(String projectName) => '''
import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({
    super.key,
    this.isVisible = false,
    this.avatarUrl,
  });

  final bool isVisible;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          if (avatarUrl != null)
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(avatarUrl!),
            )
          else
            CircleAvatar(
              radius: 12,
              child: Text(
                'AI',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          const SizedBox(width: 8),
          const _AnimatedDots(),
        ],
      ),
    );
  }
}

class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots();

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final delay = index * 0.15;
        final value =
            ((_controller.value - delay) % 1.0).clamp(0.0, 1.0);
        final scale = 0.5 + (value * 0.5);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
''';
