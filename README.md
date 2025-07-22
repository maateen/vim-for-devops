# VIM for DevOps

A lightweight, optimized Vim configuration specifically designed for DevOps engineers with intelligent code completion, syntax highlighting, and essential tools for infrastructure management.

## ✨ Features

- **LSP Integration**: Advanced code completion via CoC.nvim
- **DevOps Focused**: Built-in support for Docker, Kubernetes, Terraform, Ansible
- **Code Quality**: Automatic linting and formatting with ALE
- **Performance Optimized**: Lazy loading for faster startup
- **Git Integration**: Seamless version control workflow
- **Modern UI**: Clean interface with file icons and status line

## 🚀 Quick Setup

### Prerequisites

Install Vim and required dependencies:

**macOS:**
```bash
brew install vim
```

**Ubuntu/Debian:**
```bash
sudo apt update && sudo apt install vim -y
```

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/maateen/vim-for-devops.git
cd vim-for-devops
```

2. **Install the configuration:**
```bash
cp vimrc ~/.vimrc
```

3. **Install vim-plug (plugin manager):**
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

4. **Install plugins:**
Open Vim and run:
```vim
:PlugInstall
```

## 🛠 Supported Technologies

| Technology | Features |
|------------|----------|
| **Docker** | Syntax highlighting, linting with hadolint |
| **Kubernetes** | YAML support, Helm charts |
| **Terraform** | HCL syntax, auto-formatting, tflint integration |
| **Ansible** | Playbook syntax, ansible-lint support |
| **Python** | Black formatting, mypy type checking |
| **Go** | Full language support via vim-go |
| **YAML/JSON** | Advanced parsing and validation |
| **Shell Scripts** | Shellcheck integration |
| **Nginx** | Configuration file syntax |
| **Vagrant** | Vagrantfile support |

## ⌨️ Key Mappings

### Basic Operations
| Key | Action |
|-----|--------|
| `Ctrl+s` | Save file |
| `Ctrl+w` | Close buffer |
| `Ctrl+z` | Undo |
| `Ctrl+r` | Redo |

### File Navigation
| Key | Action |
|-----|--------|
| `Ctrl+t` | Toggle file explorer |
| `Ctrl+e` | Find current file in explorer |

### IDE Features
| Key | Action |
|-----|--------|
| `Ctrl+i` | Enable IDE mode (Git gutter + file explorer) |
| `Ctrl+g` | Toggle Git gutter |
| `Ctrl+f` | Toggle distraction-free mode |
| `Ctrl+d` | Open terminal below |

### Code Intelligence (via CoC.nvim)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Show documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |

### Git Operations
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff split |
| `<leader>gl` | Git commit log |

### Buffer/Tab Management
| Key | Action |
|-----|--------|
| `<leader>t` | New tab |
| `<leader>n` | Next buffer |
| `<leader>p` | Previous buffer |

### Quick Toggles
| Key | Action |
|-----|--------|
| `<leader>i` | Toggle indent lines |

### Comments
| Key | Action |
|-----|--------|
| `,cc` | Comment line/selection |
| `,cu` | Uncomment line/selection |

*Leader key is comma (`,`)*

## 🔌 Plugin Architecture

### Theme & UI
- **[onedark.vim](https://github.com/joshdick/onedark.vim)**: Modern dark theme
- **[vim-airline](https://github.com/vim-airline/vim-airline)**: Enhanced status line
- **[vim-devicons](https://github.com/ryanoasis/vim-devicons)**: File type icons
- **[nerdtree](https://github.com/preservim/nerdtree)**: File explorer with Git integration
- **[nerdtree-git-plugin](https://github.com/xuyuanp/nerdtree-git-plugin)**: Git integration for NERDTree
- **[vim-nerdtree-syntax-highlight](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight)**: Syntax highlighting for NERDTree

### Code Intelligence
- **[coc.nvim](https://github.com/neoclide/coc.nvim)**: Language Server Protocol support
- **[ale](https://github.com/dense-analysis/ale)**: Asynchronous linting and fixing
- **[auto-pairs](https://github.com/jiangmiao/auto-pairs)**: Smart bracket/quote pairing
- **[nerdcommenter](https://github.com/preservim/nerdcommenter)**: Intelligent commenting

### DevOps Tools
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)**: Git integration
- **[vim-gitgutter](https://github.com/airblade/vim-gitgutter)**: Git change indicators
- **[ansible-vim](https://github.com/pearofducks/ansible-vim)**: Ansible syntax support
- **[vim-terraform](https://github.com/hashivim/vim-terraform)**: Terraform/HCL support
- **[vim-kubernetes](https://github.com/andrewstuart/vim-kubernetes)**: Kubernetes YAML support
- **[Dockerfile.vim](https://github.com/ekalinin/Dockerfile.vim)**: Docker syntax
- **[vim-helm](https://github.com/towolf/vim-helm)**: Helm chart support

### Language Support
- **[vim-go](https://github.com/fatih/vim-go)**: Go development
- **[vim-markdown](https://github.com/plasticboy/vim-markdown)**: Enhanced Markdown
- **[JSON.vim](https://github.com/vim-scripts/JSON.vim)**: JSON syntax
- **[vim-yaml](https://github.com/stephpy/vim-yaml)**: YAML enhancements
- **[nginx.vim](https://github.com/chr4/nginx.vim)**: Nginx configuration
- **[vim-toml](https://github.com/cespare/vim-toml)**: TOML support
- **[vim-vagrant](https://github.com/hashivim/vim-vagrant)**: Vagrantfile support

### Utilities
- **[goyo.vim](https://github.com/junegunn/goyo.vim)**: Distraction-free writing
- **[indentLine](https://github.com/Yggdroot/indentLine)**: Visual indent guides
- **[trim.nvim](https://github.com/cappyzawa/trim.nvim)**: Automatic whitespace cleanup
- **[webapi-vim](https://github.com/mattn/webapi-vim)**: Web API functionality for other plugins

## 🎨 Customization

The configuration is modular and well-documented. Key areas for customization:

- **Theme**: Change `colorscheme onedark` in the theme section
- **Key mappings**: Modify the "Key Mappings" section
- **Plugin settings**: Adjust in the "Plugin Configs" section
- **Linters/Formatters**: Update ALE configuration for your tools

## 🐛 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:PlugInstall` in Vim
2. **CoC.nvim errors**: Install Node.js and run `:CocInstall` for language servers
3. **Linting not working**: Ensure tools like `black`, `shellcheck`, `hadolint` are installed
4. **Icons not showing**: Install a Nerd Font and configure your terminal

### Performance

The configuration uses lazy loading to maintain fast startup times. Plugins load only when needed:
- File type specific plugins load for relevant files
- UI plugins load on command
- Heavy plugins are deferred until first use

---

**Made with ❤️ for DevOps Engineers**
