import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadActionEventTemplate(ProjectConfig config) => '''
part of 'download_action_bloc.dart';

sealed class DownloadActionEvent extends Equatable {
  const DownloadActionEvent();

  @override
  List<Object?> get props => [];
}

final class DownloadSingleFile extends DownloadActionEvent {
  const DownloadSingleFile(this.data);
  final DownloadEntity data;

  @override
  List<Object?> get props => [data];
}

final class DownloadMultipleFiles extends DownloadActionEvent {
  const DownloadMultipleFiles(this.data);
  final List<DownloadEntity> data;

  @override
  List<Object?> get props => [data];
}
''';
