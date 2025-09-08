#!/bin/bash

# PetraCore Flutter Frontend Starter Installation Script

set -e

echo "🏗️  Installing PetraCore Flutter Frontend Starter..."

# Check if Dart is installed
if ! command -v dart &> /dev/null; then
    echo "❌ Dart is not installed. Please install Flutter/Dart first."
    echo "   Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check if Flutter is installed  
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "   Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Dart and Flutter found"

# Install the package globally
echo "📦 Installing PetraCore CLI globally..."
dart pub global activate petracore_flutter_frontend_starter

# Check if pub cache is in PATH
if ! echo $PATH | grep -q "/.pub-cache/bin"; then
    echo ""
    echo "⚠️  Warning: Pub cache bin directory is not in your PATH"
    echo "   Add this to your shell profile (.bashrc, .zshrc, etc.):"
    echo "   export PATH=\"\$PATH\":\"\$HOME/.pub-cache/bin\""
    echo ""
fi

# Test installation
echo "🧪 Testing installation..."
if command -v petracore &> /dev/null; then
    echo "✅ PetraCore CLI installed successfully!"
    echo ""
    echo "🎉 You're ready to go! Try these commands:"
    echo ""
    echo "   petracore --help                    # Show help"
    echo "   petracore init my_awesome_app       # Create new project"
    echo "   petracore feature auth              # Generate auth feature"
    echo ""
    echo "Happy coding! 🚀"
else
    echo "❌ Installation failed. Please check the error messages above."
    exit 1
fi
