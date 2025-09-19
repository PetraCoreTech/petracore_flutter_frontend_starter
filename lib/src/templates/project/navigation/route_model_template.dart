String routeModelTemplate() => '''
class Route {
  const Route({required this.path, this.name = ''});
  final String name;
  final String path;
}
''';
