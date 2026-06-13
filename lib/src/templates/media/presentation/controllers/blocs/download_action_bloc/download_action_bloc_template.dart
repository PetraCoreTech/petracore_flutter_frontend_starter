import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadActionBlocTemplate(ProjectConfig config) => '''
import 'package:equatable/equatable.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/media_index.dart';


part 'download_action_event.dart';
part 'download_action_state.dart';

final downloadActionBloc = DownloadActionBloc();

class DownloadActionBloc
    extends Bloc<DownloadActionEvent, DownloadActionState> {
  DownloadActionBloc() : super(const DownloadActionInitial()) {
    on<DownloadSingleFile>(_onDownloadSingleFile);
    on<DownloadMultipleFiles>(_onDownloadMultipleFiles);
  }

  Future<void> _onDownloadSingleFile(
    DownloadSingleFile event,
    Emitter<DownloadActionState> emit,
  ) async {
    emit(const DownloadActionLoading());
    final dto = DownloadDto(url: event.data.url, title: event.data.title);
    final result = await singleDownloadUseCase(dto);
    result.fold(
      (response) => emit(DownloadSuccessful(response)),
      (error) => emit(DownloadActionError(error)),
    );
  }

  Future<void> _onDownloadMultipleFiles(
    DownloadMultipleFiles event,
    Emitter<DownloadActionState> emit,
  ) async {
    emit(const DownloadActionLoading());
    final dtos = event.data
        .map((e) => DownloadDto(url: e.url, title: e.title))
        .toList();
    final result = await multipleDownloadUseCase(dtos);
    result.fold(
      (response) => emit(DownloadSuccessful(response)),
      (error) => emit(DownloadActionError(error)),
    );
  }
}
''';
