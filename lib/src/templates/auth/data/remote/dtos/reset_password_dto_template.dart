String resetPasswordDtoTemplate() => '''
class ResetPasswordDto {
  const ResetPasswordDto({
    required this.email,
    required this.password,
    this.token,
  });
  final String email;
  final String password;
  final String? token;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['email'] = email;
    json['password'] = password;
    if(token != null) json['token'] = token;
    return json;
  }
}
''';
