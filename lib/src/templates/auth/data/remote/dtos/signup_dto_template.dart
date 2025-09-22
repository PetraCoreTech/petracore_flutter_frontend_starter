String signupDtoTemplate() => '''
class SignupDto {
  const SignupDto({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.gender,
    this.deviceToken,
    this.deviceType,
    this.phoneNumber,
    this.image,
  });
  
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String? gender;
  final String? deviceType;
  final String? deviceToken;
  final String? image;
  final String? phoneNumber;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['lastname'] = lastname;
    json['firstname'] = firstname;
    json['email'] = email;
    json['password'] = password;
    if (gender != null) json['gender'] = gender;
    if (image != null) json['image'] = image;
    if (phoneNumber != null) json['phone'] = phoneNumber;
    if (deviceToken != null) json['device_token'] = deviceToken;
    if (deviceType != null) json['device_type'] = deviceType;
    return json;
  }
}
''';
