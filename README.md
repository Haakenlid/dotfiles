# Dotfiles
These dotfiles are forked from Ben "Cowboy" Almans dotfiles. The installation
scripts and structure are basically the same. Consult
[Ben's readme](https://github.com/cowboy/dotfiles/blob/master/README.md)
for further documentation.

## Installation
* The `dotfiles` executable will install some applications and modify some system files
* You might want to read Ben Almans readme before executing this.
* I've used the dotfiles on Ubuntu and RHEL. They might also work on other distros as long
as you use `bash`, as well as OSX
* Run these commands:
```
git clone https:///haakenlid/dotfiles.git ~/.dotfiles
~/.dotfiles/bin/dotfiles
```

## What happens when running `dotfiles`?
* A whole bunch of things will be installed
* Dotfiles in `$HOME` folder is backed up
* The dotfiles in this repo is symlinked to `$HOME`
* ???
* profit

### Some of the programs that gets installed
* `git` – it's a distributed version control system!
* `htop` – process monitoring with colours and stuff
* `vim` – a text editor
* `tree` – to inspect directories and files
* `silversearcher-ag` – very fast file content search utility
* `ghi` – Github command line interface
* `ptpython` – improved python shell
* `ipython` – also improved python shell
* `ptipython` – even more improved python shell!
* `tmux` – terminal multiplexer

### My favourite vim plugins as well (using _vim-plug_ as plugin manager)
* `nerdtree`
* `vim-surround`
* `ctrlp`
* `jedi-vim`
* `vim-gitgutter`
* `vim-easymotion`
* ... and some more ...

### Bash functions / aliases / scripts
* `??` – bash_history search thing (I wrote it)
* `gmail` – check gmail from the shell
* `YOLO` – Improve your git productivity by 1000%
* `v` – fuzzy search in vim history to open recently edited file
* `z` – It's like `cd`, but better

### Tmux and powerline
* `Tmux` plus `tmuxinator` plus `powerline`
* Makes your terminal look good
* Tweaked colours, keyboard shortcuts and powerline segments

## Licence
Copyright (c) 2013 "Cowboy" Ben Alman
Additions by Håken Lid
[Licensed under the MIT license](/LICENCE-MIT)

