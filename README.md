# VIM for DevOps

An awesome lightweight Vim for DevOps Engineers.

## Install VIM

### MacOSX

Please, open a terminal and play this command to install the latest vim.

```bash
$ brew install vim
```

### Ubuntu

Please, open a terminal and play these commands to install the latest vim.

```bash
$ sudo add-apt-repository ppa:jonathonf/vim -y
```
```bash
$ sudo apt update
```
```bash
$ sudo apt install vim -y
```

## Set Up VIM for DevOps

Play these commands on Terminal to set up Vim for DevOps.

```bash
$ git clone git@github.com:maateen/awesome-vimrc.git
```
```bash
$ cd awesome-vimrc
```
```bash
$ bash install.sh
```

## Supported Languages

- Dockerfile
- Golang
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
| `,f` | Toggle Fullscreen mode |
| `,g` | Enable Git Gutter |
| `,\` | Toggle NerdTree |
| `,n` | Move focus to NERDTree window |
| `,cc` | Comment out the current line or text selected in visual mode. |
| `,cu` | Uncomments the selected line(s). [Read More](https://github.com/preservim/nerdcommenter#default-mappings) |

## Plugins

| Name | Lazy Loading | On | For |
| :---: | :---: | :---: | :---: |
| lifepillar/vim-solarized8 | | | |
| junegunn/vim-easy-align | | | |
| tpope/vim-surround | | | |
| preservim/nerdcommenter | | | |
| airblade/vim-gitgutter | :white_check_mark: | GitGutterEnable | |
| junegunn/goyo.vim | :white_check_mark: | Goyo | |
| preservim/nerdtree | :white_check_mark: | NERDTreeToggle | |
| ekalinin/Dockerfile.vim | :white_check_mark: | | docker |
| fatih/vim-go | :white_check_mark: | | go |
| plasticboy/vim-markdown | :white_check_mark: | | markdown |
| chr4/nginx.vim | :white_check_mark: | | nginx |
| hashivim/vim-terraform | :white_check_mark: | | terraform |
| cespare/vim-toml | :white_check_mark: | | toml |
| hashivim/vim-vagrant | :white_check_mark: | | vagrant |
| stephpy/vim-yaml | :white_check_mark: | | yaml |

Made with :heart: for DevOps Engineers by DevOps Engineer
