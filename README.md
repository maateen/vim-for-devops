# VIM for DevOps

I am a DevOps Engineer and using VIM as a generalized lightweight editor at my day-to-day DevOps works. I am using it for Bash/Python/Golang programming and writing Dockerfiles, Ansible Playbooks, Terraform Codes and Kubernetes manifests.

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

## Shortcuts

The **Leader key** is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command. The default leader key is **comma** sign.

| Key | Description |
| --- | --- |
| `,f` | Toggle Fullscreen mode |
| `,g` | Enable Git Gutter |
| `,\` | Toggle Nerd Tree |

## Plugins

| Name | Lazy Loading | On | For |
| --- | --- | --- | --- |
| lifepillar/vim-solarized8 | | | |
| junegunn/vim-easy-align | | | |
| tpope/vim-surround | | | |
| airblade/vim-gitgutter | :white_check_mark: | GitGutterEnable | |
| junegunn/goyo.vim | :white_check_mark: | Goyo | |
| preservim/nerdtree | :white_check_mark: | NERDTreeToggle | |
| ekalinin/Dockerfile.vim | :white_check_mark: | | docker |
| fatih/vim-go | :white_check_mark: | | go |
| plasticboy/vim-markdown | :white_check_mark: | | markdown |
| chr4/nginx.vim | :white_check_mark: | | nginx |
| hashivim/vim-terraform | :white_check_mark: | | terraform |
| stephpy/vim-yaml | :white_check_mark: | | yaml |

Made with :heart: for DevOps Engineers by DevOps Engineer