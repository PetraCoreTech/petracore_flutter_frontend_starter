String videoCallScreenTemplate(String projectName) => '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({
    super.key,
    required this.calleeName,
    this.calleeAvatar,
  });

  final String calleeName;
  final String? calleeAvatar;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isCameraOn = true;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  String get _formattedTime {
    final min = (_seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (_seconds % 60).toString().padLeft(2, '0');
    return '\$min:\$sec';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(),
                Text(
                  widget.calleeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formattedTime,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CallActionButton(
                            icon: Icon(
                              _isMuted ? Icons.mic_off : Icons.mic,
                              color: Colors.white,
                            ),
                            isActive: _isMuted,
                            onTap: () =>
                                setState(() => _isMuted = !_isMuted),
                          ),
                          CallActionButton(
                            icon: Icon(
                              _isCameraOn
                                  ? Icons.videocam
                                  : Icons.videocam_off,
                              color: Colors.white,
                            ),
                            isActive: _isCameraOn,
                            onTap: () =>
                                setState(() => _isCameraOn = !_isCameraOn),
                          ),
                          CallActionButton(
                            icon: const Icon(
                              Icons.call_end,
                              color: Colors.white,
                            ),
                            isDestructive: true,
                            size: 72,
                            iconSize: 32,
                            onTap: () => Navigator.pop(context),
                          ),
                          CallActionButton(
                            icon: const Icon(
                              Icons.volume_up,
                              color: Colors.white,
                            ),
                            isActive: _isSpeakerOn,
                            onTap: () => setState(
                                () => _isSpeakerOn = !_isSpeakerOn),
                          ),
                          CallActionButton(
                            icon: const Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white54,
                    size: 48,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
