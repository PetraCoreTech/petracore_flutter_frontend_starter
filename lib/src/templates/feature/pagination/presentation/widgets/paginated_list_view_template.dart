String paginatedListViewTemplate(String projectName) => '''
import 'package:flutter/material.dart';

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    required this.isLoading,
    required this.items,
    required this.itemBuilder,
    required this.loadCallback,
    super.key,
    this.separatorBuilder,
  });
  final bool isLoading;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final void Function(int) loadCallback;
  final Widget Function(BuildContext, int)? separatorBuilder;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        final position = controller.position;
        final isAtBottom = position.pixels >= position.maxScrollExtent - 200;
        final atEdge = controller.position.atEdge;
        if (isAtBottom && atEdge && !widget.isLoading) {
          widget.loadCallback(widget.items.length);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemBuilder: (context, index) {
        if (index >= widget.items.length) {
          return widget.isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink();
        }
        return widget.itemBuilder.call(widget.items[index]);
      },
      separatorBuilder:
          widget.separatorBuilder ?? (context, index) => const Divider(),
      itemCount: widget.items.length + 1,
    );
  }
}
''';