#!/bin/sh

# Detect Operating System
OS=`uname`

if [ $OS == "Darwin" ]; then
    DOTFILES_HOME=$HOME/Documents/Dotfiles
else
    DOTFILES_HOME=$HOME/.dotfiles

echo "Attempting install dotfiles on `hostname` running $OS"

#######
# VIM #
#######

VIM_HOME=$HOME/.vim
VIM_BUNDLE=$VIM_HOME/bundle

# Remove any existing .vim dir or .vimrc file
rm -rf $VIM_HOME $HOME/.vimrc $HOME/.vimrc $HOME/.gvimrc

# Create .vim directory
mkdir $VIM_HOME $VIM_BUNDLE

# Install Pathogen
git clone https://github.com/tpope/vim-pathogen $VIM_HOME/vim-pathogen
ln -s $VIM_HOME/vim-pathogen/autoload $VIM_HOME/autoload

# Install plugins

# ale, an asynchronous lint engine
git clone https://github.com/w0rp/ale $VIM_BUNDLE/ale

# yapf, a formatter for Python files
git clone https://github.com/google/yapf $VIM_BUNDLE/yapf

# YouCompleteMe, a code-completion engine for Vim
# Currently YouCompleteMe can only be built for macOS
# Assumes XCode and cmake are installed
if [ $OS == "Darwin" ]; then
    git clone https://github.com/Valloric/YouCompleteMe $VIM_BUNDLE/YouCompleteMe
    cd $VIM_BUNDLE/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --clang-completer
fi

# Install themes
git clone https://github.com/NLKNguyen/papercolor-theme $VIM_BUNDLE/papercolor-theme

# Install vimrc and gvimrc files
ln -s $DOTFILES_HOME/vim/vimrc $HOME/.vimrc
ln -s $DOTFILES_HOME/vim/gvimrc $HOME/.gvimrc

#######
# zsh #
#######

# Remove any existing oh my zsh install or .zshrc file
rm -rf $HOME/.oh-my-zsh $HOME/.zshrc

# Clone oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh

# Install .zshrc file
ln -s $DOTFILES_HOME/zsh/zshrc $HOME/.zshrc
