import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadActionBlocTemplate(ProjectConfig config) => '''
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/media_index.dart';

part 'upload_action_event.dart';
part 'upload_action_state.dart';

final uploadActionBloc = UploadActionBloc();

class UploadActionBloc extends Bloc<UploadActionEvent, UploadActionState> {
  UploadActionBloc() : super(const UploadActionInitial()) {
    on<UploadSingleFile>(_onUploadSingleFile);
    on<UploadMultipleFiles>(_onUploadMultipleFiles);
    on<DeleteUpload>(_onDeleteUpload);
  }

  Future<void> _onUploadSingleFile(
    UploadSingleFile event,
    Emitter<UploadActionState> emit,
  ) async {
    emit(const UploadActionLoading());
    final dto = FileUploadDto(
      path: event.file.path,
      name: event.file.name,
      size: event.file.size,
      mimeType: event.file.mimeType,
    );
    final params = UploadParams(uploadDto: dto);
    final result = await singleUploadUseCase(params);
    result.fold(
      (file) => emit(FileUploaded(file)),
      (error) => emit(UploadActionError(error)),
    );
  }

  Future<void> _onUploadMultipleFiles(
    UploadMultipleFiles event,
    Emitter<UploadActionState> emit,
  ) async {
    emit(const UploadActionLoading());
    final dtos = event.files
        .map((f) => FileUploadDto(
              path: f.path,
              name: f.name,
              size: f.size,
              mimeType: f.mimeType,
            ))
        .toList();
    final params = MultipleUploadParams(files: dtos);
    final result = await multipleUploadUseCase(params);
    result.fold(
      (files) => emit(FilesUploaded(files)),
      (error) => emit(UploadActionError(error)),
    );
  }

  Future<void> _onDeleteUpload(
    DeleteUpload event,
    Emitter<UploadActionState> emit,
  ) async {
    emit(const UploadActionLoading());
    final dto = DeleteUploadDto(
      publicId: event.publicId,
      url: event.url,
      publicIds: event.publicIds,
      urls: event.urls,
      isMultiple: event.isMultiple,
    );
    final result = await deleteUploadUseCase(dto);
    result.fold(
      (response) => emit(UploadDeleted(response)),
      (error) => emit(UploadActionError(error)),
    );
  }
}
''';
