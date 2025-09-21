import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String userModelTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.projectName}/core/data/models/base_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User extends BaseModel{
  const User({
    required super.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    this.image,
    this.phoneNumber,
    super.dateCreated,
    super.lastUpdated,
  });
  
  factory User.fromJson(Map<String, dynamic> json) => _\$UserFromJson(json);

  final String email;
  @JsonKey(name: 'first_name')
  final String firstname;
  @JsonKey(name: 'last_name')
  final String lastname;
  final String? image;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber; 
  
  Map<String, dynamic> toJson() => _\$UserToJson(this);
  
  static User? maybeFromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return User.fromJson(json);
    }
    return null;
  }
}
''';
