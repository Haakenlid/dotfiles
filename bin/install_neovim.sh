#!/bin/bash

[ $UID != 0 ] && echo 'must run as root' && exit 1

add-apt-repository -y ppa:neovim-ppa/unstable
apt update
apt install -y neovim python-pip python3-pip
pip3 install neovim
pip2 install neovim

su $(logname) << 'EOF'
  ln -fs ${HOME}/.vim ${HOME}/.config/nvim
  ln -fs ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
EOF
