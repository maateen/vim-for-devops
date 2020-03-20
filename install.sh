#! /bin/bash

declare -r PWD=$(pwd)
declare -r WHOAMI=$(whoami)
declare -r PLUG_DIR=~/.vim/autoload/plug.vim

#################
### Setup vimrc ###
#################
if $(hash vim); then
    if [[ ! -d $PLUG_DIR ]]; then
        curl  --silent -fLo $PLUG_DIR --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    ln -fFs $(pwd)/vimrc ~/.vimrc
    vim +PlugInstall +qall
else
    echo "Oops! We could not find vim on your system."
fi