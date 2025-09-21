import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authHistoryModelTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

part 'auth_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthHistory {
  AuthHistory({required this.authStatus, required this.timeStamp});
  factory AuthHistory.fromJson(Map<String, dynamic> json) =>
      _\$AuthHistoryFromJson(json);

  final AuthStatus authStatus;
  final DateTime timeStamp;

  static AuthHistory? maybeFromJson(Json? json) {
    if (json != null) {
      return AuthHistory.fromJson(json);
    }
    return null;
  }

  Map<String, dynamic> toJson() => _\$AuthHistoryToJson(this);
}

enum AuthStatus { onboarded, loggedIn, loggedOut }
''';
