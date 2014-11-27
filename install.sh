#! /bin/sh
#
# install.sh
# Copyright (C) 2014 Roy QIU <karoyqiu@gmail.com>
#
# Distributed under terms of the MIT license.
#

SCRIPT=$(readlink -f $0)
RC_DIR=`dirname $SCRIPT`
echo "RC directory: $RC_DIR"
echo "Installing RC to $HOME"

# vimrc
read -n 1 -p "Do you want to install vimrc? [Y/n]: " ANSWER
echo ""

if [[ "$ANSWER" = [Yy] ]]
then
    echo "Installing vimrc"

    # Backup the original .vimrc and .vim
    if [ -f "$HOME/.vimrc" ]
    then
        mv -f "$HOME/.vimrc" "$HOME/.vimrc.bak"
    fi

    if [ -d "$HOME/.vim" ]
    then
        mv -f "$HOME/.vim" "$HOME/.vim.bak"
    fi

    # Make a symbolic link
    ln -fs "$RC_DIR/vimrc" "$HOME/.vim"
fi

# oh-my-zsh
read -n 1 -p "Do you want to install oh-my-zsh? [Y/n]: " ANSWER
echo ""

if [[ "$ANSWER" = [Yy] ]]
then
    echo "Installing oh-my-zsh"

    # Backup the original .oh-my-zsh
    if [ -d "$HOME/.oh-my-zsh" ]
    then
        mv -f "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.bak"
    fi

    # Make a symbolic link
    ln -fs "$RC_DIR/oh-my-zsh" "$HOME/.oh-my-zsh"
    $HOME/.oh-my-zsh/tools/install.sh
fi

# astyle
read -n 1 -p "Do you want to install astylerc? [Y/n]: " ANSWER
echo ""

if [[ "$ANSWER" = [Yy] ]]
then
    echo "Installing oh-my-zsh"

    # Backup the original .astylerc
    if [ -d "$HOME/.astylerc" ]
    then
        mv -f "$HOME/.astylerc" "$HOME/.astylerc.bak"
    fi

    # Make a symbolic link
    ln -fs "$RC_DIR/astylerc" "$HOME/.astylerc"
fi

# astyle
read -n 1 -p "Do you want to install git config files? [Y/n]: " ANSWER
echo ""

if [[ "$ANSWER" = [Yy] ]]
then
    echo "Installing oh-my-zsh"

    # Backup the original .gitconfig
    if [ -d "$HOME/.gitconfig" ]
    then
        mv -f "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
    fi

    # Make a symbolic link
    ln -fs "$RC_DIR/git/gitconfig" "$HOME/.gitconfig"
    ln -fs "$RC_DIR/git/gitignore_global" "$HOME/.gitignore_global"
fi

echo "Done"

