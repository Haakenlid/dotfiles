" Keyboard shortcuts
let mapleader=" "

imap jj <esc>
map Q @q
" Ctrl-Q = quit
map <C-Q> :qa!
map! <C-Q> <esc>:qa!
" Ctrl-S = save
map <C-S> :w!<cr>
map! <C-S> <esc>:w!<cr>

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1


" Tagbar settings
nmap <C-T> :TagbarOpenAutoClose<cr>
set tags=tags;,.git/tags;

"sane defaults
colorscheme molokai
let previewheight=5

"neovim python programs
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

set hidden
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
" set rnu
set nu
set listchars=tab:>-,extends:>,precedes:<
set list
set mouse=a
set backspace=indent,eol,start
set cursorline
set laststatus=2 " Always display the statusline in all windows
" set showtabline=2 " Always display the tabline, even if there is only one tab
" set showtabline=1
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
" autocmd vimrc InsertEnter * :set norelativenumber
" autocmd vimrc InsertLeave * :set relativenumber

" Make it obvious where 80 characters is
" set textwidth=80
set colorcolumn=80

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

" YouCompleteMe settings
nmap gd :YcmCompleter GoTo<cr>
nmap gD :YcmCompleter GetDoc<cr>
nmap gi /import<CR>
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
let g:ycm_add_preview_to_completeopt = 1

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'rst' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}

" Easymotion settings
let g:EasyMotion_do_mapping = 1 " Disable default mappings
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

" RIV settings
let g:riv_fold_auto_update = 0

" NERDTree settings
let NERDTreeShowHidden = 1
nmap <C-N> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore=['.git$', '.pyc$', '__pyc__']

" CTRL-P settings
nmap gS :CtrlPTag<cr>
nmap gs :CtrlPBufTag<cr>
nmap gb :CtrlPBuffer<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=20
let g:ctrlp_lazy_update=1
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_extensions = ['tag']
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -lS --ignore=".git" --hidden --nocolor -g ""'
endif

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'floobits/floobits-neovim'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'rking/ag.vim'
Plug 'Rykka/InstantRst'
Plug 'Rykka/riv.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': '/usr/bin/python2 ./install.py --clang-completer' }

" Plug 'Valloric/YouCompleteMe', { 'do': '/usr/bin/python2 ./install.py --clang-completer', 'branch': 'dev'}
" Plug 'chase/vim-ansible-yaml'
" Plug 'davidhalter/jedi-vim'
" Plug 'flazz/vim-colorschemes'
" Plug 'mattn/emmet-vim'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vinegar'

call plug#end()
