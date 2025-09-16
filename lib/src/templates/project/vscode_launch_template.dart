
import '../../generators/project_generator.dart';

String vscodeLaunchTemplate(ProjectConfig config) => '''
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "${config.packageName}",
            "request": "launch",
            "type": "dart"
        },
        {
            "name": "${config.packageName} (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "${config.packageName} (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}
''';
