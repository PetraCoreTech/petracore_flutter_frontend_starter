String voiceCallScreenTemplate(String projectName) => '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({
    super.key,
    required this.calleeName,
    this.calleeAvatar,
  });

  final String calleeName;
  final String? calleeAvatar;

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  // bool _isCallHeld = false;
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
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            CircleAvatar(
              radius: 56,
              backgroundColor: theme.colorScheme.primaryContainer,
              backgroundImage: widget.calleeAvatar != null
                  ? NetworkImage(widget.calleeAvatar!)
                  : null,
              child: widget.calleeAvatar == null
                  ? Text(
                      widget.calleeName.isNotEmpty
                          ? widget.calleeName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 24),
            Text(
              widget.calleeName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formattedTime,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CallActionButton(
                  icon: Icon(
                    _isMuted ? Icons.mic_off : Icons.mic,
                  ),
                  label: 'Mute',
                  isActive: _isMuted,
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                CallActionButton(
                  icon: Icon(
                    _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  ),
                  label: 'Speaker',
                  isActive: _isSpeakerOn,
                  onTap: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                ),
                CallActionButton(
                  icon: const Icon(Icons.person_add),
                  label: 'Add',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            CallActionButton(
              icon: const Icon(Icons.call_end),
              label: 'End',
              isDestructive: true,
              size: 72,
              iconSize: 32,
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
''';
