String checkUserDtoTemplate() => '''
class CheckUserDto {
  const CheckUserDto({required this.target});
  final String target;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['target'] = target;
    return json;
  }
}
''';
