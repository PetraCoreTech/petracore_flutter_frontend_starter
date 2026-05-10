String paginationBlocTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc<T, P> extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc({
    required this.useCase,
  }) : super(PaginationInitial()) {
    on<FetchPaginatedResult<P>>(_fetchResult);
  }
  final UseCase<List<T>, P> useCase;

  Future<void> _fetchResult(
    FetchPaginatedResult<P> event,
    Emitter<PaginationState> emit,
  ) async {
    emit(PaginationLoading());
    final res = await useCase.call(event.params);
    res.fold(
      (l) => emit(PaginationResultLoaded(l)),
      (r) => emit(PaginationError(r)),
    );
  }
}
''';
