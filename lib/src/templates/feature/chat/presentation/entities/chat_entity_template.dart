String chatEntityTemplate(String projectName) => '''
class ChatEntity {
  ChatEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.image,
  });
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? image;

  String? get fullName {
    if (firstName != null && lastName != null) {
      return '\$firstName \$lastName';
    }
    return firstName ?? lastName ?? email;
  }
}
''';
