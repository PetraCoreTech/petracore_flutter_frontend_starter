String downloadDtoTemplate() => '''
class DownloadDto {
  DownloadDto({required this.url, required this.title});
  final String url;
  final String title;
}
''';
