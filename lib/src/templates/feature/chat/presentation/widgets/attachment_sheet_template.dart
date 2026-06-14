String attachmentSheetTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:$projectName/core/core.dart';

enum AttachmentType { gallery, camera, document, audio }

class AttachmentSheet extends StatelessWidget {
  const AttachmentSheet({
    super.key,
    required this.onFilePicked,
  });

  final void Function(XFile file, AttachmentType type) onFilePicked;

  static final _picker = ImagePicker();

  static Future<void> show(
    BuildContext context, {
    required void Function(XFile file, AttachmentType type) onFilePicked,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AttachmentSheet(onFilePicked: onFilePicked),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 80);
    if (file != null) {
      onFilePicked(file, AttachmentType.gallery);
    }
  }

  Future<void> _pickVideo() async {
    final file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      onFilePicked(file, AttachmentType.gallery);
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      onFilePicked(result.files.first.xFile, AttachmentType.document);
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      onFilePicked(result.files.first.xFile, AttachmentType.audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Share',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentItem(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  color: Colors.purple,
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                _AttachmentItem(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: Colors.orange,
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _AttachmentItem(
                  icon: Icons.videocam,
                  label: 'Video',
                  color: Colors.blue,
                  onTap: _pickVideo,
                ),
                _AttachmentItem(
                  icon: Icons.insert_drive_file,
                  label: 'Document',
                  color: Colors.teal,
                  onTap: _pickDocument,
                ),
                _AttachmentItem(
                  icon: Icons.music_note,
                  label: 'Audio',
                  color: Colors.pink,
                  onTap: _pickAudio,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}
''';
