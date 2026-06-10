String paginationEventTemplate(String projectName) => '''
part of 'pagination_bloc.dart';

@immutable
sealed class PaginationEvent {}

final class FetchPaginatedResult<P> extends PaginationEvent {
  FetchPaginatedResult(this.params);
  final Params params;
}
''';
