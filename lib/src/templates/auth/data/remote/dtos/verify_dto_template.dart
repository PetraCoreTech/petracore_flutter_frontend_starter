String verifyDtoTemplate() => '''
class VerifyDto {
  const VerifyDto({required this.target, required this.value});
  
  final String target;
  final String value;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['target'] = target;
    json['value'] = value;
    return json;
  }
}
''';
