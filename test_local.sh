#!/bin/bash

# PetraCore Flutter Frontend Starter - Local Testing Script
# This script helps you test the CLI locally without publishing

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLI_PATH="$SCRIPT_DIR/bin/main.dart"

echo -e "${BLUE}🏗️  PetraCore Local Testing Script${NC}"
echo -e "${BLUE}=======================================${NC}"

# Function to run CLI commands
# NOTE: --verbose is a global flag and must come BEFORE the subcommand
run_cli() {
    echo -e "${YELLOW}Running: dart run $CLI_PATH $@${NC}"
    dart run "$CLI_PATH" "$@"
}

# Function to clean up test directory
cleanup() {
    if [ -d "$HOME/StudioProjects/petracore_local_test" ]; then
        echo -e "${YELLOW}🧹 Cleaning up previous test directory...${NC}"
        rm -rf "$HOME/StudioProjects/petracore_local_test"
    fi
}

# Function to setup test environment
setup() {
    echo -e "${BLUE}📦 Setting up dependencies...${NC}"
    cd "$SCRIPT_DIR"
    dart pub get
    
    echo -e "${BLUE}📁 Creating test directory...${NC}"
    mkdir -p "$HOME/StudioProjects/petracore_local_test"
    cd "$HOME/StudioProjects/petracore_local_test"
}

# Function to test project initialization
test_init() {
    echo -e "${GREEN}🧪 Testing Project Initialization${NC}"
    echo -e "${GREEN}=================================${NC}"
    
    # --verbose before the subcommand (global flag)
    run_cli --verbose init test_app --force --no-interactive --design-preset apple
    
    if [ -d "test_app" ]; then
        echo -e "${GREEN}✅ Project initialization: PASSED${NC}"
        cd test_app
    else
        echo -e "${RED}❌ Project initialization: FAILED${NC}"
        exit 1
    fi
    
    # Verify managed regions exist in generated files
    if grep -q "petracore:start:feature_routes" lib/navigation/router.dart; then
        echo -e "${GREEN}✅ Managed region 'feature_routes' present in router.dart${NC}"
    else
        echo -e "${RED}❌ Managed region 'feature_routes' missing from router.dart${NC}"
        exit 1
    fi
    
    if grep -q "petracore:start:route_constants" lib/navigation/routes.dart; then
        echo -e "${GREEN}✅ Managed region 'route_constants' present in routes.dart${NC}"
    else
        echo -e "${RED}❌ Managed region 'route_constants' missing from routes.dart${NC}"
        exit 1
    fi
    
    if grep -q "petracore:start:bloc_providers" lib/features/shared/presentation/controllers/bloc_provider.dart; then
        echo -e "${GREEN}✅ Managed region 'bloc_providers' present in bloc_provider.dart${NC}"
    else
        echo -e "${RED}❌ Managed region 'bloc_providers' missing from bloc_provider.dart${NC}"
        exit 1
    fi
    
    # Verify AppEntryScreen is the initial route (not SplashScreen)
    if grep -q "AppRoutes.entry.path" lib/navigation/router.dart && grep -q "AppEntryScreen" lib/navigation/router.dart; then
        echo -e "${GREEN}✅ Router uses AppEntryScreen as entry point${NC}"
    else
        echo -e "${RED}❌ Router missing AppEntryScreen entry point${NC}"
        exit 1
    fi
    
    # Verify AppEntryScreen file exists
    if [ -f "lib/features/main_app/presentation/screens/app_entry_screen.dart" ]; then
        echo -e "${GREEN}✅ AppEntryScreen file generated${NC}"
    else
        echo -e "${RED}❌ AppEntryScreen file missing${NC}"
        exit 1
    fi
    
    # Verify petracore.config.json exists with correct preset
    if [ -f "petracore.config.json" ]; then
        echo -e "${GREEN}✅ petracore.config.json generated${NC}"
        if grep -q '"designPreset": "default"' petracore.config.json && grep -q '"themeType": "mix"' petracore.config.json; then
            echo -e "${GREEN}✅ petracore.config.json has correct preset and theme${NC}"
        else
            echo -e "${RED}❌ petracore.config.json missing expected values${NC}"
            exit 1
        fi
    else
        echo -e "${RED}❌ petracore.config.json missing${NC}"
        exit 1
    fi
}

# Function to test feature generation with --output
test_feature_output() {
    echo -e "${GREEN}🧪 Testing Feature Generation with --output${NC}"
    echo -e "${GREEN}==========================================${NC}"
    
    run_cli --verbose feature profile --no-interactive --output lib/modules
    
    if [ -d "lib/modules/profile" ]; then
        echo -e "${GREEN}✅ Feature generation with --output: PASSED${NC}"
    else
        echo -e "${RED}❌ Feature generation with --output: FAILED${NC}"
        exit 1
    fi
    
    # Verify importRoot uses the custom output path
    if [ -f "lib/navigation/routes/profile_routes.dart" ]; then
        echo -e "${GREEN}✅ profile_routes.dart generated${NC}"
    else
        echo -e "${RED}❌ profile_routes.dart missing${NC}"
        exit 1
    fi
    
    # Check route constant was added to managed region
    if grep -q "static const profile" lib/navigation/routes.dart; then
        echo -e "${GREEN}✅ Profile route constant registered${NC}"
    else
        echo -e "${RED}❌ Profile route constant missing${NC}"
        exit 1
    fi
}

# Function to test basic feature keyword
test_feature() {
    echo -e "${GREEN}🧪 Testing Media Feature (keyword)${NC}"
    echo -e "${GREEN}===================================${NC}"
    
    # Pipe "2" to select full media feature (default)
    echo "2" | run_cli --verbose feature media
    
    if [ -d "lib/features/media" ]; then
        echo -e "${GREEN}✅ Media feature generation: PASSED${NC}"
    else
        echo -e "${RED}❌ Media feature generation: FAILED${NC}"
        exit 1
    fi
}

# Function to test auth flow generation (basic feature)
test_auth_basic() {
    echo -e "${GREEN}🧪 Testing Basic Auth Feature Generation${NC}"
    echo -e "${GREEN}========================================${NC}"
    
    # Pipe "1" to select basic auth feature
    echo "1" | run_cli --verbose feature auth
    
    if [ -d "lib/features/auth" ]; then
        echo -e "${GREEN}✅ Basic auth feature generation: PASSED${NC}"
    else
        echo -e "${RED}❌ Basic auth feature generation: FAILED${NC}"
        exit 1
    fi
}

# Function to test full auth flow generation with --output
test_auth_flow_output() {
    echo -e "${GREEN}🧪 Testing Complete Auth Flow with --output${NC}"
    echo -e "${GREEN}==========================================${NC}"
    
    # Remove existing auth feature if it exists to test clean generation
    if [ -d "lib/features/auth" ]; then
        echo -e "${YELLOW}Removing existing auth feature for clean test...${NC}"
        rm -rf "lib/features/auth"
    fi
    
    # Remove old auth routes if they exist
    if [ -f "lib/navigation/routes/auth_routes.dart" ]; then
        rm -f "lib/navigation/routes/auth_routes.dart"
    fi
    
    # Test complete auth flow with non-interactive mode
    # --verbose is before the subcommand
    run_cli --verbose auth --no-interactive --login --signup --otp --forgot-password --email-verification
    
    # Check if auth flow was generated properly
    if [ -d "lib/features/auth" ] && \
       [ -f "lib/features/auth/data/models/user_model.dart" ] && \
       [ -f "lib/features/auth/presentation/screens/login/login_screen.dart" ] && \
       [ -f "lib/features/auth/presentation/screens/signup/signup_screen.dart" ] && \
       [ -f "lib/features/auth/presentation/controllers/blocs/auth_bloc/auth_bloc.dart" ]; then
        echo -e "${GREEN}✅ Complete auth flow generation: PASSED${NC}"
    else
        echo -e "${RED}❌ Complete auth flow generation: FAILED${NC}"
        echo -e "${RED}Missing expected files in auth feature${NC}"
        exit 1
    fi
    
    # Verify auth routes file exists
    if [ -f "lib/navigation/routes/auth_routes.dart" ]; then
        echo -e "${GREEN}✅ Auth routes file generated${NC}"
    else
        echo -e "${RED}❌ Auth routes file missing${NC}"
        exit 1
    fi
    
    # Verify auth route was registered in the managed region
    if grep -q "...authRoutes," lib/navigation/router.dart; then
        echo -e "${GREEN}✅ Auth routes registered in managed region${NC}"
    else
        echo -e "${RED}❌ Auth routes not registered in managed region${NC}"
        exit 1
    fi
    
    # Verify route constants were added
    if grep -q "static const login" lib/navigation/routes.dart && \
       grep -q "static const signup" lib/navigation/routes.dart && \
       grep -q "static const otp" lib/navigation/routes.dart; then
        echo -e "${GREEN}✅ Auth route constants registered${NC}"
    else
        echo -e "${RED}❌ Auth route constants missing${NC}"
        exit 1
    fi
}

# Function to test auth flow WITHOUT welcome screen (the bug fix)
test_auth_no_welcome() {
    echo -e "${GREEN}🧪 Testing Auth Flow Without Welcome Screen${NC}"
    echo -e "${GREEN}============================================${NC}"
    
    # Remove existing auth feature
    if [ -d "lib/features/auth" ]; then
        rm -rf "lib/features/auth"
    fi
    if [ -f "lib/navigation/routes/auth_routes.dart" ]; then
        rm -f "lib/navigation/routes/auth_routes.dart"
    fi
    
    # Generate auth without welcome screen
    run_cli --verbose auth --no-interactive --login --signup --otp --forgot-password --no-welcome
    
    # Verify login routes still exist even without welcome
    if grep -q "LoginScreen" lib/navigation/routes/auth_routes.dart; then
        echo -e "${GREEN}✅ Login routes generated without WelcomeScreen${NC}"
    else
        echo -e "${RED}❌ Login routes missing when WelcomeScreen disabled${NC}"
        exit 1
    fi
    
    # Verify welcome is NOT in the routes
    if grep -q "WelcomeScreen" lib/navigation/routes/auth_routes.dart; then
        echo -e "${YELLOW}⚠️  Welcome screen reference found (expected when disabled)${NC}"
    fi
}

# Function to test Flutter commands in generated project
test_flutter_commands() {
    echo -e "${GREEN}🧪 Testing Flutter Commands in Generated Project${NC}"
    echo -e "${GREEN}===============================================${NC}"
    
    echo -e "${YELLOW}Running flutter pub get...${NC}"
    flutter pub get
    
    echo -e "${YELLOW}Running dart analyze...${NC}"
    dart analyze lib/
    
    echo -e "${GREEN}✅ Flutter commands: PASSED${NC}"
}

# Function to run unit tests
test_unit() {
    echo -e "${GREEN}🧪 Running Package Unit Tests${NC}"
    echo -e "${GREEN}==============================${NC}"
    
    cd "$SCRIPT_DIR"
    dart test
}

# Main testing function
run_tests() {
    cleanup
    setup
    test_init
    test_feature_output
    test_auth_flow_output
    test_flutter_commands
    test_unit
    
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    echo -e "${BLUE}Generated project location: $HOME/StudioProjects/petracore_local_test/test_app${NC}"
}

# Interactive mode
interactive_mode() {
    echo -e "${BLUE}🎯 Interactive Testing Mode${NC}"
    echo -e "${BLUE}===========================${NC}"
    echo ""
    echo "Choose what you want to test:"
    echo "1. Full test suite (recommended)"
    echo "2. Test project initialization only"
    echo "3. Test feature with --output only (requires existing project)"
    echo "4. Test complete auth flow with --output only (requires existing project)"
    echo "5. Test auth flow without welcome screen (requires existing project)"
    echo "6. Test basic auth feature only (requires existing project)"
    echo "7. Test unit tests only"
    echo "8. Custom CLI command"
    echo "9. Exit"
    echo ""
    read -p "Enter your choice (1-9): " choice
    
    case $choice in
        1)
            run_tests
            ;;
        2)
            cleanup
            setup
            test_init
            ;;
        3)
            cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
                echo -e "${RED}❌ No existing project found. Run option 1 or 2 first.${NC}"
                exit 1
            }
            test_feature_output
            ;;
        4)
            cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
                echo -e "${RED}❌ No existing project found. Run option 1 or 2 first.${NC}"
                exit 1
            }
            test_auth_flow_output
            ;;
        5)
            cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
                echo -e "${RED}❌ No existing project found. Run option 1 or 2 first.${NC}"
                exit 1
            }
            test_auth_no_welcome
            ;;
        6)
            cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
                echo -e "${RED}❌ No existing project found. Run option 1 or 2 first.${NC}"
                exit 1
            }
            test_auth_basic
            ;;
        7)
            test_unit
            ;;
        8)
            echo -e "${YELLOW}Enter CLI command (without 'dart run bin/main.dart'):${NC}"
            read -p "> " custom_command
            run_cli $custom_command
            ;;
        9)
            echo -e "${BLUE}👋 Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice${NC}"
            interactive_mode
            ;;
    esac
}

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -h, --help        Show this help message"
    echo "  -i, --init        Test project initialization only"
    echo "  -f, --feature     Test feature with --output only"
    echo "  -a, --auth        Test complete auth flow with --output"
    echo "  --auth-basic      Test basic auth feature only"
    echo "  --auth-no-welcome Test auth flow without welcome screen"
    echo "  -t, --test        Run full test suite"
    echo "  -c, --clean       Clean up test directory"
    echo "  -u, --unit        Run package unit tests"
    echo ""
    echo "If no options are provided, interactive mode will be launched."
    echo ""
    echo "Examples:"
    echo "  $0                 # Launch interactive mode"
    echo "  $0 --test          # Run full test suite"
    echo "  $0 --init          # Test project initialization only"
    echo "  $0 --auth-no-welcome  # Test auth without welcome screen"
    echo "  $0 --clean         # Clean up test directory"
}

# Parse command line arguments
case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    -i|--init)
        cleanup
        setup
        test_init
        ;;
    -f|--feature)
        cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
            echo -e "${RED}❌ No existing project found. Run with --init first.${NC}"
            exit 1
        }
        test_feature_output
        ;;
    -a|--auth)
        cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
            echo -e "${RED}❌ No existing project found. Run with --init first.${NC}"
            exit 1
        }
        test_auth_flow_output
        ;;
    --auth-basic)
        cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
            echo -e "${RED}❌ No existing project found. Run with --init first.${NC}"
            exit 1
        }
        test_auth_basic
        ;;
    --auth-no-welcome)
        cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
            echo -e "${RED}❌ No existing project found. Run with --init first.${NC}"
            exit 1
        }
        test_auth_no_welcome
        ;;
    -t|--test)
        run_tests
        ;;
    -c|--clean)
        cleanup
        echo -e "${GREEN}✅ Test directory cleaned${NC}"
        ;;
    -u|--unit)
        test_unit
        ;;
    "")
        interactive_mode
        ;;
    *)
        echo -e "${RED}❌ Unknown option: $1${NC}"
        show_help
        exit 1
        ;;
esac
