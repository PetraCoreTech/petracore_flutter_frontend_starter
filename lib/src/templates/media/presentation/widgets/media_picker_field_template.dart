import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaPickerFieldTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:${config.packageName}/features/media/presentation/widgets/selected_media_item.dart';

class MediaPickerField extends StatelessWidget {
  const MediaPickerField({
    required this.files,
    required this.onPick,
    required this.onRemove,
    super.key,
    this.label,
    this.title,
    this.maxFiles = 5,
  });
  final List<AttachedMedia> files;
  final VoidCallback onPick;
  final ValueChanged<AttachedMedia> onRemove;
  final String? label;
  final String? title;
  final int maxFiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
          const Gap(8),
        ],
        _AttachmentGrid(
          files: files,
          onRemove: onRemove,
          maxFiles: maxFiles,
          onPick: onPick,
          title: title,
        ),
      ],
    );
  }
}

class UploadedMediaDisplay extends StatelessWidget {
  const UploadedMediaDisplay({
    required this.files,
    required this.onRemove,
    super.key,
    this.label,
  });
  final List<AttachedMedia> files;
  final ValueChanged<AttachedMedia> onRemove;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
          const Gap(8),
        ],
        _AttachmentGrid(
          files: files,
          onRemove: onRemove,
          readOnly: true,
        ),
      ],
    );
  }
}

class _AttachmentGrid extends StatelessWidget {
  const _AttachmentGrid({
    required this.files,
    required this.onRemove,
    this.maxFiles = 5,
    this.onPick,
    this.title,
    this.readOnly = false,
  });
  final List<AttachedMedia> files;
  final ValueChanged<AttachedMedia> onRemove;
  final int maxFiles;
  final VoidCallback? onPick;
  final String? title;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...files.map(
          (file) => SelectedMediaItem(
            url: file.url,
            path: file.path,
            fileBytes: file.fileBytes,
            height: 80,
            width: 80,
            onCancel: readOnly ? null : () => onRemove(file),
          ),
        ),
        if (!readOnly && files.length < maxFiles)
          _AddMediaButton(onPick: onPick, title: title),
      ],
    );
  }
}

class _AddMediaButton extends StatelessWidget {
  const _AddMediaButton({this.onPick, this.title});
  final VoidCallback? onPick;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_photo_alternate_outlined),
            if (title != null)
              Text(title!, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
''';
