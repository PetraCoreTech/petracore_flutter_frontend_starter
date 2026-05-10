String paginationStateTemplate(String projectName) => '''
part of 'pagination_bloc.dart';

@immutable
sealed class PaginationState {}

final class PaginationInitial extends PaginationState {}

final class PaginationLoading extends PaginationState {}

final class PaginationResultLoaded<T> extends PaginationState {
  PaginationResultLoaded(this.results);
  final List<T> results;
}

final class PaginationError extends PaginationState {
  PaginationError(this.error);
  final ErrorResponse error;
}
''';
