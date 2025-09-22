import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authHistoryModelTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.projectName}/core/core.dart';

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

extension AuthStatusExtension on AuthStatus {
  String get string {
    final state = this;
    final res = switch (state) {
      AuthStatus.onboarded => 'onboarded',
      AuthStatus.loggedIn => 'logged_in',
      AuthStatus.loggedOut => 'logged_out',
    };
    return res;
  }

  bool get isLoggedIn => this == AuthStatus.loggedIn;

  bool get isLoggedOut => this == AuthStatus.loggedOut;
}

extension AuthStatusStringExtensions on String {
  AuthStatus get authStatus {
    final text = this;
    final state = switch (text) {
      'onboarded' => AuthStatus.onboarded,
      'logged_in' => AuthStatus.loggedIn,
      'logged_out' => AuthStatus.loggedOut,
      String() => AuthStatus.loggedOut,
    };
    return state;
  }
}
''';
