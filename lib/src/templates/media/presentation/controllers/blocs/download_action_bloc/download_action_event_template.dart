import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadActionEventTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/presentation/entities/download_entity.dart';
import 'package:equatable/equatable.dart';

sealed class DownloadActionEvent extends Equatable {
  const DownloadActionEvent();

  @override
  List<Object?> get props => [];
}

final class DownloadSingleFile extends DownloadActionEvent {
  final DownloadEntity data;
  const DownloadSingleFile(this.data);

  @override
  List<Object?> get props => [data];
}

final class DownloadMultipleFiles extends DownloadActionEvent {
  final List<DownloadEntity> data;
  const DownloadMultipleFiles(this.data);

  @override
  List<Object?> get props => [data];
}
''';
