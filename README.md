# VIM for DevOps

An awesome lightweight Vim for DevOps Engineers.

## Install VIM

### MacOSX

Please, open a terminal and play this command to install the latest vim.

```
$ brew install vim
```

### Ubuntu

Please, open a terminal and play these commands to install the latest vim.

```
$ sudo apt update && sudo apt install vim -y
```

## Set Up VIM for DevOps

Play these commands on Terminal to set up Vim for DevOps.

```
$ git clone git@github.com:maateen/awesome-vimrc.git
```
```
$ cd awesome-vimrc
```
```
$ bash install.sh
```

## Supported Languages

- Dockerfile
- Golang
- HCL
- Markdown
- Nginx
- Python3
- Terraform
- TOML
- Vagrant
- YAML

## Shortcuts

The **Leader key** is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command. The default leader key is **comma** (`,`) key.

| Key | Description |
| --- | --- |
| `Ctrl-i` | Toggle IDE mode in VIM |
| `Ctrl-g` | Enable Git Gutter |
| `Ctrl-f` | Toggle Fullscreen mode |
| `Ctrl-t` | Toggle NerdTree |
| `Ctrl-n` | Move focus to NERDTree window |
| `Ctrl-d` | Toggle Terminal below current tab |
| `,cc` | Comment out the current line or text selected in visual mode. |
| `,cu` | Uncomments the selected line(s). [Read More](https://github.com/preservim/nerdcommenter#default-mappings) |

## Plugins

| Name | Lazy Loading | On | For |
| :---: | :---: | :---: | :---: |
| [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim) | | | |
| [jiangmiao/auto-pairs](https://github.com/jiangmiao/auto-pairs) | | | |
| [preservim/nerdcommenter](https://github.com/preservim/nerdcommenter) | | | |
| [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter) | :white_check_mark: | GitGutterEnable | |
| [junegunn/goyo.vim](https://github.com/junegunn/goyo.vim) | :white_check_mark: | Goyo | |
| [preservim/nerdtree](https://github.com/preservim/nerdtree) | :white_check_mark: | NERDTree, NERDTreeToggle, NERDTreeFind, NERDTreeFocus | |
| [xuyuanp/nerdtree-git-plugin](https://github.com/xuyuanp/nerdtree-git-plugin) | :white_check_mark: | NERDTree, NERDTreeToggle, NERDTreeFind, NERDTreeFocus | |
| [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons) | :white_check_mark: | NERDTree, NERDTreeToggle, NERDTreeFind, NERDTreeFocus | |
| [ekalinin/Dockerfile.vim](https://github.com/ekalinin/Dockerfile.vim) | :white_check_mark: | | dockerfile |
| [fatih/vim-go](https://github.com/fatih/vim-go) | :white_check_mark: | | go |
| [plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown) | :white_check_mark: | | markdown |
| [chr4/nginx.vim](https://github.com/chr4/nginx.vim) | :white_check_mark: | | nginx |
| [hashivim/vim-terraform](https://github.com/hashivim/vim-terraform) | :white_check_mark: | | hcl, terraform |
| [cespare/vim-toml](https://github.com/cespare/vim-toml) | :white_check_mark: | | toml |
| [hashivim/vim-vagrant](https://github.com/hashivim/vim-vagrant) | :white_check_mark: | | vagrant |
| [stephpy/vim-yaml](https://github.com/stephpy/vim-yaml) | :white_check_mark: | | yaml |

<br>Made with :heart: for DevOps Engineers by DevOps Engineer
