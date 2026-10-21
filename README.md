# VIM for DevOps

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Vim 8.1+](https://img.shields.io/badge/Vim-8.1%2B-019733.svg)](https://www.vim.org/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](#requirements)

A lightweight, optimized Vim configuration for DevOps engineers: language server
completion, linting and formatting on save, and first-class support for the file
types you touch every day — Docker, Kubernetes, Terraform, Ansible, Helm, shell,
Python and Go.

![VIM for DevOps](https://repository-images.githubusercontent.com/77739984/f41fa080-6b5f-11ea-9b05-375ad4abcda3)

## Features

- **Language server completion** through [CoC.nvim](https://github.com/neoclide/coc.nvim)
- **Lint and format on save** through [ALE](https://github.com/dense-analysis/ale)
- **DevOps file types** covered out of the box: Dockerfile, Kubernetes/Helm YAML,
  Terraform/HCL, Ansible, Vagrant, Nginx, TOML, JSON and shell
- **Lazy plugin loading** keyed on commands and file types to keep startup fast
- **Git workflow** with [fugitive](https://github.com/tpope/vim-fugitive) and
  [gitgutter](https://github.com/airblade/vim-gitgutter)
- **Persistent undo**, sane search behaviour, and split/window defaults
- **Idempotent installer** with backup, dry-run and uninstall support

## Requirements

| Requirement | Why |
|-------------|-----|
| Vim **8.1+** with `+job` and `+timers` | CoC.nvim and ALE run jobs asynchronously |
| `git`, `curl` (or `wget`) | Plugin download |
| [Node.js](https://nodejs.org/) 16+ | CoC.nvim language servers |
| A [Nerd Font](https://www.nerdfonts.com/) | File icons in NERDTree and the status line |
| A true-color terminal | `termguicolors` and the onedark theme |

## Installation

### Scripted (recommended)

```bash
git clone https://github.com/maateen/vim-for-devops.git
cd vim-for-devops
./install.sh
```

The script backs up `~/.vimrc` and your existing Vim configuration, installs
vim-plug and the plugins, installs vim-go binaries when Go is available, and
reports which optional tools are missing.

| Option | Description |
|--------|-------------|
| `-y`, `--yes` | Unattended install (assume yes) |
| `-n`, `--dry-run` | Print every action without changing anything |
| `-u`, `--uninstall` | Move the current config aside and restore the latest backup |
| `-h`, `--help` | Show usage |

### Manual

1. Copy the configuration:

   ```bash
   cp vimrc ~/.vimrc
   ```

2. Install [vim-plug](https://github.com/junegunn/vim-plug):

   ```bash
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

3. Install the plugins from inside Vim:

   ```vim
   :PlugInstall
   ```

4. Install the language servers you need:

   ```vim
   :CocInstall coc-json coc-yaml coc-sh coc-go coc-pyright
   ```

   Run `:CocList marketplace` to browse extensions such as `coc-docker` or
   `coc-ansible`.

## Supported technologies

| Technology | Provided by |
|------------|-------------|
| Docker | Dockerfile syntax, `hadolint` linting |
| Kubernetes | YAML syntax, schema-aware `coc-yaml` |
| Helm | Chart and template syntax |
| Terraform / HCL | Syntax, alignment, `terraform fmt` on save, `tflint` |
| Ansible | Playbook syntax, `ansible-lint` |
| Vagrant | Vagrantfile file type |
| Python | `black`/`isort` on save, `mypy`/`pylint` diagnostics |
| Go | vim-go, `gofmt` on save, `gd`/`gr` through CoC |
| YAML / JSON / TOML | Syntax, `yamllint`/`yamlfix`, `jq` |
| Shell | `shellcheck`, `shfmt` on save |
| Nginx | Directive and block syntax |

## Key mappings

Leader key is <kbd>,</kbd>.

### Basic operations

| Key | Action |
|-----|--------|
| `Ctrl+s` | Save file |
| `Ctrl+w` | Close buffer |
| `Ctrl+z` | Undo |
| `Ctrl+r` | Redo |

### File navigation

| Key | Action |
|-----|--------|
| `Ctrl+t` | Toggle file explorer |
| `Ctrl+e` | Find current file in explorer |

### IDE features

| Key | Action |
|-----|--------|
| `Ctrl+i` | Enable IDE mode (Git gutter + file explorer) |
| `Ctrl+g` | Enable Git gutter |
| `Ctrl+f` | Toggle distraction-free mode |
| `Ctrl+d` | Open terminal below |

### Code intelligence (CoC)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Show documentation |
| `,rn` | Rename symbol |
| `,ca` | Code actions |

### Git

| Key | Action |
|-----|--------|
| `,gs` | `:Git` status |
| `,gd` | Side-by-side diff |
| `,gl` | Commit log |

### Buffers and tabs

| Key | Action |
|-----|--------|
| `,t` | New tab |
| `,n` | Next buffer |
| `,p` | Previous buffer |

### Quick toggles

| Key | Action |
|-----|--------|
| `,i` | Toggle indent guides |

### Comments

| Key | Action |
|-----|--------|
| `,cc` | Comment the current line or selection |
| `,cu` | Uncomment the current line or selection |

## Formatting and linting

ALE formats on save for the file types below and always trims trailing
whitespace. Disable it globally with `let g:ale_fix_on_save = 0` in `~/.vimrc`.

| File type | Fixer(s) | Linter(s) |
|-----------|----------|-----------|
| Any | trailing whitespace/lines | — |
| Python | `black`, `isort` | `mypy`, `pylint` |
| Shell | `shfmt` | `shellcheck` |
| Terraform | `terraform fmt` | `tflint` |
| YAML | `yamlfix` | `yamllint` |
| JSON | `jq` | — |
| Dockerfile | — | `hadolint` |
| Ansible | — | `ansible-lint` |

Install only the tools you need; missing ones are skipped. Common install
commands:

```bash
# macOS
brew install black isort mypy pylint shfmt shellcheck hadolint \
             terraform tflint ansible-lint yamllint jq node

# Python tools (any platform)
pipx install black isort mypy pylint yamllint yamlfix ansible-lint
```

`hadolint`, `tflint`, `terraform` and `shfmt` also ship as standalone binaries —
see their release pages if your package manager does not provide them.

## Customization

The configuration is a single, commented `vimrc`; edit it directly or keep your
overrides in a separate file.

- **Theme** — `colorscheme onedark` and the `g:onedark_*` options in the theme
  section. The options must stay above `colorscheme`.
- **Key mappings** — the `Key mappings` section at the bottom.
- **Lint/format behaviour** — `g:ale_fixers` and `g:ale_linters`.
- **Machine-specific overrides** — put them in `~/.vimrc.local`, which is sourced
  at the end if it exists. It is never overwritten by the installer:

  ```vim
  " ~/.vimrc.local
  set colorcolumn=100
  ```

- **Language-server settings** — use `coc-settings.json`; `:CocConfig` opens it.

Changes to `~/.vimrc` are re-sourced automatically when you save the file.

## Project structure

```text
.
├── vimrc                  # The configuration
├── install.sh             # Installer, backup and uninstall helper
├── README.md              # This file
├── _config.yml            # GitHub Pages / Jekyll settings
├── CNAME                  # Custom domain for the documentation site
└── .github/workflows/     # GitHub Pages deployment
```

## Troubleshooting

**Plugins are missing or out of date**
Run `:PlugInstall` (or `:PlugUpdate`) inside Vim, then check `:PlugStatus`.

**CoC does not complete anything**
CoC needs Node.js and Vim 8.1+ with `+job` and `+timers`. Check `vim --version`,
then run `:CocInfo` and install a server for the current file type with
`:CocInstall coc-yaml` (for example).

**`gd` does nothing in a Go file**
vim-go's own `gd` mapping is disabled so CoC owns it. Install `coc-go` and make
sure `gopls` is on your `PATH`.

**Icons render as boxes**
Install a Nerd Font and select it in your terminal. Without it, the UI still
works but file icons fall back to placeholders.

**Colors look wrong or the background is unreadable**
The config enables `termguicolors`, which requires a true-color terminal. Remove
the `set termguicolors` line (or run `:set notermguicolors`) if your terminal
does not support it.

**A fixer or linter never runs**
`ALEInfo` lists the tools it found. Install the missing binary, or remove it
from `g:ale_fixers` / `g:ale_linters`.

**Startup feels slow**
Measure it with `vim --startuptime /tmp/startup.log +q` and look for heavy
plugins. Most language plugins are already lazy-loaded.

## Uninstall

```bash
./install.sh --uninstall
```

The script moves `~/.vimrc` and the Vim configuration directories to
`~/.vim-removed-<timestamp>`, restores the newest `~/.vim-backup-*` snapshot, and
keeps the shared plugin cache in `~/.vim/plugged`. Nothing is deleted
permanently.

## Contributing

Issues and pull requests are welcome. Keep the configuration portable across
macOS and Linux, keep mappings documented here, and run `bash -n install.sh`
before submitting a change to the installer.

## License

[GNU General Public License v3.0](LICENSE) © Maksudur Rahman Maateen
