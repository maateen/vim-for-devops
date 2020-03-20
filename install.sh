#! /bin/bash

set -x

declare -r PWD=$(pwd)
declare -r WHOAMI=$(whoami)
declare -r SSH_DIR=~/.ssh

#################
### Setup vimrc ###
#################
if $(which vim); then
    ln -fFs $(pwd)/vimrc ~/.vimrc
    vim +PlugInstall +qall
else
    echo "Oops! We could not find vim on your system."
fi