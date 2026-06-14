import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String authSetupGuideTemplate(ProjectConfig config) => '''# Auth Feature Setup Guide

## 1. Register Bloc Provider
In \`lib/app/shared/bloc_provider.dart\`, add:
\`\`\`dart
import 'package:${config.packageName}/features/auth/presentation/controllers/auth_controller_index.dart';
\`\`\`
And add \`...authBlocProvider,\` inside your providers list.

## 2. Add Routes
In your router configuration, add the auth routes:
\`\`\`dart
import 'package:${config.packageName}/features/auth/presentation/screens/auth_routes.dart';
\`\`\`
Then add \`authRoutes\` to your route list.

## 3. Configure API Base URL
Set your API base URL in environment variables or \`env.json\`:
\`\`\`json
{
  "base_url": "https://your-api.com/api/v1"
}
\`\`\`

## 4. Run Build Runner
\`\`\`bash
dart run build_runner build
\`\`\`
''';
