#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
sudo pip3 install neovim
sudo pip2 install neovim

ln -s ${HOME}/.vim ${HOME}/.config/nvim
ln -s ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
