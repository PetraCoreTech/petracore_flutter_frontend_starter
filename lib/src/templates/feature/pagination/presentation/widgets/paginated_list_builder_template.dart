String paginatedListBuilderTemplate(String projectName) => '''
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/pagination/presentation/controllers/pagination_bloc/pagination_bloc.dart';
import 'package:$projectName/features/pagination/presentation/widgets/paginated_list_view.dart';

class PaginatedListBuilder<T, P> extends StatefulWidget {
  const PaginatedListBuilder({
    required this.useCase,
    required this.params,
    required this.items,
    required this.itemBuilder,
    super.key,
    this.separatorBuilder,
    this.onResultLoaded,
    this.initCallback,
    this.shouldPaginate = true,
  });
  final UseCase<List<T>, P> useCase;
  final Params Function(int) params;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final ValueChanged<List<T>>? onResultLoaded;
  final VoidCallback? initCallback;
  final bool shouldPaginate;

  @override
  State<PaginatedListBuilder<T, P>> createState() =>
      _PaginatedListBuilderState<T, P>();
}

class _PaginatedListBuilderState<T, P>
    extends State<PaginatedListBuilder<T, P>> {
  late PaginationBloc<T, P> paginationBloc;

  @override
  void initState() {
    super.initState();
    widget.initCallback?.call();
    paginationBloc = PaginationBloc(useCase: widget.useCase);
  }

  @override
  void dispose() {
    paginationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paginationItems = widget.items;
    return BlocConsumer(
      bloc: paginationBloc,
      listener: (context, state) {
        if (state is PaginationResultLoaded<T> && state.results.isNotEmpty) {
          final test = paginationItems.last;
          if (!state.results.contains(test)) {
            widget.onResultLoaded?.call(state.results);
          }
        }
      },
      builder: (context, state) {
        return PaginatedListView<T>(
          itemBuilder: widget.itemBuilder,
          isLoading: state is PaginationLoading,
          items: paginationItems,
          loadCallback: (index) {
            if (widget.shouldPaginate) {
              final params = widget.params.call(index);
              paginationBloc.add(FetchPaginatedResult(params));
            }
          },
          separatorBuilder: widget.separatorBuilder,
        );
      },
    );
  }
}
''';
