String routeModelTemplate() => '''
class AppRoute {
  const AppRoute({required this.path, this.name = ''});
  final String name;
  final String path;
}
''';
