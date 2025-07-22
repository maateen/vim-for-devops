#!/usr/bin/env bash

# VIM for DevOps Installation Script
# Copyright (C) 2025 Maksudur Rahman Maateen <maateen@outlook.com>
# Licensed under GPL v3

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly VIMRC_SOURCE="${SCRIPT_DIR}/vimrc"
readonly VIMRC_TARGET="${HOME}/.vimrc"
readonly VIM_DIR="${HOME}/.vim"
readonly PLUG_VIM="${VIM_DIR}/autoload/plug.vim"
readonly BACKUP_DIR="${HOME}/.vim-backup-$(date +%Y%m%d_%H%M%S)"

# Function to print colored output
print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to backup existing vim configuration
backup_existing_config() {
    local backup_needed=false
    
    if [[ -f "${VIMRC_TARGET}" ]]; then
        backup_needed=true
        print_status "Backing up existing .vimrc to ${BACKUP_DIR}"
        mkdir -p "${BACKUP_DIR}"
        cp "${VIMRC_TARGET}" "${BACKUP_DIR}/vimrc"
    fi
    
    if [[ -d "${VIM_DIR}" ]]; then
        backup_needed=true
        print_status "Backing up existing .vim directory to ${BACKUP_DIR}"
        mkdir -p "${BACKUP_DIR}"
        cp -r "${VIM_DIR}" "${BACKUP_DIR}/vim"
    fi
    
    if [[ "${backup_needed}" == true ]]; then
        print_success "Configuration backed up to ${BACKUP_DIR}"
    fi
}

# Function to install vim-plug
install_vim_plug() {
    print_status "Installing vim-plug plugin manager..."
    
    if [[ -f "${PLUG_VIM}" ]]; then
        print_warning "vim-plug already exists, updating..."
    fi
    
    mkdir -p "${VIM_DIR}/autoload"
    
    if command_exists curl; then
        curl -fLo "${PLUG_VIM}" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    elif command_exists wget; then
        wget -O "${PLUG_VIM}" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
    
    print_success "vim-plug installed successfully"
}

# Function to install vimrc
install_vimrc() {
    print_status "Installing VIM for DevOps configuration..."
    
    if [[ ! -f "${VIMRC_SOURCE}" ]]; then
        print_error "vimrc file not found at ${VIMRC_SOURCE}"
        print_error "Please run this script from the vim-for-devops directory"
        exit 1
    fi
    
    cp "${VIMRC_SOURCE}" "${VIMRC_TARGET}"
    print_success "vimrc installed to ${VIMRC_TARGET}"
}

# Function to install vim plugins
install_plugins() {
    print_status "Installing Vim plugins..."
    print_warning "This may take a few minutes depending on your internet connection"
    
    # Install/update plugins silently
    if vim +PlugUpgrade +PlugClean! +PlugInstall +PlugUpdate +qall >/dev/null 2>&1; then
        print_success "Vim plugins installed successfully"
    else
        print_warning "Plugin installation completed with some warnings"
        print_status "You can manually run ':PlugInstall' in Vim to check for issues"
    fi
}

# Function to install Go binaries (if Go is available)
install_go_binaries() {
    if command_exists go; then
        print_status "Go detected, installing vim-go binaries..."
        
        # Create a temporary Go file to trigger vim-go installation
        local temp_go_file="/tmp/temp_install.go"
        echo "package main" > "${temp_go_file}"
        
        if vim "${temp_go_file}" +GoInstallBinaries +qall >/dev/null 2>&1; then
            print_success "vim-go binaries installed successfully"
        else
            print_warning "vim-go binary installation completed with warnings"
        fi
        
        rm -f "${temp_go_file}"
    else
        print_warning "Go not found. vim-go features will be limited"
        print_status "Install Go to enable full vim-go functionality"
    fi
}

# Function to check and suggest additional tools
check_optional_tools() {
    print_status "Checking for optional DevOps tools..."
    
    local tools=(
        "black:Python code formatter"
        "shellcheck:Shell script linter"
        "hadolint:Dockerfile linter"
        "terraform:Infrastructure as code"
        "ansible-lint:Ansible playbook linter"
        "yamllint:YAML linter"
        "jq:JSON processor"
        "node:JavaScript runtime (for CoC.nvim)"
    )
    
    local missing_tools=()
    
    for tool_info in "${tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info##*:}"
        
        if command_exists "${tool}"; then
            print_success "${tool} is available"
        else
            missing_tools+=("${tool}:${description}")
        fi
    done
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        print_warning "Optional tools not found (install for enhanced features):"
        for tool_info in "${missing_tools[@]}"; do
            local tool="${tool_info%%:*}"
            local description="${tool_info##*:}"
            echo "  - ${tool}: ${description}"
        done
    fi
}

# Function to print post-installation instructions
print_post_install() {
    print_success "VIM for DevOps installation completed!"
    echo
    print_status "Next steps:"
    echo "  1. Restart your terminal or run 'source ~/.bashrc'"
    echo "  2. Open Vim and run ':checkhealth' (if available) to verify setup"
    echo "  3. For CoC.nvim language servers, run ':CocInstall coc-json coc-yaml coc-go' etc."
    echo "  4. Install optional tools mentioned above for enhanced features"
    echo
    print_status "Key shortcuts to remember:"
    echo "  - Ctrl+t: Toggle file explorer"
    echo "  - Ctrl+i: Enable IDE mode"
    echo "  - ,cc: Comment/uncomment lines"
    echo "  - gd: Go to definition (CoC.nvim)"
    echo
    print_status "Documentation: https://github.com/maateen/vim-for-devops"
    echo
    if [[ -d "${BACKUP_DIR}" ]]; then
        print_status "Your previous configuration was backed up to: ${BACKUP_DIR}"
    fi
}

# Main installation function
main() {
    echo
    print_status "=== VIM for DevOps Installation ==="
    print_status "Copyright (C) 2025 Maksudur Rahman Maateen"
    echo
    
    # Check if Vim is installed
    if ! command_exists vim; then
        print_error "Vim is not installed on your system"
        print_status "Please install Vim first:"
        echo "  - macOS: brew install vim"
        echo "  - Ubuntu/Debian: sudo apt install vim"
        echo "  - CentOS/RHEL: sudo yum install vim"
        exit 1
    fi
    
    print_success "Vim found: $(vim --version | head -n1)"
    
    # Ask for confirmation if existing config exists
    if [[ -f "${VIMRC_TARGET}" ]] || [[ -d "${VIM_DIR}" ]]; then
        echo
        print_warning "Existing Vim configuration detected"
        read -p "Do you want to continue? Your current config will be backed up. (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
    fi
    
    # Perform installation steps
    backup_existing_config
    install_vim_plug
    install_vimrc
    install_plugins
    install_go_binaries
    check_optional_tools
    print_post_install
}

# Trap errors and provide helpful message
trap 'print_error "Installation failed at line $LINENO. Check the error message above."' ERR

# Run main function
main "$@"