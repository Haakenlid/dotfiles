"Keyboard shortcuts
let mapleader=" "
syntax on
filetype plugin indent on
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

nmap zn :GitGutterNextHunk<cr>
nmap zN :GitGutterPrevHunk<cr>

" Don't use swap file.
set nobackup
set nowritebackup
set noswapfile

" Python
"
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd FileType python nmap <buffer> <M-8> :call Autopep8()<CR>
autocmd FileType python BracelessEnable +indent 

" let g:lt_height = 5
autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>
autocmd! BufNewFile,BufReadPost *.md set filetype=markdown
autocmd! BufNewFile,BufReadPost *.{tpl,tmpl} set filetype=jinja
set modeline
set modelines=5

" let g:airline_section_x = 'pencil: %{PencilMode()}'
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd,text 
"         \ | call pencil#init()
"         \ | call lexical#init()
" augroup END

map! jj <esc>
" imap DD <esc>dd
" imap AA <esc>A
" imap II <esc>I
" imap OO <esc>O
" imap CC <esc>C

imap <c-cr> <esc>o
imap <c-u> <esc>ui
map Q @q
" Ctrl-Q = quit
map <C-Q> :qa!
map! <C-Q> <esc>:qa!
" Ctrl-S = save
map <C-S> :w!<cr>
map! <C-S> <esc>:w!<cr>
" clear search pattern
map <leader>/ :let @/=""<cr>

" Replace word under cursor
nmap <leader>r *N:redraw!<CR>:%s/\<<C-r>=expand('<cword>')<CR>\>//g<left><left>

" leader p => previous buffer
map <leader>p :bp<CR>

" open vimrc with leader V 
map <leader>v :e $MYVIMRC<CR>
au BufRead $MYVIMRC :map <buffer> <leader>v :bp<CR>:so $MYVIMRC<CR>

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

" Tagbar settings
map <leader>t :TagbarOpenAutoClose<cr>
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


if ! has('gui_running')
    " this makes insert mode commands such as jj possible  
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=300
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" YouCompleteMe settings
nmap gd :YcmCompleter GoTo<cr>
nmap gD :YcmCompleter GetDoc<cr>
nmap gi /import<CR>:let @/ = ""<CR>

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_min_num_identifier_candidate_chars = 2


let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'rst' : 1,
      \ 'unite' : 1,
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
nmap <leader>s <Plug>(easymotion-s)
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
map <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore=['.git$', '.pyc$', '__pyc__']

" Inactive splits background color hack
" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
function! s:DimInactiveWindows()
  for i in range(1, tabpagewinnr(tabpagenr(), '$'))
    let l:range = ""
    if i != winnr()
      if &wrap
        " HACK: when wrapping lines is enabled, we use the maximum number
        " of columns getting highlighted. This might get calculated by
        " looking for the longest visible line and using a multiple of
        " winwidth().
        let l:width=256 " max
      else
        let l:width=winwidth(i)
      endif
      let l:range = join(range(1, l:width), ',')
    endif
    call setwinvar(i, '&colorcolumn', l:range)
  endfor
endfunction
" augroup DimInactiveWindows
"   au!
"   au WinEnter * call s:DimInactiveWindows()
"   au WinEnter * set cursorline
"   au WinLeave * set nocursorline
" augroup END

" JSX settings
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" CTRL-P settings
nmap gS :CtrlPTag<cr>
nmap gs :CtrlPBufTag<cr>
nmap gb :CtrlPBuffer<cr>
nmap gm :CtrlPMRUFiles<cr>
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

""" Emmet config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_next_key='<M-j>'
let g:user_emmet_prev_key='<M-k>'

""" Ultisnips config
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsListSnippets="<M-s>"
" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsUsePythonVersion=2

" let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" let g:UltiSnipsSnippetDirectories=[]

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
"

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'floobits/floobits-neovim'
Plug 'lambdatoast/elm.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mickaobrien/vim-stackoverflow'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'Rykka/InstantRst'
Plug 'Rykka/riv.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'Valloric/ListToggle'
Plug 'Valloric/YouCompleteMe', { 'do': '/usr/bin/python2 ./install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'reedes/vim-pencil'
Plug 'reedes/vim-lexical'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tell-k/vim-autopep8'
Plug 'tweekmonster/braceless.vim'

" Plug 'hynek/vim-python-pep8-indent'
" Plug 'chase/vim-ansible-yaml'
" Plug 'davidhalter/jedi-vim'
" Plug 'flazz/vim-colorschemes'
" Plug 'honza/vim-snippets'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" Plug 'scrooloose/syntastic'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vinegar'

call plug#end()

