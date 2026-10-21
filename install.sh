#!/usr/bin/env bash
#
# VIM for DevOps installer
# Copyright (C) 2025 Maksudur Rahman Maateen <maateen@outlook.com>
# Licensed under GPL-3.0
#
# Usage: ./install.sh [OPTIONS]
#   -y, --yes        Assume "yes" for all prompts (non-interactive)
#   -n, --dry-run    Print the actions without changing anything
#   -u, --uninstall  Remove the configuration and restore the last backup
#   -h, --help       Show this help message

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly VIMRC_SOURCE="${SCRIPT_DIR}/vimrc"
readonly VIMRC_TARGET="${HOME}/.vimrc"
readonly VIM_DIR="${HOME}/.vim"
readonly VIM_UNDO_DIR="${VIM_DIR}/undo"
readonly PLUG_VIM="${VIM_DIR}/autoload/plug.vim"
readonly PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Restored / created by the installer
readonly CONFIG_DIRS=(after autoload colors ftplugin indent syntax)

ASSUME_YES=false
DRY_RUN=false
UNINSTALL=false
BACKUP_DIR=""
TMP_DIR=""

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------
print_status()  { printf '%b[INFO]%b    %s\n' "${BLUE}" "${NC}" "$*"; }
print_success() { printf '%b[OK]%b      %s\n' "${GREEN}" "${NC}" "$*"; }
print_warning() { printf '%b[WARNING]%b %s\n' "${YELLOW}" "${NC}" "$*"; }
print_error()   { printf '%b[ERROR]%b   %s\n' "${RED}" "${NC}" "$*" >&2; }

cleanup() {
  if [[ -n "${TMP_DIR}" && -d "${TMP_DIR}" ]]; then
    rm -rf "${TMP_DIR}"
  fi
}

on_error() {
  local exit_code=$?
  print_error "Installation failed at line ${1:-?} (exit code ${exit_code})."
  exit "${exit_code}"
}

command_exists() { command -v "$1" >/dev/null 2>&1; }

header() {
  echo
  printf '%s\n' "================================================"
  printf ' %s\n' "$1"
  printf '%s\n' "================================================"
}

# Run a command, or only print it with --dry-run.
run() {
  if [[ "${DRY_RUN}" == true ]]; then
    print_status "[dry-run] $*"
    return 0
  fi
  "$@"
}

confirm() {
  if [[ "${ASSUME_YES}" == true ]]; then
    return 0
  fi
  if [[ ! -t 0 ]]; then
    print_warning "No interactive terminal available. Re-run with --yes to proceed."
    return 1
  fi
  local reply=""
  read -r -p "$1 [y/N]: " reply || reply=""
  [[ "${reply}" =~ ^[Yy]$ ]]
}

usage() {
  cat <<EOF
VIM for DevOps installer

Usage: ./${SCRIPT_NAME} [OPTIONS]

Options:
  -y, --yes        Assume "yes" for all prompts (non-interactive)
  -n, --dry-run    Print the actions without changing anything
  -u, --uninstall  Remove the configuration and restore the last backup
  -h, --help       Show this help message

Examples:
  ./${SCRIPT_NAME}              # interactive install
  ./${SCRIPT_NAME} --yes        # unattended install
  ./${SCRIPT_NAME} --uninstall  # restore the previous configuration
EOF
}

# ---------------------------------------------------------------------------
# Environment checks
# ---------------------------------------------------------------------------
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}

check_vim() {
  if ! command_exists vim; then
    print_error "Vim is not installed."
    echo
    echo "Install it first:"
    case "$(detect_os)" in
      macos) echo "  brew install vim" ;;
      linux|wsl)
        echo "  sudo apt install vim   # Debian/Ubuntu"
        echo "  sudo dnf install vim   # Fedora/RHEL"
        ;;
      *) echo "  https://www.vim.org/download.php" ;;
    esac
    exit 1
  fi

  local version major minor
  version="$(vim --version | head -n1 | awk '{print $5}')"
  major="${version%%.*}"
  minor="${version#*.}"
  minor="${minor%%.*}"

  print_success "Vim ${version} ($(command -v vim))"

  if (( major < 8 || (major == 8 && minor < 1) )); then
    print_error "Vim 8.1 or newer is required (found ${version})."
    print_status "CoC.nvim and terminal support depend on it."
    exit 1
  fi

  local feature
  for feature in +job +timers; do
    if ! vim --version | grep -q -- "${feature}"; then
      print_warning "This Vim build lacks ${feature}; CoC.nvim may not work."
    fi
  done

  if ! command_exists node; then
    print_warning "Node.js was not found; CoC.nvim needs it for language servers."
  fi
}

# ---------------------------------------------------------------------------
# Backup and restore
# ---------------------------------------------------------------------------
ensure_backup_dir() {
  # Set the global (not in a subshell) so print_post_install can report it.
  if [[ -z "${BACKUP_DIR}" ]]; then
    BACKUP_DIR="${HOME}/.vim-backup-$(date +%Y%m%d_%H%M%S)"
  fi
}

backup_existing_config() {
  ensure_backup_dir
  local backup_dir="${BACKUP_DIR}"
  local backed_up=false

  if [[ -e "${VIMRC_TARGET}" || -L "${VIMRC_TARGET}" ]]; then
    run mkdir -p "${backup_dir}"
    # Move a symlink instead of writing through it.
    if [[ -L "${VIMRC_TARGET}" ]]; then
      print_status "Replacing the ${VIMRC_TARGET} symlink with a regular file."
      run mv "${VIMRC_TARGET}" "${backup_dir}/vimrc"
    else
      run cp -p "${VIMRC_TARGET}" "${backup_dir}/vimrc"
    fi
    backed_up=true
  fi

  local coc_settings="${VIM_DIR}/coc-settings.json"
  if [[ -f "${coc_settings}" ]]; then
    run mkdir -p "${backup_dir}/coc-settings"
    run cp -p "${coc_settings}" "${backup_dir}/coc-settings/coc-settings.json"
    backed_up=true
  fi

  local dir
  for dir in "${CONFIG_DIRS[@]}"; do
    if [[ -d "${VIM_DIR}/${dir}" ]]; then
      run mkdir -p "${backup_dir}/vim"
      run cp -Rp "${VIM_DIR}/${dir}" "${backup_dir}/vim/${dir}"
      backed_up=true
    fi
  done

  if [[ "${backed_up}" == true ]]; then
    if [[ "${DRY_RUN}" == true ]]; then
      print_status "[dry-run] Previous configuration would be backed up to ${backup_dir}"
    else
      print_success "Previous configuration backed up to ${backup_dir}"
    fi
  fi
}

# ---------------------------------------------------------------------------
# Installation steps
# ---------------------------------------------------------------------------
install_vim_plug() {
  print_status "Installing vim-plug..."

  if [[ -f "${PLUG_VIM}" ]]; then
    print_success "vim-plug is already installed, keeping it"
    return 0
  fi

  run mkdir -p "${VIM_DIR}/autoload"

  local tmp_plug="${TMP_DIR}/plug.vim"
  if command_exists curl; then
    run curl -fsSL -o "${tmp_plug}" "${PLUG_URL}"
  elif command_exists wget; then
    run wget -q -O "${tmp_plug}" "${PLUG_URL}"
  else
    print_error "Neither curl nor wget is available. Install one of them first."
    exit 1
  fi

  if [[ "${DRY_RUN}" == false ]] && [[ ! -s "${tmp_plug}" ]]; then
    print_error "Failed to download vim-plug from ${PLUG_URL}"
    exit 1
  fi

  run mv "${tmp_plug}" "${PLUG_VIM}"
  print_success "vim-plug installed"
}

install_vimrc() {
  print_status "Installing vimrc to ${VIMRC_TARGET}..."

  if [[ ! -f "${VIMRC_SOURCE}" ]]; then
    print_error "vimrc not found at ${VIMRC_SOURCE}"
    print_error "Run this script from the vim-for-devops directory."
    exit 1
  fi

  run install -m 0644 "${VIMRC_SOURCE}" "${VIMRC_TARGET}"
  print_success "vimrc installed"

  if [[ "${DRY_RUN}" == false ]]; then
    mkdir -p "${VIM_UNDO_DIR}"
  else
    print_status "[dry-run] mkdir -p ${VIM_UNDO_DIR}"
  fi
}

install_plugins() {
  print_status "Installing Vim plugins (this can take a few minutes)..."
  print_warning "Missing network access will leave plugins uninstalled; re-run :PlugInstall later."

  local log_file="${TMP_DIR}/pluginstall.log"

  if [[ "${DRY_RUN}" == true ]]; then
    print_status "[dry-run] vim -Nu ${VIMRC_TARGET} -Es +'PlugInstall --sync' +qa"
    return 0
  fi

  # Vim exits with 0 even when a plugin fails, so inspect the log as well.
  if ! vim -Nu "${VIMRC_TARGET}" -Es +"PlugInstall --sync" +"qa!" >"${log_file}" 2>&1; then
    print_warning "Plugin installation returned a non-zero exit code."
    tail -n 20 "${log_file}" || true
  fi

  if grep -qiE '(^|[^a-z])(error|failed)([^a-z]|$)|E[0-9]+:' "${log_file}"; then
    print_warning "Some plugins reported errors:"
    grep -iE '(^|[^a-z])(error|failed)([^a-z]|$)|E[0-9]+:' "${log_file}" | tail -n 10
    print_status "Open Vim and run :PlugStatus for details."
  else
    print_success "Vim plugins installed"
  fi
}

install_go_binaries() {
  if ! command_exists go; then
    print_warning "Go not found; skipping vim-go binaries (vim-go features will be limited)."
    return 0
  fi

  if [[ ! -d "${VIM_DIR}/plugged/vim-go" ]]; then
    print_warning "vim-go is not installed yet; skipping its binaries."
    return 0
  fi

  print_status "Installing vim-go binaries..."
  local go_file="${TMP_DIR}/install.go"
  printf 'package main\n' > "${go_file}"

  if [[ "${DRY_RUN}" == true ]]; then
    print_status "[dry-run] vim ${go_file} +GoInstallBinaries +qall"
    return 0
  fi

  if vim -Nu "${VIMRC_TARGET}" "${go_file}" +"GoInstallBinaries" +"qall" >/dev/null 2>&1; then
    print_success "vim-go binaries installed"
  else
    print_warning "vim-go binary installation reported problems; run :GoInstallBinaries in Vim."
  fi
}

# ---------------------------------------------------------------------------
# Optional tooling
# ---------------------------------------------------------------------------
check_optional_tools() {
  print_status "Checking optional DevOps tools..."

  # cmd:description
  local tools=(
    "black:Python formatter (ALE fixer)"
    "isort:Python import sorter (ALE fixer)"
    "mypy:Python type checker (ALE linter)"
    "pylint:Python linter (ALE linter)"
    "shfmt:Shell formatter (ALE fixer)"
    "shellcheck:Shell linter (ALE linter)"
    "hadolint:Dockerfile linter (ALE linter)"
    "terraform:Terraform CLI (ALE fixer)"
    "tflint:Terraform linter (ALE linter)"
    "ansible-lint:Ansible playbook linter (ALE linter)"
    "yamllint:YAML linter (ALE linter)"
    "yamlfix:YAML formatter (ALE fixer)"
    "jq:JSON processor (ALE fixer)"
  )

  local missing=()
  local entry tool description
  for entry in "${tools[@]}"; do
    tool="${entry%%:*}"
    description="${entry##*:}"
    if command_exists "${tool}"; then
      print_success "${tool} found"
    else
      missing+=("${tool}|${description}")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    print_success "All optional tools are installed"
    return 0
  fi

  print_warning "Missing optional tools (only needed for the related file types):"
  local item
  for item in "${missing[@]}"; do
    printf '  - %-14s %s\n' "${item%%|*}" "${item##*|}"
  done

  echo
  case "$(detect_os)" in
    macos)
      local packages=()
      for item in "${missing[@]}"; do
        packages+=("${item%%|*}")
      done
      print_status "Install them on macOS with:"
      echo "  brew install ${packages[*]}"
      print_status "Package names occasionally differ; check 'brew search <tool>' if one fails."
      ;;
    linux|wsl)
      print_status "Install the missing tools with your package manager or the upstream releases."
      print_status "See the Requirements section of README.md for details."
      ;;
    *)
      print_status "See the Requirements section of README.md for install instructions."
      ;;
  esac
}

# ---------------------------------------------------------------------------
# Post-install summary
# ---------------------------------------------------------------------------
print_post_install() {
  echo
  print_success "VIM for DevOps is installed."
  echo
  print_status "Next steps:"
  echo "  1. Install CoC language servers:  vim +'CocInstall coc-json coc-yaml coc-sh coc-go coc-pyright'"
  echo "  2. Verify plugins:                open Vim and run :PlugStatus"
  echo "  3. Check CoC:                     open Vim and run :CocInfo"
  echo
  print_status "Quick reference:"
  echo "  - Ctrl+t: Toggle file explorer"
  echo "  - Ctrl+i: Enable IDE mode (Git gutter + file explorer)"
  echo "  - ,cc:    Comment line/selection"
  echo "  - gd:     Go to definition (CoC.nvim)"
  echo
  print_status "Documentation: https://github.com/maateen/vim-for-devops"
  if [[ -n "${BACKUP_DIR}" && -d "${BACKUP_DIR}" ]]; then
    print_status "Previous configuration: ${BACKUP_DIR}"
    print_status "Restore it with: ./${SCRIPT_NAME} --uninstall"
  fi
}

# ---------------------------------------------------------------------------
# Uninstall
# ---------------------------------------------------------------------------
latest_backup() {
  ls -1d "${HOME}"/.vim-backup-* 2>/dev/null | sort | tail -n 1
}

uninstall_config() {
  header "Uninstalling VIM for DevOps"

  local backup_dir
  backup_dir="$(latest_backup || true)"

  if [[ -z "${backup_dir}" ]]; then
    print_warning "No backup found (${HOME}/.vim-backup-*)."
    print_status "The current configuration will be moved aside, not restored."
  else
    print_status "Latest backup: ${backup_dir}"
  fi

  if ! confirm "Move the current configuration aside and restore the last backup?"; then
    print_status "Cancelled."
    exit 0
  fi

  local removed_dir="${HOME}/.vim-removed-$(date +%Y%m%d_%H%M%S)"
  run mkdir -p "${removed_dir}"

  if [[ -f "${VIMRC_TARGET}" || -L "${VIMRC_TARGET}" ]]; then
    run mv "${VIMRC_TARGET}" "${removed_dir}/vimrc"
    print_success "Moved ${VIMRC_TARGET} to ${removed_dir}"
  fi

  if [[ -d "${VIM_DIR}" ]]; then
    run mkdir -p "${removed_dir}/vim"
    # plugged/ is a shared plugin cache; keep it so the restored configuration
    # still has its plugins without downloading them again.
    local entry base
    for entry in "${VIM_DIR}"/*; do
      [[ -e "${entry}" ]] || continue
      base="${entry##*/}"
      [[ "${base}" == "plugged" ]] && continue
      run mv "${entry}" "${removed_dir}/vim/${base}"
    done
    print_success "Moved ${VIM_DIR} (except plugged/) to ${removed_dir}"
  fi

  if [[ -n "${backup_dir}" ]]; then
    if [[ -f "${backup_dir}/vimrc" || -L "${backup_dir}/vimrc" ]]; then
      # -P keeps a backed-up symlink intact instead of copying its target.
      run cp -pP "${backup_dir}/vimrc" "${VIMRC_TARGET}"
      print_success "Restored previous ${VIMRC_TARGET}"
    fi

    if [[ -f "${backup_dir}/coc-settings/coc-settings.json" ]]; then
      run mkdir -p "${VIM_DIR}"
      run cp -p "${backup_dir}/coc-settings/coc-settings.json" "${VIM_DIR}/coc-settings.json"
      print_success "Restored previous coc-settings.json"
    fi

    if [[ -d "${backup_dir}/vim" ]]; then
      local dir
      for dir in "${CONFIG_DIRS[@]}"; do
        if [[ -d "${backup_dir}/vim/${dir}" ]]; then
          run mkdir -p "${VIM_DIR}"
          run cp -Rp "${backup_dir}/vim/${dir}" "${VIM_DIR}/${dir}"
        fi
      done
      print_success "Restored previous Vim configuration directories"
    fi
  fi

  echo
  print_status "Removed files are kept in ${removed_dir} in case you need them."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes)       ASSUME_YES=true ;;
      -n|--dry-run)   DRY_RUN=true ;;
      -u|--uninstall) UNINSTALL=true ;;
      -h|--help)      usage; exit 0 ;;
      *)              print_error "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
  done

  if [[ "${DRY_RUN}" == true && "${UNINSTALL}" == true ]]; then
    print_error "--dry-run cannot be combined with --uninstall."
    exit 1
  fi
}

main() {
  parse_args "$@"

  TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/vim-for-devops.XXXXXX")"
  trap cleanup EXIT
  trap 'on_error ${LINENO}' ERR

  header "VIM for DevOps installer"

  if [[ "${UNINSTALL}" == true ]]; then
    uninstall_config
    exit 0
  fi

  check_vim

  if [[ -f "${VIMRC_TARGET}" || -d "${VIM_DIR}" ]]; then
    print_warning "An existing Vim configuration was found; it will be backed up."
    if ! confirm "Continue with the installation?"; then
      print_status "Cancelled."
      exit 0
    fi
  fi

  backup_existing_config

  header "Installing"
  install_vim_plug
  install_vimrc
  install_plugins
  install_go_binaries

  header "Optional tools"
  check_optional_tools

  print_post_install
}

main "$@"
