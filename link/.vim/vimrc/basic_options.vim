syntax on
filetype plugin indent on
colorscheme hken

" Use swap file
set noswapfile

" Don't write backup
set nobackup
set nowritebackup

" show at least N lines before and after cursor position
set scrolloff=3

" Printing
set printoptions+=formfeed:y
set printoptions+=header:0

" No --INSERT-- in command line
set noshowmode

" Modeline
set modeline
set modelines=5
" set showtabline=2 " Always display the tabline, even if there is only one tab
" set showtabline=1

" Ctags
set tags=tags;,.git/tags;

" Hide buffers instead of closing
set hidden

" Indent
set textwidth=80
set colorcolumn=-1
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

" line numbers
set number

" show tab characters
set list
set listchars=tab:>-,extends:>,precedes:<

" use mouse?
"set mouse=a

set cursorline
" set laststatus=2 " Always display the statusline in all windows

" Splits
set splitbelow " New split goes below
set splitright " New split goes right

" Make it obvious where 80 characters is
set dictionary="/usr/dict/words"
set ignorecase

" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*
