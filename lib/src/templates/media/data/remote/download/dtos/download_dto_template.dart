String downloadDtoTemplate() => '''
class DownloadDto {
  final String url;
  final String title;

  DownloadDto({required this.url, required this.title});
}
''';
