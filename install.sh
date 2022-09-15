#! /bin/bash
#################
### Setup vimrc ###
#################
if $(hash vim); then
    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    ln -fFs $(pwd)/vimrc ~/.vimrc
    vim +PlugUpgrade +PlugClean +PlugInstall +PlugUpdate +qall

    if $(hash go); then
        vim ~/.vim.go +GoInstallBinaries +GoUpdateBinaries +qall
    fi

else
    echo "Oops! We could not find vim on your system."
fi