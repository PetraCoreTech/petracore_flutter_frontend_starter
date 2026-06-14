import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaSetupGuideTemplate(ProjectConfig config) => '''# Media Feature Setup Guide

## 1. Environment Variables
Add to your build command or \`.env\`:
\`\`\`
CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_SECRET_KEY=your_api_secret
\`\`\`

Or add to \`env.json\`:
\`\`\`json
{
  "cloud_name": "your_cloud_name",
  "cloudinary_api_key": "your_api_key",
  "cloudinary_api_secret": "your_api_secret"
}
\`\`\`

## 2. Run Build Runner
\`\`\`bash
dart run build_runner build
\`\`\`

## 3. Usage
Use \`MediaHelper\` to pick and display media throughout your app.
''';
