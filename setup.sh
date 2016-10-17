#!/bin/sh

# Detect Operating System
OS=`uname`
DOTFILES_HOME=$HOME/.dotfiles

# Remove dotfiles symlink if it exists already
rm $DOTFILES_HOME

# We're going to assume that if $HOME/Dropbox exists, it means Dropbox is installed
if [ -d $HOME/Dropbox ]; then
    ln -s $HOME/Dropbox/dotfiles $DOTFILES_HOME
fi

#TODO Add Failover to Synology and install in case neither cloud nor Synology is available

#######
# VIM #
#######

VIM_HOME=$HOME/.vim

# Remove any existing .vim dir or .vimrc file
rm -rf $VIM_HOME $HOME/.vimrc

# Create .vim directory
mkdir $VIM_HOME $VIM_HOME/bundle

# Install Pathogen
ln -s $DOTFILES_HOME/vim/tools/vim-pathogen/autoload $VIM_HOME/autoload

# Install all the platform independent plugins
for plugin in `ls $DOTFILES_HOME/vim/plugins`
do
    ln -s $DOTFILES_HOME/vim/plugins/$plugin $VIM_HOME/bundle/$plugin
done

# Currently YouCompleteMe is only built for macOS
if [ $OS == "Darwin" ]; then
    ln -s $DOTFILES_HOME/vim/tools/YouCompleteMe $VIM_HOME/bundle/YouCompleteMe
fi

# Install the themes
for theme in `ls $DOTFILES_HOME/vim/themes`
do
    ln -s $DOTFILES_HOME/vim/themes/$theme $VIM_HOME/bundle/$theme
done

# Install vimrc file
ln -s $DOTFILES_HOME/vim/vimrc $HOME/.vimrc

#######
# zsh #
#######

# Remove any existing oh my zsh install or .zshrc file
rm -rf $HOME/.oh-my-zsh $HOME/.zshrc

#install oh my zsh folder
ln -s $DOTFILES_HOME/zsh/oh-my-zsh $HOME/.oh-my-zsh

#install .zshrc file
ln -s $DOTFILES_HOME/zsh/zshrc $HOME/.zshrc
