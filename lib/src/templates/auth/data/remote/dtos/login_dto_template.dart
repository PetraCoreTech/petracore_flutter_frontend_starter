String loginDtoTemplate() => '''
class LoginDto {
  const LoginDto({
    required this.email,
    required this.password,
    this.deviceToken,
    this.deviceType,
  });
  
  final String email;
  final String password;
  final String? deviceType;
  final String? deviceToken;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['email'] = email;
    json['password'] = password;
    if (deviceToken != null) json['device_token'] = deviceToken;
    if (deviceType != null) json['device_type'] = deviceType;
    return json;
  }
}
''';
