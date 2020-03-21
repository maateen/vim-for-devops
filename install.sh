#! /bin/bash

declare -r PWD=$(pwd)
declare -r WHOAMI=$(whoami)
declare -r VIM_PLUG=~/.vim/autoload/plug.vim

#################
### Setup vimrc ###
#################
if $(hash vim); then
    if [[ ! -f $VIM_PLUG ]]; then
        curl  --silent -fLo $VIM_PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    ln -fFs $(pwd)/vimrc ~/.vimrc
    vim +PlugUpgrade +PlugClean +PlugInstall +PlugUpdate +qall

    if $(hash go); then
        vim ~/.vim.go +GoInstallBinaries +GoUpdateBinaries +qall
    fi

else
    echo "Oops! We could not find vim on your system."
fi