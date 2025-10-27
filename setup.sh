#!/bin/bash

# FlowWave Setup Script
# Quickly set up FlowWave workflows in your repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🌊 FlowWave Setup Script"
echo "========================"
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo -e "${RED}Error: Not a git repository. Please run this script from the root of your repository.${NC}"
    exit 1
fi

# Function to display menu
show_menu() {
    echo "Select your team size:"
    echo "1) Small team (2-5 developers)"
    echo "2) Medium team (5-20 developers)"
    echo "3) Large/Enterprise team (20+ developers)"
    echo "4) Open source project"
    echo "5) Exit"
    echo ""
}

# Function to copy template
setup_template() {
    local template_type=$1
    local flowwave_path=$2
    
    if [ ! -d "$flowwave_path" ]; then
        echo -e "${RED}Error: FlowWave repository not found at $flowwave_path${NC}"
        echo "Please provide the path to the FlowWave repository."
        exit 1
    fi
    
    echo -e "${YELLOW}Setting up $template_type template...${NC}"
    
    # Create .github directory if it doesn't exist
    mkdir -p .github/workflows
    mkdir -p .github/ISSUE_TEMPLATE
    
    # Copy workflows
    if [ -d "$flowwave_path/examples/$template_type/.github" ]; then
        cp -r "$flowwave_path/examples/$template_type/.github/"* .github/ 2>/dev/null || true
        echo -e "${GREEN}✓ Copied workflow files${NC}"
    fi
    
    # Copy documentation
    if [ -f "$flowwave_path/examples/$template_type/README.md" ]; then
        cp "$flowwave_path/examples/$template_type/README.md" .github/FLOWWAVE_SETUP.md
        echo -e "${GREEN}✓ Copied setup documentation${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}Setup complete!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Review the files in .github/"
    echo "2. Customize workflows for your project"
    echo "3. Read .github/FLOWWAVE_SETUP.md for details"
    echo "4. Configure GitHub repository settings"
    echo "5. Create a test PR to verify workflows"
    echo ""
}

# Main script
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <flowwave-path>${NC}"
    echo "Example: $0 /path/to/flowwave"
    echo ""
    exit 1
fi

FLOWWAVE_PATH=$1

while true; do
    show_menu
    read -p "Enter your choice [1-5]: " choice
    
    case $choice in
        1)
            setup_template "small-team" "$FLOWWAVE_PATH"
            break
            ;;
        2)
            echo -e "${YELLOW}Medium team template coming soon!${NC}"
            echo "Using small-team template for now..."
            setup_template "small-team" "$FLOWWAVE_PATH"
            break
            ;;
        3)
            echo -e "${YELLOW}Enterprise template coming soon!${NC}"
            echo "Using small-team template for now..."
            setup_template "small-team" "$FLOWWAVE_PATH"
            break
            ;;
        4)
            echo -e "${YELLOW}Open source template coming soon!${NC}"
            echo "Using small-team template for now..."
            setup_template "small-team" "$FLOWWAVE_PATH"
            break
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            echo ""
            ;;
    esac
done
