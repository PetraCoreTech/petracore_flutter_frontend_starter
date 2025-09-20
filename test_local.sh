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
    
    run_cli init test_app --force --verbose
    
    if [ -d "test_app" ]; then
        echo -e "${GREEN}✅ Project initialization: PASSED${NC}"
        cd test_app
    else
        echo -e "${RED}❌ Project initialization: FAILED${NC}"
        exit 1
    fi
}

# Function to test feature generation
test_feature() {
    echo -e "${GREEN}🧪 Testing Feature Generation${NC}"
    echo -e "${GREEN}============================${NC}"
    
    run_cli feature user_profile --verbose
    
    if [ -d "lib/features/user_profile" ]; then
        echo -e "${GREEN}✅ Feature generation: PASSED${NC}"
    else
        echo -e "${RED}❌ Feature generation: FAILED${NC}"
        exit 1
    fi
}

# Function to test auth flow generation
test_auth() {
    echo -e "${GREEN}🧪 Testing Auth Flow Generation (Basic)${NC}"
    echo -e "${GREEN}=======================================${NC}"
    
    # Test basic auth feature (option 1)
    echo "1" | run_cli feature auth --verbose
    
    if [ -d "lib/features/auth" ]; then
        echo -e "${GREEN}✅ Basic auth feature generation: PASSED${NC}"
    else
        echo -e "${RED}❌ Basic auth feature generation: FAILED${NC}"
        exit 1
    fi
}

# Function to run Flutter commands in generated project
test_flutter_commands() {
    echo -e "${GREEN}🧪 Testing Flutter Commands in Generated Project${NC}"
    echo -e "${GREEN}===============================================${NC}"
    
    echo -e "${YELLOW}Running flutter pub get...${NC}"
    flutter pub get
    
    echo -e "${YELLOW}Running flutter analyze...${NC}"
    flutter analyze
    
    echo -e "${GREEN}✅ Flutter commands: PASSED${NC}"
}

# Main testing function
run_tests() {
    cleanup
    setup
    test_init
    test_feature
    test_auth
    test_flutter_commands
    
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
    echo "3. Test feature generation only (requires existing project)"
    echo "4. Test auth flow generation only (requires existing project)"
    echo "5. Custom CLI command"
    echo "6. Exit"
    echo ""
    read -p "Enter your choice (1-6): " choice
    
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
            test_feature
            ;;
        4)
            cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
                echo -e "${RED}❌ No existing project found. Run option 1 or 2 first.${NC}"
                exit 1
            }
            test_auth
            ;;
        5)
            echo -e "${YELLOW}Enter CLI command (without 'dart run bin/main.dart'):${NC}"
            read -p "> " custom_command
            run_cli $custom_command
            ;;
        6)
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
    echo "  -h, --help     Show this help message"
    echo "  -i, --init     Test project initialization only"
    echo "  -f, --feature  Test feature generation only"
    echo "  -a, --auth     Test auth flow generation only"
    echo "  -t, --test     Run full test suite"
    echo "  -c, --clean    Clean up test directory"
    echo ""
    echo "If no options are provided, interactive mode will be launched."
    echo ""
    echo "Examples:"
    echo "  $0              # Launch interactive mode"
    echo "  $0 --test       # Run full test suite"
    echo "  $0 --init       # Test project initialization only"
    echo "  $0 --clean      # Clean up test directory"
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
        test_feature
        ;;
    -a|--auth)
        cd "$HOME/StudioProjects/petracore_local_test/test_app" 2>/dev/null || {
            echo -e "${RED}❌ No existing project found. Run with --init first.${NC}"
            exit 1
        }
        test_auth
        ;;
    -t|--test)
        run_tests
        ;;
    -c|--clean)
        cleanup
        echo -e "${GREEN}✅ Test directory cleaned${NC}"
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