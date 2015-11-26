let mapleader=" "
imap jj <esc>
colorscheme molokai

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set rnu
set nu
set listchars=tab:>-,extends:>,precedes:<
set list
set mouse=a
set backspace=indent,eol,start
set cursorline
set laststatus=2 " Always display the statusline in all windows
" set showtabline=2 " Always display the tabline, even if there is only one tab
set showtabline=1 
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

hi CursorLine   cterm=NONE ctermbg=235
hi CursorLineNr cterm=bold ctermfg=Yellow ctermbg=235

augroup vimrc
  autocmd!
augroup END

" Splits
set splitbelow " New split goes below
set splitright " New split goes right

filetype indent plugin on
syntax on

" Show absolute numbers in insert mode, otherwise relative line numbers.
autocmd vimrc InsertEnter * :set norelativenumber
autocmd vimrc InsertLeave * :set relativenumber

" Make it obvious where 80 characters is
" set textwidth=80
set colorcolumn=80

" Run current file from command line with leader R
:nnoremap <leader>r :!%:p 

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set dictionary="/usr/dict/words"

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

function! Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

if ! has('gui_running')
    " set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=300
        au InsertLeave * set timeoutlen=1000
    augroup END
endif



" Powerline Scripts -------------------------
 try
     python import os, sys
     python sys.path.append(os.getenv('HOME')+'/.dotfiles/libs/powerline/')
     python from powerline.vim import setup as powerline_setup
     python powerline_setup()
     python del powerline_setup
 catch
 endtry


let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" Bi-directional find motions
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" " Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"
" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" NERDTree
let NERDTreeShowHidden = 1
nmap <C-N> :NERDTreeToggle<CR> 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore=['.git$', '.pyc$', '__pyc__']

" CTRL-P settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=8
let g:ctrlp_lazy_update=1
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -lS --ignore=".git" --hidden --nocolor -g ""'
endif

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'flazz/vim-colorschemes'

" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-eunuch'

" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" Plug 'mattn/emmet-vim'
" Plug 'chase/vim-ansible-yaml'
" Plug 'terryma/vim-multiple-cursors'

call plug#end()
