# Vim for Python3 and Go

This is my minimal .vimrc file, I am using for day-to-day Python3 and Go programming. You can follow this at your own risk.

# Usage

You're gonna do Python3 and Go programming on Vim. Let me suppose that you have installed them already.

## Install

You should always use the latest Vim (with vim-gnome, build-essential, cmake, git, python3-dev, python3-pip). For Ubuntu, open terminal and play these commands to install them. These command will also install GVim (Vim with GUI) as I also like to use GVim.

```
sudo add-apt-repository ppa:jonathonf/vim -y
```
```
sudo apt update
```
```
sudo apt install build-essential cmake git python3-dev python3-pip vim vim-gnome -y
```

## Set up

Play these commands on Terminal to set up Vim.

```
sudo pip3 install jedi flake8 pylint
```
```
curl "https://raw.githubusercontent.com/maateen/vim-for-python-and-go/master/.vimrc" > ~/.vimrc
```
```
curl "https://raw.githubusercontent.com/maateen/vim-for-python-and-go/master/.gvimrc" > ~/.gvimrc
```
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
```
vim +PlugInstall +qall
```

## Compile

Let's compile the YouCompleteMe for autocompletion.

```
cd ~/.vim/plugged/YouCompleteMe/
```
```
python3 install.py --gocode-completer
```

## Shortcuts
The **Leader key** is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command. The default leader key is **backslash**.

| Key | Description |
| --- | --- |
| F5 | Run Python3 Scripts |
| \r | go run |
| \b | go build |
| \t | go test |
| \c | go coverage |

# Roadmap

I can't remmebr. :(
